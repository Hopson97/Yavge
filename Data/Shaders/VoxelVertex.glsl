#version 450 core

layout (location = 0) in vec3 inVertexCoord;
layout (location = 1) in int inColourid;
layout (location = 2) in vec3 inNormal;

uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;
uniform float waterLevel;

out vec3 passNormal;
out vec3 passFragPosition;
out vec3 passColour;

<COLOURS>


void main()
{   
    vec4 worldPos = modelMatrix * vec4(inVertexCoord, 1.0);

    gl_Position = projectionViewMatrix * worldPos;
    passColour = voxelColours[inColourid];

    passNormal = mat3(transpose(inverse(modelMatrix))) * inNormal;
    passFragPosition = vec3(worldPos);
}