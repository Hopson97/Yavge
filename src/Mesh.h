#pragma once

#include "Mesh.h"
#include <glad/glad.h>
#include <glm/glm.hpp>
#include <vector>
#include "Chunk.h"

struct Vertex {
    glm::vec3 position{0.0f};
    glm::vec2 texture{0.0f};
};

struct Mesh {
    std::vector<Vertex> vertices;
    std::vector<GLuint> indices;

    GLsizei indicesCount = 0;
};

Mesh createQuadMesh();
Mesh createCubeMesh();

using VoxelFace = std::array<glm::ivec3, 4>;

struct ChunkVertex {
    glm::vec3 position{0.0f};
    glm::vec3 texture{0.0f};
};

struct ChunkMesh {
    std::vector<ChunkVertex> vertices;
    std::vector<GLuint> indices;

    GLsizei indicesCount = 0;

    void addFace();
    void addFace(const VoxelFace& face, const VoxelPosition& voxelPosition);
};

ChunkMesh createChunkMesh(const Chunk& chunk);
