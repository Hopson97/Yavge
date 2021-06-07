#include "Chunk.h"
#include "Voxels.h"
namespace {
    int toLocalVoxelIndex(const VoxelPosition& position)
    {
        return position.y * (CHUNK_AREA) + position.z * CHUNK_SIZE + position.x;
    }

    ChunkPosition toChunkPosition(const VoxelPosition& position)
    {
        int x = position.x;
        int y = position.y;
        int z = position.z;
        return {
            x < 0 ? ((x - CHUNK_SIZE) / CHUNK_SIZE) : (x / CHUNK_SIZE),
            y < 0 ? ((y - CHUNK_SIZE) / CHUNK_SIZE) : (y / CHUNK_SIZE),
            z < 0 ? ((z - CHUNK_SIZE) / CHUNK_SIZE) : (z / CHUNK_SIZE),
        };
    }

    // ChunkPosition toChunkPosition(float xp, float yp, float zp)
    //{
    //    int x = static_cast<int>(xp);
    //    int y = static_cast<int>(yp);
    //    int z = static_cast<int>(zp);
    //    return toChunkPosition({x, y, z});
    //}

    VoxelPosition toLocalVoxelPosition(const VoxelPosition& position)
    {
        // Deals with negative coordinates too
        return {(CHUNK_SIZE + (position.x % CHUNK_SIZE)) % CHUNK_SIZE,
                (CHUNK_SIZE + (position.y % CHUNK_SIZE)) % CHUNK_SIZE,
                (CHUNK_SIZE + (position.z % CHUNK_SIZE)) % CHUNK_SIZE};
    }

    // VoxelPosition toLocalVoxelPosition(float xp, float yp, float zp)
    //{
    //    int x = static_cast<int>(xp);
    //    int y = static_cast<int>(yp);
    //    int z = static_cast<int>(zp);
    //    return toLocalVoxelPosition({x, y, z});
    //}

    VoxelPosition toGlobalVoxelPosition(const VoxelPosition& voxelPosition, const ChunkPosition& localChunkPosition)
    {
        return {localChunkPosition.x * CHUNK_SIZE + voxelPosition.x,
                localChunkPosition.y * CHUNK_SIZE + voxelPosition.y,
                localChunkPosition.z * CHUNK_SIZE + voxelPosition.z};
    }

    // VoxelPosition toVoxelPosition(const glm::vec3& vec)
    //{
    //    auto x = static_cast<int>(std::floor(vec.x));
    //    auto y = static_cast<int>(std::floor(vec.y));
    //    auto z = static_cast<int>(std::floor(vec.z));
    //    return {x, y, z};
    //}

    // ChunkPosition worldToChunkPosition(const glm::vec3& position)
    //{
    //    return toChunkPosition(toVoxelPosition(position));
    //}

    bool voxelPositionOutOfChunkBounds(const VoxelPosition& voxelPosition)
    {
        return voxelPosition.x < 0 || voxelPosition.x >= CHUNK_SIZE || voxelPosition.y < 0 ||
               voxelPosition.y >= CHUNK_SIZE || voxelPosition.z < 0 || voxelPosition.z >= CHUNK_SIZE;
    }
} // namespace

void Chunk::setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid)
{
    if (voxelPositionOutOfChunkBounds(voxelPosition)) {
        return m_pChunkMap->setVoxel(toGlobalVoxelPosition(voxelPosition, m_position), voxelid);
    }
    qSetVoxel(voxelPosition, voxelid);
}

VoxelID Chunk::getVoxel(const VoxelPosition& voxelPosition) const
{
    if (voxelPositionOutOfChunkBounds(voxelPosition)) {
        return m_pChunkMap->getVoxel(toGlobalVoxelPosition(voxelPosition, m_position));
    }
    return qGetVoxel(voxelPosition);
}

void Chunk::qSetVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid)
{
    assert(!voxelPositionOutOfChunkBounds(voxelPosition));
    m_voxels[toLocalVoxelIndex(voxelPosition)] = voxelid;
}

VoxelID Chunk::qGetVoxel(const VoxelPosition& voxelPosition) const
{
    assert(!voxelPositionOutOfChunkBounds(voxelPosition));
    return m_voxels[toLocalVoxelIndex(voxelPosition)];
}

bool Chunk::isFaceVisible(VoxelPosition pos, int axis, bool isBackFace) const
{
    // Convert the block position to the adjacent voxel pos that is currently
    // being looked at
    pos[axis] += isBackFace ? -1 : 1;

    return !isVoxelSolid(getVoxel(pos));
}

bool Chunk::compareStep(VoxelPosition a, VoxelPosition b, int dir, bool isBackFace) const
{
    auto voxelA = getVoxel(a);
    auto voxelB = getVoxel(b);
    return voxelA == voxelB && isVoxelSolid(voxelB) && isFaceVisible(b, dir, isBackFace);
}

///
///
///     CHUNK MAP
///
///
///
void ChunkMap::setVoxel(const VoxelPosition& voxelPosition, VoxelID voxelid)
{
    auto chunkPosition = toChunkPosition(voxelPosition);
    auto itr = m_chunks.find(chunkPosition);
    auto local = toLocalVoxelPosition(voxelPosition);
    if (itr != m_chunks.cend()) {
        itr->second.qSetVoxel(local, voxelid);
    }
    else {
        addChunk(chunkPosition).qSetVoxel(local, voxelid);
    }
    ensureNeighbours(chunkPosition);
}

VoxelID ChunkMap::getVoxel(const VoxelPosition& voxelPosition) const
{
    auto chunkPosition = toChunkPosition(voxelPosition);
    auto itr = m_chunks.find(chunkPosition);
    if (itr == m_chunks.cend()) {
        return 0;
    }
    return itr->second.qGetVoxel(toLocalVoxelPosition(voxelPosition));
}

const Chunk& ChunkMap::getChunk(const ChunkPosition& chunk) const
{
    auto itr = m_chunks.find(chunk);
    if (itr == m_chunks.cend()) {
        return empty;
    }
    return itr->second;
}

Chunk& ChunkMap::addChunk(const ChunkPosition& chunk)
{
    auto itr = m_chunks.find(chunk);
    if (itr == m_chunks.cend()) {
        return m_chunks
            .emplace(std::piecewise_construct, std::forward_as_tuple(chunk), std::forward_as_tuple(this, chunk))
            .first->second;
    }
    return itr->second;
}

void ChunkMap::ensureNeighbours(const ChunkPosition& chunkPosition)
{
    const auto& cp = chunkPosition;
    addChunk(cp);
    addChunk({cp.x, cp.y + 1, cp.z});
    addChunk({cp.x, cp.y - 1, cp.z});
    addChunk({cp.x - 1, cp.y, cp.z});
    addChunk({cp.x + 1, cp.y, cp.z});
    addChunk({cp.x, cp.y, cp.z - 1});
    addChunk({cp.x, cp.y, cp.z + 1});
}

bool ChunkMap::hasNeighbours(const ChunkPosition& chunkPosition) const
{
    const auto& cp = chunkPosition;

    return getChunk({cp.x, cp.y + 1, cp.z}).hasTerrain && getChunk({cp.x, cp.y - 1, cp.z}).hasTerrain &&
           getChunk({cp.x - 1, cp.y, cp.z}).hasTerrain && getChunk({cp.x + 1, cp.y, cp.z}).hasTerrain &&
           getChunk({cp.x, cp.y, cp.z - 1}).hasTerrain && getChunk({cp.x, cp.y, cp.z + 1}).hasTerrain;
}

void ChunkMap::destroyWorld()
{
    m_chunks.clear();
}
