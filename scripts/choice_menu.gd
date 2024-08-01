extends Control

#@onready var v_split_container = $VSplitContainer/HBoxContainer
signal on_choice(choice:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	#v_split_container.connect("focus_exited", Callable(self, "_on_focus_exited"))
	focus_mode = Control.FOCUS_ALL
	$VSplitContainer.connect("focus_exited", Callable(self, "_on_choice_selected"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if !visible:
		return

func _on_visibility_changed():
	if visible:
		get_node("VSplitContainer/HBoxContainer/attack_button").grab_focus()

func _on_focus_changed(control:Control) -> void:
	if control != null:
		print(control.name)

func _on_attack_button_pressed():
	visible = false
	on_choice.emit(1)

func _on_defend_button_pressed():
	visible = false
	on_choice.emit(2)

func _on_skills_button_pressed():
	on_choice.emit(3)

