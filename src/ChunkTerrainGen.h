#pragma once

#include "Chunk.h"
#include "Graphics/Mesh.h"

std::vector<ChunkPosition> createChunkTerrain(ChunkMap& chunkmap, int chunkX, int chunkZ, int worldSize, int seed);
