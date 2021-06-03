#version 450 core

in vec3 passNormal;
in vec3 passFragPosition;
in vec2 passTexCoords;
in vec4 passClipSpace;
in float passTime;

out vec4 outColour;

layout(binding = 0) uniform sampler2D reflectTexture;
layout(binding = 1) uniform sampler2D refractTexture;

layout(binding = 2) uniform sampler2D distortMap;

uniform vec3 lightColour;
uniform vec3 lightPosition;
uniform vec3 eyePosition;

uniform bool useFresnal;
uniform bool useDUDVMaps;

const float DISTORT_STRENGTH = 0.0045;

void main()
{
    vec2 deviceCoords = (passClipSpace.xy / passClipSpace.w) / 2.0 + 0.5;
    vec2 refractTexCoords = deviceCoords;
    vec2 reflectTexCoords = vec2(deviceCoords.x, 1-deviceCoords.y);

    if (useDUDVMaps) {
        float offset = passTime * 0.025;
        vec2 distort = texture(distortMap, vec2(passTexCoords.x + offset, passTexCoords.y)).rg * 0.1;
        distort = passTexCoords + vec2(distort.x, distort.y + offset);
        vec2 totalDistort = (texture(distortMap, distort).rg * 2.0 - 1.0) * DISTORT_STRENGTH;

        refractTexCoords += totalDistort;
        reflectTexCoords += totalDistort;
    }

    vec4 refractColour = texture(refractTexture, refractTexCoords);
    vec4 reflectColour = texture(reflectTexture, reflectTexCoords);

    // Calculate Lighting
    vec3 ambient = 0.1 * lightColour;

    vec3 normal = normalize(passNormal);
    vec3 lightDirection = normalize(lightPosition - passFragPosition);
    vec3 eyeDirection = normalize(eyePosition - passFragPosition);

    vec3 reflectDirection = reflect(-lightDirection, normal);

    float spec = pow(max(dot(eyeDirection, reflectDirection), 0.0), 64);
    vec3 specular = 0.5 * spec * lightColour;

    float diff = max(dot(normal, lightDirection), 0.0);
    vec3 diffuse = lightColour * diff;

    vec4 lighting = vec4(ambient + specular + diffuse, 1.0); 


    // Calculate Fresnel Effect
    float refractiveFactor = dot(eyeDirection, normal);
    if (useFresnal) {
        outColour = mix(reflectColour, refractColour, useFresnal ? refractiveFactor : 0.5);
    }
    else {
        outColour = mix(reflectColour, refractColour, 0.5);
    }
    outColour *= lighting;
}