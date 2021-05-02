extends KinematicBody


var camera 
var velocity = Vector3()


const SPEED = 30
const ROTATE = 20
const ACCELERATION = 2
const DE_ACCELERATION = 3


func _ready():
	pass


func _physics_process(delta):
	
	var dir = Vector3()
	var deg = Vector3()
	camera = get_node("target/Camera").get_global_transform()
	

	if $Skin.visible and $Aura.visible == false:
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("d"):
			dir += camera.basis[0]
			deg += camera.basis[2]
			$Skin.rotate(deg, deg2rad(-ROTATE))
		elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("a"):
			dir += -camera.basis[0]
			deg += camera.basis[2]
			$Skin.rotate(deg, deg2rad(ROTATE))
		elif Input.is_action_pressed("ui_up") or Input.is_action_pressed("w"):
			dir += -camera.basis[2]
			deg += camera.basis[0]
			$Skin.rotate(deg, deg2rad(-ROTATE))
		elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("s"):
			dir += camera.basis[2]
			deg += camera.basis[0]	
			$Skin.rotate(deg, deg2rad(ROTATE))
		

	dir = dir.normalized()
	deg = deg.normalized()
	
	var hv = velocity
	var new_pos = dir*SPEED
	var accel = DE_ACCELERATION
	
	if(dir.dot(hv)>0):
		accel = ACCELERATION	
	
	hv = hv.linear_interpolate(new_pos, accel*delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = move_and_slide(velocity, Vector3(0,0,0))
		

func _on_enemy_body_entered(body):
	if not get_parent().get_node("Control/Counter").coins == 36:
		if body.name == "Ball":
			$explodeTimer.start()
			$Skin.visible = false
			$explode.visible = true
			$gameMusic.stop()
			$Pluck.play()
			
			
func _on_explodeTimer_timeout():
	get_tree().change_scene("res://Scenes/Replay.tscn")
