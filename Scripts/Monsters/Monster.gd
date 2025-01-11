extends Node2D

class_name Monster

@onready var navigation = $NavigationAgent2D
@onready var attack_delay = $AttackDelay.wait_time

@export var speed : float
var is_attacking = false


func _physics_process(delta: float) -> void:
	if position != GameManager.player.position:
		Move(delta)
	else:
		$AnimatedSprite2D.play("default")
	if is_attacking:
		if $AttackDelay.is_stopped():
			Attack()
			$AttackDelay.start()
	
func Move(delta):
	$AnimatedSprite2D.flip_h = true if position.x <= GameManager.player.position.x else false
	
	$NavigationAgent2D.target_position = GameManager.player.position
	position = position.move_toward(navigation.get_next_path_position(),delta * speed)
	$AnimatedSprite2D.play("walk")
	
	

func turn_attack_mode(body,onoff:bool):
	if body.is_in_group("Player"):
		is_attacking = onoff

func Attack():
	print("attack!!!")
