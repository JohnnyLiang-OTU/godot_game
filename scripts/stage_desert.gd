extends Node2D

var arrow_sequence = []
var current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_arrow_sequence()
	current_index = 0
	var sequence = String()
	for arrow in arrow_sequence:
		sequence.indent(keycode_to_string(arrow) + " ")
	print(sequence)

func generate_arrow_sequence():
	var arrow = [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]
	for i in range(10):
		arrow_sequence.append(arrow[randi() % arrow.size()])

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			check_arrow_input(event.keycode)

func check_arrow_input(keycode):
	if keycode == arrow_sequence[current_index]:
		current_index += 1
		print("Correct input! Current index: ", current_index)
		if current_index >= arrow_sequence.size():
			print("Sequence completed!")
			current_index = 0
	else:
		print("Wrong input! Resetting sequence.")
		current_index = 0  
		
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
