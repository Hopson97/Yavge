#include "Voxels.h"

#include "Graphics/Texture.h"
#include <array>

namespace {
    std::array<Voxel, NUM_VOXELS> voxels;
} // namespace

void initVoxelSystem(TextureArray2D& textureArray)
{
    GLuint tGrass = textureArray.addTexture("grass.png");
    GLuint tGrassSide = textureArray.addTexture("grass_side.png");
    GLuint tDirt = textureArray.addTexture("dirt.png");
    GLuint tStone = textureArray.addTexture("stone.png");
    GLuint tWater = textureArray.addTexture("water.png");
    GLuint tSand = textureArray.addTexture("sand.png");

    voxels[AIR] = {"Air", 0, 0, 0, false};
    voxels[GRASS] = {"Grass", tGrass, tGrassSide, tDirt, false};
    voxels[DIRT] = {"Grass", tDirt, tDirt, tDirt, false};
    voxels[STONE] = {"Stone", tStone, tStone, tStone, false};
    voxels[WATER] = {"Water", tWater, tWater, tWater, true};
    voxels[SAND] = {"Sand", tSand, tSand, tSand, false};
}

const Voxel& getVoxelType(VoxelType type)
{
    return voxels[type];
}

/*

    AIR = 0,
    GRASS = 1,
    STONE = 2,
    WATER = 3,*/