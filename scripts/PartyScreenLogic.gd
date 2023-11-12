extends Node2D

var charIconOrder = [2, 3, 4, 5, 6, 7, 8, 9, 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 0, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
var iconTracker = [0, 0]

# Save file ! !  !
var saveFile = ConfigFile.new()
var partyData = [null, null, null, null, null, null, null, null]

func _ready():
	# Loading up the save file
	saveFile.load("res://saves/fnafw1")
	
	# Party setup
	for j in partyData.size():
		partyData[j] = saveFile.get_value("fnafw", "s" + str(j + 1))
		#print("P " + str(partyData[j]))
	
	# Icons showup
	for i in charIconOrder.size():
		var curIcon = load("res://scenes/characters/SelectIcon.tscn").instance() # Duplicating the object
		var doesHave = saveFile.get_value("fnafw", str(i + 1) + "have") # Checking if the player has the character
		
		get_node("Icons").add_child(curIcon) # Adding a child node
		
		# Some tweaking
		curIcon.set_name(str(i)) # Name
		curIcon.frame = charIconOrder[i] # Frame
		curIcon.set_scale(Vector2(1.2, 1.125)) # Scale
		if doesHave != 1:
			curIcon.modulate = Color(1, 1, 1, 0.3) # Setting opacity if the character is not obtained
		curIcon.set_position( # Position
			Vector2(
				33 + ((4 + 84) * iconTracker[0]), 
				24 + ((4  + 78.75) * iconTracker[1])
				)
			)
		
		# Row tweaking
		if iconTracker[0] == 7:
			iconTracker[1] += 1
			iconTracker[0] = 0
		else:
			iconTracker[0] += 1
		
		#print(curIcon.get_name())
		yield(get_tree().create_timer(0.015), "timeout") # A little wait time between icons
		
	for a in range(8):
		var curSelSlot = load("res://scenes/gui/partySlots/" + str(a + 1) +".tscn").instance()
		
		get_node("SelIcons").add_child(curSelSlot)
		
		# Some tweaking
		curSelSlot.set_name(str(a)) # Name
		curSelSlot.set_scale(Vector2(1.2, 1.125)) # Scale
		curSelSlot.set_position(get_node("Icons/" + str(partyData[a] - 1)).get_position()) # Position
		print(str(get_node("Icons/" + str(partyData[a])).get_position()))
