extends Label
@export var health_component:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var format_hp = "%d"
	text = format_hp % health_component.hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_component_hp_change():
	var format_hp = "%d"
	text = format_hp % health_component.hp
