#include "Texture.h"

#include <SFML/Graphics/Image.hpp>
#include <string.h>

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

    sf::Image img;
    img.loadFromFile(texturePath);

    int width = img.getSize().x;
    int height = img.getSize().y;

    glCreateTextures(GL_TEXTURE_2D, 1, &m_handle);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTextureStorage2D(m_handle, 1, GL_RGBA8, width, height);
    glTextureSubImage2D(m_handle, 0, 0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, img.getPixelsPtr());
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