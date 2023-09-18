extends Node2D

var charIconOrder = [2, 3, 4, 5, 6, 7, 8, 9, 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 0, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
var iconTracker = [0, 0]

func _ready():
	for i in charIconOrder.size():
		var curIcon = load("res://scenes/characters/SelectIcon.tscn").instance()
		
		get_node("Icons").add_child(curIcon)
		
		curIcon.set_name(str(i))
		curIcon.frame = charIconOrder[i]
		curIcon.set_scale(Vector2(1.2, 1.125))
		curIcon.set_position(
			Vector2(
				33 + ((4 + 84) * iconTracker[0]), 
				24 + ((4  + 78.75) * iconTracker[1])
				)
			)
			
		if iconTracker[0] == 7:
			iconTracker[1] += 1
			iconTracker[0] = 0
		else:
			iconTracker[0] += 1
		
		print(curIcon.get_name())
