#pragma once

#include <cstdint>
#include <glad/glad.h>
class TextureArray2D;

enum VoxelType : uint16_t {
    AIR = 0,
    GRASS = 1,
    DIRT = 2,
    STONE = 3,
    WATER = 4,
    SAND = 5,

    NUM_VOXELS
};

struct Voxel {
    Voxel() = default;
    Voxel(const char* name, GLuint textureTop, GLuint textureSide, GLuint textureBottom)
        : name{name}
        , textureTop{textureTop}
        , textureSide{textureSide}
        , textureBottom{textureBottom}
    {
    }
    const char* name;
    GLuint textureTop;
    GLuint textureSide;
    GLuint textureBottom;
};

void initVoxelSystem(TextureArray2D& textureArray);
const Voxel& getVoxelType(VoxelType type);