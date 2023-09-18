extends Node2D

var skillSet = [
	"Bite",
	"BashJam",
	"HappyJam"
]

var health = 120
var def = 5
var attack = 10


func _on_AttackPlayer_animation_finished(anim_name):
	$Attack.visible = false
	$Texture.visible = true
