extends CharacterBody2D


const SPEED = 300.0

var Collision_X: int
var Collision_Y: int
var Move_Distance: Vector2
var Move_Direction: Vector2
var Movement: bool = false


func _physics_process(delta: float) -> void:
	if Movement == true:
		if event.is_action_pressed("Left"):
			pass

func _on_collison_box_ready() -> void:
	Collision_X = get_child(0).shape.size.x
	Collision_Y = get_child(0).shape.size.y
	Move_Distance = Vector2(Collision_X,Collision_Y)
	print(Move_Distance)

func _on_move_input_timer_timeout() -> void:
	pass
