#pragma once

#include <unordered_map>

#include <glad/glad.h>


#include "../Maths.h"

class Shader final {
  public:
    Shader() = default;

    void loadFromMemory(const char* vertexSource, const char* fragmentSource);
    void loadFromFile(const char* vertexFilename, const char* fragmentFileName);

    void set(const char* name, int value);
    void set(const char* name, float value);
    void set(const char* name, const glm::mat4& matrix);
    void set(const char* name, const glm::vec4& vector);
    void set(const char* name, const glm::vec3& vector);

    void bind() const;

  private:
    GLuint getUniformLocation(const char* name);

    std::unordered_map<const char*, GLuint> m_uniformLocations;
    GLuint m_program = 0;

  public:
    Shader& operator=(Shader&& other);
    Shader(Shader&& other);
    ~Shader();

    Shader& operator=(Shader& other) = delete;
    Shader(Shader& other) = delete;
};
