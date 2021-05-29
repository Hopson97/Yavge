include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS SUFFIX BUILD_TYPE)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            set(_BTYPE ${CMAKE_BUILD_TYPE})
        elseif(NOT BUILD_TYPE STREQUAL "")
            set(_BTYPE ${BUILD_TYPE})
        endif()
        if(_BTYPE)
            if(${_BTYPE} MATCHES "Debug|_DEBUG")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "Release|_RELEASE")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "RelWithDebInfo|_RELWITHDEBINFO")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "MinSizeRel|_MINSIZEREL")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            endif()
        endif()
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAME ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS${SUFFIX}} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS${SUFFIX}}")
            endif()
        endforeach()
    endif()
endmacro()


#################
###  SFML
#################
set(CONAN_SFML_ROOT "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e")
set(CONAN_INCLUDE_DIRS_SFML "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/include")
set(CONAN_LIB_DIRS_SFML "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/lib")
set(CONAN_BIN_DIRS_SFML )
set(CONAN_RES_DIRS_SFML )
set(CONAN_SRC_DIRS_SFML )
set(CONAN_BUILD_DIRS_SFML "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/")
set(CONAN_FRAMEWORK_DIRS_SFML )
set(CONAN_LIBS_SFML sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_PKG_LIBS_SFML sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s)
set(CONAN_SYSTEM_LIBS_SFML pthread udev)
set(CONAN_FRAMEWORKS_SFML )
set(CONAN_FRAMEWORKS_FOUND_SFML "")  # Will be filled later
set(CONAN_DEFINES_SFML "-DSFML_STATIC")
set(CONAN_BUILD_MODULES_PATHS_SFML )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_SFML "SFML_STATIC")

