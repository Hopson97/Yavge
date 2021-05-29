cmake_minimum_required(VERSION 3.10)

#Set up project
project(
    yavge 
    VERSION 1.0
)

include(${CMAKE_BINARY_DIR}/../conanbuildinfo.cmake)
conan_basic_setup()

#Set executable
add_executable(${PROJECT_NAME}     
    src/main.cpp
    src/Camera.cpp
    src/GUI.cpp
    src/Maths.cpp
    src/Utility.cpp
    src/Graphics/Mesh.cpp
    src/Graphics/Framebuffer.cpp
    src/Graphics/Shader.cpp
    src/Graphics/Texture.cpp
    src/Graphics/VertexArray.cpp
)



#Set C++17
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)

#Set flags
if(MSVC)
  	target_compile_options(${PROJECT_NAME} PRIVATE 
    	/W4)
else()
  	target_compile_options(${PROJECT_NAME} PRIVATE 
		-Wall -Wextra -pedantic -fPIE)		
endif()


add_subdirectory(deps)

target_include_directories(
    ${PROJECT_NAME}
    PRIVATE
    deps
)

if (UNIX)
    target_link_libraries(${PROJECT_NAME} 
        dl
        ${CMAKE_DL_LIBS}
    )
endif (UNIX)

#Finally
target_link_libraries(${PROJECT_NAME} 
    glad 
    stb
    nuklear
    ${CONAN_LIBS}
)
