#include "Chunk.h"

#include <algorithm>
#include <cassert>
#include <iostream>

namespace {
    // clang-format off
    bool voxelPositionOutOfChunkBounds(const VoxelPosition& voxelPosition) {
        return 
        voxelPosition.x < 0 || voxelPosition.x >= CHUNK_SIZE ||
        voxelPosition.y < 0 || voxelPosition.y >= CHUNK_SIZE ||
        voxelPosition.z < 0 || voxelPosition.z >= CHUNK_SIZE;
    }
    // clang-format on
} // namespace

int toLocalVoxelIndex(const VoxelPosition& position)
{
    return position.y * (CHUNK_AREA) + position.z * CHUNK_SIZE + position.x;
}

Chunk::Chunk()
    : voxels(CHUNK_VOLUME)
{
    std::fill(voxels.begin(), voxels.end(), 0);
}

uint16_t Chunk::getVoxel(const VoxelPosition& position) const
{
    if (voxelPositionOutOfChunkBounds(position))
        return 0;
    return voxels[toLocalVoxelIndex(position)];
}

void Chunk::setVoxel(const VoxelPosition& position, uint16_t voxel)
{
    assert(!voxelPositionOutOfChunkBounds(position));
    voxels[toLocalVoxelIndex(position)] = voxel;
}
