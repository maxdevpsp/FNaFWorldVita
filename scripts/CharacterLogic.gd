extends Node

# Our current party. Sets from settings
var partySet = [
	"Freddy",
	"Bonnie",
	"Chica",
	"Foxy"
]

var partyScenes = [null, null, null, null]
var partyPlacement = [
	[690, 155],
	[825, 235],
	[618, 305],
	[770, 395]
]

# Spawning the party
func _ready():
	for i in range(4):
		print(i)
		
		# Getting the member's scene
		partyScenes[i] = load("res://scenes/characters/" + partySet[i] + ".tscn").instance() #get_node("Characters/" + partySet[i])
		print("Loaded " + partyScenes[i].get_name())
		
		# Making an instance
		var curInstance = partyScenes[i]
		add_child(curInstance)
		
		# Some tweaking
		curInstance.set_name("Character" + str(i))
		curInstance.set_position(Vector2(partyPlacement[i][0], partyPlacement[i][1])) # Position
		curInstance.set_scale(Vector2(1.2, 1.15)) # Scale
		
		get_parent().get_node("HUD/Bar" + str(i + 1)).max_value = partyScenes[i].health
		
		print("Added " + partyScenes[i].get_name())
		
	get_parent().get_node("PartyAppear/AnimationPlayer").play("pAppear")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Animaions handler
	get_node("Character0/AnimationPlayer").play("idle")
	get_node("Character1/AnimationPlayer").play("idle")
	get_node("Character2/AnimationPlayer").play("idle")
	get_node("Character3/AnimationPlayer").play("idle")
	
	# Start animation (jump??)
	get_node("Character0").set_position(Vector2(partyPlacement[0][0], partyPlacement[0][1]) + get_parent().get_node("PartyAppear").global_position)
	get_node("Character1").set_position(Vector2(partyPlacement[1][0], partyPlacement[1][1]) + get_parent().get_node("PartyAppear").global_position)
	get_node("Character2").set_position(Vector2(partyPlacement[2][0], partyPlacement[2][1]) + get_parent().get_node("PartyAppear").global_position)
	get_node("Character3").set_position(Vector2(partyPlacement[3][0], partyPlacement[3][1]) + get_parent().get_node("PartyAppear").global_position)
