#include "GUI.h"

#include "GraphicsOptions.h"
#include "Maths.h"
#include "Utility.h"
#include <nuklear/nuklear_def.h>
#include <nuklear/nuklear_sfml_gl3.h>
#include "Game.h"
#include "ChunkMesh.h"

#include <iomanip>
#include <locale>

template<class T>
std::string formatNumber(T value)
{
    std::stringstream ss;
    ss.imbue(std::locale(""));
    ss << std::fixed << value;
    return ss.str();
}

#define MAX_VERTEX_MEMORY 0x80000
#define MAX_ELEMENT_MEMORY 0x80000

struct nk_context* ctx;
sf::Clock fpsClock;
float frames = 0;
float fps;
float frameTime = 0;

const sf::Window* p_window = nullptr;

int window_flags = 0;

void guiInit(sf::Window& window)
{
    window_flags |= NK_WINDOW_BORDER;
    window_flags |= NK_WINDOW_SCALABLE;
    window_flags |= NK_WINDOW_MOVABLE;
    window_flags |= NK_WINDOW_NO_SCROLLBAR;
    window_flags |= NK_WINDOW_SCALE_LEFT;
    window_flags |= NK_WINDOW_MINIMIZABLE;
    p_window = &window;
    // set_style(ctx, THEME_WHITE);
    ctx = nk_sfml_init(&window);
    {
        struct nk_font_atlas* atlas;
        nk_sfml_font_stash_begin(&atlas);
        /*struct nk_font *droid = nk_font_atlas_add_from_file(atlas,
         * "../../../extra_font/DroidSans.ttf", 14, 0);*/
        nk_sfml_font_stash_end();
    }
    // nk_set_style(ctx, THEME_DARK);
}

void guiShutdown(void)
{
    nk_sfml_shutdown();
}

void guiBeginFrame(void)
{
    nk_input_begin(ctx);
    frames++;
    if (fpsClock.getElapsedTime().asSeconds() >= 1.0f) {
        fps = frames;
        frameTime = (float)fpsClock.getElapsedTime().asMilliseconds() / frames;

        fpsClock.restart();
        frames = 0;
    }
}

void guiProcessEvent(sf::Event& event)
{
    nk_sfml_handle_event(&event);
}

void guiEndFrame(void)
{
    if (p_window->isOpen()) {
        nk_sfml_render(NK_ANTI_ALIASING_ON, MAX_VERTEX_MEMORY, MAX_ELEMENT_MEMORY);
    }
}

void guiDebugScreen(const Transform& transform, const Stats& stats)
{
    if (nk_begin(ctx, "Debug Window", nk_rect(10, 10, 300, 130), window_flags)) {
        nk_layout_row_dynamic(ctx, 12, 1);
        nk_labelf(ctx, NK_STATIC, "Player Position: (%.*f, %.*f, %.*f)", 2, transform.position[0], 2, transform.position[1],
                  2, transform.position[2]);

        nk_labelf(ctx, NK_STATIC, "Player Rotation: (%.*f, %.*f, %.*f)",  2, transform.rotation[0],  2, transform.rotation[1],
                   2, transform.rotation[2]);


        nk_labelf(ctx, NK_STATIC, "FPS: %f", fps);
        nk_labelf(ctx, NK_STATIC, "Frame Time: %f", frameTime);
    }
    nk_end(ctx);

    if (nk_begin(ctx, "Draw Stats", nk_rect(320, 10, 450, 130), window_flags)) {
        nk_layout_row_dynamic(ctx, 12, 1);
        nk_labelf(ctx, NK_STATIC, "Note: These numbers include redraws (EG reflections).");
        nk_layout_row_dynamic(ctx, 14, 1);
        nk_labelf(ctx, NK_STATIC, "This means the *real* total values are a bit smaller.");
        int verticiesDrawn = stats.verticiesDrawn;
        int totalVertices = stats.totalVertices;
        float verticiesDrawnMem = (float)sizeof(VoxelVertex) * stats.verticiesDrawn / (1024.0f * 1024.0f);
        float totalVerticesMem = (float)sizeof(VoxelVertex) * stats.totalVertices / (1024.0f * 1024.0f);
        int blockFacesDrawn = stats.blockFacesDrawn;
        int totalBlockFaces = stats.totalBlockFaces;

        nk_labelf(ctx, NK_STATIC, "Chunks Drawn: %d / %d", stats.chunksDrawn, stats.totalChunks);
        nk_labelf(ctx, NK_STATIC, "Vertices Drawn: %s / %s (%.*f / %.*f MB)", formatNumber(verticiesDrawn).c_str(), formatNumber(totalVertices).c_str(), 2, verticiesDrawnMem, 2, totalVerticesMem);
        nk_labelf(ctx, NK_STATIC, "Faces Drawn: %s / %s", formatNumber(blockFacesDrawn).c_str(), formatNumber(totalBlockFaces).c_str());
    }
    nk_end(ctx);
}

