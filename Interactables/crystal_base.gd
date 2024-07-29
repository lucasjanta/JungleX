extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var open_anim = $open_anim

var is_locked = true
var interaction : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	open_anim.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass



func _on_area_2d_body_entered(body):
	if body.has_method("player_method"):
		open_anim.visible = true
		open_anim.play("default")



func _on_area_2d_body_exited(body):
	if body.has_method("player_method"):
		open_anim.visible = false
		open_anim.stop()
