#include "Game.h"

#include "ChunkTerrainGen.h"
#include "Utility.h"
#include "Voxels.h"

Game::Game()
{
    // clang-format off
    m_sceneShader   .loadFromFile("SceneVertex.glsl",   "SceneFragment.glsl");
    m_waterShader   .loadFromFile("WaterVertex.glsl",   "WaterFragment.glsl");
    m_terrain   .bufferMesh(createTerrainMesh(64, 128, false));
    m_lightCube .bufferMesh(createCubeMesh({10.5f, 10.5f, 10.5f}));


    std::srand(std::time(0));
    m_terrainGenOptions.seed = std::rand() % 30000;

    std::cout << "SEED: " << m_terrainGenOptions.seed << "\n";
    
    m_refractFramebuffer.create(WIDTH , HEIGHT);
    m_refractFramebuffer.addRenderBuffer();
    m_refractFramebuffer.finish();

    m_reflectFramebuffer.create(WIDTH , HEIGHT);
    m_reflectFramebuffer.addRenderBuffer();
    m_reflectFramebuffer.finish();

    m_refractTexture = m_refractFramebuffer.addTexture();
    m_reflectTexture = m_reflectFramebuffer.addTexture();

    m_texture.loadFromFile("OpenGLLogo.png", 1);

    m_waterTexture.loadFromFile("Water.png", 1);
    m_textureArray.create(16, 16);

    m_waterDistortTexture.loadFromFile("WaterDUDV.png", 8);
    m_waterDistortTexture.useDefaultFilters();

    m_waterNormalTexture.loadFromFile("WaterNormal.png", 4);
    m_waterNormalTexture.useDefaultFilters();

    m_voxelShader = initVoxelSystem();

    float aspect = (float)WIDTH / (float)HEIGHT;
    m_projectionMatrix = createProjectionMatrix(aspect, 90.0f);

    resetWorld(8);

    m_cameraTransform = { {CHUNK_SIZE, CHUNK_SIZE * 1.5, CHUNK_SIZE}, {0, 0, 0} };

    // clang-format on
}

void Game::resetWorld(int worldSize)
{
    m_worldSize = worldSize;
    m_isRunning = false;
    if (m_chunkMeshGenThread.joinable()) {
        m_chunkMeshGenThread.join();
    }
    m_isRunning = true;

    m_chunkMeshQueue = std::queue<ChunkMesh>();
    m_chunkReadyForMeshingQueue = std::queue<ChunkPosition>();
    m_chunkUpdateQueue = std::queue<ChunkPosition>();

    m_chunkMap.destroyWorld();
    m_chunkVertexArrays.clear();
    m_chunkUnderWaterRenderList.clear();
    m_chunkAboveWaterRenderList.clear();

    int center = CHUNK_SIZE * worldSize / 2 - CHUNK_SIZE / 2;
    m_sun.center = center;

    m_waterQuad.reset();
    m_waterQuad.bufferMesh(createTerrainMesh(CHUNK_SIZE * worldSize, CHUNK_SIZE * worldSize / 4, true));

    for (int x = 0; x < worldSize; x++) {
        for (int z = 0; z < worldSize; z++) {
            m_chunkUpdateQueue.push({x, 0, z});
        }
    }

    m_chunkMeshGenThread = std::thread([&] { runTerrainThread(); });
}

Game::~Game()
{
    m_isRunning = false;
    if (m_chunkMeshGenThread.joinable()) {
        m_chunkMeshGenThread.join();
    }
}

void Game::onInput(const Keyboard& keyboard, const sf::Window& window, bool isMouseActive)
{
    Transform& camera = m_cameraTransform;

    float PLAYER_SPEED = 0.5f;
    if (keyboard.isKeyDown(sf::Keyboard::LControl)) {
        PLAYER_SPEED = 5.0f;
    }
    if (keyboard.isKeyDown(sf::Keyboard::W)) {
        camera.position += forwardsVector(camera.rotation) * PLAYER_SPEED;
    }
    else if (keyboard.isKeyDown(sf::Keyboard::S)) {
        camera.position += backwardsVector(camera.rotation) * PLAYER_SPEED;
    }
    if (keyboard.isKeyDown(sf::Keyboard::A)) {
        camera.position += leftVector(camera.rotation) * PLAYER_SPEED;
    }
    else if (keyboard.isKeyDown(sf::Keyboard::D)) {
        camera.position += rightVector(camera.rotation) * PLAYER_SPEED;
    }

    if (!isMouseActive) {
        return;
    }
    static auto lastMousePosition = sf::Mouse::getPosition(window);
    auto change = sf::Mouse::getPosition(window) - lastMousePosition;
    camera.rotation.x -= static_cast<float>(change.y * 0.5);
    camera.rotation.y += static_cast<float>(change.x * 0.5);
    sf::Mouse::setPosition({(int)window.getSize().x / 2, (int)window.getSize().y / 2}, window);
    lastMousePosition.x = (int)window.getSize().x / 2;
    lastMousePosition.y = (int)window.getSize().y / 2;

    camera.rotation.x = glm::clamp(camera.rotation.x, -89.9f, 89.9f);
    camera.rotation.y = (int)camera.rotation.y % 360;
}

