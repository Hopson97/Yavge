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
#include <mutex>
#include <thread>

class Keyboard;

class Game {
  public:
    Game();
    ~Game();

    void onInput(const Keyboard& keyboard, const sf::Window& window, bool isMouseActive);

    void onUpdate();

    void onRender();

    void onGUI();

  private:
    void runTerrainThread();

    Shader m_sceneShader;
    Shader m_voxelShader;

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

    Transform m_cameraTransform;
    Transform m_lightCubeTransform;
    Transform m_quadTransform;

    glm::mat4 m_projectionMatrix;

    sf::Clock m_timer;

    std::mutex m_chunkVectorLock;
    std::mutex m_chunkUpdateLock;
    std::thread m_chunkMeshGenThread;
    std::atomic_bool m_isRunning{true};
};
