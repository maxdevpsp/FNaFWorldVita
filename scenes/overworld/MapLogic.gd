# Map logic
extends Node2D

# If we can actually encounter enemies
onready var canEncounter = false

# Random value for encounter
var fightvar = 0

# If the player is in loading screen
var isInLoading = false

func _ready():
	randomize() # Magic.

func _process(delta):
	if get_node("Player").isWalking == true: # If the player is NOT AFK
		enableEncTimer() # we're looking for enemies
	else:
		$Encounter.stop() # let them afk bro
		
	#print(str($Encounter.time_left))

func enableEncTimer(): # self explanatory
	if canEncounter == true && $Encounter.time_left == 0 && isInLoading == false:
		print("Can fight, enabling EncTimer")
		$Encounter.start()

func _on_Encounter_timeout(): # When the timer runs out
	fightvar = randi() % 7 # Magic 2.
	
	if fightvar == 0:
		# Basically going into a fight
		$Camera/Loading.visible = true
		$Camera/Loading/LoadTimer.start()
		isInLoading = true
	else:
		print("Not fighting yet")
		enableEncTimer() # and doing it again

func _on_LoadTimer_timeout():
	get_tree().change_scene("res://scenes/Fight.tscn")