void Game::onUpdate()
{
    m_sun.update(m_worldSize, m_timer.getElapsedTime().asMilliseconds());
    std::unique_lock<std::mutex> l(m_chunkVectorLock);
    while (!m_chunkMeshQueue.empty()) {

        ChunkMesh mesh = std::move(m_chunkMeshQueue.front());
        m_chunkMeshQueue.pop();
        if (mesh.indicesCount > 0) {
            VertexArray chunkVertexArray;
            chunkVertexArray.bufferMesh(mesh);
            int verts = mesh.vertices.size();
            int faces = verts / 4;
            if (mesh.chunkPosY >= WATER_LEVEL) {
                m_chunkAboveWaterRenderList.emplace_back(mesh.chunkPos, chunkVertexArray.getRendable(), verts, faces);
            }
            else {
                m_chunkUnderWaterRenderList.emplace_back(mesh.chunkPos, chunkVertexArray.getRendable(), verts, faces);
            }
            m_chunkVertexArrays.push_back(std::move(chunkVertexArray));
        }
    }

    m_stats.totalChunks = m_chunkUnderWaterRenderList.size() + m_chunkAboveWaterRenderList.size() * 2;
    m_stats.chunksDrawn = 0;
    m_isUnderwater = m_cameraTransform.position.y < WATER_LEVEL;

    m_stats.verticiesDrawn = 0;
    m_stats.totalVertices = 0;
    m_stats.blockFacesDrawn = 0;
    m_stats.totalBlockFaces = 0;
    for (auto& chunk : m_chunkAboveWaterRenderList) {
        m_stats.totalVertices += chunk.numVerts;
        m_stats.totalBlockFaces += chunk.numFaces;
    }
    for (auto& chunk : m_chunkUnderWaterRenderList) {
        m_stats.totalVertices += chunk.numVerts;
        m_stats.totalBlockFaces += chunk.numFaces;
    }
}

void Game::onRender()
{
    auto& underwater = m_chunkUnderWaterRenderList;
    auto& aboveWater = m_chunkAboveWaterRenderList;

    float distance = (m_cameraTransform.position.y - WATER_LEVEL) * 2;

    m_cameraTransform.position.y -= distance;
    m_cameraTransform.rotation.x = -m_cameraTransform.rotation.x;

    if (m_options.doWaterReflection && !m_isUnderwater) {
        m_reflectFramebuffer.bind();

        auto viewMatrix = createViewMartix(m_cameraTransform, {0, 1, 0});
        auto projectionViewMatrix = m_projectionMatrix * viewMatrix;
        m_frustum.update(projectionViewMatrix);

        setClearColour(COLOUR_SKY_BLUE);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        renderScene(projectionViewMatrix);
        prepareChunkRender(projectionViewMatrix);
        renderChunks(aboveWater, false);
    }

    m_cameraTransform.position.y += distance;
    m_cameraTransform.rotation.x = -m_cameraTransform.rotation.x;

    auto viewMatrix = createViewMartix(m_cameraTransform, {0, 1, 0});
    auto projectionViewMatrix = m_projectionMatrix * viewMatrix;
    m_frustum.update(projectionViewMatrix);

    if (m_options.doWaterRefraction) {
        setClearColour(COLOUR_SKY_BLUE);
        m_refractFramebuffer.bind();
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        prepareChunkRender(projectionViewMatrix);
        renderChunks(m_isUnderwater ? aboveWater : underwater, true);
    }

    setClearColour(COLOUR_SKY_BLUE);
    Framebuffer::unbind();
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    renderWater(projectionViewMatrix);
    renderScene(projectionViewMatrix);

    prepareChunkRender(projectionViewMatrix);
    renderChunks(m_isUnderwater ? underwater : aboveWater, true);
}

void Game::onGUI()
{
    guiDebugScreen(m_cameraTransform, m_stats);
    guiGraphicsOptions(&m_options);
    guiResetWorld(this, &Game::resetWorld, &m_terrainGenOptions);
    if (m_options.showPreviews) {
        constexpr int SIZE = 400;
        if (m_options.doWaterRefraction) {
            m_guiTexture.render(*m_refractTexture, WIDTH - SIZE, HEIGHT - SIZE, SIZE, SIZE);
        }

        if (m_options.doWaterReflection) {
            m_guiTexture.render(*m_reflectTexture, WIDTH - SIZE, (HEIGHT - SIZE * 2), SIZE, SIZE);
        }
    }
}

