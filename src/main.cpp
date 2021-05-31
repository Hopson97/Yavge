#include "Chunk.h"
#include "GUI.h"
#include "Graphics/GLWrappers.h"
#include "Maths.h"
#include "Utility.h"
#include "Voxels.h"

#include "ChunkMesh.h"
#include "ChunkTerrainGen.h"

bool mouseActive = true;
Transform camera{
    {0, 0, 2},
    {0, -90, 0},
};

glm::vec3 lightPosition{66, 33, 66};

void mouseInput(const sf::Window& window)
{
    if (!mouseActive)
        return;
    // Input stuff
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

void keyboardInput(const Keyboard& keyboard)
{
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
}

int main()
{
    // Init Window, OpenGL set up etc
    sf::Window window;
    if (!initWindow(&window)) {
        return 1;
    }
    window.setFramerateLimit(60);
    guiInit(window);
    glClearColor(0.3f, 0.8f, 1.0f, 0.0f);

    Shader sceneShader("SceneVertex.glsl", "SceneFragment.glsl");
    Shader screenShader("ScreenVertex.glsl", "ScreenFragment.glsl");
    Shader voxelShader("VoxelVertex.glsl", "VoxelFragment.glsl");

    // Screen VAO is the final render target renderable thing
    VertexArray screen;

    // A square
    VertexArray quad;
    quad.bufferMesh(createQuadMesh());

    // Normal terrain
    VertexArray terrain;
    terrain.bufferMesh(createTerrainMesh());

    // A cube to represent the light
    VertexArray lightCube;
    lightCube.bufferMesh(createCubeMesh({2.5f, 2.5f, 2.5f}));

    // a cute cube
    VertexArray grassCube;
    grassCube.bufferMesh(createGrassCubeMesh());

    // Normal texture
    Texture2D texture;
    texture.loadTexture("opengl_logo.png");

    // Init the block system, which also populates this texture array
    TextureArray2D textureArray;
    textureArray.create(16, 16);
    initVoxelSystem(textureArray);

    ChunkMap chunkMap;
    constexpr int worldSize = 20;
    auto pos = createChunkTerrains(chunkMap, worldSize);

    std::vector<VertexArray> chunkVertexArrays;
    std::vector<Renderable> chunkRenderList;

    for (const auto& p : pos) {
        VertexArray v;
        v.bufferMesh(createChunkMesh(chunkMap.getChunk(p)));
        chunkRenderList.push_back(v.getRendable());
        chunkVertexArrays.push_back(std::move(v));
    }

    Framebuffer framebuffer(WIDTH, HEIGHT);
    const Texture2D* colour = framebuffer.addTexture();
    framebuffer.finish();

    Transform quadTransform;

    float aspect = (float)WIDTH / (float)HEIGHT;
    glm::mat4 projectionMatrix = createProjectionMatrix(aspect, 90.0f);

    sf::Clock clock;

    Keyboard keyboard;
    while (window.isOpen()) {
        guiBeginFrame();
        sf::Event e;
        while (window.pollEvent(e)) {
            keyboard.update(e);
            guiProcessEvent(e);
            if (e.type == sf::Event::KeyReleased) {
                if (e.key.code == sf::Keyboard::Escape) {
                    window.close();
                }
                else if (e.key.code == sf::Keyboard::L) {
                    mouseActive = !mouseActive;
                }
            }
        }

        lightPosition.x += sin(clock.getElapsedTime().asSeconds()) / 16;
        lightPosition.z += cos(clock.getElapsedTime().asSeconds()) / 16;

        //  I n p u t
        keyboardInput(keyboard);
        mouseInput(window);

        // U p d a t e
        auto viewMatrix = createViewMartix(camera, {0, 1, 0});
        auto projectionViewMatrix = projectionMatrix * viewMatrix;

        // R e n d e r
        // To the framebuffer
        glEnable(GL_DEPTH_TEST);
        framebuffer.bind();

        // Render the regular scene
        sceneShader.bind();
        sceneShader.set("projectionViewMatrix", projectionViewMatrix);
        texture.bind();

        auto modelMatrix = createModelMatrix(quadTransform);
        sceneShader.set("modelMatrix", modelMatrix);

        quad.getRendable().drawElements();

        glm::mat4 terrainModel{1.0f};
        terrainModel = glm::translate(terrainModel, {100, 10, 100});
        sceneShader.set("modelMatrix", terrainModel);
        terrain.getRendable().drawElements();

        glm::mat4 lightModel{1.0f};
        lightModel = glm::translate(lightModel, lightPosition);
        sceneShader.set("modelMatrix", lightModel);
        lightCube.getRendable().drawElements();

        // Render the voxels/chunks/mesh chunk/ voxel mesh forms
        voxelShader.bind();
        voxelShader.set("projectionViewMatrix", projectionViewMatrix);
        textureArray.bind();

        glm::mat4 voxelModel{1.0f};
        voxelModel = glm::translate(voxelModel, {0, 10, 0});
        voxelShader.set("modelMatrix", voxelModel);
        grassCube.getRendable().drawElements();

        voxelModel = glm::translate(voxelModel, {-100, -100, 0});
        voxelShader.set("modelMatrix", voxelModel);
        for (auto& chunk : chunkRenderList) {
            chunk.drawElements();
        }

        // To the window
        Framebuffer::unbind();
        screenShader.bind();
        colour->bind();

        screen.getRendable().drawArrays(6);

        guiDebugScreen(camera);
        guiEndFrame();

        window.display();
    }
    guiShutdown();
}