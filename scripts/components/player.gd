extends Node2D

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
	viz_component.connect("animation_finished", Callable(self, "_on_player_viz_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func accumulate_action_points(delta):
	action_points += speed * delta
	if action_points >= action_threshold:
		pause_timer()
		perform_action()
		action_points -= action_threshold

func perform_action():
	viz_component.play("attack")

func pause_timer():
	get_parent().halt_action = true
	
func resume_timer():
	get_parent().halt_action = false

func _on_player_viz_animation_finished():
	if viz_component.animation == "attack":
		viz_component.play("idle")
		resume_timer()
