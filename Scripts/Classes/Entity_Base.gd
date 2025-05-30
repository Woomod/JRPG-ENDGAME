extends Node2D

class_name Entity_Base



#Meta Non Stat Stuff
var Selected_Ability: int
var Action_Needs_Selected: bool

#Basics
var Level: int
var Name: String
var Vitality: int
var Difficulty_Mod: float
var Max_Hp: int = (Vitality * Level * Difficulty_Mod)
var Current_Hp: int
var Wu_Wei: int
var Initiative: int:
	set(Initiative):
		if Initiative >0:
			Speed_Broke = false
			
		if Initiative <= 0:
			Speed_Broke = true
			Has_Acted = true
var Has_Acted: bool
var Abilities = [{"Ability_1": "Name", "Initiative_Cost": int(), "Tp_Cost": int(), "Effects": []}]
var Speed_Broke: bool:
	set(Speed_Broke):
		if Speed_Broke == true:
			pass #Placeholder in case we want to add a message or whatever to integrate that. Also for testing and as a reminder.


var Attack: int:
	set(Attack): print("Hype")


var Defence: int
var Magic: int
var Resistance: int

var Affliction_Chance: int

var Base_Crit_Chance: int:
	set(Base_Crit_Chance):
		if Blinded != 0:
			Crit_Chance = Base_Crit_Chance
var Crit_Chance: int
var Evade_Chance: int
var Parry_Chance: int
var Fortitude_Chance: int


#Statuses
# Above 0 means it is active, counts down every round. Easier to track that way
var Haste: int:
	set(Haste):
		if Haste > 0:
			for Ability in Abilities:
				Ability.Initiative_Cost *= 2
		if Haste == 0:
			for Ability in Abilities:
				Ability.Initiative_Cost /= 2


var Deflect: int:
	set(Deflect):
		if Deflect > 0:
			Evade_Chance += 15
			Parry_Chance += 30
			
		if Deflect == 0:
			Evade_Chance -= 15
			Parry_Chance -= 30

var Focused: int:
	set(Focused):
		if Focused >0:
			Base_Crit_Chance += 30
		if Focused == 0:
			Base_Crit_Chance -= 30

var Mighty: int:
	set(Mighty):
		if Mighty > 0:
			Attack *= 1.5
			Magic *= 1.5
			
		if Mighty == 0:
			Attack = Attack/1.5
			Magic = Magic/1.5

var Protect: int:
	set(Protect):
		if Protect > 0:
			Defence *= 1.5
			Resistance *= 1.5
		if Protect == 0:
			Defence = Defence/1.5
			Resistance = Resistance/1.5

var Aegis: int:
	set(Aegis):
		if Aegis > 0:
			Defence * 2
		if Aegis == 0:
			Defence = Defence/2

var Barrier: int:
	set(Barrier):
		if Barrier > 0:
			Resistance = Resistance / 2
		if Barrier == 0:
			Resistance *= 2

var Regen: int

var Stunned: int:
	set(Stunned):
		if Stunned > 0:
			for Ability in Abilities:
				Ability.Initiative_Cost /= 2
				
		if Stunned == 0:
			for Ability in Abilities:
				Ability.Initiative_Cost *= 2

var Winded: int:
	set(Winded):
		if Winded > 0:
			for Ability in Abilities:
				Ability.Initiative_Cost = Ability.Initiative_Cost * 2
				Ability.Tp_Cost = Ability.Tp_Cost * 2
		if Winded == 0:
			for Ability in Abilities:
				Ability.Initiative_Cost = Ability.Initiative_Cost / 2
				Ability.Tp_Cost = Ability.Tp_Cost / 2

var Dazed: int #Done in Encounter Manager

var Weakened: int:
	set(Weakened):
		if Weakened > 0:
			Attack = Attack/1.5
			Magic = Magic / 1.5
		if Weakened == 0:
			Attack *= 1.5
			Magic *= 1.5

var Vulnerable: int:
	set(Vulnerable):
		if Vulnerable > 0:
			Defence = Defence/1.5
			Resistance = Resistance/1.5

var Blinded: int:
	set(Blinded): 
		if Blinded > 0:
			Crit_Chance = 0
			if Blinded == 0:
				Crit_Chance = Base_Crit_Chance

var Cursed: int:
	set(Cursed):
		if Cursed > 0:
			Fortitude_Chance - 30
		if Cursed == 0:
			Fortitude_Chance + 30

var Strength_Break: int:
	set(Strength_Break):
		if Strength_Break > 0:
			Attack = Attack/1.5
			Defence = Defence / 1.5


var Magic_Break: int:
	set(Magic_Break):
		if Magic_Break > 0:
			Magic /= 1.5
			Resistance /= 1.5
		if Magic_Break == 0:
			Magic *= 1.5
			Resistance *= 1.5


var Off_Balance: bool # Is Done in Encounter_Manager



	
	
	
	
	
	
	
	
	
	
	
