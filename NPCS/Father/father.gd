extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var interact_sprite = $InteractAnim
var player_on_range = false

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

func interact():
	pass

func out_of_range():
	pass

func _on_area_2d_body_entered(body):
	if body is Player:
		interact_sprite.visible = true
		interact_sprite.play("interact")
		player_on_range = true


func _on_area_2d_body_exited(body):
	if body is Player:
		body.interaction_array.erase(body)
		interact_sprite.visible = false
		interact_sprite.stop()
		player_on_range = false


func _on_player_interaction():
	if player_on_range:
		if Dialogic.current_timeline != null:
			return
		else:
			Dialogic.start('tutorial_timeline')
			get_viewport().set_input_as_handled()
