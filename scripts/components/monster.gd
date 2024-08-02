extends Node2D

@export var hp_component : Node2D
@export var viz_component : AnimatedSprite2D

signal monster_turn()
signal monster_turn_over()


var mana = 50
var speed = 10
var action_points = 0
var action_threshold = 20
var attack = 11
var defense = 9
# choice_input {
# 0 - attack
# 1 - defend
# 2,3,... - some skill 
#}
var choice_input: int
# Called when the node enters the scene tree for the first time.
func _ready():
	viz_component = get_node("monster_viz")
	#viz_component.connect("animation_finished", Callable(self, "_on_monster_viz_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func accumulate_action_points(delta):
	action_points += speed * delta
	if action_points >= action_threshold:
		monster_turn.emit()
		perform_action()
		action_points -= action_threshold

func perform_action():
	choice_input = randi_range(0, 1)
	match choice_input:
		0: 
			viz_component.play("attack")
		1:
			print("defend")
			_on_monster_viz_animation_finished()
		_:
			pass

func pause_timer():
	get_parent().pause_action_point_accumulation()
	
func resume_timer():
	get_parent().resume_action_point_accumulation()

func _on_monster_viz_animation_finished():
		viz_component.play("idle")
		monster_turn_over.emit()
