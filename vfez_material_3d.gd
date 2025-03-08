@tool
extends ShaderMaterial
class_name VFEZMaterial3D

enum BlendModeEnum
{
	Mix = 0,
	Add = 1,
	Subtract = 2,
	Multiply = 3,
	Premultiplied_Alpha= 4
}

enum DepthDrawModeEnum
{
	Opaque = 0,
	Always = 1,
	Never = 2
}

enum CullModeEnum
{
	Back = 0,
	Front = 1,
	Disabled = 2
}

enum DiffuseModeEnum
{
	Lambert = 0,
	Lambert_Wrap = 1,
	Burley = 2,
	Toon = 3,
}

enum SpecularModeEnum
{
	Schlick_Ggx = 0,
	Toon = 1,
	Disabled = 2
}

enum ShadingModeEnum
{
	Unshaded = 0,
	Shaded = 1
}

enum BillboardModeEnum
{
	Disabled = 0,
	Enabled = 1,
	Y = 2,
	Particle = 3,
}


@export_group("Render Options")
@export var BlendMode: BlendModeEnum:
	get:
		return _blendMode
	set(value):
		_blendMode = value
		_update_shader_code()

@export var DepthDrawMode: DepthDrawModeEnum:
	get:
		return _depthDrawMode
	set(value):
		_depthDrawMode = value
		_update_shader_code()
		
@export var CullMode: CullModeEnum:
	get:
		return _cullMode
	set(value):
		_cullMode = value
		_update_shader_code()

@export var DiffuseMode: DiffuseModeEnum:
	get:
		return _diffuseMode
	set(value):
		_diffuseMode = value
		_update_shader_code()

@export var SpecularMode: SpecularModeEnum:
	get:
		return _specularMode
	set(value):
		_specularMode = value
		_update_shader_code()

@export var ShadingMode: ShadingModeEnum:
	get:
		return _shadingMode
	set(value):
		_shadingMode = value
		_update_shader_code()

@export var BillboardMode: BillboardModeEnum:
	get: 
		return _billboardMode
	set(value):
		_billboardMode = value
		_update_shader_code()

@export var BillboardKeepScale: bool:
	get: 
		return _billboardKeepScale
	set(value):
		_billboardKeepScale = value
		_update_shader_code()
		
@export var NoDepthTest: bool:
	get: 
		return _noDepthTest
	set(value):
		_noDepthTest = value
		_update_shader_code()
		
var _blendMode: BlendModeEnum = BlendModeEnum.Mix
var _depthDrawMode: DepthDrawModeEnum = DepthDrawModeEnum.Opaque
var _cullMode: CullModeEnum = CullModeEnum.Back
var _diffuseMode: DiffuseModeEnum = DiffuseModeEnum.Lambert
var _specularMode: SpecularModeEnum = SpecularModeEnum.Schlick_Ggx
var _shadingMode: ShadingModeEnum = ShadingModeEnum.Unshaded
var _billboardMode: BillboardModeEnum = BillboardModeEnum.Disabled
var _billboardKeepScale: bool
var _noDepthTest: bool

# handle property gets. 
# if is shader property set it in shader 
# and if it starts with use_ update shader code to include new definitions
# if is render property set new value and update shader code
func _set(property, value):
	if property.begins_with("shader_parameter/"):
		set_shader_parameter(property.replace("shader_parameter/", ""), value)
		if property.begins_with("shader_parameter/use_"):
			_update_shader_code()

