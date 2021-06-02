#include "ChunkTerrainGen.h"

#include "Voxels.h"
#include <algorithm>
#include <cstring>
#include <functional>
#include <glm/gtc/noise.hpp>
#include <iostream>

namespace {
    struct NoiseOptions {
        int octaves;
        float amplitude;
        float smoothness;
        float roughness;
        float offset;
    };

    // THANKS! Karasa and K.jpg for help with this algo
    float rounded(const glm::vec2& coord)
    {
        auto bump = [](float t) { return glm::max(0.0f, 1.0f - std::pow(t, 6.0f)); };
        float b = bump(coord.x) * bump(coord.y);
        return b * 0.9f;
    }

    float getNoiseAt(const glm::vec2& voxelPosition, const glm::vec2& chunkPosition, const NoiseOptions& options,
                     int seed)
    {
        // Get voxel X/Z positions
        float voxelX = voxelPosition.x + chunkPosition.x * CHUNK_SIZE;
        float voxelZ = voxelPosition.y + chunkPosition.y * CHUNK_SIZE;

        // Begin iterating through the octaves
        float value = 0;
        float accumulatedAmps = 0;
        for (int i = 0; i < options.octaves; i++) {
            float frequency = glm::pow(2.0f, i);
            float amplitude = glm::pow(options.roughness, i);

            float x = voxelX * frequency / options.smoothness;
            float y = voxelZ * frequency / options.smoothness;

            float noise = glm::simplex(glm::vec3{seed + x, seed + y, seed});
            noise = (noise + 1.0f) / 2.0f;
            value += noise * amplitude;
            accumulatedAmps += amplitude;
        }
        return value / accumulatedAmps;
    }

    std::array<int, CHUNK_AREA> createChunkHeightMap(const ChunkPosition& position, int worldSize, int seed)
    {
        const float WOLRD_SIZE = static_cast<float>(worldSize) * CHUNK_SIZE;

        NoiseOptions firstNoise;
        firstNoise.amplitude = 230;
        firstNoise.octaves = 8;
        firstNoise.smoothness = 500.f;
        firstNoise.roughness = 0.58f;
        firstNoise.offset = 0;

        NoiseOptions secondNoise;
        secondNoise.amplitude = 20;
        secondNoise.octaves = 4;
        secondNoise.smoothness = 200;
        secondNoise.roughness = 0.45f;
        secondNoise.offset = 0;

        glm::vec2 chunkXZ = {position.x, position.z};

        std::array<int, CHUNK_AREA> heightMap;
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                float bx = static_cast<float>(x + position.x * CHUNK_SIZE);
                float bz = static_cast<float>(z + position.z * CHUNK_SIZE);

                glm::vec2 coord = (glm::vec2{bx, bz} - WOLRD_SIZE / 2.0f) / WOLRD_SIZE * 2.0f;

                auto noise = getNoiseAt({x, z}, chunkXZ, firstNoise, seed);
                auto noise2 = getNoiseAt({x, z}, {position.x, position.z}, secondNoise, seed);
                auto island = rounded(coord) * 1.25;
                float result = noise * noise2;

                float r = static_cast<int>((result * firstNoise.amplitude + firstNoise.offset) * island) - 5;
                //if (r < WATER_LEVEL) r = WATER_LEVEL - r;
                heightMap[z * CHUNK_SIZE + x] =r;
            }
        }

        return heightMap;
    }

    std::array<int, CHUNK_AREA> createBiomeMap(const ChunkPosition& position, int seed)
    {
        NoiseOptions biomeMapNoise;
        biomeMapNoise.amplitude = 120;
        biomeMapNoise.octaves = 4;
        biomeMapNoise.smoothness = 200.f;
        biomeMapNoise.roughness = 0.5f;
        biomeMapNoise.offset = 18;

        std::array<int, CHUNK_AREA> biomeMap;
        glm::vec2 chunkXZ = {position.x, position.z};
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                auto noise = getNoiseAt({x, z}, chunkXZ, biomeMapNoise, seed);
                int height = static_cast<int>(noise * biomeMapNoise.amplitude);
                biomeMap[z * CHUNK_SIZE + x] = height;
            }
        }
        return biomeMap;
    }

    void createTerrain(Chunk& chunk, const std::array<int, CHUNK_AREA>& heightMap,
                       [[maybe_unused]] const std::array<int, CHUNK_AREA>& biomeMap)
    {
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                int height = heightMap[z * CHUNK_SIZE + x];
                // int biomeVal = biomeMap[z * CHUNK_SIZE + x];
                for (int y = 0; y < CHUNK_SIZE; y++) {
                    int voxelY = chunk.position().y * CHUNK_SIZE + y;
                    VoxelID voxel = VoxelType::AIR;

                    if (voxelY > height) {
                        if (voxelY < WATER_LEVEL) {
                            voxel = VoxelType::WATER;
                        }
                    }
                    else if (voxelY == height) {
                        if (voxelY < WATER_LEVEL + 3) {
                            voxel = VoxelType::SAND;
                        }
                        else {
                            voxel = VoxelType::GRASS;
                        }
                    }
                    else if (voxelY > height - 3) {
                        voxel = VoxelType::DIRT;
                    }
                    else {
                        voxel = VoxelType::STONE;
                    }

                    if (voxel > 0) {
                        chunk.qSetVoxel({x, y, z}, voxel);
                    }
                }
            }
        }
    }

} // namespace

std::vector<ChunkPosition> createChunkTerrain(ChunkMap& chunkmap, int chunkX, int chunkZ, int worldSize, int seed)
{
    std::cout << "SEED: " << seed << "\n";
    std::vector<ChunkPosition> positions;
    ChunkPosition position{chunkX, 0, chunkZ};

    auto heightMap = createChunkHeightMap(position, worldSize, seed);
    auto biomeMap = createBiomeMap(position, 9876);
    int maxHeight = *std::max_element(heightMap.cbegin(), heightMap.cend());
    for (int y = 0; y < std::max(WATER_LEVEL / CHUNK_SIZE, maxHeight / CHUNK_SIZE) + 1; y++) {
        Chunk& chunk = chunkmap.addChunk({chunkX, y, chunkZ});
        createTerrain(chunk, heightMap, biomeMap);
        //   chunkmap.ensureNeighbours(chunk.position());
        positions.push_back({chunkX, y, chunkZ});
        chunk.hasTerrain = true;
    }

    return positions;
}
