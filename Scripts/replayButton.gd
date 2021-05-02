extends Button


func _ready():
	pass


func _on_replayButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")
