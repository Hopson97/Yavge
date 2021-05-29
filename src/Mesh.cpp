#include "Mesh.h"

#include "Chunk.h"
#include <array>
#include <iostream>

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



const VoxelFace FRONT_FACE = {glm::ivec3{1, 1, 1}, {0, 1, 1}, {0, 0, 1}, {1, 0, 1}};
const VoxelFace LEFT_FACE = {glm::ivec3{0, 1, 1}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}};
const VoxelFace BACK_FACE = {glm::ivec3{0, 1, 0}, {1, 1, 0}, {1, 0, 0}, {0, 0, 0}};
const VoxelFace RIGHT_FACE = {glm::ivec3{1, 1, 0}, {1, 1, 1}, {1, 0, 1}, {1, 0, 0}};
const VoxelFace TOP_FACE = {glm::ivec3{1, 1, 0}, {0, 1, 0}, {0, 1, 1}, {1, 1, 1}};
const VoxelFace BOTTOM_FACE = {glm::ivec3{0, 0, 0}, {1, 0, 0}, {1, 0, 1}, {0, 0, 1}};
std::array<glm::vec2, 4> textures = {glm::vec2{0.0f, 1.0f}, {1.0f, 1.0f}, {1.0f, 0.0f}, {0.0f, 0.0f}};

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

void ChunkMesh::addFace(const VoxelFace& face, const VoxelPosition& voxelPosition)
{
    for (unsigned i = 0; i < 4; i++) {
        ChunkVertex v;
        v.position = face[i] + voxelPosition;
        v.texture = glm::vec3(textures[i].x, textures[i].y, 0);

        vertices.push_back(v);
    }

    indices.push_back(indicesCount);
    indices.push_back(indicesCount + 1);
    indices.push_back(indicesCount + 2);
    indices.push_back(indicesCount + 2);
    indices.push_back(indicesCount + 3);
    indices.push_back(indicesCount);
    indicesCount += 4;
}

ChunkMesh createChunkMesh(const Chunk& chunk)
{
    ChunkMesh mesh;
    for (int y = 0; y < CHUNK_SIZE; y++) {
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                // If it is "not air"
                VoxelPosition voxelPosition(x, y, z);
                auto voxel = chunk.getVoxel(voxelPosition);
                if (voxel > 0) {
                    // Left voxel face
                    if (makeFace(voxel, chunk.getVoxel({x - 1, y, z}))) {
                        mesh.addFace(LEFT_FACE, voxelPosition);
                    }

                    // Right chunk face
                    if (makeFace(voxel, chunk.getVoxel({x + 1, y, z}))) {
                        mesh.addFace(RIGHT_FACE, voxelPosition);
                    }

                    // Front chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y, z + 1}))) {
                        mesh.addFace(FRONT_FACE, voxelPosition);
                    }

                    // Back chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y, z - 1}))) {
                        mesh.addFace(BACK_FACE, voxelPosition);
                    }

                    // Bottom chunk face
                    if (makeFace(voxel, chunk.getVoxel({x, y - 1, z}))) {
                        mesh.addFace(BOTTOM_FACE, voxelPosition);
                    }

                    if (makeFace(voxel, chunk.getVoxel({x, y + 1, z}))) {
                        {
                            mesh.addFace(TOP_FACE, voxelPosition);
                        }
                    }
                }
            }
        }
    }
    return mesh;
}