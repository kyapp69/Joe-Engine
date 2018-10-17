#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 0) uniform UBO_ViewProj {
    mat4 viewProj;
} ubo_viewProj;

layout (binding = 1) uniform UBODynamic_ModelMat {
	mat4 model;
} uboDynamicModelMatInstance;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inUV;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragUV;
layout(location = 2) out float fragDepth;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
    vec4 pos = ubo_viewProj.viewProj * uboDynamicModelMatInstance.model * vec4(inPosition, 1.0);
    gl_Position = pos;
    fragUV = inUV;
    fragColor = inColor;
    pos /= pos.w;
    fragDepth = pos.z;
}
