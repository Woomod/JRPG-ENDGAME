extends Entity_Base


#Abilities is formatted as a Array of Dicts, the first 3 places are Name, Initiative Cost, Tp Cost >>
#Effects are set under the ready func by creating a new Attack or Status and setting its stats.
# Special Effects are functions that Take the place of Attack or Status, do to it's own effect, they 

var Func = Callable(self,"_Special_Thingy")

var Atk_Check = Attack_Class.new()

var Ability_1_Attack_1 = Attack_Class.new()
var Abilitie_Reference = [{"Ability_1": "Name", "Initiative_Cost": int(), "Tp_Cost": int(), "Effects": [],"User": self}]
var Check = "Level"

func _ready():
	Name = "Butt"
	Evade_Chance = 10
	Level = 10
	Attack = 10
	
	add_child(Atk_Check)
	Atk_Check.Attack = 10 + Attack
	
	
	
	
	

func _Special_Thingy():
	print("Yummy")


func _process(delta: float) -> void:
	
	pass
