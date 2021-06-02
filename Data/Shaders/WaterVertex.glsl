#version 450 core

layout (location = 0) in vec3 inVertexCoord;
layout (location = 1) in vec2 inTexCoord;
layout (location = 2) in vec3 inNormal;

uniform mat4 modelMatrix;
uniform mat4 projectionViewMatrix;

out vec3 passNormal;
out vec3 passFragPosition;

out vec4 passClipSpace;
out vec2 passTexCoords;

void main()
{
    vec4 worldPos = modelMatrix * vec4(inVertexCoord, 1.0);
    passClipSpace = projectionViewMatrix * worldPos;
    gl_Position = passClipSpace;

    passNormal = mat3(transpose(inverse(modelMatrix))) * inNormal;
    passFragPosition = vec3(worldPos);
    passTexCoords = inTexCoord;

}