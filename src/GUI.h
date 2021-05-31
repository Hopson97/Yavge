#pragma once

#include <SFML/Window.hpp>

#include "Game.h"

struct Transform;

void guiInit(sf::Window& window);
void guiShutdown();

void guiBeginFrame();
void guiProcessEvent(sf::Event& event);
void guiEndFrame();

void guiDebugScreen(const Transform& transform);
void gameDebugScreen(Sun& sun);
