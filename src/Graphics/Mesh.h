#pragma once

#include "Mesh.h"
#include <glad/glad.h>
#include <glm/glm.hpp>
#include <vector>

constexpr int TERRAIN_SIZE = 128;

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