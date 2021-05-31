#pragma once

#include <array>
#include <cstdint>
#include <glm/glm.hpp>
#include <optional>
#include <unordered_map>
#include <vector>

constexpr int CHUNK_SIZE = 32;
constexpr int CHUNK_AREA = CHUNK_SIZE * CHUNK_SIZE;
constexpr int CHUNK_VLME = CHUNK_AREA * CHUNK_SIZE;

constexpr int WATER_LEVEL = 33;

using VoxelPosition = glm::ivec3;
using ChunkPosition = glm::ivec3;
using VoxelID = uint16_t;

class ChunkMap;

// http://www.beosil.com/download/CollisionDetectionHashing_VMV03.pdf
struct ChunkPositionHash {
    std::size_t operator()(const ChunkPosition& position) const
    {
        return (position.x * 88339) ^ (position.z * 91967) ^ (position.z * 126323);
    }
};

class Chunk {
  public:
    Chunk(ChunkMap* map, const ChunkPosition& p)
        : m_pChunkMap(map)
        , m_position(p)
    {
    }

    void setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid);
    VoxelID getVoxel(const VoxelPosition& voxelPosition) const;

    void qSetVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid);
    VoxelID qGetVoxel(const VoxelPosition& voxelPosition) const;

    ChunkPosition position() const
    {
        return m_position;
    };

  private:
    ChunkMap* m_pChunkMap;
    ChunkPosition m_position;

    std::array<VoxelID, CHUNK_VLME> m_voxels{0};
};

class ChunkMap {
  public:
    ChunkMap()
        : empty(this, {0, 0, 0})
    {
    }

    void setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid);
    VoxelID getVoxel(const VoxelPosition& voxelPosition) const;

    const Chunk& getChunk(const ChunkPosition& chunk) const;

    Chunk& addChunk(const ChunkPosition& chunk);
    void ensureNeighbours(const ChunkPosition& chunkPosition);

  private:
    std::unordered_map<ChunkPosition, Chunk, ChunkPositionHash> m_chunks;

    Chunk empty;
};