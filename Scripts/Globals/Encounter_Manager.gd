extends Node

var Steps_Since_Encounter: int
var Base_Chance_Of_Encounter = float(0.93)
var Effective_Chance_Of_Encounter = float()
var Active_Chance = true
var Active_Battle
var Encounter_Scene = preload("res://Scenes/Maps/Final Castle 1.tscn").instantiate()
var Combatants: Array
var Player_Characters: Array
var Monsters: Array

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


func _Initiative_Calculation():
	
	for Character in Player_Characters:
		Character.Initiative = randi_range(0,15) + Character.Wu_Wei
		if Character.Stunned > 0:
			Character.Initiative /= 2
		if Character.Haste > 0:
			Character.Initiative *= 2
		Combatants.append(Character)
		
		
	
	for Monster in Monsters:
		Monster.Initiative = randi_range(0,15) + Monster.Wu_Wei
		if Monster.Stunned > 0:
			Monster.Initiative /= 2
		if Monster.Haste > 0:
			Monster.Initiative *= 2
		Combatants.append(Monster)
	
	Combatants.sort_custom(_Inititative_Sorter)


func _Inititative_Sorter(Combatant_1,Combatant_2):
	if Combatant_1.Initiative > Combatant_2.Initiative:
		return true
	elif  Combatant_1.Initiative > Combatant_2.Initiative:
		return 0 != randi_range(0,1)

func _Ability_Carry_Outer(Effects):
	
	for Effect in Effects:
		
		
		match Effect:
			
			Attack_Class:
				for Target in Effect.Targets:
					Effect.Hit_Result = await Hit_Classifier(Effect.Targets,Effect.User)
					if Effect.Hit_Result == 0:
						return
					
					
				
				
				
			Status_Class:
				
				match Effect.Type:
				
					"Affliction":
						for Target in Effect.Targets:
							
							match await Hit_Classifier(Effect.Targets,Effect.User):
								
								0:
									return
							
								1:
									pass
							
								2:
									pass
							
								3:
									pass
					
					
					
					"Buff":
						for Target in Effect.Targets:
							_Buff(Effect,Target)
					
					
					
					"Heal":
						for Target in Effect.Targets:
							_Healing(Effect,Target)
						
						
			
			
			
			
			_:
				Effect.get_object().call(Effect.get_method())
				
				
			
			
			








func Hit_Classifier(Target, User):
	var Hit_Status: int #0 = Miss, 1 = Parry, 2 = Hit, 3 = Crit
	var Crit: bool
	var Evade: bool
	var Parry: bool
	var Effective_Crit_Chance: int
	var Effective_Evade_Chance: int
	var Effective_Parry_Chance: int
	
	
	
	if randi_range(0,99) > Effective_Crit_Chance:
		Crit = true
	if randi_range(0,99) > Effective_Evade_Chance:
		Evade = true
	if randi_range(0,99) > Effective_Parry_Chance:
		Parry = true
	
	if Crit == true and Evade == true:
		Crit = false
		Evade = false
	if Crit == true and Parry == true:
		Crit = false
		Parry = false
	
	if Evade == true:
		Hit_Status = 0
	
	elif Parry == true:
		Hit_Status = 1
	
	
	elif Crit == true:
		Hit_Status = 3
	
	return Hit_Status
	


func _Attack_Damage(Target, Effect, User):
	pass
	
	
	

func _Healing(Effect, Targets):
	for Target in Targets:
		Target.hp += Effect.Heal

func _Buff(Effect,Target):
	
	for Status in Effect:
			Target[Status] += Effect.get(Status)
	
	
	
	
