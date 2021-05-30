#version 450 core

in vec2 passTextureCoord;
in vec3 passNormal;
in vec3 passFragPosition;

out vec4 outColour;

uniform sampler2D tex;
uniform vec3 lightColour;
uniform vec3 lightPosition;
uniform vec3 viewerPosition;

uniform bool isLightSource;

void main()
{
    vec3 normal = normalize(passNormal);


    vec3 viewerDirection = normalize(viewerPosition - passFragPosition);
    vec3 lightDirection = normalize(lightPosition - passFragPosition);
    vec3 reflectDirection = reflect(-lightDirection, normal);  

    float difference = max(dot(normal, lightDirection), 0.0);
    vec3 diffuse = difference * lightColour;

    float ambientLight = isLightSource ? 1.0 : 0.1;
    vec3 ambientColour = ambientLight * lightColour;

    float spec = pow(max(dot(viewerDirection, reflectDirection), 0.0), 16);
    vec3 specular = 0.5 * spec * lightColour; 
    
    vec4 light = vec4(ambientColour + diffuse + specular, 1.0);

    outColour = texture(tex, passTextureCoord) * light;
}