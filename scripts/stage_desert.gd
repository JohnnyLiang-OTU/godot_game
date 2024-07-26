extends Node2D

var arrow_sequence = []
var current_index = 0
var missclick_count = 0
@onready var sequence_container = $sequence_container
@onready var player_node = $player

func _ready():
	player_node.connect("animation_finished", Callable(self, "_on_animation_finished"))
	
	randomize()
	generate_arrow_sequence()
	draw_arrow_sequence()
	current_index = 0
	var sequence = String()
	for arrow in arrow_sequence:
		sequence += keycode_to_string(arrow) + " "
	print(sequence)
	
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			check_arrow_input(event.keycode)


# <---------------------------- Arrow Sequence Generation ------------------------->
			
func generate_arrow_sequence():
	var arrow = [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]
	for i in range(9):
		arrow_sequence.append(arrow[randi() % arrow.size()])

func check_arrow_input(keycode):
	if keycode == arrow_sequence[current_index]:
		current_index += 1
		print("Correct input! Current index: ", current_index)
	else:
		missclick(current_index)
		current_index += 1
	if current_index >= arrow_sequence.size():
		if missclick_count >= 1:
			pass #Handle mid_attack
		else:
			attack_success()
			print("Sequence completed!")
			current_index = 0
		

func draw_arrow_sequence():
	# Clear children from sequence_container
	for n in sequence_container.get_children():
		n.queue_free()
			
	for arrow in arrow_sequence:
		var arrow_texture = load_arrow_texture(arrow)
		if arrow_texture:
			var arrow_rect = TextureRect.new()
			arrow_rect.expand_mode = TextureRect.SIZE_EXPAND
			arrow_rect.texture = arrow_texture
			sequence_container.add_child(arrow_rect)

func update_arrow_sequence_with_x(index):
	if index < sequence_container.get_child_count():
		var x_texture = preload("res://assets/combat_ui/x.png")
		if x_texture:
			sequence_container.get_child(index).texture = x_texture
			
func _on_animation_finished():
	if player_node.animation == "attack":
		player_node.play("idle")

# <------------------------ Combat/Gameplay Functions ----------------------->
func attack_success():
	player_node.play("attack")

func missclick(index):
	#missclick_count += 1
	update_arrow_sequence_with_x(index)

# <--------------------- Helper Functions -------------------->

func keycode_to_string(keycode):
	match keycode:
		KEY_UP:
			return "UP"
		KEY_DOWN:
			return "DOWN"
		KEY_LEFT:
			return "LEFT"
		KEY_RIGHT:
			return "RIGHT"
		_:
			return "UNKNOWN"
			
func load_arrow_texture(scancode):
	match scancode:
		KEY_UP:
			return preload("res://assets/combat_ui/arrow_u.png")
		KEY_DOWN:
			return preload("res://assets/combat_ui/arrow_d.png")
		KEY_LEFT:
			return preload("res://assets/combat_ui/arrow_l.png")
		KEY_RIGHT:
			return preload("res://assets/combat_ui/arrow_r.png")
		_:
			return null
