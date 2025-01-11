extends CharacterBody2D


const SPEED = 70.0

var hp = 20

func _ready() -> void:
	GameManager.player = self
	UIUpdate()
	

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	var axis = Input.get_axis("move_left","move_right")
	
	if direction:
		velocity = direction.normalized() * SPEED
		if axis != 0:
			$AnimatedSprite2D.flip_h = axis > 0
		$AnimatedSprite2D.play("walk")
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("default")
		
	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		for area in $InteractionArea.get_overlapping_areas():
			if area.is_in_group("InteractionObject"):
				area.Interact()
	
func UIUpdate():
	var heart_list = $CanvasLayer/UI/Hearts.get_children()
	for heart in heart_list:
		heart.texture.region.position = Vector2(0,16)
		
	for index in range((hp / 2)):
		heart_list[index].texture.region.position = Vector2(0,0)
	if hp % 2 == 1:
		heart_list[(hp / 2)].texture.region.position = Vector2(16,0)

func Damage(damage:int):
	hp -= damage
	UIUpdate()
	if hp <= 0:
		print("gameOver")
