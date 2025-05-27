extends Entity_Base


#Abilities is formatted as a dicitonary of Arrays, the first 3 places are Name, Initiative Cost, Tp Cost >>
#Effects are set under the ready func by creating a new Attack or Status and setting its stats.
# Special Effects are functions that Take the place of Attack or Status, do to it's own effect, they 

var Func = Callable(self,"_Special_Thingy")

var Ability_1_Attack_1 = Attack_Class.new()
var Abilities = [{"Ability_1": "Name", "Initiative_Cost": int(), "Tp_Cost": int(), "Effects": []}]
var Check = "Level"
var Ear

func _ready():
	Name = "Butt"
	Evade_Chance = 10
	Level = 10
	
	
	

func _Special_Thingy():
	print("Yummy")
