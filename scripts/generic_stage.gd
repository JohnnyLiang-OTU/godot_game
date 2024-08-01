extends Node2D
#another signal player_node to do according to the user input
signal choice_to_player(choice:int)

var entities = []
var halt_action
@onready var choice_menu = $choice_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	choice_menu.visible = false
	entities.append($player)
	entities.append($monster)
	halt_action = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for entity in entities:
		if !halt_action:
			entity.accumulate_action_points(delta)

func pause_action_point_accumulation():
	halt_action = true

func resume_action_point_accumultion():
	halt_action = false
	
func draw_choice_menu():
	choice_menu.visible = true

func erase_choice_menu():
	choice_menu.visible = false

func damage_calculation(entA:=$player, entB:=$monster):
	entB.hp_component.take_damage(entA.attack)

func _on_player_user_turn():
	pause_action_point_accumulation()
	draw_choice_menu()

func _on_choice_menu_on_choice(choice:int): 
	# 1 - attack
	# 2 - defend
	# 3 - skills
	match choice:
		1:
			choice_to_player.emit(1)
		2:
			choice_to_player.emit(2)
		3:
			choice_to_player.emit(3)

func _on_player_end_turn():
	damage_calculation(entities[0], entities[1])
	resume_action_point_accumultion()
