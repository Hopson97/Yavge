#pragma once

#include "Chunk.h"
#include "GUI.h"
#include "Graphics/GLWrappers.h"
#include "GraphicsOptions.h"
#include "Maths.h"
#include <SFML/System/Clock.hpp>
#include <SFML/Window/Window.hpp>
#include <atomic>
#include <iostream>
#include <mutex>
#include <queue>
#include <thread>
#include <vector>

class Keyboard;

struct ChunkRenderable {
    ChunkRenderable(const ChunkPosition& chunkPosition, Renderable chunkRenderable)
        : position(chunkPosition)
        , renderable(chunkRenderable)
    {
    }

    ChunkPosition position;
    Renderable renderable;
};

struct Sun {
    Transform t;
    int orbitRadius = CHUNK_SIZE;
    int orbitSpeed = 24000;
    int center;
    
    void update(float time)
    {
        float rads = (2.0f * 3.14159f / orbitSpeed * time);
        t.position.x = center + sin(rads) * orbitRadius;
        t.position.z = center + cos(rads) * orbitRadius;
        t.position.y = CHUNK_SIZE * 5;
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
    void resetWorld(int worldSize);
    void renderScene(const glm::mat4& projectionViewMatrix);
    void renderWater(const glm::mat4& projectionViewMatrix);

    void prepareChunkRender(const glm::mat4& projectionViewMatrix);
    void renderChunks(std::vector<ChunkRenderable>& renderList);

    void runTerrainThread();

    Shader m_sceneShader;
    Shader m_voxelShader;
    Shader m_waterShader;

    VertexArray m_terrain;
    VertexArray m_lightCube;

    Texture2D m_texture;
    Texture2D m_waterDistortTexture;
    Texture2D m_waterNormalTexture;
    TextureArray2D m_textureArray;

    Framebuffer m_refractFramebuffer;
    const Texture2D* m_refractTexture = nullptr;

    Framebuffer m_reflectFramebuffer;
    const Texture2D* m_reflectTexture = nullptr;

    Sun m_sun;

    ViewFrustum m_frustum;
    Transform m_cameraTransform;
    Transform m_quadTransform;

    glm::mat4 m_projectionMatrix;

    sf::Clock m_timer;

    // Chunk render stuff

    std::vector<VertexArray> m_chunkVertexArrays;
    std::vector<ChunkRenderable> m_chunkUnderWaterRenderList;
    std::vector<ChunkRenderable> m_chunkAboveWaterRenderList;
    VertexArray m_waterQuad;
    Texture2D m_waterTexture;

    ChunkMap m_chunkMap;
    std::queue<ChunkMesh> m_chunkMeshQueue;
    std::queue<ChunkPosition> m_chunkReadyForMeshingQueue;
    std::queue<ChunkPosition> m_chunkUpdateQueue;
    std::mutex m_chunkVectorLock;
    std::mutex m_chunkUpdateLock;
    std::thread m_chunkMeshGenThread;
    std::atomic_bool m_isRunning{true};
    SpriteRenderer m_guiTexture;

    GraphicsOptions m_options;
    Stats m_stats;

    int m_worldSize = 0;

    bool m_isUnderwater = false;
};
