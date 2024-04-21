#include "ChunkMesh.h"

#include "Voxels.h"
#include <iostream>
namespace {
    using v3 = glm::ivec3;
    using v2 = glm::vec2;
    const VoxelMeshFace FRONT_FACE = {{v3{1, 1, 1}, {0, 1, 1}, {0, 0, 1}, {1, 0, 1}}, v3{0, 0, 1}};
    const VoxelMeshFace LEFT_FACE = {{v3{0, 1, 1}, {0, 1, 0}, {0, 0, 0}, {0, 0, 1}}, v3{-1, 0, 0}};
    const VoxelMeshFace BACK_FACE = {{v3{0, 1, 0}, {1, 1, 0}, {1, 0, 0}, {0, 0, 0}}, v3{0, 0, -1}};
    const VoxelMeshFace RIGHT_FACE = {{v3{1, 1, 0}, {1, 1, 1}, {1, 0, 1}, {1, 0, 0}}, v3{1, 0, 0}};
    const VoxelMeshFace TOP_FACE = {{v3{1, 1, 0}, {0, 1, 0}, {0, 1, 1}, {1, 1, 1}}, v3{0, 1, 0}};
    const VoxelMeshFace BOTTOM_FACE = {{v3{0, 0, 0}, {1, 0, 0}, {1, 0, 1}, {0, 0, 1}}, v3{0, -1, 0}};

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
                             int voxelId)
{
    for (int i = 0; i < 4; i++) {
        VoxelVertex v;
        v.position = face.vertexPositions[i] + chunkPos * CHUNK_SIZE + position;
        v.voxelId = voxelId;
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
    mesh.chunkPosY = (float)(chunk.position().y * CHUNK_SIZE);
    mesh.chunkPos = chunk.position();

    for (int y = 0; y < CHUNK_SIZE; y++) {
        for (int z = 0; z < CHUNK_SIZE; z++) {
            for (int x = 0; x < CHUNK_SIZE; x++) {
                // If it is "not air"
                VoxelPosition voxelPosition(x, y, z);
                auto voxel = chunk.qGetVoxel(voxelPosition);
                if (voxel > VoxelType::WATER) {

                    // Left voxel face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x - 1, y, z}))) {
                        mesh.addVoxelFace(LEFT_FACE, p, voxelPosition, voxel);
                    }

                    // Right chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x + 1, y, z}))) {
                        mesh.addVoxelFace(RIGHT_FACE, p, voxelPosition, voxel);
                    }

                    // Front chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y, z + 1}))) {
                        mesh.addVoxelFace(FRONT_FACE, p, voxelPosition, voxel);
                    }

                    // Back chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y, z - 1}))) {
                        mesh.addVoxelFace(BACK_FACE, p, voxelPosition, voxel);
                    }

                    // Bottom chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y - 1, z}))) {
                        mesh.addVoxelFace(BOTTOM_FACE, p, voxelPosition, voxel);
                    }

                    // Top chunk face
                    if (shouldMakeFace(voxel, chunk.getVoxel({x, y + 1, z}))) {
                        mesh.addVoxelFace(TOP_FACE, p, voxelPosition, voxel);
                    }
                }
            }
        }
    }

    return mesh;
}

