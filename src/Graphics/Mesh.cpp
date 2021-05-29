#include "Mesh.h"

#include <iostream>

Mesh createQuadMesh()
{
    // clang-format off
    Mesh mesh;
    mesh.vertices = {
        {{-0.5f, -0.5f, 0.0f}, {0.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},
        {{ 0.5f, -0.5f, 0.0f}, {1.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},
        {{ 0.5f,  0.5f, 0.0f}, {1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
        {{-0.5f,  0.5f, 0.0f}, {0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
    };
    // clang-format on
    mesh.indices = {0, 1, 2, 2, 3, 0};
    return mesh;
}

Mesh createCubeMesh(const glm::vec3& dimensions)
{
    Mesh mesh;

    float w = dimensions.x;
    float h = dimensions.y;
    float d = dimensions.z;

    mesh.vertices = {
        {{w, h, d}, {1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  {{0, h, d}, {0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
        {{0, 0, d}, {0.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},  {{w, 0, d}, {1.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},

        {{0, h, d}, {1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, {{0, h, 0}, {0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},
        {{0, 0, 0}, {0.0f, 1.0f}, {-1.0f, 0.0f, 0.0f}}, {{0, 0, d}, {1.0f, 1.0f}, {-1.0f, 0.0f, 0.0f}},

        {{0, h, 0}, {1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, {{w, h, 0}, {0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},
        {{w, 0, 0}, {0.0f, 1.0f}, {0.0f, 0.0f, -1.0f}}, {{0, 0, 0}, {1.0f, 1.0f}, {0.0f, 0.0f, -1.0f}},

        {{w, h, 0}, {1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  {{w, h, d}, {0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f}, {1.0f, 0.0f, 0.0f}},  {{w, 0, 0}, {1.0f, 1.0f}, {1.0f, 0.0f, 0.0f}},

        {{w, h, 0}, {1.0f, 0.0f}, {0.0f, 1.0f, 0.0f}},  {{0, h, 0}, {0.0f, 0.0f}, {0.0f, 1.0f, 0.0f}},
        {{0, h, d}, {0.0f, 1.0f}, {0.0f, 1.0f, 0.0f}},  {{w, h, d}, {1.0f, 1.0f}, {0.0f, 1.0f, 0.0f}},

        {{0, 0, 0}, {1.0f, 0.0f}, {0.0f, -1.0f, 0.0f}}, {{w, 0, 0}, {0.0f, 0.0f}, {0.0f, -1.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, {{0, 0, d}, {1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
    };

    int currIndex = 0;
    for (int i = 0; i < 6; i++) {
        mesh.indices.push_back(currIndex);
        mesh.indices.push_back(currIndex + 1);
        mesh.indices.push_back(currIndex + 2);
        mesh.indices.push_back(currIndex + 2);
        mesh.indices.push_back(currIndex + 3);
        mesh.indices.push_back(currIndex);
        currIndex += 4;
    }

    return mesh;
}

constexpr int SIZE = 64;
constexpr int EDGE_VERTEX_COUNT = 12;
constexpr int AREA = EDGE_VERTEX_COUNT * EDGE_VERTEX_COUNT;
constexpr GLfloat fEDGE_VERTEX_COUNT = GLfloat(EDGE_VERTEX_COUNT - 1);

Mesh createTerrainMesh()
{
    Mesh mesh;
    for (int z = 0; z < (int)EDGE_VERTEX_COUNT; z++) {
        for (int x = 0; x < (int)EDGE_VERTEX_COUNT; x++) {
            GLfloat fz = static_cast<GLfloat>(z);
            GLfloat fx = static_cast<GLfloat>(x);

            Vertex vertex;
            vertex.position.x = fx / fEDGE_VERTEX_COUNT * SIZE;
            vertex.position.y = -1.0;
            vertex.position.z = fz / fEDGE_VERTEX_COUNT * SIZE;

            vertex.textureCoord.s = fx / fEDGE_VERTEX_COUNT;
            vertex.textureCoord.t = fz / fEDGE_VERTEX_COUNT;

            vertex.normal.x = 0;
            vertex.normal.y = 1;
            vertex.normal.z = 0;

            mesh.vertices.push_back(vertex);
        }
    }

    for (int z = 0; z < (int)EDGE_VERTEX_COUNT - 1; z++) {
        for (int x = 0; x < (int)EDGE_VERTEX_COUNT - 1; x++) {
            int topLeft = (z * EDGE_VERTEX_COUNT) + x;
            int topRight = topLeft + 1;
            int bottomLeft = ((z + 1) * EDGE_VERTEX_COUNT) + x;
            int bottomRight = bottomLeft + 1;

            mesh.indices.push_back(topLeft);
            mesh.indices.push_back(bottomLeft);
            mesh.indices.push_back(topRight);
            mesh.indices.push_back(topRight);
            mesh.indices.push_back(bottomLeft);
            mesh.indices.push_back(bottomRight);
        }
    }
    return mesh;
}
