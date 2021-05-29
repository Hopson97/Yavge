#include "Texture.h"

#include <algorithm>
#include <stb/stb_image.h>
#include <string.h>
#include <iostream>

Texture2d ::Texture2d()
{
    glCreateTextures(GL_TEXTURE_2D, 1, &m_handle);
}

Texture2d& Texture2d ::operator=(Texture2d&& other) noexcept
{
    m_handle = other.m_handle;
    other.m_handle = 0;
    return *this;
}

Texture2d ::Texture2d(Texture2d&& other) noexcept
    : m_handle{other.m_handle}
{
    other.m_handle = 0;
}

Texture2d::~Texture2d()
{
    glDeleteTextures(1, &m_handle);
}

void Texture2d::loadTexture(const char* file)
{
    char texturePath[128] = "Data/Textures/";
    strcat(texturePath, file);

    int width;
    int height;
    int channels;
    unsigned char* imageData = stbi_load(texturePath, &width, &height, &channels, STBI_rgb_alpha);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTextureStorage2D(m_handle, 1, GL_RGBA8, width, height);
    glTextureSubImage2D(m_handle, 0, 0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    stbi_image_free(imageData);
}

void Texture2d::createFramebufferTexture(GLint width, GLint height)
{
    glTextureStorage2D(m_handle, 1, GL_RGB8, width, height);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

void Texture2d::bind() const
{
    glBindTextureUnit(0, m_handle);
}

TextureArray::TextureArray()
{
    glCreateTextures(GL_TEXTURE_2D_ARRAY, 1, &m_handle);
}

TextureArray::~TextureArray()
{
    glDeleteTextures(1, &m_handle);
}

TextureArray::TextureArray(TextureArray&& other)
{
    *this = std::move(other);
}

TextureArray& TextureArray::operator=(TextureArray&& other)
{
    m_handle = other.m_handle;
    m_textureCount = other.m_textureCount;
    m_maxTextures = other.m_maxTextures;
    m_textureSize = other.m_textureSize;

    other.m_handle = 0;
    other.m_textureCount = 0;
    other.m_maxTextures = 0;
    other.m_textureSize = 0;

    return *this;
}

void TextureArray::create(GLsizei numTextures, GLsizei textureSize)
{
    m_maxTextures = numTextures;
    m_textureSize = textureSize;

    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTextureStorage3D(m_handle, 0, GL_RGBA, textureSize, textureSize, numTextures);

}

GLuint TextureArray::addTexture(const char* file)
{
    char texturePath[128] = "Data/Textures/";
    strcat(texturePath, file);

    int width;
    int height;
    int channels;
    unsigned char* imageData = stbi_load(texturePath, &width, &height, &channels, STBI_rgb_alpha);

    glTextureSubImage3D(m_handle, 0, 0, 0, m_textureCount, width, height, 1, GL_RGBA, GL_UNSIGNED_BYTE,
                        imageData);

    // Generate Mipmap
  //  glGenerateMipmap(GL_TEXTURE_2D_ARRAY);

  //  glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
  ///  glTextureParameteri(m_handle, GL_TEXTURE_LOD_BIAS, -1);

    stbi_image_free(imageData);

    return m_textureCount++;
}

void TextureArray::bind() const
{
    glBindTextureUnit(0, m_handle);
}
