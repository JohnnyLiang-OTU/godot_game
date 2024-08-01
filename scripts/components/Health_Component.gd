extends Node2D

signal hp_change

var max_health = 100
var hp

# Called when the node enters the scene tree for the first time.
func _ready():
	set_health(max_health)

#func _process(delta):
	#pass

func take_damage(damage):
	hp -= damage
	hp_change.emit()
	if(hp <= 0):
		die()

func take_heal(healing):
	hp += healing

func set_health(health):
	hp = health

func die():
	print("die")
	#queue_free()
