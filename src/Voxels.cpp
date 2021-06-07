#include "Voxels.h"

#include "Graphics/Texture.h"
#include <array>

namespace {
    std::array<Voxel, NUM_VOXELS> voxels;
} // namespace

void initVoxelSystem(TextureArray2D& textureArray)
{
    GLuint tGrass = textureArray.addTexture("Grass.png");
    GLuint tGrassSide = textureArray.addTexture("GrassSide.png");
    GLuint tDirt = textureArray.addTexture("Dirt.png");
    GLuint tStone = textureArray.addTexture("Stone.png");
    GLuint tWater = textureArray.addTexture("Water.png");
    GLuint tSand = textureArray.addTexture("Sand.png");

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

bool isVoxelSolid(uint16_t i)
{
    return i > VoxelType::WATER;
}