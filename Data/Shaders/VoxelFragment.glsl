#version 450 core

in vec3 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2DArray diffuseTexture;
uniform vec3 lightColour;
uniform vec3 lightPosition;

uniform vec3 eyePosition;

void main()
{
    vec3 ambient = 0.2 * lightColour;

    vec3 normal = normalize(passNormal);
    vec3 lightDirection = normalize(lightPosition - passFragPosition);

    vec3 eyeDirection = normalize(eyePosition - passFragPosition);
    vec3 reflectDirection = reflect(-lightDirection, normal);
    float spec = pow(max(dot(eyeDirection, reflectDirection), 0.0), 32);
    vec3 specular = 0.1 * spec * lightColour;

    float diff = max(dot(normal, lightDirection), 0.0);
    vec3 diffuse = lightColour * diff;

    vec4 result = vec4(ambient + specular + diffuse, 1.0); 
    outColour = texture(diffuseTexture, passTextureCoord) * result;
}