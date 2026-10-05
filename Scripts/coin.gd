extends Area2D
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound


func _on_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().call_group("UI", "add_coin")
		collect()
func collect():
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
	pickup_sound.play()
	await pickup_sound.finished
	queue_free()
