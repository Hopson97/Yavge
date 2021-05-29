#pragma once

#include <glad/glad.h>

GLuint loadTexture(const char* file);
GLuint createFramebufferTexture(GLint width, GLint height);

class Texture2d final {
  public:
    Texture2d();

    void create(unsigned width, unsigned height);
    void create(const char* name, bool flip);

    void bind() const;

    void loadTexture(const char* file);
    void createFramebufferTexture(GLint width, GLint height);

  private:
    GLuint m_handle = 0;

    friend class Framebuffer;

  public:
    Texture2d& operator=(Texture2d&& other) noexcept;
    Texture2d(Texture2d&& other) noexcept;
    ~Texture2d();
    Texture2d& operator=(Texture2d& other) = delete;
    Texture2d(Texture2d& other) = delete;
};