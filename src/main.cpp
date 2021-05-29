#include "Camera.h"
#include "GUI.h"
#include "Graphics/GLWrappers.h"
#include "Graphics/Mesh.h"
#include "Maths.h"
#include "Utility.h"
#include <SFML/GpuPreference.hpp>
#include <SFML/Graphics.hpp>
#include <SFML/System/Clock.hpp>

int main(void)
{
    sf::Window window;
    window.setFramerateLimit(60);
    window.setMouseCursorGrabbed(true);
    if (!initWindow(&window)) {
        return 1;
    }
    glClearColor(0.5, 0.5, 0.5, 0.0);
    glViewport(0, 0, WIDTH, HEIGHT);
    guiInit(window);

    // Init OpenGL Objects
    // clang-format off

    // clang-format on
    auto quadMesh = createQuadMesh();
    VertexArray quad;
    quad.bufferMesh(quadMesh);

    VertexArray screen;

    Shader shader("MinVertex.glsl", "MinFragment.glsl");
    Shader frameBufferShader("FramebufferVertex.glsl", "FramebufferFragment.glsl");

    Texture2d texture;
    texture.loadTexture("opengl_logo.png");

    Framebuffer framebuffer(WIDTH, HEIGHT);
    auto colour = framebuffer.addTexture();
    framebuffer.finish();

    // Init scene
    Camera camera;
    camera.transform.position.x = 50;
    camera.transform.position.y = 50;
    camera.transform.position.z = 50;

    // Scene objects
    Transform modelTransform;

    // JFF
    sf::Clock sinTimer;

    // Init window
    while (window.isOpen()) {
        guiBeginFrame();
        sf::Event event;
        while (window.pollEvent(event)) {
            guiProcessEvent(event);
            if (event.type == sf::Event::Closed) {
                window.close();
            }
            else if (event.type == sf::Event::KeyReleased) {
                if (event.key.code == sf::Keyboard::Escape) {
                    window.close();
                }
            }
        }
        camera.mouseInput(window);

        //  Input
        camera.keyboardInput();
        camera.update();

        // Update
        glm::mat4 projectionViewMatrix = camera.update();

        // Render
        guiDebugScreen(camera);
        glEnable(GL_DEPTH_TEST);

        // 1. Bind framebuffer target
        framebuffer.bind();

        // Use the scene shaders
        shader.bind();
        shader.loadUniform("projectionViewMatrix", projectionViewMatrix);

        // Render the quad
        quad.bind();
        texture.bind();
        modelTransform.position += glm::sin(sinTimer.getElapsedTime().asSeconds()) / 128;
        modelTransform.rotation += 1.0f;
        glm::mat4 modelMatrix = createModelMatrix(modelTransform);
        shader.loadUniform("modelMatrix", modelMatrix);

        glDrawElements(GL_TRIANGLES, quad.indicesCount(), GL_UNSIGNED_INT, 0);

        // 2. Unbind framebuffers, render to the window
        glBindFramebuffer(GL_FRAMEBUFFER, 0);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        frameBufferShader.bind();
        colour->bind();

        // Render to window
        screen.bind();
        glDrawArrays(GL_TRIANGLES, 0, 6);
        guiEndFrame();

        window.display();

        // End frame
        // SDL_GL_SwapWindow(window);
    }
    guiShutdown();
    return 0;
}
