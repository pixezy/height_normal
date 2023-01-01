# PerlinNoise3D.gd
@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeCircleShape


func _get_name():
	return "Circle"


func _get_category():
	return "Shapes"


func _get_description():
	return "Circle"


func _init():
	set_input_port_default_value(1, 0.3)
	set_input_port_default_value(2, 0.0)
	


func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_input_port_count():
	return 3


func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "diameter"
		2: 
			return "feather"
		


func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		
			


func _get_output_port_count():
	return 1


func _get_output_port_name(port):
	return "result"


func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(mode):
	return """
	float circle(vec2 position, float diameter, float feather)
	{
		float radius = diameter / 2.0; 
		return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
	}
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = circle(%s,%s,%s);" % [input_vars[0],input_vars[1],input_vars[2]]
