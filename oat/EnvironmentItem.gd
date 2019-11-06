tool
extends StaticBody

export (String) var unique_name
export (Shape) var collision_shape = BoxShape.new() setget set_collision_shape
onready var model = get_node("Model")


func _ready():
	$CollisionShape.shape = collision_shape
	# TODO: this will probably not work for objects with emission
	model.material_override.emission_enabled = true
	model.material_override.emission = Color.white
	model.material_override.emission_energy = 0.0
	
	oat_interaction_signals.connect("oat_environment_item_selected", self, "select")
	oat_interaction_signals.connect("oat_environment_item_deselected", self, "deselect")


func set_collision_shape(new_shape):
	collision_shape = new_shape
	if is_inside_tree():
		$CollisionShape.shape = collision_shape


func select(item_name):
	if item_name == unique_name:
		model.material_override.emission_energy = 0.2


func deselect(item_name):
	if item_name == unique_name:
		model.material_override.emission_energy = 0.0