func generate_render_options_definition_string() -> String:
	var definition_string: String = ""
	
	match _blendMode:
		BlendModeEnum.Mix:
			definition_string += "#define BLEND_MIX\n"
		BlendModeEnum.Add:
			definition_string += "#define BLEND_ADD\n"
		BlendModeEnum.Subtract:
			definition_string += "#define BLEND_SUB\n"
		BlendModeEnum.Multiply:
			definition_string += "#define BLEND_MUL\n"
		BlendModeEnum.Premultiplied_Alpha:
			definition_string += "#define BLEND_PREMUL_ALPHA\n"
	
	match _depthDrawMode:
		DepthDrawModeEnum.Opaque:
			definition_string += "#define DEPTH_DRAW_OPAQUE\n"
		DepthDrawModeEnum.Always:
			definition_string += "#define DEPTH_DRAW_ALWAYS\n"
		DepthDrawModeEnum.Never:
			definition_string += "#define DEPTH_DRAW_NEVER\n"	
	
	match _cullMode:
		CullModeEnum.Back:
			definition_string += "#define CULL_BACK\n"
		CullModeEnum.Front:
			definition_string += "#define CULL_FRONT\n"
		CullModeEnum.Disabled:
			definition_string += "#define CULL_DISABLED\n"

	match _diffuseMode:
		DiffuseModeEnum.Lambert:
			definition_string += "#define DIFFUSE_LAMBERT\n"
		DiffuseModeEnum.Lambert_Wrap:
			definition_string += "#define DIFFUSE_LABERT_WRAP\n"
		DiffuseModeEnum.Burley:
			definition_string += "#define DIFFUSE_BURLEY\n"
		DiffuseModeEnum.Toon:
			definition_string += "#define DIFFUSE_TOON\n"
	
	match _specularMode:
		SpecularModeEnum.Schlick_Ggx:
			definition_string += "#define SPECULAR_SCHLICK_GGX\n"
		SpecularModeEnum.Toon:
			definition_string += "#define SPECULAR_TOON\n"
		SpecularModeEnum.Disabled:
			definition_string += "#define SPECULAR_DISABLED\n"
	
	match _shadingMode:
		ShadingModeEnum.Unshaded:
			definition_string += "#define UNSHADED\n"
	
	match _billboardMode:
		BillboardModeEnum.Enabled:
			definition_string += "#define BILLBOARD_ENABLED\n"
		BillboardModeEnum.Y:
			definition_string += "#define BILLBOARD_Y\n"
		BillboardModeEnum.Particle:
			definition_string += "#define BILLBOARD_PARTICLE\n"
	
	if _noDepthTest:
		definition_string += "#define NO_DEPTH_TEST\n"
	
	if _billboardKeepScale:
		definition_string += "#define BILLBOARD_KEEP_SCALE\n"

	return definition_string
	
# update shader code to include new option definitions
func _update_shader_code():
	if not Engine.is_editor_hint():
		return
	
	var template_header = """
// This shader was dynamically generated by the VFEZ material.
// **********************************
// Every change to the VFEZ material Render Options or 
// Include Options generates a new shader. After every change
// you can click on the new exported shader in the editor to view
// the latest changes. Only the definitions (#define) actually change.
// **********************************
"""
	# find current directory name and create absolute include path for template shader
	var base_dir_name = get_script().get_path().get_base_dir()
	var shader_include_str: String = "#include \"" + base_dir_name + "/Shaders/vfez_3d_template.gdshaderinc\"\n"
	var template_code: String = "shader_type spatial;\n"
	
	# we duplicate the shader, else the code bugs 
	# if the generated shader is open in the editor
	shader = shader.duplicate()
	# initialize the shader code with the included shader template. 
	# This is necessary to be able to read the shader uniforms later.
	shader.code = template_code + shader_include_str
	
	template_code += generate_render_options_definition_string()
	
	# set all shader definition options based on the relevant use_X uniform values
	for uniform in shader.get_shader_uniform_list():
		var uniform_name: String = uniform["name"]
		
		# if start with use_ there is a relevant define options
		if uniform_name.begins_with("use_"):
			var shader_parameter = get_shader_parameter(uniform_name)
			# if use_ shader parameter is true (1) then set the define option
			# to enable the effect	
			if shader_parameter != null && int(shader_parameter) == 1:
				# extract define option from shader_parameter name
				# for example use_uv_wave becomes -> UV_WAVE
				var define_option = uniform_name.replace("use_", "").to_upper()
				template_code += "#define %s\n" % define_option
	
	# update final code to include description template, the define options 
	# and the shader include string at the end
	shader.code = template_header + template_code + shader_include_str

func _init() -> void:	
	if Engine.is_editor_hint():
		shader = Shader.new()
		shader.resource_name = "VFEZ3DPreview"
		_update_shader_code()
