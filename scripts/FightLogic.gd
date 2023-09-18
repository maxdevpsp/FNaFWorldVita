extends Node2D

var curPartyStats = [ # Current party's HP, ATK and DEF
	[null, null, null],
	[null, null, null],
	[null, null, null],
	[null, null, null]
]

func _ready():
	$SFX/BattleMusic.play() # Play the theme

func _process(delta):
	# Show HP
	get_node("HUD/Bar1/HPShow").text = str(curPartyStats[0][0])
	get_node("HUD/Bar2/HPShow").text = str(curPartyStats[1][0])
	get_node("HUD/Bar3/HPShow").text = str(curPartyStats[2][0])
	get_node("HUD/Bar4/HPShow").text = str(curPartyStats[3][0])
	
	# Set the Max HP
	get_node("HUD/Bar1").value = curPartyStats[0][0]
	get_node("HUD/Bar2").value = curPartyStats[1][0]
	get_node("HUD/Bar3").value = curPartyStats[2][0]
	get_node("HUD/Bar4").value = curPartyStats[3][0]
	
	#if Input.is_action_pressed("ui_accept"):
	#	print("play")


func _on_Characters_ready():
	# Preparing character stats
	for i in range(4):
		print(str(i))
		var curChar = get_node("Characters/Character" + str(i))
		
		curPartyStats[i][0] = curChar.health # HP
		curPartyStats[i][1] = curChar.attack # Attack
		curPartyStats[i][2] = curChar.def # Defense
		
		get_node("HUD/Bar" + str(i + 1)).value = curPartyStats[i][0]
