#version 450

in vec2 passTexCoord;
out vec4 outColour;

uniform sampler2D guiTexture;

void main() { 
    outColour = texture(guiTexture, passTexCoord);



   // float depth = texture(colourTexture, passTexCoord).r;
    //depth = 1.0 - (1.0 - depth) * 50.0;
    //outColour = vec4(depth);
}