set(CONAN_C_FLAGS_SFML "")
set(CONAN_CXX_FLAGS_SFML "")
set(CONAN_SHARED_LINKER_FLAGS_SFML "")
set(CONAN_EXE_LINKER_FLAGS_SFML "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_SFML_LIST "")
set(CONAN_CXX_FLAGS_SFML_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_SFML_LIST "")
set(CONAN_EXE_LINKER_FLAGS_SFML_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_SFML "${CONAN_FRAMEWORKS_SFML}" "_SFML" "")
# Append to aggregated values variable
set(CONAN_LIBS_SFML ${CONAN_PKG_LIBS_SFML} ${CONAN_SYSTEM_LIBS_SFML} ${CONAN_FRAMEWORKS_FOUND_SFML})


#################
###  GLM
#################
set(CONAN_GLM_ROOT "/home/hopson/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_GLM "/home/hopson/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_GLM )
set(CONAN_BIN_DIRS_GLM )
set(CONAN_RES_DIRS_GLM )
set(CONAN_SRC_DIRS_GLM )
set(CONAN_BUILD_DIRS_GLM "/home/hopson/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_GLM )
set(CONAN_LIBS_GLM )
set(CONAN_PKG_LIBS_GLM )
set(CONAN_SYSTEM_LIBS_GLM )
set(CONAN_FRAMEWORKS_GLM )
set(CONAN_FRAMEWORKS_FOUND_GLM "")  # Will be filled later
set(CONAN_DEFINES_GLM )
set(CONAN_BUILD_MODULES_PATHS_GLM )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GLM )

set(CONAN_C_FLAGS_GLM "")
set(CONAN_CXX_FLAGS_GLM "")
set(CONAN_SHARED_LINKER_FLAGS_GLM "")
set(CONAN_EXE_LINKER_FLAGS_GLM "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GLM_LIST "")
set(CONAN_CXX_FLAGS_GLM_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GLM_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GLM_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GLM "${CONAN_FRAMEWORKS_GLM}" "_GLM" "")
# Append to aggregated values variable
set(CONAN_LIBS_GLM ${CONAN_PKG_LIBS_GLM} ${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM})


#################
###  ASSIMP
#################
set(CONAN_ASSIMP_ROOT "/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45")
set(CONAN_INCLUDE_DIRS_ASSIMP "/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/include")
set(CONAN_LIB_DIRS_ASSIMP "/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/lib")
set(CONAN_BIN_DIRS_ASSIMP )
set(CONAN_RES_DIRS_ASSIMP )
set(CONAN_SRC_DIRS_ASSIMP )
set(CONAN_BUILD_DIRS_ASSIMP "/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/")
set(CONAN_FRAMEWORK_DIRS_ASSIMP )
set(CONAN_LIBS_ASSIMP assimp)
set(CONAN_PKG_LIBS_ASSIMP assimp)
set(CONAN_SYSTEM_LIBS_ASSIMP rt m pthread stdc++)
set(CONAN_FRAMEWORKS_ASSIMP )
set(CONAN_FRAMEWORKS_FOUND_ASSIMP "")  # Will be filled later
set(CONAN_DEFINES_ASSIMP )
set(CONAN_BUILD_MODULES_PATHS_ASSIMP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ASSIMP )

set(CONAN_C_FLAGS_ASSIMP "")
set(CONAN_CXX_FLAGS_ASSIMP "")
set(CONAN_SHARED_LINKER_FLAGS_ASSIMP "")
set(CONAN_EXE_LINKER_FLAGS_ASSIMP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ASSIMP_LIST "")
set(CONAN_CXX_FLAGS_ASSIMP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ASSIMP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ASSIMP "${CONAN_FRAMEWORKS_ASSIMP}" "_ASSIMP" "")
# Append to aggregated values variable
set(CONAN_LIBS_ASSIMP ${CONAN_PKG_LIBS_ASSIMP} ${CONAN_SYSTEM_LIBS_ASSIMP} ${CONAN_FRAMEWORKS_FOUND_ASSIMP})


#################
###  FREETYPE
#################
set(CONAN_FREETYPE_ROOT "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67")
set(CONAN_INCLUDE_DIRS_FREETYPE "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/include"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/include/freetype2")
set(CONAN_LIB_DIRS_FREETYPE "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/lib")
set(CONAN_BIN_DIRS_FREETYPE "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/bin")
set(CONAN_RES_DIRS_FREETYPE )
set(CONAN_SRC_DIRS_FREETYPE )
set(CONAN_BUILD_DIRS_FREETYPE "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_FREETYPE )
set(CONAN_LIBS_FREETYPE freetype)
set(CONAN_PKG_LIBS_FREETYPE freetype)
set(CONAN_SYSTEM_LIBS_FREETYPE m)
set(CONAN_FRAMEWORKS_FREETYPE )
set(CONAN_FRAMEWORKS_FOUND_FREETYPE "")  # Will be filled later
set(CONAN_DEFINES_FREETYPE )
set(CONAN_BUILD_MODULES_PATHS_FREETYPE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FREETYPE )

set(CONAN_C_FLAGS_FREETYPE "")
set(CONAN_CXX_FLAGS_FREETYPE "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FREETYPE_LIST "")
set(CONAN_CXX_FLAGS_FREETYPE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FREETYPE "${CONAN_FRAMEWORKS_FREETYPE}" "_FREETYPE" "")
# Append to aggregated values variable
set(CONAN_LIBS_FREETYPE ${CONAN_PKG_LIBS_FREETYPE} ${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE})


#################
###  STB
#################
set(CONAN_STB_ROOT "/home/hopson/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_STB "/home/hopson/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_STB )
set(CONAN_BIN_DIRS_STB )
set(CONAN_RES_DIRS_STB )
set(CONAN_SRC_DIRS_STB )
set(CONAN_BUILD_DIRS_STB "/home/hopson/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_STB )
set(CONAN_LIBS_STB )
set(CONAN_PKG_LIBS_STB )
set(CONAN_SYSTEM_LIBS_STB )
set(CONAN_FRAMEWORKS_STB )
set(CONAN_FRAMEWORKS_FOUND_STB "")  # Will be filled later
set(CONAN_DEFINES_STB "-DSTB_TEXTEDIT_KEYTYPE=unsigned")
set(CONAN_BUILD_MODULES_PATHS_STB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_STB "STB_TEXTEDIT_KEYTYPE=unsigned")

set(CONAN_C_FLAGS_STB "")
set(CONAN_CXX_FLAGS_STB "")
set(CONAN_SHARED_LINKER_FLAGS_STB "")
set(CONAN_EXE_LINKER_FLAGS_STB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_STB_LIST "")
set(CONAN_CXX_FLAGS_STB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_STB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_STB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_STB "${CONAN_FRAMEWORKS_STB}" "_STB" "")
# Append to aggregated values variable
set(CONAN_LIBS_STB ${CONAN_PKG_LIBS_STB} ${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB})


#################
###  OPENAL
#################
set(CONAN_OPENAL_ROOT "/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b")
set(CONAN_INCLUDE_DIRS_OPENAL "/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/include"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/include/AL")
set(CONAN_LIB_DIRS_OPENAL "/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/lib")
set(CONAN_BIN_DIRS_OPENAL )
set(CONAN_RES_DIRS_OPENAL )
set(CONAN_SRC_DIRS_OPENAL )
set(CONAN_BUILD_DIRS_OPENAL "/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_OPENAL )
set(CONAN_LIBS_OPENAL openal)
set(CONAN_PKG_LIBS_OPENAL openal)
set(CONAN_SYSTEM_LIBS_OPENAL dl m)
set(CONAN_FRAMEWORKS_OPENAL )
set(CONAN_FRAMEWORKS_FOUND_OPENAL "")  # Will be filled later
set(CONAN_DEFINES_OPENAL "-DAL_LIBTYPE_STATIC")
set(CONAN_BUILD_MODULES_PATHS_OPENAL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENAL "AL_LIBTYPE_STATIC")

set(CONAN_C_FLAGS_OPENAL "")
set(CONAN_CXX_FLAGS_OPENAL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENAL_LIST "")
set(CONAN_CXX_FLAGS_OPENAL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENAL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENAL "${CONAN_FRAMEWORKS_OPENAL}" "_OPENAL" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENAL ${CONAN_PKG_LIBS_OPENAL} ${CONAN_SYSTEM_LIBS_OPENAL} ${CONAN_FRAMEWORKS_FOUND_OPENAL})


#################
###  FLAC
#################
set(CONAN_FLAC_ROOT "/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d")
set(CONAN_INCLUDE_DIRS_FLAC "/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/include")
set(CONAN_LIB_DIRS_FLAC "/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/lib")
set(CONAN_BIN_DIRS_FLAC "/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/bin")
set(CONAN_RES_DIRS_FLAC )
set(CONAN_SRC_DIRS_FLAC )
set(CONAN_BUILD_DIRS_FLAC "/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/")
set(CONAN_FRAMEWORK_DIRS_FLAC )
set(CONAN_LIBS_FLAC FLAC++ FLAC)
set(CONAN_PKG_LIBS_FLAC FLAC++ FLAC)
set(CONAN_SYSTEM_LIBS_FLAC m)
set(CONAN_FRAMEWORKS_FLAC )
set(CONAN_FRAMEWORKS_FOUND_FLAC "")  # Will be filled later
set(CONAN_DEFINES_FLAC "-DFLAC__NO_DLL")
set(CONAN_BUILD_MODULES_PATHS_FLAC )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FLAC "FLAC__NO_DLL")

set(CONAN_C_FLAGS_FLAC "")
set(CONAN_CXX_FLAGS_FLAC "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC "")
set(CONAN_EXE_LINKER_FLAGS_FLAC "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FLAC_LIST "")
set(CONAN_CXX_FLAGS_FLAC_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FLAC_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FLAC_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FLAC "${CONAN_FRAMEWORKS_FLAC}" "_FLAC" "")
# Append to aggregated values variable
set(CONAN_LIBS_FLAC ${CONAN_PKG_LIBS_FLAC} ${CONAN_SYSTEM_LIBS_FLAC} ${CONAN_FRAMEWORKS_FOUND_FLAC})


#################
###  VORBIS
#################
set(CONAN_VORBIS_ROOT "/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302")
set(CONAN_INCLUDE_DIRS_VORBIS "/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/include")
set(CONAN_LIB_DIRS_VORBIS "/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/lib")
set(CONAN_BIN_DIRS_VORBIS )
set(CONAN_RES_DIRS_VORBIS )
set(CONAN_SRC_DIRS_VORBIS )
set(CONAN_BUILD_DIRS_VORBIS "/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/")
set(CONAN_FRAMEWORK_DIRS_VORBIS )
set(CONAN_LIBS_VORBIS vorbisenc vorbisfile vorbis)
set(CONAN_PKG_LIBS_VORBIS vorbisenc vorbisfile vorbis)
set(CONAN_SYSTEM_LIBS_VORBIS m)
set(CONAN_FRAMEWORKS_VORBIS )
set(CONAN_FRAMEWORKS_FOUND_VORBIS "")  # Will be filled later
set(CONAN_DEFINES_VORBIS )
set(CONAN_BUILD_MODULES_PATHS_VORBIS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_VORBIS )

set(CONAN_C_FLAGS_VORBIS "")
set(CONAN_CXX_FLAGS_VORBIS "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_VORBIS_LIST "")
set(CONAN_CXX_FLAGS_VORBIS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_VORBIS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_VORBIS "${CONAN_FRAMEWORKS_VORBIS}" "_VORBIS" "")
# Append to aggregated values variable
set(CONAN_LIBS_VORBIS ${CONAN_PKG_LIBS_VORBIS} ${CONAN_SYSTEM_LIBS_VORBIS} ${CONAN_FRAMEWORKS_FOUND_VORBIS})


#################
###  XORG
#################
set(CONAN_XORG_ROOT "/home/hopson/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_XORG "/usr/include/uuid"
			"/usr/include/freetype2"
			"/usr/include/libpng16")
set(CONAN_LIB_DIRS_XORG )
set(CONAN_BIN_DIRS_XORG )
set(CONAN_RES_DIRS_XORG )
set(CONAN_SRC_DIRS_XORG )
set(CONAN_BUILD_DIRS_XORG "/home/hopson/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_XORG )
set(CONAN_LIBS_XORG )
set(CONAN_PKG_LIBS_XORG )
set(CONAN_SYSTEM_LIBS_XORG X11 X11-xcb xcb fontenc ICE SM Xau Xaw7 Xt Xcomposite Xcursor Xdamage Xfixes Xdmcp Xext Xft Xi Xinerama xkbfile Xmu Xmuu Xpm Xrandr Xrender XRes Xss Xtst Xv XvMC Xxf86vm xcb-xkb xcb-icccm xcb-image xcb-shm xcb-keysyms xcb-randr xcb-render xcb-render-util xcb-shape xcb-sync xcb-xfixes xcb-xinerama xcb-util xcb-dri3)
set(CONAN_FRAMEWORKS_XORG )
set(CONAN_FRAMEWORKS_FOUND_XORG "")  # Will be filled later
set(CONAN_DEFINES_XORG "-D_DEFAULT_SOURCE"
			"-D_BSD_SOURCE"
			"-DHAS_FCHOWN"
			"-DHAS_STICKY_DIR_BIT")
set(CONAN_BUILD_MODULES_PATHS_XORG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XORG "_DEFAULT_SOURCE"
			"_BSD_SOURCE"
			"HAS_FCHOWN"
			"HAS_STICKY_DIR_BIT")

set(CONAN_C_FLAGS_XORG "")
set(CONAN_CXX_FLAGS_XORG "")
set(CONAN_SHARED_LINKER_FLAGS_XORG "")
set(CONAN_EXE_LINKER_FLAGS_XORG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XORG_LIST "")
set(CONAN_CXX_FLAGS_XORG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XORG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XORG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XORG "${CONAN_FRAMEWORKS_XORG}" "_XORG" "")
# Append to aggregated values variable
set(CONAN_LIBS_XORG ${CONAN_PKG_LIBS_XORG} ${CONAN_SYSTEM_LIBS_XORG} ${CONAN_FRAMEWORKS_FOUND_XORG})


#################
###  OPENGL
#################
set(CONAN_OPENGL_ROOT "/home/hopson/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_OPENGL )
set(CONAN_LIB_DIRS_OPENGL )
set(CONAN_BIN_DIRS_OPENGL )
set(CONAN_RES_DIRS_OPENGL )
set(CONAN_SRC_DIRS_OPENGL )
set(CONAN_BUILD_DIRS_OPENGL "/home/hopson/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_OPENGL )
set(CONAN_LIBS_OPENGL )
set(CONAN_PKG_LIBS_OPENGL )
set(CONAN_SYSTEM_LIBS_OPENGL GL)
set(CONAN_FRAMEWORKS_OPENGL )
set(CONAN_FRAMEWORKS_FOUND_OPENGL "")  # Will be filled later
set(CONAN_DEFINES_OPENGL )
set(CONAN_BUILD_MODULES_PATHS_OPENGL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENGL )

set(CONAN_C_FLAGS_OPENGL "")
set(CONAN_CXX_FLAGS_OPENGL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENGL_LIST "")
set(CONAN_CXX_FLAGS_OPENGL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENGL "${CONAN_FRAMEWORKS_OPENGL}" "_OPENGL" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENGL ${CONAN_PKG_LIBS_OPENGL} ${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL})


#################
###  IRRXML
#################
set(CONAN_IRRXML_ROOT "/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56")
set(CONAN_INCLUDE_DIRS_IRRXML "/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/include")
set(CONAN_LIB_DIRS_IRRXML "/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/lib")
set(CONAN_BIN_DIRS_IRRXML )
set(CONAN_RES_DIRS_IRRXML )
set(CONAN_SRC_DIRS_IRRXML )
set(CONAN_BUILD_DIRS_IRRXML "/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/")
set(CONAN_FRAMEWORK_DIRS_IRRXML )
set(CONAN_LIBS_IRRXML IrrXML)
set(CONAN_PKG_LIBS_IRRXML IrrXML)
set(CONAN_SYSTEM_LIBS_IRRXML m)
set(CONAN_FRAMEWORKS_IRRXML )
set(CONAN_FRAMEWORKS_FOUND_IRRXML "")  # Will be filled later
set(CONAN_DEFINES_IRRXML )
set(CONAN_BUILD_MODULES_PATHS_IRRXML )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_IRRXML )

set(CONAN_C_FLAGS_IRRXML "")
set(CONAN_CXX_FLAGS_IRRXML "")
set(CONAN_SHARED_LINKER_FLAGS_IRRXML "")
set(CONAN_EXE_LINKER_FLAGS_IRRXML "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_IRRXML_LIST "")
set(CONAN_CXX_FLAGS_IRRXML_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST "")
set(CONAN_EXE_LINKER_FLAGS_IRRXML_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_IRRXML "${CONAN_FRAMEWORKS_IRRXML}" "_IRRXML" "")
# Append to aggregated values variable
set(CONAN_LIBS_IRRXML ${CONAN_PKG_LIBS_IRRXML} ${CONAN_SYSTEM_LIBS_IRRXML} ${CONAN_FRAMEWORKS_FOUND_IRRXML})


#################
###  LIBPNG
#################
set(CONAN_LIBPNG_ROOT "/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77")
set(CONAN_INCLUDE_DIRS_LIBPNG "/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/include")
set(CONAN_LIB_DIRS_LIBPNG "/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/lib")
set(CONAN_BIN_DIRS_LIBPNG "/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/bin")
set(CONAN_RES_DIRS_LIBPNG )
set(CONAN_SRC_DIRS_LIBPNG )
set(CONAN_BUILD_DIRS_LIBPNG "/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/")
set(CONAN_FRAMEWORK_DIRS_LIBPNG )
set(CONAN_LIBS_LIBPNG png16)
set(CONAN_PKG_LIBS_LIBPNG png16)
set(CONAN_SYSTEM_LIBS_LIBPNG m)
set(CONAN_FRAMEWORKS_LIBPNG )
set(CONAN_FRAMEWORKS_FOUND_LIBPNG "")  # Will be filled later
set(CONAN_DEFINES_LIBPNG )
set(CONAN_BUILD_MODULES_PATHS_LIBPNG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBPNG )

set(CONAN_C_FLAGS_LIBPNG "")
set(CONAN_CXX_FLAGS_LIBPNG "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBPNG_LIST "")
set(CONAN_CXX_FLAGS_LIBPNG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBPNG "${CONAN_FRAMEWORKS_LIBPNG}" "_LIBPNG" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBPNG ${CONAN_PKG_LIBS_LIBPNG} ${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG})


#################
###  BZIP2
#################
set(CONAN_BZIP2_ROOT "/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0")
set(CONAN_INCLUDE_DIRS_BZIP2 "/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/include")
set(CONAN_LIB_DIRS_BZIP2 "/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/lib")
set(CONAN_BIN_DIRS_BZIP2 "/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/bin")
set(CONAN_RES_DIRS_BZIP2 )
set(CONAN_SRC_DIRS_BZIP2 )
set(CONAN_BUILD_DIRS_BZIP2 "/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_BZIP2 )
set(CONAN_LIBS_BZIP2 bz2)
set(CONAN_PKG_LIBS_BZIP2 bz2)
set(CONAN_SYSTEM_LIBS_BZIP2 )
set(CONAN_FRAMEWORKS_BZIP2 )
set(CONAN_FRAMEWORKS_FOUND_BZIP2 "")  # Will be filled later
set(CONAN_DEFINES_BZIP2 )
set(CONAN_BUILD_MODULES_PATHS_BZIP2 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BZIP2 )

set(CONAN_C_FLAGS_BZIP2 "")
set(CONAN_CXX_FLAGS_BZIP2 "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2 "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BZIP2_LIST "")
set(CONAN_CXX_FLAGS_BZIP2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BZIP2 "${CONAN_FRAMEWORKS_BZIP2}" "_BZIP2" "")
# Append to aggregated values variable
set(CONAN_LIBS_BZIP2 ${CONAN_PKG_LIBS_BZIP2} ${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2})


#################
###  LIBALSA
#################
set(CONAN_LIBALSA_ROOT "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d")
set(CONAN_INCLUDE_DIRS_LIBALSA "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/include")
set(CONAN_LIB_DIRS_LIBALSA "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/lib")
set(CONAN_BIN_DIRS_LIBALSA "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/bin")
set(CONAN_RES_DIRS_LIBALSA "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/res")
set(CONAN_SRC_DIRS_LIBALSA )
set(CONAN_BUILD_DIRS_LIBALSA "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/")
set(CONAN_FRAMEWORK_DIRS_LIBALSA )
set(CONAN_LIBS_LIBALSA asound)
set(CONAN_PKG_LIBS_LIBALSA asound)
set(CONAN_SYSTEM_LIBS_LIBALSA dl m rt pthread)
set(CONAN_FRAMEWORKS_LIBALSA )
set(CONAN_FRAMEWORKS_FOUND_LIBALSA "")  # Will be filled later
set(CONAN_DEFINES_LIBALSA )
set(CONAN_BUILD_MODULES_PATHS_LIBALSA )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBALSA )

set(CONAN_C_FLAGS_LIBALSA "")
set(CONAN_CXX_FLAGS_LIBALSA "")
set(CONAN_SHARED_LINKER_FLAGS_LIBALSA "")
set(CONAN_EXE_LINKER_FLAGS_LIBALSA "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBALSA_LIST "")
set(CONAN_CXX_FLAGS_LIBALSA_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBALSA_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBALSA "${CONAN_FRAMEWORKS_LIBALSA}" "_LIBALSA" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBALSA ${CONAN_PKG_LIBS_LIBALSA} ${CONAN_SYSTEM_LIBS_LIBALSA} ${CONAN_FRAMEWORKS_FOUND_LIBALSA})


#################
###  OGG
#################
set(CONAN_OGG_ROOT "/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709")
set(CONAN_INCLUDE_DIRS_OGG "/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include")
set(CONAN_LIB_DIRS_OGG "/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/lib")
set(CONAN_BIN_DIRS_OGG )
set(CONAN_RES_DIRS_OGG )
set(CONAN_SRC_DIRS_OGG )
set(CONAN_BUILD_DIRS_OGG "/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/")
set(CONAN_FRAMEWORK_DIRS_OGG )
set(CONAN_LIBS_OGG ogg)
set(CONAN_PKG_LIBS_OGG ogg)
set(CONAN_SYSTEM_LIBS_OGG )
set(CONAN_FRAMEWORKS_OGG )
set(CONAN_FRAMEWORKS_FOUND_OGG "")  # Will be filled later
set(CONAN_DEFINES_OGG )
set(CONAN_BUILD_MODULES_PATHS_OGG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OGG )

set(CONAN_C_FLAGS_OGG "")
set(CONAN_CXX_FLAGS_OGG "")
set(CONAN_SHARED_LINKER_FLAGS_OGG "")
set(CONAN_EXE_LINKER_FLAGS_OGG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OGG_LIST "")
set(CONAN_CXX_FLAGS_OGG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OGG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OGG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OGG "${CONAN_FRAMEWORKS_OGG}" "_OGG" "")
# Append to aggregated values variable
set(CONAN_LIBS_OGG ${CONAN_PKG_LIBS_OGG} ${CONAN_SYSTEM_LIBS_OGG} ${CONAN_FRAMEWORKS_FOUND_OGG})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT "/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709")
set(CONAN_INCLUDE_DIRS_ZLIB "/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include")
set(CONAN_LIB_DIRS_ZLIB "/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/lib")
set(CONAN_BIN_DIRS_ZLIB )
set(CONAN_RES_DIRS_ZLIB )
set(CONAN_SRC_DIRS_ZLIB )
set(CONAN_BUILD_DIRS_ZLIB "/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/")
set(CONAN_FRAMEWORK_DIRS_ZLIB )
set(CONAN_LIBS_ZLIB z)
set(CONAN_PKG_LIBS_ZLIB z)
set(CONAN_SYSTEM_LIBS_ZLIB )
set(CONAN_FRAMEWORKS_ZLIB )
set(CONAN_FRAMEWORKS_FOUND_ZLIB "")  # Will be filled later
set(CONAN_DEFINES_ZLIB )
set(CONAN_BUILD_MODULES_PATHS_ZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB )

set(CONAN_C_FLAGS_ZLIB "")
set(CONAN_CXX_FLAGS_ZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB "${CONAN_FRAMEWORKS_ZLIB}" "_ZLIB" "")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB ${CONAN_PKG_LIBS_ZLIB} ${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "x86_64")
set(CONAN_SETTINGS_ARCH_BUILD "x86_64")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "gcc")
set(CONAN_SETTINGS_COMPILER_LIBCXX "libstdc++11")
set(CONAN_SETTINGS_COMPILER_VERSION "9")
set(CONAN_SETTINGS_OS "Linux")
set(CONAN_SETTINGS_OS_BUILD "Linux")

set(CONAN_DEPENDENCIES sfml glm assimp freetype stb openal flac vorbis xorg opengl irrxml libpng bzip2 libalsa ogg zlib)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/include"
			"/home/hopson/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/include"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/include"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/include/freetype2"
			"/home/hopson/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/include"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/include/AL"
			"/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/include"
			"/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/include"
			"/usr/include/uuid"
			"/usr/include/freetype2"
			"/usr/include/libpng16"
			"/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/include"
			"/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/include"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/include"
			"/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/include"
			"/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include"
			"/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/lib"
			"/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/lib"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/lib"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/lib"
			"/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/lib"
			"/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/lib"
			"/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/lib"
			"/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/lib"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/lib"
			"/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/lib"
			"/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/lib"
			"/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/bin"
			"/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/bin"
			"/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/bin"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/bin"
			"/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS "/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/res" ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s assimp freetype openal FLAC++ FLAC vorbisenc vorbisfile vorbis IrrXML png16 bz2 asound ogg z ${CONAN_LIBS})
set(CONAN_PKG_LIBS sfml-graphics-s sfml-window-s sfml-network-s sfml-audio-s sfml-system-s assimp freetype openal FLAC++ FLAC vorbisenc vorbisfile vorbis IrrXML png16 bz2 asound ogg z ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS udev stdc++ X11 X11-xcb xcb fontenc ICE SM Xau Xaw7 Xt Xcomposite Xcursor Xdamage Xfixes Xdmcp Xext Xft Xi Xinerama xkbfile Xmu Xmuu Xpm Xrandr Xrender XRes Xss Xtst Xv XvMC Xxf86vm xcb-xkb xcb-icccm xcb-image xcb-shm xcb-keysyms xcb-randr xcb-render xcb-render-util xcb-shape xcb-sync xcb-xfixes xcb-xinerama xcb-util xcb-dri3 GL dl m rt pthread ${CONAN_SYSTEM_LIBS})
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES "-D_DEFAULT_SOURCE"
			"-D_BSD_SOURCE"
			"-DHAS_FCHOWN"
			"-DHAS_STICKY_DIR_BIT"
			"-DFLAC__NO_DLL"
			"-DAL_LIBTYPE_STATIC"
			"-DSTB_TEXTEDIT_KEYTYPE=unsigned"
			"-DSFML_STATIC" ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS  ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "/home/hopson/.conan/data/sfml/2.5.1/bincrafters/stable/package/0001157c962c3889b834759df18c803aa6d4312e/"
			"/home/hopson/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/hopson/.conan/data/assimp/5.0.1/_/_/package/805d61ab0598e76b12d97807251e7e2783426b45/"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/"
			"/home/hopson/.conan/data/freetype/2.10.1/_/_/package/387eb5152986b9b3cbc2ebb94607d96d90674d67/lib/cmake"
			"/home/hopson/.conan/data/stb/20200203/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/"
			"/home/hopson/.conan/data/openal/1.19.1/_/_/package/8f758c7d79f11e0791dfc187e19cd92dffabbd2b/lib/cmake"
			"/home/hopson/.conan/data/flac/1.3.3/_/_/package/b9bd28193f63cd74fd2213b63c74017e7893c24d/"
			"/home/hopson/.conan/data/vorbis/1.3.6/_/_/package/033a9a186751ed382a6fa5fa2c844ad34b7c3302/"
			"/home/hopson/.conan/data/xorg/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/hopson/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"/home/hopson/.conan/data/irrxml/1.2/_/_/package/b911f48570f9bb2902d9e83b2b9ebf9d376c8c56/"
			"/home/hopson/.conan/data/libpng/1.6.37/_/_/package/f99afdbf2a1cc98ba2029817b35103455b6a9b77/"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/"
			"/home/hopson/.conan/data/bzip2/1.0.8/_/_/package/da606cf731e334010b0bf6e85a2a6f891b9f36b0/lib/cmake"
			"/home/hopson/.conan/data/libalsa/1.2.4/_/_/package/d48130e0dd76369b1338deb3b2372c5a649f9f2d/"
			"/home/hopson/.conan/data/ogg/1.3.4/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/"
			"/home/hopson/.conan/data/zlib/1.2.11/_/_/package/6af9cc7cb931c5ad942174fd7838eb655717c709/" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}" "" "")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS ${CONAN_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES "${CONAN_SYSTEM_LIBS_SFML} ${CONAN_FRAMEWORKS_FOUND_SFML} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML}" "${CONAN_LIB_DIRS_SFML}"
                                  CONAN_PACKAGE_TARGETS_SFML "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}"
                                  "" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_SFML_DEBUG} ${CONAN_FRAMEWORKS_FOUND_SFML_DEBUG} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_DEBUG}" "${CONAN_LIB_DIRS_SFML_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_SFML_DEBUG "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}"
                                  "debug" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_SFML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_SFML_RELEASE} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_RELEASE}" "${CONAN_LIB_DIRS_SFML_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_SFML_RELEASE "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}"
                                  "release" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_SFML_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_SFML_RELWITHDEBINFO} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_SFML_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_SFML_RELWITHDEBINFO "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" sfml)
    set(_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_SFML_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_SFML_MINSIZEREL} CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::ogg CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_SFML_MINSIZEREL}" "${CONAN_LIB_DIRS_SFML_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_SFML_MINSIZEREL "${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" sfml)

    add_library(CONAN_PKG::sfml INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_SFML} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_SFML_RELEASE} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_SFML_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_SFML_MINSIZEREL} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_SFML_DEBUG} ${_CONAN_PKG_LIBS_SFML_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_SFML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_SFML_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_SFML}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_SFML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_SFML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_SFML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_SFML_DEBUG}>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_SFML}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_SFML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_SFML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_SFML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_SFML_DEBUG}>)
    set_property(TARGET CONAN_PKG::sfml PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_SFML_LIST} ${CONAN_CXX_FLAGS_SFML_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_SFML_RELEASE_LIST} ${CONAN_CXX_FLAGS_SFML_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_SFML_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_SFML_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_SFML_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_SFML_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_SFML_DEBUG_LIST}  ${CONAN_CXX_FLAGS_SFML_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM}" "${CONAN_LIB_DIRS_GLM}"
                                  CONAN_PACKAGE_TARGETS_GLM "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}"
                                  "" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GLM_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GLM_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_DEBUG}" "${CONAN_LIB_DIRS_GLM_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GLM_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}"
                                  "debug" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GLM_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GLM_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELEASE}" "${CONAN_LIB_DIRS_GLM_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}"
                                  "release" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GLM_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GLM_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GLM_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GLM_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GLM_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_MINSIZEREL}" "${CONAN_LIB_DIRS_GLM_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" glm)

    add_library(CONAN_PKG::glm INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GLM} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GLM_RELEASE} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GLM_DEBUG} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GLM_LIST} ${CONAN_CXX_FLAGS_GLM_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GLM_RELEASE_LIST} ${CONAN_CXX_FLAGS_GLM_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GLM_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GLM_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GLM_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GLM_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ASSIMP} ${CONAN_FRAMEWORKS_FOUND_ASSIMP} CONAN_PKG::zlib CONAN_PKG::irrxml")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP}" "${CONAN_LIB_DIRS_ASSIMP}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}"
                                  "" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ASSIMP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_DEBUG} CONAN_PKG::zlib CONAN_PKG::irrxml")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_DEBUG}" "${CONAN_LIB_DIRS_ASSIMP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_DEBUG "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}"
                                  "debug" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ASSIMP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_RELEASE} CONAN_PKG::zlib CONAN_PKG::irrxml")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_RELEASE}" "${CONAN_LIB_DIRS_ASSIMP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_RELEASE "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}"
                                  "release" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ASSIMP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::irrxml")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ASSIMP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ASSIMP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::irrxml")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_MINSIZEREL}" "${CONAN_LIB_DIRS_ASSIMP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_MINSIZEREL "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" assimp)

    add_library(CONAN_PKG::assimp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ASSIMP} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ASSIMP_RELEASE} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ASSIMP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ASSIMP_MINSIZEREL} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ASSIMP_DEBUG} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ASSIMP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ASSIMP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ASSIMP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ASSIMP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ASSIMP_DEBUG}>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ASSIMP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_DEBUG}>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ASSIMP_LIST} ${CONAN_CXX_FLAGS_ASSIMP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ASSIMP_RELEASE_LIST} ${CONAN_CXX_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ASSIMP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ASSIMP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ASSIMP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ASSIMP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE}" "${CONAN_LIB_DIRS_FREETYPE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}"
                                  "" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FREETYPE_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_DEBUG} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_DEBUG}" "${CONAN_LIB_DIRS_FREETYPE_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}"
                                  "debug" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FREETYPE_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELEASE}" "${CONAN_LIB_DIRS_FREETYPE_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}"
                                  "release" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FREETYPE_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELWITHDEBINFO} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FREETYPE_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FREETYPE_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_MINSIZEREL} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_MINSIZEREL}" "${CONAN_LIB_DIRS_FREETYPE_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" freetype)

    add_library(CONAN_PKG::freetype INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FREETYPE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FREETYPE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FREETYPE_RELEASE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FREETYPE_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FREETYPE_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FREETYPE_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FREETYPE_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_STB} ${CONAN_FRAMEWORKS_FOUND_STB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB}" "${CONAN_LIB_DIRS_STB}"
                                  CONAN_PACKAGE_TARGETS_STB "${_CONAN_PKG_LIBS_STB_DEPENDENCIES}"
                                  "" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_STB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_STB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_DEBUG}" "${CONAN_LIB_DIRS_STB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_STB_DEBUG "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}"
                                  "debug" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_STB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_STB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELEASE}" "${CONAN_LIB_DIRS_STB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_STB_RELEASE "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}"
                                  "release" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_STB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_STB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_STB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" stb)
    set(_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_STB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_STB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_STB_MINSIZEREL}" "${CONAN_LIB_DIRS_STB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_STB_MINSIZEREL "${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" stb)

    add_library(CONAN_PKG::stb INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_STB} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_STB_RELEASE} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_STB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_STB_MINSIZEREL} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_STB_DEBUG} ${_CONAN_PKG_LIBS_STB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_STB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_STB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_STB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_STB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_STB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_STB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_STB_DEBUG}>)
    set_property(TARGET CONAN_PKG::stb PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_STB_LIST} ${CONAN_CXX_FLAGS_STB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_STB_RELEASE_LIST} ${CONAN_CXX_FLAGS_STB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_STB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_STB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_STB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_STB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_STB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_STB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENAL} ${CONAN_FRAMEWORKS_FOUND_OPENAL} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL}" "${CONAN_LIB_DIRS_OPENAL}"
                                  CONAN_PACKAGE_TARGETS_OPENAL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}"
                                  "" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENAL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENAL_DEBUG} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_DEBUG}" "${CONAN_LIB_DIRS_OPENAL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_DEBUG "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}"
                                  "debug" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENAL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENAL_RELEASE} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_RELEASE}" "${CONAN_LIB_DIRS_OPENAL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_RELEASE "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}"
                                  "release" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENAL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENAL_RELWITHDEBINFO} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENAL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openal)
    set(_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENAL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENAL_MINSIZEREL} CONAN_PKG::libalsa")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENAL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENAL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENAL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openal)

    add_library(CONAN_PKG::openal INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENAL} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENAL_RELEASE} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENAL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENAL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENAL_DEBUG} ${_CONAN_PKG_LIBS_OPENAL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENAL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENAL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENAL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENAL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENAL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENAL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENAL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENAL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENAL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENAL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENAL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENAL_DEBUG}>)
    set_property(TARGET CONAN_PKG::openal PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENAL_LIST} ${CONAN_CXX_FLAGS_OPENAL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENAL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENAL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENAL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENAL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENAL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENAL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENAL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENAL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FLAC} ${CONAN_FRAMEWORKS_FOUND_FLAC} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC}" "${CONAN_LIB_DIRS_FLAC}"
                                  CONAN_PACKAGE_TARGETS_FLAC "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}"
                                  "" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FLAC_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FLAC_DEBUG} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_DEBUG}" "${CONAN_LIB_DIRS_FLAC_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FLAC_DEBUG "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}"
                                  "debug" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FLAC_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FLAC_RELEASE} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_RELEASE}" "${CONAN_LIB_DIRS_FLAC_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FLAC_RELEASE "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}"
                                  "release" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FLAC_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FLAC_RELWITHDEBINFO} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FLAC_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FLAC_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" flac)
    set(_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FLAC_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FLAC_MINSIZEREL} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FLAC_MINSIZEREL}" "${CONAN_LIB_DIRS_FLAC_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FLAC_MINSIZEREL "${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" flac)

    add_library(CONAN_PKG::flac INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FLAC} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FLAC_RELEASE} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FLAC_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FLAC_MINSIZEREL} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FLAC_DEBUG} ${_CONAN_PKG_LIBS_FLAC_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FLAC_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FLAC_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FLAC}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FLAC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FLAC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FLAC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FLAC_DEBUG}>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FLAC}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FLAC_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FLAC_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FLAC_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FLAC_DEBUG}>)
    set_property(TARGET CONAN_PKG::flac PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FLAC_LIST} ${CONAN_CXX_FLAGS_FLAC_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FLAC_RELEASE_LIST} ${CONAN_CXX_FLAGS_FLAC_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FLAC_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FLAC_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FLAC_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FLAC_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FLAC_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FLAC_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_VORBIS} ${CONAN_FRAMEWORKS_FOUND_VORBIS} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS}" "${CONAN_LIB_DIRS_VORBIS}"
                                  CONAN_PACKAGE_TARGETS_VORBIS "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}"
                                  "" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_VORBIS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_VORBIS_DEBUG} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_DEBUG}" "${CONAN_LIB_DIRS_VORBIS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_DEBUG "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}"
                                  "debug" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_VORBIS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_VORBIS_RELEASE} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_RELEASE}" "${CONAN_LIB_DIRS_VORBIS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_RELEASE "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}"
                                  "release" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_VORBIS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_VORBIS_RELWITHDEBINFO} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_VORBIS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" vorbis)
    set(_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_VORBIS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_VORBIS_MINSIZEREL} CONAN_PKG::ogg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_VORBIS_MINSIZEREL}" "${CONAN_LIB_DIRS_VORBIS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_VORBIS_MINSIZEREL "${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" vorbis)

    add_library(CONAN_PKG::vorbis INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_VORBIS} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_VORBIS_RELEASE} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_VORBIS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_VORBIS_MINSIZEREL} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_VORBIS_DEBUG} ${_CONAN_PKG_LIBS_VORBIS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_VORBIS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_VORBIS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_VORBIS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_VORBIS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_VORBIS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_VORBIS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_VORBIS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_VORBIS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_VORBIS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_VORBIS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_VORBIS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_VORBIS_DEBUG}>)
    set_property(TARGET CONAN_PKG::vorbis PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_VORBIS_LIST} ${CONAN_CXX_FLAGS_VORBIS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_VORBIS_RELEASE_LIST} ${CONAN_CXX_FLAGS_VORBIS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_VORBIS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_VORBIS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_VORBIS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_VORBIS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_VORBIS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_VORBIS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XORG} ${CONAN_FRAMEWORKS_FOUND_XORG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG}" "${CONAN_LIB_DIRS_XORG}"
                                  CONAN_PACKAGE_TARGETS_XORG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}"
                                  "" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XORG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XORG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_DEBUG}" "${CONAN_LIB_DIRS_XORG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XORG_DEBUG "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}"
                                  "debug" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XORG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XORG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_RELEASE}" "${CONAN_LIB_DIRS_XORG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XORG_RELEASE "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}"
                                  "release" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XORG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XORG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XORG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XORG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xorg)
    set(_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XORG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XORG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XORG_MINSIZEREL}" "${CONAN_LIB_DIRS_XORG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XORG_MINSIZEREL "${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xorg)

    add_library(CONAN_PKG::xorg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XORG} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XORG_RELEASE} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XORG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XORG_MINSIZEREL} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XORG_DEBUG} ${_CONAN_PKG_LIBS_XORG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XORG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XORG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XORG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XORG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XORG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XORG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XORG_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XORG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XORG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XORG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XORG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XORG_DEBUG}>)
    set_property(TARGET CONAN_PKG::xorg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XORG_LIST} ${CONAN_CXX_FLAGS_XORG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XORG_RELEASE_LIST} ${CONAN_CXX_FLAGS_XORG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XORG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XORG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XORG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XORG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XORG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XORG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL}" "${CONAN_LIB_DIRS_OPENGL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}"
                                  "" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENGL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENGL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_DEBUG}" "${CONAN_LIB_DIRS_OPENGL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}"
                                  "debug" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENGL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELEASE}" "${CONAN_LIB_DIRS_OPENGL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}"
                                  "release" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENGL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENGL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENGL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENGL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENGL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opengl)

    add_library(CONAN_PKG::opengl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENGL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENGL_RELEASE} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENGL_DEBUG} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENGL_LIST} ${CONAN_CXX_FLAGS_OPENGL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENGL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENGL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENGL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENGL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENGL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES "${CONAN_SYSTEM_LIBS_IRRXML} ${CONAN_FRAMEWORKS_FOUND_IRRXML} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML}" "${CONAN_LIB_DIRS_IRRXML}"
                                  CONAN_PACKAGE_TARGETS_IRRXML "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}"
                                  "" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_IRRXML_DEBUG} ${CONAN_FRAMEWORKS_FOUND_IRRXML_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_DEBUG}" "${CONAN_LIB_DIRS_IRRXML_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_DEBUG "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}"
                                  "debug" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_IRRXML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_IRRXML_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_RELEASE}" "${CONAN_LIB_DIRS_IRRXML_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_RELEASE "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}"
                                  "release" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_IRRXML_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_IRRXML_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_IRRXML_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_IRRXML_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_IRRXML_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_MINSIZEREL}" "${CONAN_LIB_DIRS_IRRXML_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_MINSIZEREL "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" irrxml)

    add_library(CONAN_PKG::irrxml INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_IRRXML} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_IRRXML_RELEASE} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_IRRXML_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_IRRXML_MINSIZEREL} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_IRRXML_DEBUG} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_IRRXML}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_IRRXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_IRRXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_IRRXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_IRRXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_IRRXML}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_IRRXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_IRRXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_IRRXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_IRRXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_IRRXML_LIST} ${CONAN_CXX_FLAGS_IRRXML_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_IRRXML_RELEASE_LIST} ${CONAN_CXX_FLAGS_IRRXML_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_IRRXML_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_IRRXML_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_IRRXML_DEBUG_LIST}  ${CONAN_CXX_FLAGS_IRRXML_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG}" "${CONAN_LIB_DIRS_LIBPNG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}"
                                  "" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBPNG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_DEBUG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_DEBUG}" "${CONAN_LIB_DIRS_LIBPNG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}"
                                  "debug" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBPNG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELEASE}" "${CONAN_LIB_DIRS_LIBPNG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}"
                                  "release" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBPNG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELWITHDEBINFO} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBPNG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBPNG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_MINSIZEREL} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBPNG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libpng)

    add_library(CONAN_PKG::libpng INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBPNG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBPNG_LIST} ${CONAN_CXX_FLAGS_LIBPNG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBPNG_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBPNG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBPNG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBPNG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBPNG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2}" "${CONAN_LIB_DIRS_BZIP2}"
                                  CONAN_PACKAGE_TARGETS_BZIP2 "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}"
                                  "" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BZIP2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BZIP2_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_DEBUG}" "${CONAN_LIB_DIRS_BZIP2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}"
                                  "debug" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BZIP2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELEASE}" "${CONAN_LIB_DIRS_BZIP2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}"
                                  "release" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BZIP2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BZIP2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BZIP2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BZIP2_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_MINSIZEREL}" "${CONAN_LIB_DIRS_BZIP2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" bzip2)

    add_library(CONAN_PKG::bzip2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BZIP2} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BZIP2_RELEASE} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BZIP2_DEBUG} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BZIP2_LIST} ${CONAN_CXX_FLAGS_BZIP2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BZIP2_RELEASE_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BZIP2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BZIP2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BZIP2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BZIP2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBALSA} ${CONAN_FRAMEWORKS_FOUND_LIBALSA} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA}" "${CONAN_LIB_DIRS_LIBALSA}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}"
                                  "" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBALSA_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_DEBUG}" "${CONAN_LIB_DIRS_LIBALSA_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_DEBUG "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}"
                                  "debug" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBALSA_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_RELEASE}" "${CONAN_LIB_DIRS_LIBALSA_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_RELEASE "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}"
                                  "release" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBALSA_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBALSA_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libalsa)
    set(_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBALSA_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBALSA_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBALSA_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBALSA_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBALSA_MINSIZEREL "${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libalsa)

    add_library(CONAN_PKG::libalsa INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBALSA} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBALSA_RELEASE} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBALSA_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBALSA_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBALSA_DEBUG} ${_CONAN_PKG_LIBS_LIBALSA_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBALSA_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBALSA}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBALSA_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBALSA_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBALSA_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBALSA_DEBUG}>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBALSA}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBALSA_DEBUG}>)
    set_property(TARGET CONAN_PKG::libalsa PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBALSA_LIST} ${CONAN_CXX_FLAGS_LIBALSA_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBALSA_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBALSA_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBALSA_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBALSA_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBALSA_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBALSA_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBALSA_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBALSA_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OGG} ${CONAN_FRAMEWORKS_FOUND_OGG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG}" "${CONAN_LIB_DIRS_OGG}"
                                  CONAN_PACKAGE_TARGETS_OGG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}"
                                  "" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OGG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OGG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_DEBUG}" "${CONAN_LIB_DIRS_OGG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OGG_DEBUG "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}"
                                  "debug" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OGG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OGG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_RELEASE}" "${CONAN_LIB_DIRS_OGG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OGG_RELEASE "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}"
                                  "release" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OGG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OGG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OGG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OGG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" ogg)
    set(_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OGG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OGG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OGG_MINSIZEREL}" "${CONAN_LIB_DIRS_OGG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OGG_MINSIZEREL "${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" ogg)

    add_library(CONAN_PKG::ogg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OGG} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OGG_RELEASE} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OGG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OGG_MINSIZEREL} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OGG_DEBUG} ${_CONAN_PKG_LIBS_OGG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OGG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OGG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OGG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OGG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OGG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OGG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OGG_DEBUG}>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OGG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OGG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OGG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OGG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OGG_DEBUG}>)
    set_property(TARGET CONAN_PKG::ogg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OGG_LIST} ${CONAN_CXX_FLAGS_OGG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OGG_RELEASE_LIST} ${CONAN_CXX_FLAGS_OGG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OGG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OGG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OGG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OGG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OGG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OGG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB}" "${CONAN_LIB_DIRS_ZLIB}"
                                  CONAN_PACKAGE_TARGETS_ZLIB "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}"
                                  "" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_DEBUG}" "${CONAN_LIB_DIRS_ZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}"
                                  "debug" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELEASE}" "${CONAN_LIB_DIRS_ZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}"
                                  "release" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_ZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zlib)

    add_library(CONAN_PKG::zlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZLIB} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZLIB_RELEASE} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZLIB_DEBUG} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZLIB_LIST} ${CONAN_CXX_FLAGS_ZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZLIB_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::sfml CONAN_PKG::glm CONAN_PKG::assimp CONAN_PKG::freetype CONAN_PKG::stb CONAN_PKG::openal CONAN_PKG::flac CONAN_PKG::vorbis CONAN_PKG::xorg CONAN_PKG::opengl CONAN_PKG::irrxml CONAN_PKG::libpng CONAN_PKG::bzip2 CONAN_PKG::libalsa CONAN_PKG::ogg CONAN_PKG::zlib)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()


macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()


macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()


macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        conan_get_policy(CMP0091 policy_0091)
        if(policy_0091 STREQUAL "NEW")
            if(CONAN_LINK_RUNTIME MATCHES "MTd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
            elseif(CONAN_LINK_RUNTIME MATCHES "MDd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
            elseif(CONAN_LINK_RUNTIME MATCHES "MT")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
            elseif(CONAN_LINK_RUNTIME MATCHES "MD")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
            endif()
        else()
            foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                         CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                         CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
                if(DEFINED ${flag})
                    string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
            foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
                if(DEFINED ${flag})
                    string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
        endif()
    endif()
endmacro()


macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()


function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


function(conan_get_policy policy_id policy)
    if(POLICY "${policy_id}")
        cmake_policy(GET "${policy_id}" _policy)
        set(${policy} "${_policy}" PARENT_SCOPE)
    else()
        set(${policy} "" PARENT_SCOPE)
    endif()
endfunction()


function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
            set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    # Add all dependencies to all targets
    string(REPLACE " " ";" deps_list "${deps}")
    foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
        set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
    endforeach()

    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()


macro(conan_set_std)
    conan_message(STATUS "Conan: Adjusting language standard")
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
        if(CONAN_STD_CXX_FLAG)
            conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
            set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
        endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()


macro(conan_set_rpath)
    conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
        # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        set(CMAKE_SKIP_RPATH 1 CACHE BOOL "rpaths" FORCE)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()


macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()


macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()


macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()


macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: \n"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}\n"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}\n"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])\n"
                        "P.S. You may set CONAN_DISABLE_CHECK_COMPILER CMake variable in order to disable this check."
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})

function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    # MATCHALL will match all, including the last one, which is the full_settings one
    string(REGEX MATCH "full_settings.*" _FULL_SETTINGS_MATCHED ${CONANINFO})
    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()


function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc" OR CONAN_COMPILER STREQUAL "mcst-lcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "intel")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 19.1)
            if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
               conan_error_compiler_version()
            endif()
        else()
            if(NOT ${VERSION_MAJOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR})
               conan_error_compiler_version()
            endif()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()


function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "llvm" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()


macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()


macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()


macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()


macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

set(CONAN_USER_FREETYPE_LIBTOOL_VERSION "23.0.17")