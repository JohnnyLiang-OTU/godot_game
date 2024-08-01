extends Node2D
# Enough action points to act (Is the user's turn)
signal user_turn()
# User's turn is over (Signal to continue the game logic)
signal end_turn()

var hp_component: Node2D = null
var viz_component: AnimatedSprite2D = null

var mana = 50
var speed = 10
var action_points = 0
var action_threshold = 20
var attack = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	hp_component = get_node("Health_Component")
	viz_component = get_node("player_viz")
	#viz_component.connect("animation_finished", Callable(self, "_on_player_viz_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func accumulate_action_points(delta):
	action_points += speed * delta
	if action_points >= action_threshold:
		user_turn.emit()
		action_points -= action_threshold

func _on_player_viz_animation_finished():
	viz_component.play("idle")
	end_turn.emit()

func receive_choice(choice):
	match choice:
		1:
			viz_component.play("attack")
		2: 
			viz_component.play("defend")
		3: 
			end_turn.emit()
		_:
			pass
