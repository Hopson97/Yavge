#version 450 core

in vec2 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2D tex;


void main()
{


    outColour = texture(tex, passTextureCoord);// * light;
}