#include "GUI.h"
#include "Game.h"
#include "Graphics/GLWrappers.h"
#include "Utility.h"

int main()
{
    bool isMouseActive = true;

    // Init Window, OpenGL set up etc
    sf::Window window;
    if (!initWindow(&window)) {
        return 1;
    }
    window.setFramerateLimit(60);
    guiInit(window);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glClearColor(0.3f, 0.8f, 1.0f, 0.0f);

    // Final render target
    // VertexArray screen;
    // Shader screenShader;
    // Framebuffer framebuffer;

    // screenShader.loadFromFile("ScreenVertex.glsl", "ScreenFragment.glsl");
    // framebuffer.create(WIDTH, HEIGHT);
    // const Texture2D* colour = framebuffer.addTexture();
    // framebuffer.finish();

    // The game/ system itself
    Game game;

    Keyboard keyboard;
    while (window.isOpen()) {
        guiBeginFrame();
        sf::Event e;
        while (window.pollEvent(e)) {
            keyboard.update(e);
            guiProcessEvent(e);
            if (e.type == sf::Event::KeyReleased) {
                if (e.key.code == sf::Keyboard::Escape) {
                    window.close();
                }
                else if (e.key.code == sf::Keyboard::L) {
                    isMouseActive = !isMouseActive;
                }
            }
        }

        // Input + update
        game.onInput(keyboard, window, isMouseActive);

        game.onUpdate();

        //
        glEnable(GL_DEPTH_TEST);
        //   framebuffer.bind();

        // Render the regular scene
        glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
        game.onRender();

        // Render the frame buffer content to the window
        // Framebuffer::unbind();
        // screenShader.bind();
        //  colour->bind();
        //  screen.getRendable().drawArrays(6);

        game.onGUI();
        guiEndFrame();

        window.display();
    }
    guiShutdown();
}