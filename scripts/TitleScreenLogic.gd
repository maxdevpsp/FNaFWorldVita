extends Node2D

func _ready():
	$SFX/MenuMusic.play() # Play menu music
	
	$Glow/AppearAnim.play("appear")
	
	$BackFade/FadeIn.play("fadeIn")
	
	# Play logo animations
	$Fw/IdleAnim.play("idle")
	$Fw/AppearAnim.play("appear")
	$Vita.visible = true
	$Vita/AppearAnim.play("appear")
	
	# Play title characters animation
	$TitleChar/UpAnim.play("up")
	
func _process(delta):
	if Input.is_action_pressed("ui_accept") and get_node("Credits").visible == false:
		# Showing the loading screen
		get_node("Loading").visible = true
		get_node("Loading/LoadTimer").start()
		
	if Input.is_action_pressed("ui_select"):
		# Showing the credits screen
		get_node("Credits").visible = true
		
	if Input.is_action_pressed("ui_cancel") and get_node("Credits").visible == true:
		get_node("Credits").visible = false


func _on_AppearAnim_animation_finished(anim_name): # When the logo animation is over
	$Fw/IdleAnim.stop() # Some logo tweaking
	$Fw.frame = 1
	
	# Particles ! ! ! ! 
	$BGParticles.emitting = true


func _on_LoadTimer_timeout(): # When everything is loaded up
	# Switch to another scene
	#get_tree().change_scene("res://scenes/Fight.tscn")
	get_tree().change_scene("res://scenes/overworld/FazbearHills.tscn")
