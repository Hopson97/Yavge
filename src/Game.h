#pragma once

#include "Chunk.h"
#include "Graphics/GLWrappers.h"
#include "Maths.h"
#include <SFML/System/Clock.hpp>
#include <SFML/Window/Window.hpp>
#include <queue>
#include <vector>

#include <atomic>
#include <condition_variable>
#include <iostream>
#include <mutex>
#include <thread>

class Keyboard;

struct Sun {
    Transform t;
    int orbitRadius = CHUNK_SIZE * 4;
    int orbitSpeed = 8000;
    void update(float time)
    {
        float rads = (2.0f * 3.14159f / orbitSpeed * time);
        t.position.x = CHUNK_SIZE * 10 + sin(rads) * orbitRadius;
        t.position.z = CHUNK_SIZE * 10 + cos(rads) * orbitRadius;
    }
};

class Game {

  public:
    Game();
    ~Game();

    void onInput(const Keyboard& keyboard, const sf::Window& window, bool isMouseActive);

    void onUpdate();

    void onRender();

    void onGUI();

  private:
    void renderScene(const glm::mat4& projectionViewMatrix);
    void renderTerrain(const glm::mat4& projectionViewMatrix);
    void renderWater(const glm::mat4& projectionViewMatrix);

    void runTerrainThread();

    Shader m_sceneShader;
    Shader m_voxelShader;
    Shader m_waterShader;

    VertexArray m_quad;
    VertexArray m_terrain;
    VertexArray m_lightCube;
    VertexArray m_grassCube;


    Texture2D m_texture;
    TextureArray2D m_textureArray;
    const Texture2D* m_frambufferTexture = nullptr;

    ChunkMap m_chunkMap;

    std::queue<ChunkMesh> m_chunkMeshQueue;
    std::queue<ChunkPosition> m_chunkReadyForMeshingQueue;
    std::queue<ChunkPosition> m_chunkUpdateQueue;

    std::vector<VertexArray> m_chunkVertexArrays;
    std::vector<Renderable> m_chunkRenderList;
    VertexArray m_waterQuad;
    Texture2D m_waterTexture;

    Sun m_sun;
    Transform m_cameraTransform;
    Transform m_quadTransform;

    glm::mat4 m_projectionMatrix;

    sf::Clock m_timer;

    std::mutex m_chunkVectorLock;
    std::mutex m_chunkUpdateLock;
    std::thread m_chunkMeshGenThread;
    std::atomic_bool m_isRunning{true};
};