void guiGraphicsOptions(GraphicsOptions* options)
{
    if (nk_begin(ctx, "Graphics Options", nk_rect(10, 150, 200, 200), window_flags)) {
        nk_layout_row_dynamic(ctx, 14, 1);
        nk_labelf(ctx, NK_STATIC, "Press 'L' to unlock mouse.");
        nk_labelf(ctx, NK_STATIC, "Press 'ESC' to exit.");

        nk_checkbox_label(ctx, "Reflection Enabled", &options->doWaterReflection);
        nk_checkbox_label(ctx, "Refractions Enabled", &options->doWaterRefraction);
        nk_checkbox_label(ctx, "Fresnel Effect", &options->doFresnel);
        nk_checkbox_label(ctx, "Water Distortian", &options->useDistortMaps);
        nk_checkbox_label(ctx, "Water Normal", &options->useNormal);

        nk_checkbox_label(ctx, "Show Previews", &options->showPreviews);

    }
    nk_end(ctx);
}

void guiResetWorld(Game* game, void(Game::*resetWorldFunc)(int))
{
    static int worldSize = 8;
    if (nk_begin(ctx, "World Reset", nk_rect(10, 370, 200, 200), window_flags)) {
        nk_layout_row_dynamic(ctx, 15, 1);
        nk_labelf(ctx, NK_STATIC, "World Size: %d", worldSize);
        nk_slider_int(ctx, 4, &worldSize, 40, 1);
        if(nk_button_label(ctx, "Reset World")) {
            (*game.*resetWorldFunc)(worldSize);
        }

    }
    nk_end(ctx);
}

SpriteRenderer::SpriteRenderer()
{
    glm::mat4 orthoMatrix{1.0f};
    orthoMatrix = glm::ortho(0.0f, (float)WIDTH, 0.0f, (float)HEIGHT, -1.0f, 1.0f);
    m_guiShader.loadFromFile("GUIVertex.glsl", "GUIFragment.glsl");
    m_guiBorder.loadFromFile("GUIBorder.png", 1);

    m_guiShader.bind();
    m_guiShader.set("orthographicMatrix", orthoMatrix);
    m_guiShader.set("guiTexture", 0);
    m_guiShader.set("borderTexture", 1);
}

void SpriteRenderer::render(const Texture2D& texture, float x, float y, float width, float height)
{
    // glEnable(GL_BLEND);
    texture.bind(0);
    m_guiBorder.bind(1);
    m_guiShader.bind();

    glm::mat4 modelMatrix{1.0f};
    modelMatrix = glm::translate(modelMatrix, {x, y, 0});
    modelMatrix = glm::scale(modelMatrix, {width, height, 1.0});
    m_guiShader.set("transform", modelMatrix);

    m_guiQuad.getRendable().drawArrays(6);
    // glDisable(GL_BLEND);
}