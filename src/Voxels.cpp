#include "Voxels.h"

#include "Graphics/Texture.h"
#include "Utility.h"
#include <array>
#include <iostream>

namespace {
    std::array<Voxel, NUM_VOXELS> voxels;

    bool replace(std::string& str, const std::string& from, const std::string& to)
    {
        size_t start_pos = str.find(from);
        if (start_pos == std::string::npos)
            return false;
        str.replace(start_pos, from.length(), to);
        return true;
    }
} // namespace

Shader initVoxelSystem()
{
    // GLuint tGrass = textureArray.addTexture("Grass.png");
    // GLuint tGrassSide = textureArray.addTexture("GrassSide.png");
    // GLuint tDirt = textureArray.addTexture("Dirt.png");
    // GLuint tStone = textureArray.addTexture("Stone.png");
    // GLuint tWater = textureArray.addTexture("Water.png");
    // GLuint tSand = textureArray.addTexture("Sand.png");

    voxels[AIR] = {"Air", {0, 0, 0}, true};
    voxels[WATER] = {"Water", {0, 0, 0}, true};
    voxels[GRASS] = {"Grass", {126, 200, 80}, false};
    voxels[DIRT] = {"Dirt", {150, 75, 20}, false};
    voxels[STONE] = {"Stone", {100, 100, 100}, false};
    voxels[SAND] = {"Sand", {194, 178, 128}, false};

    char* vertexSource = getFileContent("Data/Shaders/VoxelVertex.glsl");
    char* fragmentSource = getFileContent("Data/Shaders/VoxelFragment.glsl");

    std::string voxelVertex = vertexSource;
    std::string source;
    source.reserve(voxels.size() * 32);
    source += "vec3 voxelColours[] = vec3[](\n";
    for (unsigned i = 0; i < voxels.size(); i++) {
        auto r = std::to_string(voxels[i].colour.r);
        auto g = std::to_string(voxels[i].colour.g);
        auto b = std::to_string(voxels[i].colour.b);
        source += std::string("\tvec3(" + r + "," + g + "," + b + ((i == voxels.size() - 1) ? ")\n" : "),\n"));
    }
    source += ");";
    replace(voxelVertex, "<COLOURS>", source);


    Shader voxelShader;
    voxelShader.loadFromMemory(voxelVertex.c_str(), fragmentSource);

    free(vertexSource);
    free(fragmentSource);

    return voxelShader;
}

const Voxel& getVoxelType(VoxelType type)
{
    return voxels[type];
}

bool isVoxelSolid(VoxelID i)
{
    return i > VoxelType::WATER;
}