extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_button_pressed() -> void:
	# Disable the background buttons so they can't steal the mouse
	$ButtonsNode/Level1Button.disabled = true
	$ButtonsNode/Level2Button.disabled = true
	$ButtonsNode/Level3Button.disabled = true
	
	$CanvasLayer/Level1Popup/LevelName.text = "Bit Ashen Woods"
	$CanvasLayer/Level1Popup/DifficultyLabel.text = "DIFFICULTY"
	$CanvasLayer/Level1Popup/StarsLabel.text = "★☆☆☆☆"
	
	$CanvasLayer/Level1Popup.show()
	$AnimationPlayer.play("Level1Popup")



func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
	
	



func _on_level_2_button_pressed() -> void:
		# Disable the background buttons so they can't steal the mouse
	$ButtonsNode/Level1Button.disabled = true
	$ButtonsNode/Level2Button.disabled = true
	$ButtonsNode/Level3Button.disabled = true
	
	$CanvasLayer/Level2Popup/LevelName.text = "Glitchwood Catacombs"
	$CanvasLayer/Level2Popup/DifficultyLabel.text = "DIFFICULTY"
	$CanvasLayer/Level2Popup/StarsLabel.text = "★★★☆☆"
	
	$CanvasLayer/Level2Popup.show()
	$AnimationPlayer.play("Level2Popup")


func _on_back_1_button_pressed() -> void:
	$CanvasLayer/Level1Popup.hide()
	
	# Re-enable the background buttons when the popup closes
	$ButtonsNode/Level1Button.disabled = false
	$ButtonsNode/Level2Button.disabled = false
	$ButtonsNode/Level3Button.disabled = false



func _on_back_2_button_pressed() -> void:
	$CanvasLayer/Level2Popup.hide()
	
	# Re-enable the background buttons when the popup closes
	$ButtonsNode/Level1Button.disabled = false
	$ButtonsNode/Level2Button.disabled = false
	$ButtonsNode/Level3Button.disabled = false


func _on_level_3_button_pressed() -> void:
	$ButtonsNode/Level1Button.disabled = true
	$ButtonsNode/Level2Button.disabled = true
	$ButtonsNode/Level3Button.disabled = true
	
	$CanvasLayer/Level3Popup/LevelName.text = "The Monochromatic Keep"
	$CanvasLayer/Level3Popup/DifficultyLabel.text = "DIFFICULTY"
	$CanvasLayer/Level3Popup/StarsLabel.text = "★★★★★"
	
	$CanvasLayer/Level3Popup.show()
	$AnimationPlayer.play("Level3Popup")
	


func _on_back_3_button_pressed() -> void:
	$CanvasLayer/Level3Popup.hide()
	
	# Re-enable the background buttons when the popup closes
	$ButtonsNode/Level1Button.disabled = false
	$ButtonsNode/Level2Button.disabled = false
	$ButtonsNode/Level3Button.disabled = false