// Ported from https://eddieabbondanz.io/post/voxel/greedy-mesh/
// Consider a 3D vector as an array rather than 3 seperate components
// and this becomes a lot more clear
// eg If you have array with glm::vec3 = {11, 29, 23};, X is 1, Y is 2, and Z is 3
// OR thinking in arrays, [0] = 11, [1] = 29, and [2] = 23
// By working out which component of the vector needs to be sweeped through, the
// algorithm is able to be used for multiple directions without changing
ChunkMesh createGreedyChunkMesh(const Chunk& chunk)
{
    ChunkMesh mesh;
    auto p = chunk.position();
    mesh.chunkPosY = (float)(chunk.position().y * CHUNK_SIZE);
    mesh.chunkPos = chunk.position();

    // For each slice, a mask is created to determine if a block face has already been visited
    std::array<bool, CHUNK_AREA> mask;
    auto maskIdx = [](int x, int y) { return y * CHUNK_SIZE + x; };

    // Goes through all 6 axis eg X, -X, Y, -Y, Z, and -Z
    for (int faceAxis = 0; faceAxis < 6; faceAxis++) {
        // For -X, -Y, and -Z, this is true, else is false
        bool isBackFace = faceAxis > 2;

        // X, Y, or Z component of the vector. This is the "slice" component of the chunk
        // This says which layer the
        int sliceDir = faceAxis % 3;

        // These are the other two components of the vector complemening "direction"
        // that are used to sweep across the indiidual planes/slices
        // Eg if the "slice direction" is 0 (or X),
        // then these will be 1 and 2, (or Y and Z) etc
        int sweepDirA = (sliceDir + 1) % 3;
        int sweepDirB = (sliceDir + 2) % 3;

        // The "working" location within the chunk
        VoxelPosition start{0};
        VoxelPosition end{0};

        // iterate the chunk layers
        for (start[sliceDir] = 0; start[sliceDir] < CHUNK_SIZE; start[sliceDir]++) {

            // Reset the mask for each layer that is visted
            mask = {false};

            // Iterate the voxels of this layer
            for (start[sweepDirA] = 0; start[sweepDirA] < CHUNK_SIZE; start[sweepDirA]++) {
                for (start[sweepDirB] = 0; start[sweepDirB] < CHUNK_SIZE; start[sweepDirB]++) {

                    // Get the voxel at this location in the chunk
                    VoxelID thisVoxel = chunk.getVoxel(start);

                    // Skip this voxel in the working direction if its working face is not visible or has already been
                    // merged
                    if (mask.at(maskIdx(start[sweepDirA], start[sweepDirB])) || !isVoxelSolid(thisVoxel) ||
                        !chunk.isFaceVisible(start, sliceDir, isBackFace))
                        continue;

                    // At this point a SINGLE voxel face has been found.
                    // Adajacent voxel faces are then combined into this one by:
                    //  1. Calculate the width of this voxel section
                    //  2. Calculate the height of this voxel section
                    //  3. Create 4 vertices, and add them to the chunk mesh

                    VoxelPosition currPos = start;
                    glm::ivec3 quadSize{0};

                    // Work out how "wide" the section is by going throuugh a single row of voxels
                    // and looking at the next voxel along to see if it is the same type of voxel
                    // and has a visible face

                    /////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////
                    ////
                    ////  vvvv   NEED TO WORK OUT HOW THIS WORKS  vvvv
                    ////
                    /////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////
                    for (currPos = start, currPos[sweepDirB]++;
                         currPos[sweepDirB] < CHUNK_SIZE && chunk.compareStep(start, currPos, sliceDir, isBackFace) &&
                         !mask.at(maskIdx(currPos[sweepDirA], currPos[sweepDirB]));
                         currPos[sweepDirB]++) {
                    }
                    quadSize[sweepDirB] = currPos[sweepDirB] - start[sweepDirB];

                    // Figure out the height, then save it
                    for (currPos = start, currPos[sweepDirA]++;
                         currPos[sweepDirA] < CHUNK_SIZE && chunk.compareStep(start, currPos, sliceDir, isBackFace) &&
                         !mask.at(maskIdx(currPos[sweepDirA], currPos[sweepDirB]));
                         currPos[sweepDirA]++) {
                        for (currPos[sweepDirB] = start[sweepDirB];
                             currPos[sweepDirB] < CHUNK_SIZE &&
                             chunk.compareStep(start, currPos, sliceDir, isBackFace) &&
                             !mask.at(maskIdx(currPos[sweepDirA], currPos[sweepDirB]));
                             currPos[sweepDirB]++) {
                        }

                        // If we didn't reach the end then its not a good add.
                        if (currPos[sweepDirB] - start[sweepDirB] < quadSize[sweepDirB]) {
                            break;
                        }
                        else {
                            currPos[sweepDirB] = start[sweepDirB];
                        }
                    }
                    quadSize[sweepDirA] = currPos[sweepDirA] - start[sweepDirA];
                    /////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////
                    ////
                    //// ^^^^   NEED TO WORK OUT HOW THAT WORKS  ^^^^^
                    ////
                    /////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////

                    // Calculate the "width" and "height"
                    glm::ivec3 width{0};
                    glm::ivec3 height{0};
                    glm::ivec3 offset = p * CHUNK_SIZE + start;

                    // The components of the width and height are the sweep planes
                    width[sweepDirA] = quadSize[sweepDirA];
                    height[sweepDirB] = quadSize[sweepDirB];

                    // The "offset" is the layer within this chunk the voxel is
                    offset[sliceDir] += isBackFace ? 0 : 1;

                    // Calculate the positon
                    VoxelVertex vertices[4];
                    vertices[0].position = offset;
                    vertices[1].position = offset + width;
                    vertices[2].position = offset + width + height;
                    vertices[3].position = offset + height;

                    // Calulate the texture coords and add to the mesh
                    glm::vec3 normal{0};
                    normal[sliceDir] = isBackFace ? -1 : 1;
                    for (int i = 0; i < 4; i++) {
                        vertices[i].voxelId = thisVoxel;
                        vertices[i].normal = normal;

                        mesh.vertices.push_back(vertices[i]);
                    }
                    if (isBackFace) {
                        mesh.indices.push_back(mesh.indicesCount + 2);
                        mesh.indices.push_back(mesh.indicesCount + 1);
                        mesh.indices.push_back(mesh.indicesCount);
                        mesh.indices.push_back(mesh.indicesCount);
                        mesh.indices.push_back(mesh.indicesCount + 3);
                        mesh.indices.push_back(mesh.indicesCount + 2);
                    }
                    else {
                        mesh.indices.push_back(mesh.indicesCount);
                        mesh.indices.push_back(mesh.indicesCount + 1);
                        mesh.indices.push_back(mesh.indicesCount + 2);
                        mesh.indices.push_back(mesh.indicesCount + 2);
                        mesh.indices.push_back(mesh.indicesCount + 3);
                        mesh.indices.push_back(mesh.indicesCount);
                    }
                    mesh.indicesCount += 4;

                    // Finally, add the face to the mask so they aren't repeated
                    for (int y = 0; y < quadSize[sweepDirA]; y++) {
                        for (int x = 0; x < quadSize[sweepDirB]; x++) {
                            mask.at(maskIdx(start[sweepDirA] + y, start[sweepDirB] + x)) = true;
                        }
                    }
                }
            }
        }
    }
    return mesh;
}

/*

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
*/