void Game::renderScene(const glm::mat4& projectionViewMatrix)
{
    // Normal stuff
    glDisable(GL_CULL_FACE);
    m_sceneShader.bind();
    m_sceneShader.set("projectionViewMatrix", projectionViewMatrix);
    m_sceneShader.set("isLight", false);
    m_sceneShader.set("lightColour", glm::vec3{1.0, 1.0, 1.0});
    m_sceneShader.set("lightDirection", {-0.2, -1, 0.3});
    m_sceneShader.set("eyePosition", m_cameraTransform.position);

    m_texture.bind(0);

    glm::mat4 terrainModel{1.0f};
    terrainModel = glm::translate(terrainModel, {-30, CHUNK_SIZE * 3, -40});
    m_sceneShader.set("modelMatrix", terrainModel);
    m_terrain.getRendable().drawElements();

    glEnable(GL_CULL_FACE);
    auto lightModel = createModelMatrix(m_sun.t);
    m_sceneShader.set("modelMatrix", lightModel);
    m_sceneShader.set("isLight", true);
    m_lightCube.getRendable().drawElements();
}

void Game::prepareChunkRender(const glm::mat4& projectionViewMatrix)
{
    // Chunks
    m_voxelShader.bind();
    m_voxelShader.set("projectionViewMatrix", projectionViewMatrix);
    m_voxelShader.set("lightColour", glm::vec3{1.0, 1.0, 1.0});
    m_voxelShader.set("lightDirection", m_sun.t.rotation);
    m_voxelShader.set("eyePosition", m_cameraTransform.position);
    // m_textureArray.bind();

    glm::mat4 voxelModel{1.0f};
    voxelModel = glm::translate(voxelModel, {0, 0, 0});
    m_voxelShader.set("modelMatrix", voxelModel);
}

void Game::renderChunks(std::vector<ChunkRenderable>& renderList, bool count)
{
    for (auto& chunk : renderList) {
        if (m_frustum.chunkIsInFrustum(chunk.position)) {
            chunk.renderable.drawElements();
            if (count) {
                m_stats.chunksDrawn++;
                m_stats.verticiesDrawn += chunk.numVerts;
                m_stats.blockFacesDrawn += chunk.numFaces;
            }
        }
    }
}

void Game::renderWater(const glm::mat4& projectionViewMatrix)
{
    glDisable(GL_CULL_FACE);
    m_waterShader.bind();
    m_waterShader.set("projectionViewMatrix", projectionViewMatrix);
    m_waterShader.set("lightColour", glm::vec3{1.0, 1.0, 1.0});
    m_waterShader.set("lightDirection", {0, -1, 0});
    m_waterShader.set("eyePosition", m_cameraTransform.position);
    m_waterShader.set("useFresnal", m_options.doFresnel);
    m_waterShader.set("isUnderwater", m_isUnderwater);
    m_waterShader.set("useDUDVMaps", m_options.useDistortMaps);
    m_waterShader.set("useNormalMaps", m_options.useNormal);
    m_waterShader.set("time", m_timer.getElapsedTime().asSeconds());

    if (m_options.doWaterReflection && !m_isUnderwater) {
        m_reflectTexture->bind(0);
    }
    else {
        m_waterTexture.bind(0);
    }
    if (m_options.doWaterRefraction) {
        m_refractTexture->bind(1);
    }
    else {
        m_waterTexture.bind(1);
    }

    m_waterDistortTexture.bind(2);
    m_waterNormalTexture.bind(3);

    glm::mat4 waterModel{1.0f};
    waterModel = glm::translate(waterModel, {0, WATER_LEVEL + 0.1, 0});
    m_waterShader.set("modelMatrix", waterModel);

    m_waterQuad.getRendable().drawElements();
}

void Game::runTerrainThread()
{
    // Cool seeds:
    // 12993 -> 3 islands with a harboury area between
    // 18087 -> Ridge mountins
    // 2914 -> lots of lil island
    // 24777 -> s i c k mountains
    // 11763 -> Cute islands
    // 11226 -> awesome mountains

    // 27949 -> VIBESVIBESVIBESVIBESVIBESVIBES

    while (m_isRunning) {
        std::this_thread::sleep_for(std::chrono::microseconds(10));

        {
            std::unique_lock<std::mutex> l(m_chunkUpdateLock);
            if (!m_chunkUpdateQueue.empty()) {
                ChunkPosition& p = m_chunkUpdateQueue.front();
                m_chunkUpdateQueue.pop();
                auto pos = createChunkTerrain(m_chunkMap, p.x, p.z, m_worldSize, m_terrainGenOptions);
                for (const auto& p : pos) {
                    m_chunkReadyForMeshingQueue.push(p);
                }
            }
        }

        {
            if (!m_chunkReadyForMeshingQueue.empty()) {
                std::unique_lock<std::mutex> cvl(m_chunkVectorLock);
                auto p = m_chunkReadyForMeshingQueue.front();
                if (m_chunkMap.hasNeighbours(p)) {
                    ChunkMesh mesh = m_terrainGenOptions.useGreedyMeshing
                                         ? createGreedyChunkMesh(m_chunkMap.getChunk(p))
                                         : createChunkMesh(m_chunkMap.getChunk(p));
                    m_chunkMeshQueue.push(mesh);
                    m_chunkReadyForMeshingQueue.pop();
                }
            }
        }
    }
}
