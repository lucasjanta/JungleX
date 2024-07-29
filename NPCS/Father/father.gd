extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var interact_sprite = $InteractAnim

func _ready():
	interact_sprite.visible = false
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

	update_animations()

func update_animations():
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
	

func _on_interact_area_body_entered(body):
	if body.has_method("player_method"):
		if body.can_interact_ar.size() > 0:
			body.can_interact_ar[body.can_interact_ar.size()] = self
		else:
			body.can_interact_ar[0] = self
		print(body.can_interact_ar)
		body.can_interact = true
		print("entrou")
		interact_sprite.visible = true
		interact_sprite.play("interact")
		

func _on_interact_area_body_exited(body):
	if body.has_method("player_method"):
		body.can_interact = false
		print("saiu")
		interact_sprite.visible = false
		interact_sprite.stop()


func _on_player_interaction():
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.start('tutorial_timeline')
		get_viewport().set_input_as_handled()

#teste teste teste
