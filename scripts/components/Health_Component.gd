extends Node2D

var max_health = 10
var hp

# Called when the node enters the scene tree for the first time.
func _ready():
	set_health(max_health)

#func _process(delta):
	#pass

func take_damage(damage):
	hp -= damage
	if(hp <= 0):
		die()

func take_heal(healing):
	hp += healing

func set_health(health):
	hp = health

func die():
	queue_free()
