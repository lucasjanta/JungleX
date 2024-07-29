extends ActionLeaf

var is_close_to_player : bool = false

# Called when the node enters the scene tree for the first time.
func tick(actor, _blackboard):
	if is_close_to_player: 
		actor.velocity.x = 0
		return SUCCESS
	#if actor.is_away:
		#return FAILURE
	actor.velocity.x = -50
	return RUNNING



func _on_interact_area_body_entered(body):
	if body.has_method("player_method"):
		is_close_to_player = true
