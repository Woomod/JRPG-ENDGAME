extends Node

var Steps_Since_Encounter: int
var Base_Chance_Of_Encounter = float(0.93)
var Effective_Chance_Of_Encounter = float()
var Active_Chance = true
var Active_Battle
var Encounter_Scene = preload("res://Scenes/Maps/Final Castle 1.tscn").instantiate()


#This will handle encounter processing later.

func Random_Encounter_Roll():
	if Steps_Since_Encounter == 1:
		Base_Chance_Of_Encounter = .93
	Effective_Chance_Of_Encounter = Base_Chance_Of_Encounter * 0.93
	Base_Chance_Of_Encounter = Effective_Chance_Of_Encounter
	if Steps_Since_Encounter > 25:
		Effective_Chance_Of_Encounter -= .01
	
	
	print(Effective_Chance_Of_Encounter)
	
	if randf_range(0.0,1.0) > Effective_Chance_Of_Encounter == true:
		Active_Chance = false
		Active_Battle = true
		get_tree().root.add_child(Encounter_Scene)
		Steps_Since_Encounter = 0 
