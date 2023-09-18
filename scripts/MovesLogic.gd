extends Node

onready var charLogic = get_parent().get_node("Characters")
onready var turnTimer = get_parent().get_node("TurnTimer")

var charSkillSets = [
	null, null, null, null
]
var skillPlacement = [ # Skill position (x, y)
	[
		[435, 27],
		[445, 77],
		[455, 127]
	],
	[
		[615, 123],
		[625, 173],
		[635, 223]
	],
	[
		[372, 204],
		[382, 254],
		[392, 304]
	],
	[
		[550, 300],
		[560, 350],
		[570, 400]
	]
]

var curTurn = 0 # Current turn ID (0 - 3)
#var turnOrder = [1, 3, 2, 0] # I CANT GET THE RANDOM ORDER TO WORK SO its bonnie > foxy > chica > freddy
var availability = [true, true, true, true]

func _ready():
	randomize() # Randomizing
	
	for i in range(4): # Loading moves for the party
		#print(i)
		charSkillSets[i] = charLogic.partyScenes[i].skillSet
		print("Loaded " + charLogic.partyScenes[i].get_name() + " skillset")
		
	turnTimer.start() # Starting the turn timer

func _process(delta):
	get_parent().get_node("Label").text = str(turnTimer.time_left) + "\n" + str(get_parent().get_node("CharacterTimers/1").time_left) + "\n" + str(get_parent().get_node("CharacterTimers/2").time_left) + "\n" + str(get_parent().get_node("CharacterTimers/3").time_left) + "\n" + str(get_parent().get_node("CharacterTimers/4").time_left) + "\n" + str(curTurn) # Debug purposes
	
	#get_node("Move1/IdlePlayer").play("idle")
	
func prepareSkills(charID): # Load and show moves
	for j in range(3):
		var curSkill = load("res://scenes/moves/" + charSkillSets[charID][j] + ".tscn").instance() # Loading the skill up
		add_child(curSkill)
		
		# Some tweaking
		curSkill.set_name("Move" + str(j + 1)) # Name
		curSkill.set_position(Vector2(skillPlacement[charID][j][0], skillPlacement[charID][j][1])) # Position
		curSkill.set_scale(Vector2(1.2, 1.15)) # Scale
		
		# Making it click-able
		get_node(curSkill.get_name() + "/Area2D").connect("input_event", self, "_on_Move" + str(j + 1) + "_input_event")
		
		# Playing the Appear animation
		get_node(curSkill.get_name() + "/AppearPlayer").play("appear")
		get_parent().get_node("SFX/AttackReady").play()


func _on_TurnTimer_timeout(): # When the turn timer's out
	turnTimer.stop() # Stopping it
	
	curTurn = randi() % 4 # Random turn
	
	print("curturn " + str(curTurn))
	
	if availability[curTurn] == true:
		prepareSkills(curTurn) # Preparing skills for the next character
	else:
		print("nope")
		turnTimer.start()
	
func doTurn(): # When we do something (i mean fight)
	for child in self.get_children():
		child.queue_free() # Destroying the previous moves
		#print("All moves cleared")
	turnTimer.start() # Starting the timers all over again
	
	get_parent().get_node("Characters/Character" + str(curTurn) + "/Texture").visible = false
	get_parent().get_node("Characters/Character" + str(curTurn) + "/Attack").visible = true
	get_parent().get_node("Characters/Character" + str(curTurn) + "/AttackPlayer").play("attack")
	
	get_parent().get_node("CharacterTimers/" + str(curTurn + 1)).start()
	availability[curTurn] = false
	print(str(curTurn + 1) + " timer started")
	
func _on_Move1_input_event(viewport, event, shape_idx): # If we click move 1
	if InputEventMouseButton and event.is_pressed():
		print("Move 1 done")
		doTurn()
	
func _on_Move2_input_event(viewport, event, shape_idx): # If we click move 2
	if InputEventMouseButton and event.is_pressed():
		print("Move 2 done")
		doTurn()
func _on_Move3_input_event(viewport, event, shape_idx): # If we click move 3
	if InputEventMouseButton and event.is_pressed():
		print("Move 3 done")
		doTurn()

func _on_1_timeout():
	get_parent().get_node("CharacterTimers/1").stop()
	availability[0] = true


func _on_2_timeout():
	get_parent().get_node("CharacterTimers/2").stop()
	availability[1] = true


func _on_3_timeout():
	get_parent().get_node("CharacterTimers/3").stop()
	availability[2] = true


func _on_4_timeout():
	get_parent().get_node("CharacterTimers/4").stop()
	availability[3] = true
