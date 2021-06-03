#include "Game.h"

#include "ChunkTerrainGen.h"
#include "Utility.h"
#include "Voxels.h"

constexpr int WORLD_SIZE = 16;

Game::Game()
{
    // clang-format off
    m_sceneShader   .loadFromFile("SceneVertex.glsl",   "SceneFragment.glsl");
    m_voxelShader   .loadFromFile("VoxelVertex.glsl",   "VoxelFragment.glsl");
    m_waterShader   .loadFromFile("WaterVertex.glsl",   "WaterFragment.glsl");
    m_terrain   .bufferMesh(createTerrainMesh(64, 128, false));
    m_lightCube .bufferMesh(createCubeMesh({5.5f, 5.5f, 5.5f}));

    m_waterQuad .bufferMesh(createTerrainMesh(CHUNK_SIZE * WORLD_SIZE, CHUNK_SIZE * 4, true));
    
    m_refractFramebuffer.create(WIDTH , HEIGHT );
    m_refractFramebuffer.addRenderBuffer();
    m_refractFramebuffer.finish();

    m_reflectFramebuffer.create(WIDTH , HEIGHT);
    m_reflectFramebuffer.addRenderBuffer();
    m_reflectFramebuffer.finish();

    m_refractTexture = m_refractFramebuffer.addTexture();
    m_reflectTexture = m_reflectFramebuffer.addTexture();

    m_texture.useDefaultFilters();
    m_texture.loadFromFile("opengl_logo.png");

    m_waterTexture.useDefaultFilters();
    m_waterTexture.loadFromFile("water.png");
    m_textureArray.create(16, 16);
    
    initVoxelSystem(m_textureArray);

    auto c = CHUNK_SIZE * WORLD_SIZE / 2 - CHUNK_SIZE / 2;
    m_cameraTransform = { {c, CHUNK_SIZE * 5, c}, {0, 0, 0} };
    m_sun.t.position.y = CHUNK_SIZE * 3;
    m_sun.t.position.x = CHUNK_SIZE * WORLD_SIZE / 2;
    m_sun.t.position.z = CHUNK_SIZE *  WORLD_SIZE / 2;

    float aspect = (float)WIDTH / (float)HEIGHT;
    m_projectionMatrix = createProjectionMatrix(aspect, 90.0f);

    for (int x = 0; x < WORLD_SIZE; x++) {
        for (int z = 0; z < WORLD_SIZE; z++) {
            m_chunkUpdateQueue.push({x, 0, z});
        }
    }

    m_chunkMeshGenThread = std::thread([&]{
        runTerrainThread();
    });

    glCullFace(GL_BACK);

    // clang-format on
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

    const float PLAYER_SPEED = 1.0f;
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
    //  m_sun.update(m_timer.getElapsedTime().asMilliseconds());
    std::unique_lock<std::mutex> l(m_chunkVectorLock);
    while (!m_chunkMeshQueue.empty()) {

        ChunkMesh mesh = std::move(m_chunkMeshQueue.front());
        m_chunkMeshQueue.pop();
        if (mesh.indicesCount > 0) {
            VertexArray chunkVertexArray;
            chunkVertexArray.bufferMesh(mesh);
            if (mesh.chunkPosY >= WATER_LEVEL) {
                m_chunkAboveWaterRenderList.emplace_back(mesh.chunkPos, chunkVertexArray.getRendable());
            }
            else {
                m_chunkUnderWaterRenderList.emplace_back(mesh.chunkPos, chunkVertexArray.getRendable());
            }
            m_chunkVertexArrays.push_back(std::move(chunkVertexArray));
        }
    }

    m_stats.totalChunks = m_chunkUnderWaterRenderList.size() + m_chunkAboveWaterRenderList.size() * 2;
    m_stats.chunksDrawn = 0;
}

