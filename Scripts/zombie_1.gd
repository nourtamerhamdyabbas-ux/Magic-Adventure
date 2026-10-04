extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var ray_cast: RayCast2D = $RayCast

var speed = 110
var chase_speed = 130
var attack_range = 38.0
var attack_cooldown = 0.5
var direction = 1
var max_hp = 2
var current_hp = 2
var is_alive = true
var is_hurt = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_chasing = false
var is_attacking = false
var can_attack = true 
var player_ref: Node2D = null

func _ready():
	health_bar.max_value = max_hp
	health_bar.value = current_hp



func _physics_process(delta):
	if not is_alive:
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	if is_hurt or is_attacking:
		velocity.x = 0
		move_and_slide()
		return

	if is_chasing and is_instance_valid(player_ref):
		var distance_to_player = global_position.distance_to(player_ref.global_position)
		var dir_to_player = sign(player_ref.global_position.x - global_position.x)
		
		if dir_to_player != 0:
			direction = dir_to_player

		if distance_to_player <= attack_range:
			if can_attack:
				start_attack()
			else:
				velocity.x = 0
		else:
			if not ray_cast.is_colliding() and is_on_floor():
				velocity.x = 0
			elif is_on_wall():
				velocity.x = 0
			else:
				velocity.x = chase_speed * direction
	else:
		if is_on_wall():
			direction *= -1
		if not ray_cast.is_colliding() and is_on_floor():
			direction *= -1
		velocity.x = speed * direction

	move_and_slide()
	
	if not is_attacking and not is_hurt:
		if velocity.x != 0:
			animated_sprite_2d.play("walk")
			if direction > 0:
				animated_sprite_2d.flip_h = false
				animated_sprite_2d.position.x = 0
				ray_cast.position.x = abs(ray_cast.position.x)
			else:
				animated_sprite_2d.flip_h = true
				animated_sprite_2d.position.x = -11
				ray_cast.position.x = -abs(ray_cast.position.x)
		else:
			animated_sprite_2d.stop()
func start_attack():
	is_attacking = true
	can_attack = false
	velocity.x = 0
	
	if animated_sprite_2d.sprite_frames.has_animation("attack"):
		animated_sprite_2d.play("attack")
		await get_tree().create_timer(0.6).timeout 
		
		if is_attacking and is_instance_valid(player_ref):
			if global_position.distance_to(player_ref.global_position) <= attack_range + 20.0:
				if player_ref.has_method("take_damage"):
					player_ref.take_damage(1)
		await animated_sprite_2d.animation_finished 
	is_attacking = false
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
func take_damage(amount):
	if not is_alive or is_hurt:
		return
		
	is_hurt = true
	current_hp -= amount
	health_bar.value = current_hp
	
	if is_attacking:
		is_attacking = false
	
	if current_hp > 0:
		if animated_sprite_2d.sprite_frames.has_animation("hurt"):
			animated_sprite_2d.play("hurt")
		await get_tree().create_timer(0.4).timeout
		is_hurt = false
	else:
		die()
func die():
	if not is_alive:
		return
	is_alive = false
	velocity = Vector2.ZERO
	
	if animated_sprite_2d.sprite_frames.has_animation("dead"):
		animated_sprite_2d.play("dead")
		
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	
	var ui = get_tree().get_root().find_child("Level_UI", true, false)
	if ui and ui.has_method("add_zombie_kill"):
		ui.add_zombie_kill(1)
		
	queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_ref = body
		is_chasing = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		player_ref = null
		is_chasing = false
