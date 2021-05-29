#include "Chunk.h"

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

using VoxelFace = std::array<glm::ivec3, 4>;

const VoxelFace FRONT_FACE = {glm::ivec3{1, 1, 1}, {0, 1, 1}, {0, 0, 1}, {1, 0, 1}};
const VoxelFace LEFT_FACE = {glm::ivec3{0, 1, 1}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}};
const VoxelFace BACK_FACE = {glm::ivec3{0, 1, 0}, {1, 1, 0}, {1, 0, 0}, {0, 0, 0}};
const VoxelFace RIGHT_FACE = {glm::ivec3{1, 1, 0}, {1, 1, 1}, {1, 0, 1}, {1, 0, 0}};
const VoxelFace TOP_FACE = {glm::ivec3{1, 1, 0}, {0, 1, 0}, {0, 1, 1}, {1, 1, 1}};
const VoxelFace BOTTOM_FACE = {glm::ivec3{0, 0, 0}, {1, 0, 0}, {1, 0, 1}, {0, 0, 1}};

bool makeFace(uint16_t thisId, uint16_t compareId)
{
    if (compareId == 0) {
        return true;
    }
    else if (compareId != thisId) {
        return true;
    }
    return false;
}

std::array<glm::vec2, 4> textures = {glm::vec2{0.0f, 1.0f}, {1.0f, 1.0f}, {1.0f, 0.0f}, {0.0f, 0.0f}};
int indicesCount = 0;
int faces = 0;
void addFace(Mesh& mesh, const VoxelFace& face, const VoxelPosition& voxelPosition)
{
    faces++;
    for (unsigned i = 0; i < 4; i++) {
        Vertex v;
        v.position = face[i] + voxelPosition;
        v.texture = textures[i];

        mesh.vertices.push_back(v);
    }

    mesh.indices.push_back(indicesCount);
    mesh.indices.push_back(indicesCount + 1);
    mesh.indices.push_back(indicesCount + 2);
    mesh.indices.push_back(indicesCount + 2);
    mesh.indices.push_back(indicesCount + 3);
    mesh.indices.push_back(indicesCount);
    indicesCount += 4;
}

Mesh createChunkMesh(const Chunk& chunk)
{
    Mesh mesh;
    for (int y = 0; y < CHUNK_SIZE; y++) {
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                // If it is "not air"
                VoxelPosition voxelPosition(x, y, z);
                auto voxel = chunk.getVoxel(voxelPosition);
                if (voxel > 0) {
                    // Left voxel face
                    if (makeFace(voxel, chunk.getVoxel({x - 1, y, z}))) {
                        addFace(mesh, LEFT_FACE, voxelPosition);
                    }

                    // Right chunk face
                    if (makeFace(voxel, chunk.getVoxel({x + 1, y, z}))) {
                        addFace(mesh, RIGHT_FACE, voxelPosition);
                    }

                    // Front chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y, z + 1}))) {
                        addFace(mesh, FRONT_FACE, voxelPosition);
                    }

                    // Back chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y, z - 1}))) {
                        addFace(mesh, BACK_FACE, voxelPosition);
                    }

                    // Bottom chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y - 1, z}))) {
                        addFace(mesh, BOTTOM_FACE, voxelPosition);
                    }

                    if (makeFace(voxel, chunk.getVoxel({x, y + 1, z}))) {
                        {
                            addFace(mesh, TOP_FACE, voxelPosition);
                        }
                    }
                }
            }
        }
    }
    std::cout << "Faces: " << faces << std::endl;
    return mesh;
}