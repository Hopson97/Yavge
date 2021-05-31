#version 450 core

in vec2 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2D diffuseTexture;
uniform vec3 lightColour;

uniform bool isLight;

void main()
{
    outColour = texture(diffuseTexture, passTextureCoord);
    if (!isLight) {
        vec3 ambient = 0.1 * lightColour;
        
        vec4 result = vec4(ambient, 1.0); 

        outColour *= result;
    }
}