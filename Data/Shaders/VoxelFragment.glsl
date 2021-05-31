#version 450 core

in vec3 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2DArray diffuseTexture;
uniform vec3 lightColour;

void main()
{
    vec3 ambient = 0.1 * lightColour;

    vec4 result = vec4(ambient, 1.0); 
    outColour = texture(diffuseTexture, passTextureCoord) * result;
}