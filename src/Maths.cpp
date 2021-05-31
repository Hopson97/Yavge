#include "Maths.h"

glm::mat4 createModelMatrix(const Transform& transform)
{
    glm::mat4 matrix{1.0f};

    matrix = glm::translate(matrix, transform.position);

    matrix = glm::rotate(matrix, glm::radians(transform.rotation.x), {1, 0, 0});
    matrix = glm::rotate(matrix, glm::radians(transform.rotation.y), {0, 1, 0});
    matrix = glm::rotate(matrix, glm::radians(transform.rotation.z), {0, 0, 1});
    return matrix;
}

glm::mat4 createOrbitModelMatrix(const Transform& transform)
{
    glm::mat4 matrix{1.0f};

    matrix = glm::rotate(matrix, glm::radians(transform.rotation.x), {1, 0, 0});
    matrix = glm::rotate(matrix, glm::radians(transform.rotation.y), {0, 1, 0});
    matrix = glm::rotate(matrix, glm::radians(transform.rotation.z), {0, 0, 1});

    matrix = glm::translate(matrix, transform.position);

    return matrix;
}

glm::mat4 createViewMartix(const Transform& transform, const glm::vec3& up)
{
    glm::vec3 center{0.0f};
    glm::vec3 front{0.0f};

    front.x = cos(glm::radians(transform.rotation.y)) * cos(glm::radians(transform.rotation.x));
    front.y = sin(glm::radians(transform.rotation.x));
    front.z = sin(glm::radians(transform.rotation.y)) * cos(glm::radians(transform.rotation.x));
    front = glm::normalize(front);

    center = transform.position + front;

    return glm::lookAt(transform.position, center, up);
}

glm::mat4 createProjectionMatrix(float aspectRatio, float fov)
{
    return glm::perspective(glm::radians(fov), aspectRatio, 0.1f, 10000.0f);
}

glm::vec3 forwardsVector(const glm::vec3& rotation)
{
    float yaw = glm::radians(rotation.y);
    float pitch = glm::radians(rotation.x);

    return {glm::cos(yaw) * glm::cos(pitch), glm::sin(pitch), glm::cos(pitch) * glm::sin(yaw)};
}

glm::vec3 backwardsVector(const glm::vec3& rotation)
{
    return -forwardsVector(rotation);
}

glm::vec3 leftVector(const glm::vec3& rotation)
{
    float yaw = glm::radians(rotation.y + 90);
    return {-glm::cos(yaw), 0, -glm::sin(yaw)};
}

glm::vec3 rightVector(const glm::vec3& rotation)
{
    return -leftVector(rotation);
}