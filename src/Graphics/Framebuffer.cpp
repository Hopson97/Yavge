#include "Framebuffer.h"

#include "../Utility.h"
#include "Texture.h"
#include <stdio.h>

Framebuffer::Framebuffer()

{
    glCreateFramebuffers(1, &m_fbo);
}

void Framebuffer::create(GLuint width, GLuint height)
{
    m_width = width;
    m_height = height;
}

Framebuffer& Framebuffer::operator=(Framebuffer&& other) noexcept
{
    m_width = other.m_width;
    m_height = other.m_height;
    m_attachments = std::move(other.m_attachments);
    m_rbo = other.m_rbo;
    m_fbo = other.m_fbo;

    other.m_width = 0;
    other.m_height = 0;
    other.m_rbo = 0;
    other.m_fbo = 0;

    return *this;
}

Framebuffer::Framebuffer(Framebuffer&& other) noexcept
    : m_attachments{std::move(other.m_attachments)}
    , m_width{other.m_width}
    , m_height{other.m_height}
    , m_rbo{other.m_rbo}
    , m_fbo{other.m_fbo}
{
    other.m_width = 0;
    other.m_height = 0;
    other.m_rbo = 0;
    other.m_fbo = 0;
}

Framebuffer::~Framebuffer()
{
    glDeleteFramebuffers(1, &m_fbo);
    glDeleteRenderbuffers(1, &m_rbo);
}

const Texture2D* Framebuffer::addTexture()
{
    Texture2D& t = m_attachments.emplace_back();
    t.createFramebufferTexture(WIDTH, HEIGHT);
    glNamedFramebufferTexture(m_fbo, GL_COLOR_ATTACHMENT0, t.m_handle, 0);
    return &t;
}

const Texture2D* Framebuffer::addDepthTexture()
{
    Texture2D& t = m_attachments.emplace_back();
    t.createFramebufferDepth(WIDTH, HEIGHT);
    glNamedFramebufferTexture(m_fbo, GL_DEPTH_ATTACHMENT, t.m_handle, 0);
    return &t;
}


void Framebuffer::finish()
{
    glCreateRenderbuffers(1, &m_rbo);
    glNamedRenderbufferStorage(m_rbo, GL_DEPTH24_STENCIL8, m_width, m_height);
    glNamedFramebufferRenderbuffer(m_fbo, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, m_rbo);

    if (glCheckNamedFramebufferStatus(m_fbo, GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        setTextColourRGB(255, 0, 0);
        fprintf(stderr, "Failed to create framebuffer.");
        setTextColourRGB(255, 255, 255);
        fflush(stderr);
    }
}

void Framebuffer::bind() const
{
    glBindFramebuffer(GL_FRAMEBUFFER, m_fbo);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

void Framebuffer::unbind()
{
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
