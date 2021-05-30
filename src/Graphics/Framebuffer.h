#pragma once

#include "Texture.h"
#include <glad/glad.h>
#include <vector>

class Framebuffer final {
  public:
    Framebuffer(GLuint width, GLuint height);
    Framebuffer& operator=(Framebuffer&& other) noexcept;
    Framebuffer(Framebuffer&& other) noexcept;
    ~Framebuffer();

    Framebuffer& operator=(Framebuffer& other) = delete;
    Framebuffer(Framebuffer& other) = delete;

    const Texture2D* addTexture();
    void finish();

    void bind() const;

    static void unbind();

  private:
    std::vector<Texture2D> m_attachments;
    GLuint m_width = 0;
    GLuint m_height = 0;
    GLuint m_rbo = 0;
    GLuint m_fbo = 0;
};