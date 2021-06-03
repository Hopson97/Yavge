#include "ChunkMesh.h"

#include "Voxels.h"
namespace {
    using v3 = glm::ivec3;
    using v2 = glm::vec2;
    const VoxelMeshFace FRONT_FACE = {{v3{1, 1, 1}, {0, 1, 1}, {0, 0, 1}, {1, 0, 1}}, v3{0, 0, 1}};
    const VoxelMeshFace LEFT_FACE = {{v3{0, 1, 1}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}}, v3{-1, 0, 0}};
    const VoxelMeshFace BACK_FACE = {{v3{0, 1, 0}, {1, 1, 0}, {1, 0, 0}, {0, 0, 0}}, v3{0, 0, -1}};
    const VoxelMeshFace RIGHT_FACE = {{v3{1, 1, 0}, {1, 1, 1}, {1, 0, 1}, {1, 0, 0}}, v3{1, 0, 0}};
    const VoxelMeshFace TOP_FACE = {{v3{1, 1, 0}, {0, 1, 0}, {0, 1, 1}, {1, 1, 1}}, v3{0, 1, 0}};
    const VoxelMeshFace BOTTOM_FACE = {{v3{0, 0, 0}, {1, 0, 0}, {1, 0, 1}, {0, 0, 1}}, v3{0, -1, 0}};

    const std::array<glm::vec2, 4> textureCoords = {v2{1.0f, 0.0f}, v2{0.0f, 0.0f}, v2{0.0f, 1.0f}, v2{1.0f, 1.0f}};

    bool shouldMakeFace(VoxelID thisId, VoxelID compareId)
    {
        VoxelID air = 0;

        // auto& thisVoxel = getVoxelType((VoxelType)thisId);
        auto& compareVoxel = getVoxelType((VoxelType)compareId);

        if (compareId == air) {
            return true;
        }
        else if (thisId != compareId && compareVoxel.isTransparent) {
            return true;
        }
        return false;
    }
} // namespace

void ChunkMesh::addVoxelFace(const VoxelMeshFace& face, const ChunkPosition& chunkPos, const VoxelPosition& position,
                             GLfloat textureId)
{
    for (int i = 0; i < 4; i++) {
        VoxelVertex v;
        v.position = face.vertexPositions[i] + chunkPos * CHUNK_SIZE + position;
        v.textureCoord = glm::vec3(textureCoords[i].x, textureCoords[i].y, textureId);
        v.normal = face.normal;
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
    auto p = chunk.position();
    mesh.chunkPosY = chunk.position().y * CHUNK_SIZE;
    mesh.chunkPos = chunk.position();

    for (int y = 0; y < CHUNK_SIZE; y++) {
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                // If it is "not air"
                VoxelPosition voxelPosition(x, y, z);
                auto voxel = chunk.qGetVoxel(voxelPosition);
                if (voxel > VoxelType::WATER) {
                    auto& voxData = getVoxelType((VoxelType)chunk.qGetVoxel({x, y, z}));

                    // Left voxel face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x - 1, y, z}))) {
                        mesh.addVoxelFace(LEFT_FACE, p, voxelPosition, voxData.textureSide);
                    }

                    // Right chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x + 1, y, z}))) {
                        mesh.addVoxelFace(RIGHT_FACE, p, voxelPosition, voxData.textureSide);
                    }

                    // Front chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y, z + 1}))) {
                        mesh.addVoxelFace(FRONT_FACE, p, voxelPosition, voxData.textureSide);
                    }

                    // Back chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y, z - 1}))) {
                        mesh.addVoxelFace(BACK_FACE, p, voxelPosition, voxData.textureSide);
                    }

                    // Bottom chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y - 1, z}))) {
                        mesh.addVoxelFace(BOTTOM_FACE, p, voxelPosition, voxData.textureBottom);
                    }

                    // Top chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y + 1, z}))) {
                        mesh.addVoxelFace(TOP_FACE, p, voxelPosition, voxData.textureTop);
                    }
                }
            }
        }
    }

    return mesh;
}

ChunkMesh createGrassCubeMesh()
{
    ChunkMesh mesh;

    float w = 1;
    float h = 1;
    float d = 1;

    // clang-format off
    mesh.vertices = {
        {{w, h, d}, {1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  
        {{0, h, d}, {0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},
        {{0, 0, d}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},  
        {{w, 0, d}, {1.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 1.0f}},

        {{0, h, d}, {1.0f, 0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, h, 0}, {0.0f, 0.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},
        {{0, 0, 0}, {0.0f, 1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f, 0.0f}, {-1.0f, 0.0f, 0.0f}},

        {{0, h, 0}, {1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{w, h, 0}, {0.0f, 0.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},
        {{w, 0, 0}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}}, 
        {{0, 0, 0}, {1.0f, 1.0f, 0.0f}, {0.0f, 0.0f, -1.0f}},

        {{w, h, 0}, {1.0f, 0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, h, d}, {0.0f, 0.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},  
        {{w, 0, 0}, {1.0f, 1.0f, 0.0f}, {1.0f, 0.0f, 0.0f}},

        {{w, h, 0}, {1.0f, 0.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},  
        {{0, h, 0}, {0.0f, 0.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},
        {{0, h, d}, {0.0f, 1.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},  
        {{w, h, d}, {1.0f, 1.0f, 2.0f}, {0.0f, 1.0f, 0.0f}},

        {{0, 0, 0}, {1.0f, 0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{w, 0, 0}, {0.0f, 0.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
        {{w, 0, d}, {0.0f, 1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}}, 
        {{0, 0, d}, {1.0f, 1.0f, 1.0f}, {0.0f, -1.0f, 0.0f}},
    };
    // clang-format on

    int currIndex = 0;
    for (int i = 0; i < 6; i++) {
        mesh.indices.push_back(currIndex);
        mesh.indices.push_back(currIndex + 1);
        mesh.indices.push_back(currIndex + 2);
        mesh.indices.push_back(currIndex + 2);
        mesh.indices.push_back(currIndex + 3);
        mesh.indices.push_back(currIndex);
        currIndex += 4;
    }

    return mesh;
}
