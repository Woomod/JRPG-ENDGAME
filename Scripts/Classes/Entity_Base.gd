extends Node2D

class_name Entity_Base


#Basics
var Level: int
var Name: String
var Vitality: int
var Difficulty_Mod: float
var Max_Hp: int = (Vitality * Level * Difficulty_Mod)
var Current_Hp: int
var Wu_Wei: int
var Initiative: int
var Has_Acted: bool

var Attack: int
var Deffence: int
var Magic: int
var Resistance: int

var Affliction_Chance: int
var Crit_Chance: int
var Evade_Chance: int
var Parry_Chance: int
var Fortitude_Chance: int


#Statuses
# Above 0 means it is active, counts down every round. Easier to track that way
var Haste: int
var Deflect: int
var Focused: int
var Mighty: int
var Protect: int
var Aegis: int
var Barrier: int
var Regen: int

var Stunned: int
var Winded: int
var Dazed: int
var Weakened: int
var Vulnerable: int
var Blinded: int
var Cursed: int
var Strength_Break: int
var Magic_Break: int
var Off_Balance: bool



	
	
	
	
	
	
	
	
	
	
	
