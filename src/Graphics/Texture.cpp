#include "Texture.h"

#include <SFML/Graphics/Image.hpp>
#include <cstring>
#include <iostream>

Texture2D ::Texture2D()
{
    glCreateTextures(GL_TEXTURE_2D, 1, &m_handle);
}

Texture2D& Texture2D ::operator=(Texture2D&& other) noexcept
{
    m_handle = other.m_handle;
    other.m_handle = 0;
    return *this;
}

Texture2D ::Texture2D(Texture2D&& other) noexcept
    : m_handle{other.m_handle}
{
    other.m_handle = 0;
}

Texture2D::~Texture2D()
{
    glDeleteTextures(1, &m_handle);
}

void Texture2D::loadTexture(const char* file)
{
    char texturePath[128] = "Data/Textures/";
    std::strcat(texturePath, file);

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

void Texture2D::createFramebufferTexture(GLint width, GLint height)
{
    glTextureStorage2D(m_handle, 1, GL_RGB8, width, height);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

void Texture2D::bind() const
{
    glBindTextureUnit(0, m_handle);
}

TextureArray2D::TextureArray2D()
{
    glCreateTextures(GL_TEXTURE_2D_ARRAY, 1, &m_handle);
}

TextureArray2D& TextureArray2D ::operator=(TextureArray2D&& other) noexcept
{
    m_handle = other.m_handle;
    m_textureDims = other.m_textureDims;
    m_textureCount = other.m_textureCount;
    m_maxTextures = other.m_maxTextures;
    other.m_handle = 0;
    other.m_textureDims = 0;
    other.m_textureCount = 0;
    other.m_maxTextures = 0;
    return *this;
}

TextureArray2D ::TextureArray2D(TextureArray2D&& other) noexcept
    : m_handle{other.m_handle}
    , m_textureDims{other.m_textureDims}
    , m_textureCount{other.m_textureCount}
    , m_maxTextures{other.m_maxTextures}
{
    other.m_handle = 0;
    other.m_textureDims = 0;
    other.m_textureCount = 0;
    other.m_maxTextures = 0;
}

TextureArray2D::~TextureArray2D()
{
    glDeleteTextures(1, &m_handle);
}

void TextureArray2D::create(GLuint textureDims, GLuint textureCount)
{
    m_textureDims = textureDims;
    m_maxTextures = textureCount;

    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTextureParameteri(m_handle, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTextureParameteri(m_handle, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    glTextureStorage3D(m_handle, 1, GL_RGBA8, textureDims, textureDims, textureCount);
}

GLuint TextureArray2D::addTexture(const char* file)
{
    if (m_textureCount == m_maxTextures) {
        std::cout << "Cannot add anymore textures, maxmium has been reached.\n";
        return 0;
    }
    char texturePath[128] = "Data/Textures/";
    std::strcat(texturePath, file);

    sf::Image img;
    if (!img.loadFromFile(texturePath)) {
        return 0;
    }

    glTextureSubImage3D(m_handle, 0, 0, 0, m_textureCount, m_textureDims, m_textureDims, 1, GL_RGBA, GL_UNSIGNED_BYTE,
                        img.getPixelsPtr());


    return m_textureCount++;
}

void TextureArray2D::bind() const
{
    glBindTextureUnit(0, m_handle);
}