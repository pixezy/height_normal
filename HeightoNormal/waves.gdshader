shader_type spatial;
#include "res://$lib/funcs/shapes.gdshaderinc"
#include "res://$lib/funcs/normals.gdshaderinc"
#include "res://$lib/funcs/transform.gdshaderinc"
uniform float _normal_strength: hint_range(0.0, 1.0)=0.1; 
uniform vec3 color: source_color; 
void fragment() {
	vec2 uv_polar = polar_coordinates(UV,vec2(0.5)); 
	float f = sin(uv_polar.x * TAU * 3.0 - TIME * 5.0); 
	float cmask =1.0 - circle(UV,0.3,0.3); 
	f = f*cmask; 
	vec3 n = heightToNormal(f,_normal_strength,VERTEX,NORMAL);	
	NORMAL = n; 
	ALBEDO = color; 
	ALBEDO = n; 
}
