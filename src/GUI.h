#pragma once

#include <SFML/Window.hpp>

#include "Graphics/Shader.h"
#include "Graphics/Texture.h"
#include "Graphics/VertexArray.h"
#include <glm/glm.hpp>

struct Transform;

void guiInit(sf::Window& window);
void guiShutdown();

void guiBeginFrame();
void guiProcessEvent(sf::Event& event);
void guiEndFrame();

void guiDebugScreen(const Transform& transform);

struct SpriteRenderer {
  public:
    SpriteRenderer();
    void render(Texture2D& texture, float x, float y, float width, float height);

  private:
    VertexArray m_guiQuad;
    Shader m_guiShader;
};