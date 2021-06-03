# yavge

Yet Another Voxel Game Engine, or Yet Another Voxel Graphics Engine. The choice is yours.

This was created using OpenGL 4.5 and the direct state access (DSA) API as opposed to the "binding" API of OpenGL 3.3.

## Building and Running

Requires conan and cmake.

### Linux

To build, at the root of the project:

```sh
sh scripts/build.sh
```

To run, at the root of the project:

```sh
sh scripts/run.sh
```

To build and run in release mode, simply add the `release` suffix:

```sh
sh scripts/build.sh release
sh scripts/run.sh release
```

## Issues ran into

As this was my first time using DSA and more advanced computer graphics techniques, I ran into problems, which will be listed here so I don't run into them again:

### 2D array texture

With non-dsa, it seemed OK to create the 2D Array Texture as below:

```cpp
glBindTexture(GL_TEXTURE_2D_ARRAY, m_handle)
// set up texture params here
glTexImage3D(GL_TEXTURE_2D_ARRAY, 0, GL_RGBA, textureSize, textureSize,
             numTextures, 0, GL_RGBA, GL_UNSIGNED_BYTE, nullptr);
```

Where textureSize is the width and height value and "numTextures" is the maximum number of textures this particular texture array would support.

With DSA, the equal would be something like:

```cpp
// no binding needed!
// set up texture params here
glTextureStorage3D(m_handle, 0, GL_RGBA, textureSize, textureSize, numTextures);
```

However, the issue with this approach is the first and second args, which must be replaced with 1 and GL_RGBA8 respectively:

```cpp
glTextureStorage3D(m_handle, 1, GL_RGBA8, textureSize, textureSize, numTextures);
```

The reasons become clear by looking at the docs:

https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/glTexImage3D.xhtml

https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/glTexStorage3D.xhtml


### Depth Texture 

At some point I was playing around with depth textures, and struggled to render them.

It turns out the fragment shader must select a single channel from the sampled texture and amplified to actually see it (As without the differences are too small to see).

For example, typical texture mapping is (Where `tex` is a `uniform sampler2D` and `texCoord` is a vec2 for the texuture coords):

```glsl
void main() { 
    outColour = texture(tex, texCoord);
}
```

However this results in a pure red texture. In order to actually see the depth, the red channel must be extracted and amped as follows:

```glsl
void main() { 
    float depth = texture(tex, texCoord).r;
    depth = 1.0 - (1.0 - depth) * 50.0;
    outColour = vec4(depth);
}
```

### Multiple texture units

Given a shader has multiple texture units:

```glsl
uniform sampler2D tex0;
uniform sampler2D tex1;
```

In pre-dsa, this worked like:

```cpp
glUniform1i(glGetUniformLocation(program, "tex0"), 0);
glUniform1i(glGetUniformLocation(program, "tex1"), 1);

// ...

glActiveTexture(GL_TEXTURE0);
glBindTexture(GL_TEXTURE_2D, tex0);

glActiveTexture(GL_TEXTURE1);
glBindTexture(GL_TEXTURE_2D, tex1);
```

Which results with textures being mapped to the correct texture unit.

In DSA, the equal might appear to be:

```cpp
glUniform1i(glGetUniformLocation(program, "tex0"), 0);
glUniform1i(glGetUniformLocation(program, "tex1"), 1);

// ...

glBindTextureUnit(0, tex0);
glBindTextureUnit(1, tex1);
```

However this will not work. Instead the shader are able to mapped to texture unit directly, which also means the `glUniform1i`/`glGetUniformLocation` is no longer needed, as OpenGL is able to work out the correct mapping from the first arg of `glBindTextureUnit`:


```glsl
layout(binding = 0) uniform sampler2D tex0;
layout(binding = 1) uniform sampler2D tex1;
```

```cpp
glBindTextureUnit(0, tex0);
glBindTextureUnit(1, tex1);
```

Which will then result in correct textures being used.