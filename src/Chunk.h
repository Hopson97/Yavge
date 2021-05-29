#pragma once

#include "Graphics/Mesh.h"
#include <SFML/System/Vector3.hpp>
#include <array>
#include <cstdint>
#include <glm/glm.hpp>

constexpr int CHUNK_SIZE = 128;
constexpr int CHUNK_AREA = CHUNK_SIZE * CHUNK_SIZE;
constexpr int CHUNK_VOLUME = CHUNK_SIZE * CHUNK_SIZE * CHUNK_SIZE;

using ChunkPosition = glm::ivec3;
using VoxelPosition = glm::ivec3;

struct Chunk {
    std::array<uint16_t, CHUNK_VOLUME> voxels;

    uint16_t getVoxel(const VoxelPosition& position) const;
    void setVoxel(const VoxelPosition& position, uint16_t voxel);
};

Mesh createChunkMesh(const Chunk& chunk);