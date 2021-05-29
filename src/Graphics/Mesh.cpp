#include "Mesh.h"

#include <iostream>
#include <stb/stb_perlin.h>

namespace {
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

            float noiseValue = stb_perlin_noise3_seed(x, z, 0, 0, 0, 0, seed);
            noiseValue = (noiseValue + 1.0f) / 2.0f;
            value += noiseValue * amplitude;
            acc += amplitude;
        }
        return value / acc * options.amplitude + options.offset;
    }
} // namespace

Mesh createQuadMesh()
{
    // clang-format off
    Mesh mesh;
    mesh.vertices = {
        {{-0.5f, -0.5f, 0.0f}, {0.0f, 1.0f}},
        {{ 0.5f, -0.5f, 0.0f}, {1.0f, 1.0f}},
        {{ 0.5f,  0.5f, 0.0f}, {1.0f, 0.0f}},
        {{-0.5f,  0.5f, 0.0f}, {0.0f, 0.0f}},
    };
    // clang-format on
    mesh.indices = {0, 1, 2, 2, 3, 0};
    return mesh;
}

Mesh createCubeMesh()
{
    Mesh mesh;
    return mesh;
}