extends Node2D


@export var hp_component: Node2D
@export var viz_component: AnimatedSprite2D 

signal user_turn()
signal end_turn()


var mana = 50
var speed = 10
var action_points = 0
var action_threshold = 20
var attack = 10
var defense = 10
# choice_input {
# 0 - attack
# 1 - defend
# 2,3,... - some skill 
#}
var choice_input: int

# Called when the node enters the scene tree for the first time.
func _ready():
	hp_component = get_node("Health_Component")
	viz_component = get_node("player_viz")
	#viz_component.connect("animation_finished", Callable(self, "_on_player_viz_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Logic for action points accumulation. It allows higher speed characters to do more actions
# before the enemy can make one action.
func accumulate_action_points(delta):
	action_points += speed * delta
	if action_points >= action_threshold:
		user_turn.emit()
		action_points -= action_threshold

# Signals when choice of animation is done. At this point, the player already chose and
# is a signal to proceed the timer after the animation is done.
func _on_player_viz_animation_finished():
	viz_component.play("idle")
	end_turn.emit()

# player_node receives choice from generic_stage and does animation
func receive_choice(choice):
	match choice:
		1:
			viz_component.play("attack")
			choice_input = 0
		2: 
			viz_component.play("defend")
			choice_input = 1
		3: 
			end_turn.emit()
			#choice_input = n...
		_:
			pass
