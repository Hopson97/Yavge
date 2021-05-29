#version 450

in vec2 passTexCoord;
out vec4 outColour;

uniform sampler2D colourTexture;

void main() { 
    outColour = texture(colourTexture, passTexCoord);
}