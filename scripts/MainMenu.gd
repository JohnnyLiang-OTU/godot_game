extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button_Vbox/Play.connect("pressed", _on_PlayButton_pressed)
	$Button_Vbox/Exit.connect("pressed", _on_ExitButton_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_PlayButton_pressed():
	get_tree().change_scene_to_file("res://scenes/stage_selector.tscn")
	

func _on_ExitButton_pressed():
	get_tree().quit()
