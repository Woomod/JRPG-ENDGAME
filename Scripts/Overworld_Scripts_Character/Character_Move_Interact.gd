extends CharacterBody2D


const SPEED = 1

var Collision_X: int
var Collision_Y: int
var Move_Distance: Vector2
var Move_Direction: Vector2
var Movement = true
var Move_Vector = move_and_collide(Vector2(0,0))
var Step_Counter: int
var Last_Position: Vector2 = Vector2(222222,222222)
var Current_Position: Vector2
var Original_Position: Vector2

func _process(delta: float) -> void:


	if Movement == true:
		if Input.is_action_pressed("Left_Press"):
			Original_Position = global_position
			Move_Vector = move_and_collide(Vector2(-2,0))
			Move_Direction = Vector2(-2,0)
			Movement = false


		if Input.is_action_pressed("Right_Press"):
			Original_Position = global_position
			Move_Vector = move_and_collide(Vector2(2,0))
			Move_Direction = Vector2(2,0)
			Movement = false


		if Input.is_action_pressed("Up_Press"):
			Original_Position = global_position
			Move_Vector = move_and_collide(Vector2(0,-2))
			Move_Direction = Vector2(0,-2)
			Movement = false


		if Input.is_action_pressed("Down_Press"):
			Original_Position = global_position
			Move_Vector = move_and_collide(Vector2(0,2))
			Move_Direction = Vector2(0,2)
			Movement = false

			
			
	if Movement == false:
		Current_Position = global_position

		if [Vector2(32,0), Vector2(-32,0), Vector2(0,32),Vector2(0,-32)].has(Vector2((Current_Position - Original_Position))) == true:
			Move_Vector = move_and_collide(Vector2(0,0))
			Movement = true
			Last_Position = Current_Position
			EncounterManager.Steps_Since_Encounter +=1
			EncounterManager.Random_Encounter_Roll()
			print("Cool")

		else:
			match Move_Direction:
				Vector2(-2,0):
					Move_Vector = move_and_collide(Vector2(-2,0))
					Move_Direction = Vector2(-2,0)

				Vector2(+2,0):
					Move_Vector = move_and_collide(Vector2(+2,0))
					Move_Direction = Vector2(+2,0)

				Vector2(0,+2):
					Move_Vector = move_and_collide(Vector2(0,+2))
					Move_Direction = Vector2(0,+2)

				Vector2(0,-2):
					Move_Vector = move_and_collide(Vector2(0,-2))
					Move_Direction = Vector2(0,-2)

	if Movement == true:
		if Input.is_action_pressed("Interact_Select"):
			_Interact_Wip()


func _on_move_input_timer_timeout() -> void:
	pass
	
func _Interact_Wip(): #probably something Like Kicking to a Manager script based on what it detects interact with, npc, chest, etc....
	pass