void Game::onRender()
{
    glEnable(GL_CLIP_DISTANCE0);
    float distance = (m_cameraTransform.position.y - WATER_LEVEL) * 2;

    m_cameraTransform.position.y -= distance;
    m_cameraTransform.rotation.x = -m_cameraTransform.rotation.x;

    if (m_options.doWaterReflection) {
        m_reflectFramebuffer.bind();

        auto viewMatrix = createViewMartix(m_cameraTransform, {0, 1, 0});
        auto projectionViewMatrix = m_projectionMatrix * viewMatrix;
        m_frustum.update(projectionViewMatrix);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        renderScene(projectionViewMatrix);

        prepareChunkRender(projectionViewMatrix);
        renderChunks(m_chunkAboveWaterRenderList);
    }

    m_cameraTransform.position.y += distance;
    m_cameraTransform.rotation.x = -m_cameraTransform.rotation.x;

    auto viewMatrix = createViewMartix(m_cameraTransform, {0, 1, 0});
    auto projectionViewMatrix = m_projectionMatrix * viewMatrix;
    m_frustum.update(projectionViewMatrix);

    if (m_options.doWaterRefraction) {
        m_refractFramebuffer.bind();
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        renderScene(projectionViewMatrix);

        prepareChunkRender(projectionViewMatrix);
        renderChunks(m_chunkUnderWaterRenderList);
    }
    Framebuffer::unbind();
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    renderWater(projectionViewMatrix);
    renderScene(projectionViewMatrix);

    prepareChunkRender(projectionViewMatrix);
    renderChunks(m_chunkAboveWaterRenderList);
}

void Game::onGUI()
{
    guiDebugScreen(m_cameraTransform, m_stats);
    guiGraphicsOptions(&m_options);

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
    m_sceneShader.set("lightPosition", m_sun.t.position);
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
    m_voxelShader.set("lightPosition", m_sun.t.position);
    m_voxelShader.set("eyePosition", m_cameraTransform.position);
    m_textureArray.bind();

    glm::mat4 voxelModel{1.0f};
    voxelModel = glm::translate(voxelModel, {0, 0, 0});
    m_voxelShader.set("modelMatrix", voxelModel);
}

void Game::renderChunks(std::vector<ChunkRenderable>& renderList)
{
    for (auto& chunk : renderList) {
        if (m_frustum.chunkIsInFrustum(chunk.position)) {
            m_stats.chunksDrawn++;
            chunk.renderable.drawElements();
        }
    }
}

void Game::renderWater(const glm::mat4& projectionViewMatrix)
{
    glDisable(GL_CULL_FACE);
    m_waterShader.bind();
    m_waterShader.set("projectionViewMatrix", projectionViewMatrix);
    m_waterShader.set("lightColour", glm::vec3{1.0, 1.0, 1.0});
    m_waterShader.set("lightPosition", m_sun.t.position);
    m_waterShader.set("eyePosition", m_cameraTransform.position);
    m_waterShader.set("useFresnal", m_options.doFresnel);

    if (m_options.doWaterReflection) {
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
    glm::mat4 waterModel{1.0f};
    waterModel = glm::translate(waterModel, {0, WATER_LEVEL, 0});
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

    std::srand(std::time(0));
    int seed = std::rand() % 30000;

    std::cout << "SEED: " << seed << "\n";

    while (m_isRunning) {
        std::this_thread::sleep_for(std::chrono::microseconds(10));

        {
            std::unique_lock<std::mutex> l(m_chunkUpdateLock);
            if (!m_chunkUpdateQueue.empty()) {
                ChunkPosition& p = m_chunkUpdateQueue.front();
                m_chunkUpdateQueue.pop();
                auto pos = createChunkTerrain(m_chunkMap, p.x, p.z, WORLD_SIZE, seed);
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
                    m_chunkMeshQueue.push(createChunkMesh(m_chunkMap.getChunk(p)));
                    m_chunkReadyForMeshingQueue.pop();
                }
            }
        }
    }
}
