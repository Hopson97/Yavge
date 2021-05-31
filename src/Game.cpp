#include "Game.h"

#include "ChunkTerrainGen.h"
#include "GUI.h"
#include "Utility.h"
#include "Voxels.h"

Game::Game()
{
    // clang-format off
    m_sceneShader   .loadFromFile("SceneVertex.glsl",   "SceneFragment.glsl");
    m_voxelShader   .loadFromFile("VoxelVertex.glsl",   "VoxelFragment.glsl");
  
    m_quad      .bufferMesh(createQuadMesh());
    m_terrain   .bufferMesh(createTerrainMesh());
    m_lightCube .bufferMesh(createCubeMesh({2.5f, 2.5f, 2.5f}));
    m_grassCube .bufferMesh(createGrassCubeMesh());

    m_texture.loadTexture("opengl_logo.png");
    m_textureArray.create(16, 16);
    initVoxelSystem(m_textureArray);

    auto pos = createChunkTerrains(m_chunkMap, 25);
    for (const auto& p : pos) {
        VertexArray chunkVertexArray;
        chunkVertexArray.bufferMesh(createChunkMesh(m_chunkMap.getChunk(p)));
        m_chunkRenderList.push_back(chunkVertexArray.getRendable());
        m_chunkVertexArrays.push_back(std::move(chunkVertexArray));
    }

    m_cameraTransform = { {0, 0, 2}, {0, -90, 0} };

    m_lightCubeTransform.position = {66, 33, 66};

    float aspect = (float)WIDTH / (float)HEIGHT;
    m_projectionMatrix = createProjectionMatrix(aspect, 90.0f);

    // clang-format on
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

    if (!isMouseActive)
        return;
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
    m_lightCubeTransform.position.x += sin(m_timer.getElapsedTime().asSeconds()) / 16;
    m_lightCubeTransform.position.z += cos(m_timer.getElapsedTime().asSeconds()) / 16;
}

void Game::onRender()
{
    auto viewMatrix = createViewMartix(m_cameraTransform, {0, 1, 0});
    auto projectionViewMatrix = m_projectionMatrix * viewMatrix;

    m_sceneShader.bind();
    m_sceneShader.set("projectionViewMatrix", projectionViewMatrix);
    m_texture.bind();

    auto modelMatrix = createModelMatrix(m_quadTransform);
    m_sceneShader.set("modelMatrix", modelMatrix);

    m_quad.getRendable().drawElements();

    glm::mat4 terrainModel{1.0f};
    terrainModel = glm::translate(terrainModel, {100, 10, 100});
    m_sceneShader.set("modelMatrix", terrainModel);
    m_terrain.getRendable().drawElements();

    auto lightModel = createModelMatrix(m_lightCubeTransform);
    m_sceneShader.set("modelMatrix", lightModel);
    m_lightCube.getRendable().drawElements();

    // Render the voxels/chunks/mesh chunk/ voxel mesh forms
    m_voxelShader.bind();
    m_voxelShader.set("projectionViewMatrix", projectionViewMatrix);
    m_textureArray.bind();

    glm::mat4 voxelModel{1.0f};
    voxelModel = glm::translate(voxelModel, {0, 10, 0});
    m_voxelShader.set("modelMatrix", voxelModel);
    m_grassCube.getRendable().drawElements();

    voxelModel = glm::translate(voxelModel, {-100, -100, 0});
    m_voxelShader.set("modelMatrix", voxelModel);
    for (auto& chunk : m_chunkRenderList) {
        chunk.drawElements();
    }
}

void Game::onGUI()
{
    guiDebugScreen(m_cameraTransform);
}