extends ConditionLeaf


func tick(actor, _blackboard):
	if actor.visible:
		return SUCCESS
	return FAILURE
