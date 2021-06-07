#pragma once

#include "Chunk.h"
#include "Graphics/Mesh.h"

struct TerrainGenOptions {
    int octaves = 8;
    float amplitude = 230;
    float smoothness = 500;
    float roughness = 0.58;
    float offset = 0;

    int seed;
    int useGreedyMeshing = true;
};

std::vector<ChunkPosition> createChunkTerrain(ChunkMap& chunkmap, int chunkX, int chunkZ, int worldSize,
                                              const TerrainGenOptions& TerrainGenOptions);