
add_library(nuklear
nuklear/nuklear_sfml_gl3.cpp
nuklear/demos.cpp
nuklear/nuklear_impl.c
)
target_compile_options(nuklear PRIVATE -fPIE)		

add_library(glad glad/glad.c)   
target_compile_options(glad PRIVATE -fPIE)		

add_library(stb stb/stb_impl.c)   
target_compile_options(stb PRIVATE -fPIE)	

if (UNIX)
    target_compile_options(nuklear PRIVATE -fPIE)	
    target_compile_options(stb PRIVATE -fPIE)	
    target_compile_options(glad PRIVATE -fPIE)	
endif (UNIX)