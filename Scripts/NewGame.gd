extends Button


func _ready():
	pass


func _on_NewGame_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")
