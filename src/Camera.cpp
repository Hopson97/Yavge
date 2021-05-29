#include "Camera.h"

#include "Utility.h"
#include <SFML/Window/Keyboard.hpp>
#include <SFML/Window/Mouse.hpp>

Camera::Camera()
{
    float aspect = (float)WIDTH / (float)HEIGHT;
    m_projectionMatrix = createProjectionMatrix(aspect, 90.0f);
    transform.rotation.y = -90.0f;
    m_up.y = 1.0f;
}

void Camera::mouseInput(const sf::Window& window)
{
    static sf::Vector2i m_lastMousePosition;
    sf::Vector2i change = sf::Mouse::getPosition(window) - m_lastMousePosition;
    transform.rotation.x -= static_cast<float>(change.y / 8.0f);
    transform.rotation.y += static_cast<float>(change.x / 8.0f);
    sf::Mouse::setPosition({(int)window.getSize().x / 2, (int)window.getSize().y / 2}, window);
    m_lastMousePosition = sf::Mouse::getPosition(window);

    transform.rotation.x = glm::clamp(transform.rotation.x, -89.9f, 89.9f);
    transform.rotation.y = (int)transform.rotation.y % 360;
}

void Camera::keyboardInput()
{
    const float FACTOR = 0.25f;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::W)) {
        transform.position += forwardsVector(transform.rotation) * FACTOR;
    }
    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::S)) {
        transform.position += backwardsVector(transform.rotation) * FACTOR;
    }
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::A)) {
        transform.position += leftVector(transform.rotation) * FACTOR;
    }
    else if (sf::Keyboard::isKeyPressed(sf::Keyboard::D)) {
        transform.position += rightVector(transform.rotation) * FACTOR;
    }
}

glm::mat4 Camera::update()
{
    glm::mat4 viewMatrix = createViewMartix(transform, m_up);
    return m_projectionMatrix * viewMatrix;
}
