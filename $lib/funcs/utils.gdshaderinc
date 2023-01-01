float depth_map(float distance, vec3 vertex, sampler2D depthtex, vec2 screenuv,mat4 invproj){
	float distanz = 1.0; 
	float depth_tex = textureLod(depthtex, screenuv, 0.0).r;
	vec4 depth_world_pos = invproj * vec4(screenuv * 2.0 - 1.0, depth_tex, 1.0);
	depth_world_pos.xyz /= depth_world_pos.w;
	return clamp(1.0 - smoothstep(depth_world_pos.z + distanz, depth_world_pos.z, vertex.z), 0.0, 1.0);
}