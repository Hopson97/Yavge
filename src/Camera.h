#pragma once

#include "Maths.h"

#include <SFML/Window.hpp>

class Camera {
  public:
    Camera();

    void mouseInput(const sf::Window& window);
    void keyboardInput();

    glm::mat4 update();

    Transform transform;

  private:
    glm::mat4 m_projectionMatrix{1.0f};

    glm::vec3 m_up{0.0f};
    glm::vec3 m_front{0.0f};
};
