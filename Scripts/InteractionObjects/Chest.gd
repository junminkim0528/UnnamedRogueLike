extends InteractionObject

var is_opened = false

func Interact():
	is_opened = true
	$AnimatedSprite2D.play("open")
