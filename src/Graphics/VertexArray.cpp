#include "VertexArray.h"
#include <glm/glm.hpp>
#include <stb/stb_perlin.h>

VertexArray::VertexArray()
{
    glCreateVertexArrays(1, &m_vao);
    glCreateBuffers(1, &m_vbo);
    glCreateBuffers(1, &m_ibo);
}

VertexArray& VertexArray::operator=(VertexArray&& other)
{
    m_vao = other.m_vao;
    m_vbo = other.m_vbo;
    m_ibo = other.m_ibo;
    m_indexCount = other.m_indexCount;

    other.m_vao = 0;
    other.m_vbo = 0;
    other.m_ibo = 0;
    other.m_indexCount = 0;

    return *this;
}

VertexArray::VertexArray(VertexArray&& other)
    : m_vao{other.m_vao}
    , m_vbo{other.m_vbo}
    , m_ibo{other.m_ibo}
    , m_indexCount{other.m_indexCount}
{
    other.m_vao = 0;
    other.m_vbo = 0;
    other.m_ibo = 0;
    other.m_indexCount = 0;
}

VertexArray::~VertexArray()
{
    if (m_vao) {
        glDeleteVertexArrays(1, &m_vao);
        glDeleteBuffers(1, &m_vbo);
        glDeleteBuffers(1, &m_ibo);
    }
}

void VertexArray::bufferVertexData(const std::vector<Vertex>& verts)
{
    // glBufferData
    glNamedBufferStorage(m_vbo, sizeof(Vertex) * verts.size(), verts.data(), GL_DYNAMIC_STORAGE_BIT);

    // Attach the vertex array to the vertex buffer and element buffer
    glVertexArrayVertexBuffer(m_vao, 0, m_vbo, 0, sizeof(Vertex));

    // glEnableVertexAttribArray
    glEnableVertexArrayAttrib(m_vao, 0);
    glEnableVertexArrayAttrib(m_vao, 1);

    // glVertexAttribPointer
    glVertexArrayAttribFormat(m_vao, 0, 3, GL_FLOAT, GL_FALSE, offsetof(Vertex, position));
    glVertexArrayAttribFormat(m_vao, 1, 2, GL_FLOAT, GL_FALSE, offsetof(Vertex, texture));
    glVertexArrayAttribBinding(m_vao, 0, 0);
    glVertexArrayAttribBinding(m_vao, 1, 0);
}

void VertexArray::bufferVertexData(const std::vector<ChunkVertex>& verts)
{
    // glBufferData
    glNamedBufferStorage(m_vbo, sizeof(ChunkVertex) * verts.size(), verts.data(), GL_DYNAMIC_STORAGE_BIT);

    // Attach the vertex array to the vertex buffer and element buffer
    glVertexArrayVertexBuffer(m_vao, 0, m_vbo, 0, sizeof(ChunkVertex));

    // glEnableVertexAttribArray
    glEnableVertexArrayAttrib(m_vao, 0);
    glEnableVertexArrayAttrib(m_vao, 1);

    // glVertexAttribPointer
    glVertexArrayAttribFormat(m_vao, 0, 3, GL_FLOAT, GL_FALSE, offsetof(ChunkVertex, position));
    glVertexArrayAttribFormat(m_vao, 1, 3, GL_FLOAT, GL_FALSE, offsetof(ChunkVertex, texture));
    glVertexArrayAttribBinding(m_vao, 0, 0);
    glVertexArrayAttribBinding(m_vao, 1, 0);
}

void VertexArray::bufferIndicesData(const std::vector<GLuint> indices)
{
    glNamedBufferStorage(m_ibo, sizeof(GLuint) * indices.size(), indices.data(), GL_DYNAMIC_STORAGE_BIT);
    glVertexArrayElementBuffer(m_vao, m_ibo);
    m_indexCount = indices.size();
}

void VertexArray::bufferMesh(const Mesh& mesh)
{
    bufferVertexData(mesh.vertices);
    bufferIndicesData(mesh.indices);
}

void VertexArray::bufferMesh(const ChunkMesh& mesh)
{
    bufferVertexData(mesh.vertices);
    bufferIndicesData(mesh.indices);
}

GLsizei VertexArray::indicesCount()
{
    return m_indexCount;
}

void VertexArray::bind() const
{
    glBindVertexArray(m_vao);
}