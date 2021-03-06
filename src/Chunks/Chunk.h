#pragma once

#include <array>
#include <cstdint>
#include <glm/glm.hpp>
#include <optional>
#include <unordered_map>
#include <vector>

constexpr int CHUNK_SIZE = 64;
constexpr int CHUNK_AREA = CHUNK_SIZE * CHUNK_SIZE;
constexpr int CHUNK_VLME = CHUNK_AREA * CHUNK_SIZE;

constexpr int WATER_LEVEL = CHUNK_SIZE;

using VoxelPosition = glm::ivec3;
using ChunkPosition = glm::ivec3;
using VoxelID = uint8_t;

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

    void setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelId);
    VoxelID getVoxel(const VoxelPosition& voxelPosition) const;

    void qSetVoxel(const VoxelPosition& voxelPosition, VoxelID voxelId);
    VoxelID qGetVoxel(const VoxelPosition& voxelPosition) const;

    ChunkPosition position() const
    {
        return m_position;
    };

    bool isFaceVisible(VoxelPosition pos, int axis, bool isBackFace) const;
    bool compareStep(VoxelPosition a, VoxelPosition b, int dir, bool isBackFace) const;

    bool hasTerrain = false;

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
        empty.hasTerrain = true;
    }

    void setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelId);
    VoxelID getVoxel(const VoxelPosition& voxelPosition) const;

    const Chunk& getChunk(const ChunkPosition& chunk) const;

    Chunk& addChunk(const ChunkPosition& chunk);
    void ensureNeighbours(const ChunkPosition& chunkPosition);

    bool hasNeighbours(const ChunkPosition& chunkPosition) const;

    void destroyWorld();

  private:
    std::unordered_map<ChunkPosition, Chunk, ChunkPositionHash> m_chunks;

    Chunk empty;
};