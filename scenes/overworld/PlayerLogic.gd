# OK LISTEN I HAVE NO IDEA WHAT IM DOING RIGHT NOW
extends KinematicBody2D

var vel # Velocity things

var moveSpeed = 120 # Movement speed

onready var isWalking = false
	
func _physics_process(delta):
	vel = Vector2()
	if get_parent().isInLoading == false: # If the player is not loading
		# Up
		if Input.is_action_pressed("ui_up"):
			vel.y -= 1
			$AnimationPlayer.play("up")
		# Down
		if Input.is_action_pressed("ui_down"):
			vel.y += 1
			$AnimationPlayer.play("down")
		# Left
		if Input.is_action_pressed("ui_left"):
			vel.x -= 1
			$AnimationPlayer.play("left")
		# Right
		if Input.is_action_pressed("ui_right"):
			vel.x += 1
			$AnimationPlayer.play("right")
	
	if vel.x == 0 and vel.y == 0: # If we're idle
		isWalking = false
		$AnimationPlayer.play("idle")
	else:
		isWalking = true # that's for MapLogic.gd
	
	# erm... what the move
	move_and_slide(vel * moveSpeed, Vector2.ZERO)
