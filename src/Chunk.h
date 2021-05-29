#pragma once

#include <SFML/System/Vector3.hpp>
#include <array>
#include <cstdint>
#include <glm/glm.hpp>
#include <vector>

constexpr int CHUNK_SIZE = 256;
constexpr int CHUNK_AREA = CHUNK_SIZE * CHUNK_SIZE;
constexpr int CHUNK_VOLUME = CHUNK_SIZE * CHUNK_SIZE * CHUNK_SIZE;

using ChunkPosition = glm::ivec3;
using VoxelPosition = glm::ivec3;

struct Chunk {
    std::vector<uint16_t> voxels;

    Chunk();
    uint16_t getVoxel(const VoxelPosition& position) const;
    void setVoxel(const VoxelPosition& position, uint16_t voxel);
};
/*
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
*/
