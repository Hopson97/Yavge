#pragma once

#include "Mesh.h"
#include <glad/glad.h>
#include <glm/glm.hpp>
#include <vector>

constexpr int TERRAIN_SIZE = 128;

struct Vertex {
    glm::vec3 position{0.0f};
    glm::vec2 textureCoord{0.0f};
    glm::vec3 normal{0.0f};
};

struct Mesh {
    std::vector<Vertex> vertices;
    std::vector<GLuint> indices;

    GLsizei indicesCount = 0;
};

// Regular vertex except it uses a 3D texture so that it can support OpenGL 2D Texture Arrays
struct VoxelVertex {
    glm::vec3 position{0.0f};
    glm::vec3 textureCoord{0.0f};
    glm::vec3 normal{0.0f};
};

struct VoxelMesh {
    std::vector<VoxelVertex> vertices;
    std::vector<GLuint> indices;

    GLsizei indicesCount = 0;
};

Mesh createQuadMesh();
Mesh createCubeMesh(const glm::vec3& dimensions);
Mesh createTerrainMesh();

VoxelMesh createGrassCubeMesh();
