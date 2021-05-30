#version 450 core

in vec3 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2DArray diffuseTexture;

void main()
{
    outColour = texture(diffuseTexture, passTextureCoord);
}