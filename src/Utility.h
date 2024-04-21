#pragma once

#include <SFML/Window/Event.hpp>
#include <SFML/Window/Window.hpp>

#include <glm/glm.hpp>

#include <array>
#include <filesystem>

// Default window height and width
constexpr unsigned WIDTH = 1600;
constexpr unsigned HEIGHT = 900;

std::string getFileContent(const std::filesystem::path& filePath);

enum ColourSetMode {
    COL_SET_BG = 48,
    COL_SET_FG = 38,
};

class Keyboard {
  public:
    Keyboard()
    {
        std::fill(m_keys.begin(), m_keys.end(), false);
    }

    bool isKeyDown(sf::Keyboard::Key key) const
    {
        return m_keys[key];
    }

    void update(sf::Event e)
    {
        if (e.type == sf::Event::KeyPressed) {
            m_keys[e.key.code] = true;
        }
        else if (e.type == sf::Event::KeyReleased) {
            m_keys[e.key.code] = false;
        }
    }

  private:
    std::array<bool, sf::Keyboard::KeyCount> m_keys{false};
};

bool initWindow(sf::Window* window);
void setClearColour(const glm::vec4& colour);
void setTextColour(const glm::vec4& colour);
void setBackgroundColour(const glm::vec4& colour);

const glm::vec4 COLOUR_SKY_BLUE = {135, 206, 235, 255};
const glm::vec4 COLOUR_SAND = {235, 214, 135, 255};
