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

class TextureArray final {
  public:
    TextureArray();

    void create(GLsizei numTextures, GLsizei textureSize);
    GLuint addTexture(const char* file);

    void bind() const;

    void loadTexture(const char* file);

  private:
    GLuint m_handle = 0;
    GLuint m_textureCount = 0;
    GLuint m_maxTextures = 0;
    GLuint m_textureSize = 0;

  public:
    TextureArray& operator=(TextureArray&& other);
    TextureArray(TextureArray&& other);

    ~TextureArray();

    TextureArray& operator=(TextureArray& other) = delete;
    TextureArray(TextureArray& other) = delete;
};