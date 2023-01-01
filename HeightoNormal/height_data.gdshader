shader_type spatial;

#include "res://$lib/funcs/normals.gdshaderinc"
uniform sampler2D heightmap; 
uniform vec3 color: source_color; 
uniform float displacement: hint_range(0.0, 1.0); 
uniform float _normal_strength : hint_range(0.0, 1.0)=0.1; 
varying float h; 
void vertex() {
	h = textureLod(heightmap, UV,0).r;
	VERTEX += NORMAL * h * displacement;
	}

void fragment(){
	float h2 = texture(heightmap, UV*2.0).r;
	vec3 n = heightToNormal(h2,_normal_strength,VERTEX,NORMAL); 
 	NORMAL = n; 
//	ALBEDO = n; 
}
