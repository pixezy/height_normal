# PerlinNoise3D.gd
@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeRectangleShape


func _get_name():
	return "Rectangle"


func _get_category():
	return "Shapes"


func _get_description():
	return "Rectangle"


func _init():
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 0.5)
	set_input_port_default_value(3, 0.0)


func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count():
	return 4

func _get_input_port_name(port):
	match port:
		0:
			return "uv"
		1:
			return "width"
		2:
			return "height"
		3:
			return "feather"
	


func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_2D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		
			


func _get_output_port_count():
	return 1


func _get_output_port_name(port):
	return "result"


func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(mode):
	return """
	float rectangle(vec2 uv, float width, float height, float feather){
		vec2 uv_cartesian = uv * 2.0 - 1.0; 
		vec2 uv_reflected = abs(uv_cartesian); 
		float dfx = smoothstep(width,width+feather,uv_reflected.x);
		float dfy = smoothstep(height,height+feather,uv_reflected.y); 
		return max(dfx,dfy); 
	}				 
	"""

func _get_code(input_vars, output_vars, mode, type):
	return output_vars[0] + " = rectangle(%s,%s,%s,%s);" \
	% [input_vars[0],input_vars[1],input_vars[2],input_vars[3]]
