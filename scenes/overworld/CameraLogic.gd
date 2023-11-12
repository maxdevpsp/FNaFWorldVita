extends Camera2D

func _process(delta):
	self.position = get_parent().get_node("Player").position
