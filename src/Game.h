#pragma once

#include "Chunk.h"
#include "Graphics/GLWrappers.h"
#include "Maths.h"
#include <SFML/System/Clock.hpp>
#include <SFML/Window/Window.hpp>
#include <vector>

class Keyboard;

class Game {
  public:
    Game();

    void onInput(const Keyboard& keyboard, const sf::Window& window, bool isMouseActive);

    void onUpdate();

    void onRender();

    void onGUI();

  private:
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
    std::vector<VertexArray> m_chunkVertexArrays;
    std::vector<Renderable> m_chunkRenderList;

    Transform m_cameraTransform;
    Transform m_lightCubeTransform;
    Transform m_quadTransform;

    glm::mat4 m_projectionMatrix;

    sf::Clock m_timer;
};
