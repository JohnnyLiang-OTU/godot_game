extends Node2D

var entities = []
var halt_action

# Called when the node enters the scene tree for the first time.
func _ready():
	entities.append($player)
	entities.append($monster)
	halt_action = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for entity in entities:
		if !halt_action:
			entity.accumulate_action_points(delta)
