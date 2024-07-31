extends ActionLeaf
# Called when the node enters the scene tree for the first time.
func tick(actor, _blackboard):
	if actor.player_on_range: 
		actor.velocity.x = 0
		return SUCCESS
	#if !actor.player_on_range:
		#return FAILURE
	actor.velocity.x = -50
	return RUNNING
