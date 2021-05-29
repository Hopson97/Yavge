#pragma once

#include <SFML/Window/Window.hpp>

// Default window height and width
#define WIDTH 1600
#define HEIGHT 900

char* getFileContent(const char* fileName);

// Colour Util
struct Colour {
    uint8_t red = 255;
    uint8_t green = 255;
    uint8_t blue = 255;
};

enum ColourSetMode {
    COL_SET_BG = 48,
    COL_SET_FG = 38,
};

void setTerminalBackgroundColour(Colour colour);
void setTerminalTextColour(Colour colour);

void setBackgroundColourRGB(uint8_t red, uint8_t green, uint8_t blue);
void setTextColourRGB(uint8_t red, uint8_t green, uint8_t blue);

bool initWindow(sf::Window* window);
