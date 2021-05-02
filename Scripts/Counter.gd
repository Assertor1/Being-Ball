extends Label

var coins = 0
var pause = false

func _ready():
	text = String(coins)


func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept") and pause == false:
		get_tree().paused = true
		pause = true
		get_parent().get_node("Pause").visible = true
	elif Input.is_action_just_pressed("ui_accept") and pause == true:
		get_tree().paused = false
		pause = false
		get_parent().get_node("Pause").visible = false

func _on_coin_Collected():
	if get_parent().get_parent().get_node("Ball/Skin").visible:
		coins += 1
		_ready()
		if coins == 36:
			get_parent().get_parent().get_node("Ball/Aura").visible = true
			get_parent().get_parent().get_node("Ball/gameMusic").stop()
			$Aura.play()
			$Auratime.start()
		


func _on_Auratime_timeout():
	get_tree().change_scene("res://Scenes/YOUWIN.tscn")
