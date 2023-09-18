extends Node2D

func _ready():
	$Fade.play("fadeOut")

func _on_Fade_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
