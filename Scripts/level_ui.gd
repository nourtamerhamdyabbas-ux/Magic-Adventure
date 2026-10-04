extends CanvasLayer
@onready var health_bar: TextureProgressBar = $HUD/VBoxContainer/HealthBar
@onready var zombies_label: Label = $HUD/VBoxContainer/ZombiesTracker/ZombiesLabel
@onready var coins_label: Label = $HUD/VBoxContainer/CoinsTracker/CoinsLabel
@onready var resume_button: Button = $PauseMenu/NinePatchRect/VBoxContainer/ResumeButton
@onready var current_level: Label = $HUD/VBoxContainer/CurrentLevel
@onready var pause_menu: Control = $PauseMenu
@onready var level_complete: Control = $LevelComplete

@export var player: Player
@export var required_coins: int = 10
@export var required_zombies: int = 10
@export var current_level_number: int = 1
@export_file("*.tscn") var next_level_path: String
var current_coins: int = 0
var current_zombies: int = 0

func _ready():
	current_level.text = "Level " + str(current_level_number)
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		player.health_changed.connect(update_health)
	pause_menu.visible = false
	update_coins_ui()
	update_zombies_ui()
func update_health(new_health):
	health_bar.value = new_health
func add_coin(amount: int = 1):
	current_coins += amount
	update_coins_ui()
	check_level_completion()

func add_monster_kill(amount: int = 1):
	current_zombies += amount
	update_zombies_ui()
	check_level_completion()
func update_coins_ui():
	coins_label.text = str(current_coins) + " / " + str(required_coins)
func update_zombies_ui():
	zombies_label.text = str(current_zombies) + " / " + str(required_zombies)
func check_level_completion():
	if current_coins >= required_coins and current_zombies >= required_zombies: 
		level_complete.visible = true
		get_tree().paused = true
func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
	if event is InputEventKey and event.pressed and event.keycode == KEY_C: # cheat button to try the func
		level_complete.visible = true
		get_tree().paused = true
func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	pause_menu.visible = new_pause_state

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
