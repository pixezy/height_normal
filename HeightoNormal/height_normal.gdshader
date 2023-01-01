shader_type spatial;
#include "res://$lib/funcs/normals.gdshaderinc"
uniform sampler2D noisetex; 
uniform float _normal_strength: hint_range(0.0, 5.0)=0.01; 
void fragment() {
		
	float height = texture(noisetex,UV).r; 
	vec3 n = heightToNormal(height,_normal_strength,VERTEX,NORMAL); 
	NORMAL = n;
	ALBEDO = n;  
}
