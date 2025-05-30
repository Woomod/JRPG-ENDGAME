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
var Living_Chars: int
var Everyone_Acted: int:
	set(Everyone_Acted):
		if Everyone_Acted == Living_Chars:
			_Action_Carry_Out_Phase()

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
		var Initiative_Roll = randi_range(0,15)
		if Character.Off_Balance == true:
			Initiative_Roll = 0
		
		Character.Initiative = Initiative_Roll + Character.Wu_Wei
		if Character.Stunned > 0:
			Character.Initiative /= 2
		if Character.Haste > 0:
			Character.Initiative *= 2
		Combatants.append(Character)
		
		
	
	for Monster in Monsters:
		var Initiative_Roll = randi_range(0,15)
		if Monster.Off_Balance == true:
			Initiative_Roll = 0
		if Monster.Stunned > 0:
			Monster.Initiative /= 2
		if Monster.Haste > 0:
			Monster.Initiative *= 2
		Combatants.append(Monster)
	
	Combatants.sort_custom(_Inititative_Sorter)
	_Action_Select_Phase()

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
					_Attack_Damage(Effect.Targets,Effect,Effect.User)
					
				
				
				
			Status_Class:
				
				match Effect.Type:
				
					"Affliction":
						for Target in Effect.Targets:
							_Affliction_Check()
					
					"Buff":
						for Target in Effect.Targets:
							_Buff(Effect,Target)
					
					
					
					"Heal":
						for Target in Effect.Targets:
							_Healing(Effect,Target)
						
						
			
			
			
			
			_: #We Can't access Callables Out of the Gate. Well I realized can do it via string through Effect[] But this is also cleaner I feel.
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
	
	else:
		Hit_Status = 2
	
	return Hit_Status



func _Attack_Damage(Target, Effect, User):
	
	var Damage: int
	if Effect.Attack > 0:
		Damage = ((Effect.Base_Damage * User.Attack) / Target.Defence)
		Target.Current_Hp -= Damage
	
	if Effect.Magic > 0:
		Damage = ((Effect.Base_Damage * User.Magic) / Target.Resistance)
		Target.Current_Hp -= Damage
	
	if Target.Dazed == true: #If dazed is true, this multiplies Damage by 2 for the speed break Check. Comes after Damage is Applied so no harm done.
		Damage *=2
	
	Target.Initiative /= int(Damage/25)


func _Healing(Effect, Targets):
	for Target in Targets:
		Target.hp += Effect.Heal

func _Buff(Effect,Target):
	
	for Status in Effect:
			Target[Status] += Effect.get(Status)


func _Affliction_Check():
	pass

func _Action_Select_Phase():
	var Multi_Thread = Thread.new()
	
	add_child(Multi_Thread)
	
	for Combatant in Player_Characters:
		Combatant.Action_Needs_Selected = true
	
	Multi_Thread.start(_Monster_Action_Select(Multi_Thread))

func _Monster_Action_Select(The_Thread):
	for Monster in Monsters:
		pass
	The_Thread.queue_free()
	



func _Action_Carry_Out_Phase():
	for Combatant in Combatants:
		_Ability_Carry_Outer(Combatant.Ability_Selected)
		
		
