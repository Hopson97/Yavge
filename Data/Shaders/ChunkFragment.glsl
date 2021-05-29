#version 450 core

in vec3 passTextureCoord;

out vec4 outColour;

uniform sampler2DArray tex;

void main()
{
    outColour = texture(tex, passTextureCoord);
}