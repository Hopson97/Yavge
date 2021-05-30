#include "Mesh.h"

#include <glm/gtc/noise.hpp>
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

    // clang-format off
    mesh.vertices = {
        {{w, h, d}, {1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  
        {{0, h, d}, {0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
        {{0, 0, d}, {0.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},  
        {{w, 0, d}, {1.0f, 1.0f}, {0.0f, 0.0f, 1.0f}},

        {{0, h, d}, {1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, h, 0}, {0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},
        {{0, 0, 0}, {0.0f, 1.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f}, {-1.0f, 0.0f, 0.0f}},

        {{0, h, 0}, {1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{w, h, 0}, {0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},
        {{w, 0, 0}, {0.0f, 1.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{0, 0, 0}, {1.0f, 1.0f}, {0.0f, 0.0f, -1.0f}},

        {{w, h, 0}, {1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, h, d}, {0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, 0, 0}, {1.0f, 1.0f}, {1.0f, 0.0f, 0.0f}},

        {{w, h, 0}, {1.0f, 0.0f}, {0.0f, 1.0f, 0.0f}},  
        {{0, h, 0}, {0.0f, 0.0f}, {0.0f, 1.0f, 0.0f}},
        {{0, h, d}, {0.0f, 1.0f}, {0.0f, 1.0f, 0.0f}},  
        {{w, h, d}, {1.0f, 1.0f}, {0.0f, 1.0f, 0.0f}},

        {{0, 0, 0}, {1.0f, 0.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{w, 0, 0}, {0.0f, 0.0f}, {0.0f, -1.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
    };
    // clang-format on

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

struct NoiseOptions {
    float roughness;
    float smoothness;
    float amplitude;

    int octaves;
    float offset;
};

float getNoiseAt(const glm::ivec2& position, int seed, NoiseOptions& options)
{
    float value = 0;
    float acc = 0;
    for (int i = 0; i < options.octaves; i++) {
        float frequency = glm::pow(2.0f, i);
        float amplitude = glm::pow(options.roughness, i);

        float x = position.x * frequency / options.smoothness;
        float z = position.y * frequency / options.smoothness;

        float noiseValue = glm::simplex(glm::vec3{x, z, seed});
        noiseValue = (noiseValue + 1.0f) / 2.0f;
        value += noiseValue * amplitude;
        acc += amplitude;
    }
    return value / acc * options.amplitude + options.offset;
}

constexpr int SIZE = 128;
constexpr int EDGE_VERTEX_COUNT = 128;
constexpr int HEIGHT_MAP_WIDTH = EDGE_VERTEX_COUNT + 2;
constexpr int AREA = EDGE_VERTEX_COUNT * EDGE_VERTEX_COUNT;
constexpr GLfloat fEDGE_VERTEX_COUNT = GLfloat(EDGE_VERTEX_COUNT - 1);

Mesh createTerrainMesh()
{
    NoiseOptions terrainNoise;
    terrainNoise.roughness = 0.7;
    terrainNoise.smoothness = 350.0f;
    terrainNoise.octaves = 5;
    terrainNoise.amplitude = 45.0f;
    terrainNoise.offset = -33;

    NoiseOptions bumpNoise;
    bumpNoise.roughness = 0.6;
    bumpNoise.smoothness = 50.0f;
    bumpNoise.octaves = 5;
    bumpNoise.amplitude = 5.0f;
    bumpNoise.offset = 0;

    std::vector<float> heights(HEIGHT_MAP_WIDTH * HEIGHT_MAP_WIDTH);
    for (int z = 0; z < HEIGHT_MAP_WIDTH; z++) {
        for (int x = 0; x < HEIGHT_MAP_WIDTH; x++) {
            int tx = x + (HEIGHT_MAP_WIDTH - 1);
            int tz = z + (HEIGHT_MAP_WIDTH - 1);
            float height = getNoiseAt({tx, tz}, 123, terrainNoise);
            float bumps = getNoiseAt({tx, tz}, 123, bumpNoise);
            heights[z * HEIGHT_MAP_WIDTH + x] = height + bumps;
        }
    }

    auto getHeight = [&](int x, int y) {
        if (x < 0 || x >= HEIGHT_MAP_WIDTH || y < 0 || y >= HEIGHT_MAP_WIDTH) {
            return 0.0f;
        }
        else {
            return heights[y * HEIGHT_MAP_WIDTH + x];
        }
    };

    Mesh mesh;
    for (int z = 0; z < EDGE_VERTEX_COUNT; z++) {
        for (int x = 0; x < EDGE_VERTEX_COUNT; x++) {
            GLfloat fz = static_cast<GLfloat>(z);
            GLfloat fx = static_cast<GLfloat>(x);

            int hx = x + 1;
            int hz = z + 1;
            float height = getHeight(hx, hz);

            Vertex vertex;
            vertex.position.x = fx / fEDGE_VERTEX_COUNT * SIZE;
            vertex.position.y = height;
            vertex.position.z = fz / fEDGE_VERTEX_COUNT * SIZE;

            vertex.textureCoord.s = fx / fEDGE_VERTEX_COUNT;
            vertex.textureCoord.t = fz / fEDGE_VERTEX_COUNT;

            float h1 = getHeight(hx - 1, hz);
            float h2 = getHeight(hx + 1, hz);
            float h3 = getHeight(hx, hz - 1);
            float h4 = getHeight(hx, hz + 1);
            vertex.normal = glm::normalize(glm::vec3{h1 - h2, 2, h3 - h4});

            mesh.vertices.push_back(vertex);
        }
    }

    for (int z = 0; z < EDGE_VERTEX_COUNT - 1; z++) {
        for (int x = 0; x < EDGE_VERTEX_COUNT - 1; x++) {
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

VoxelMesh createGrassCubeMesh()
{
    VoxelMesh mesh;

    float w = 1;
    float h = 1;
    float d = 1;

    // clang-format off
    mesh.vertices = {
        {{w, h, d}, {1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  
        {{0, h, d}, {0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
        {{0, 0, d}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  
        {{w, 0, d}, {1.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},

        {{0, h, d}, {1.0f, 0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, h, 0}, {0.0f, 0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},
        {{0, 0, 0}, {0.0f, 1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},

        {{0, h, 0}, {1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{w, h, 0}, {0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},
        {{w, 0, 0}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{0, 0, 0}, {1.0f, 1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},

        {{w, h, 0}, {1.0f, 0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, h, d}, {0.0f, 0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, 0, 0}, {1.0f, 1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},

        {{w, h, 0}, {1.0f, 0.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},  
        {{0, h, 0}, {0.0f, 0.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},
        {{0, h, d}, {0.0f, 1.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},  
        {{w, h, d}, {1.0f, 1.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},

        {{0, 0, 0}, {1.0f, 0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{w, 0, 0}, {0.0f, 0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
    };
    // clang-format on

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
