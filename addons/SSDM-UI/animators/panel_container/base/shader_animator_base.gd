@abstract class_name SSDMUISingleControlShaderAnimatorBase
extends RefCounted

var animation_target: Control
var background_color: Color = Color(1,1,1,1)
var shader_material: ShaderMaterial
var timer: Timer


@abstract func set_speed(new_speed: float) -> void
@abstract func set_duration(new_duration: float) -> void
@abstract func _enable_shader() -> void
@abstract func _disable_shader() -> void	


func set_background_color(new_background_color: Color) -> void:
	_set_shader_parameter(SSDMUIGlobal.BACKGROUND_COLOR, new_background_color)
	background_color = new_background_color
	

func play() -> void:
	_enable_shader()
	
	
func stop() -> void:
	_disable_shader()
	_kill_timer()
	
	
func _set_shader_parameter(parameter: String, value: Variant) -> void:
	shader_material.set_shader_parameter(parameter, value)
	
	
func _init_shader_paramaters() -> void:
	set_background_color(background_color)
	
	
func _apply_shader() -> void:
	animation_target.material = shader_material
	
	
func _kill_timer() -> void:
	if timer:
		if timer.timeout.is_connected(stop):
			timer.timeout.disconnect(stop)
		timer.queue_free()
		
	
func _create_timeout_timer(duration: float) -> void:
	_kill_timer()
	if duration > 0.0:
		timer = Timer.new()	
		timer.one_shot = true
		timer.wait_time = duration
		timer.timeout.connect(stop)
		animation_target.add_child(timer)
		timer.start()
		
		
func _init(target: Control, material: ShaderMaterial) -> void:
	animation_target = target
	shader_material = material
	_apply_shader()
	_init_shader_paramaters()
