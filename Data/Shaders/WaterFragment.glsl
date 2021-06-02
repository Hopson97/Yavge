#version 450 core

in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

layout(binding = 0) uniform sampler2D reflectTexture;
layout(binding = 1) uniform sampler2D refractTexture;

uniform vec3 lightColour;
uniform vec3 lightPosition;
uniform vec3 eyePosition;

in vec2 passTexCoords;
in vec4 passClipSpace;



void main()
{
    vec2 deviceCoords = (passClipSpace.xy / passClipSpace.w) / 2.0 + 0.5;
    vec2 refractTexCoords = deviceCoords;
    vec2 reflectTexCoords = vec2(deviceCoords.x, 1-deviceCoords.y);



    vec4 refractColour = texture(refractTexture, refractTexCoords);
    vec4 reflectColour = texture(reflectTexture, reflectTexCoords);
    outColour = mix (reflectColour, refractColour, 0.5);





   // outColour = texture(diffuseTexture, passTextureCoord);
    //vec3 ambient = 0.1 * lightColour;

    //vec3 normal = normalize(passNormal);
    //vec3 lightDirection = normalize(lightPosition - passFragPosition);
    //vec3 eyeDirection = normalize(eyePosition - passFragPosition);

    //vec3 reflectDirection = reflect(-lightDirection, normal);

    //float spec = pow(max(dot(eyeDirection, reflectDirection), 0.0), 32);
    //vec3 specular = 0.5 * spec * lightColour;

    //float diff = max(dot(normal, lightDirection), 0.0);
    //vec3 diffuse = lightColour * diff;

    //vec4 result = vec4(ambient + specular + diffuse, 1.0); 
    //outColour *= result;
}