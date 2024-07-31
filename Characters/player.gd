extends Actors
class_name Player

signal game_over
var direction : Vector2 = Vector2.ZERO
var can_interact : bool = false
var interaction_array : Dictionary
signal interaction

@export var run_animation : String = "run"
@export var jump_impulse: float = 150.0
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var player = $"."
@onready var animation_tree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

var max_health: float = 100.0
var player_health: float = 100.0

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_impulse
		
	if Input.is_action_just_pressed("interact"):
		emit_signal("interaction")
		
	#if direction:
		#velocity.x = direction.x * move_speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, move_speed)
		
	if direction.x != 0:
		velocity.x = direction.x * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_facing_direction():
	if direction.x < 0: 
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		
func update_animation_parameters():
	animation_tree.set("parameters/run/blend_position", direction.x) 
	

func _on_interact_area_body_entered(body):
	if body.has_method("interact"):
		if body.interaction_array.size() < 1:
			body.interaction_array[body.interaction_array.size()] = body



func _on_interact_area_body_exited(body):
	pass # Replace with function body.

