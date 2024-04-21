#pragma once

#include "Chunk.h"

struct TerrainGenOptions {
    int octaves = 8;
    float amplitude = 337.0f;
    float smoothness = 500.0f;
    float roughness = 0.58f;
    float offset = -30.0f;

    int seed = 0;
    int useGreedyMeshing = true;
};

std::vector<ChunkPosition> createChunkTerrain(ChunkMap& chunkmap, int chunkX, int chunkZ, int worldSize,
                                              const TerrainGenOptions& terrainGenOptions);