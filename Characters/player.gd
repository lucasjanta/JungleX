extends CharacterBody2D

@export var speed : float = 200.0
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var can_interact : bool = false
var can_interact_ar : Dictionary
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO
signal interaction

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
			

	direction = Input.get_vector("left", "right", "up", "down")
	
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F:
			if can_interact:
				emit_signal("interaction")
			else:
				print("n pode falar ou interagir")

func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
func update_facing_direction():
	if direction.x < 0: 
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

func player_method():
	pass

func interact():
	pass
