#pragma once

#include "Graphics/Shader.h"
#include <cstdint>
#include <glad/glad.h>
#include <glm/glm.hpp>
class TextureArray2D;

enum VoxelType : VoxelID {
    AIR = 0,
    WATER = 1,
    GRASS = 2,
    DIRT = 3,
    STONE = 4,
    SAND = 5,

    NUM_VOXELS
};

struct Voxel {
    Voxel() = default;
    Voxel(const char* name, const glm::ivec3& colour, bool isTransparent)
        : name{name}
        , colour{colour}
        , isTransparent(isTransparent)
    {
    }
    const char* name;
    glm::ivec3 colour;
    bool isTransparent;
};

Shader initVoxelSystem();

const Voxel& getVoxelType(VoxelType type);

bool isVoxelSolid(VoxelID i);

GLuint getVoxelTexture(VoxelID id, int direction, bool isBackFace);