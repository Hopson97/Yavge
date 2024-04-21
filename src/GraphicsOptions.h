#pragma once

#include "Utility.h"

struct GraphicsOptions {
    int doWaterReflection = true;
    int doWaterRefraction = true;

    int useDistortMaps = true;
    int useNormal = true;

    int doFresnel = true;

    int showPreviews = false;

    glm::vec4 clearColour = COLOUR_SKY_BLUE;
};
