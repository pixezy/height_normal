# PerlinNoise3D.gd
@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeHeightToNormal

func _get_name():
	return "HeightToNormal"

func _get_category():
	return "Normals"

func _get_description():
	return "Height to normal"

func _init():
	set_input_port_default_value(0, 0.0)
	set_input_port_default_value(1, 0.01)


func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count():
	return 2

func _get_input_port_name(port):
	match port:
		0:
			return "height"
		1:
			return "strength"

func _get_input_port_type(port):
	match port:
		0:	
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:	
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
		return 1

func _get_output_port_name(_port):
	return "result"


func _get_output_port_type(_port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode):
	return """	
	vec3 heightToNormal(float height,float strength,vec3 vertex,vec3 normal){
		vec3 worldDerivativeX = dFdx(vertex);
		vec3 worldDerivativeY = dFdy(vertex);
		
		vec3 crossX = cross(normal, worldDerivativeX);
		vec3 crossY = cross( worldDerivativeY,normal);	
		float d = dot(worldDerivativeX,crossY);
		float sgn = d < 0.0 ? (-1.0) : 1.0;
		float surface = sgn / max(0.00000000000001192093, abs(d));

		float dHdx = dFdx(height);
		float dHdy = dFdy(height);
		vec3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
		return normalize(normal - (strength * surfGrad));
	}
	"""

func _get_code(input_vars, output_vars, _mode, _type):
	return output_vars[0] + "
	 = heightToNormal(%s,%s,VERTEX,NORMAL);
	" % [input_vars[0],input_vars[1]]
