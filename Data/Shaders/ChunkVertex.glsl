#version 450 core

layout (location = 0) in vec3 inVertexCoord;
layout (location = 1) in vec3 inTexCoord;

uniform mat4 projectionViewMatrix;

out vec3 passTextureCoord;

void main()
{
    vec4 worldPos = vec4(inVertexCoord, 1.0);
    gl_Position = projectionViewMatrix * worldPos;
    passTextureCoord = inTexCoord;
}