extends Control


@onready var h_slider: HSlider = $Panel/HSlider
@onready var check_button: CheckButton = $Panel/CheckButton



func _ready() -> void:
	h_slider.value = 80

func _on_reset_button_pressed() -> void:
	h_slider.value = 80
	check_button.button_pressed = false
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_h_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(0, volume_db)







func _on_check_button_toggled(toggled_on: bool) -> void:
	print("BUTTON SIGNAL:", toggled_on)

	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_6_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
