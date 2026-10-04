extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")



func _on_exit_button_pressed():
	$QuitPopup.show()
	$QuitDarkOverLay.show()
	$AnimationPlayer.play("QuitPopup")


func _on_yes_button_pressed():
	get_tree().quit()

func _on_no_button_pressed():
	$QuitPopup.hide()
	$QuitDarkOverLay.hide()
