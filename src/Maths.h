#pragma once

#include <glm/common.hpp>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include "Chunks/Chunk.h"

struct Transform {
    glm::vec3 position{0.0f};
    glm::vec3 rotation{0.0f};
};

glm::mat4 createModelMatrix(const Transform& transform);
glm::mat4 createOrbitModelMatrix(const Transform& transform);
glm::mat4 createViewMatrix(const Transform& transform, const glm::vec3& up);
glm::mat4 createProjectionMatrix(float aspectRatio, float fov);

glm::vec3 forwardsVector(const glm::vec3& rotation);
glm::vec3 backwardsVector(const glm::vec3& rotation);
glm::vec3 leftVector(const glm::vec3& rotation);
glm::vec3 rightVector(const glm::vec3& rotation);

class ViewFrustum {
    struct Plane {
        float distanceToPoint(const glm::vec3& point) const;

        float distanceToOrigin;
        glm::vec3 normal;
    };

  public:
    void update(const glm::mat4& projViewMatrix) noexcept;

    bool chunkIsInFrustum(ChunkPosition position) const noexcept;

  private:
    std::array<Plane, 6> m_planes;
};
