extends Node
class_name Spells



static func cast_spell(my_party : Party, enemy_party : Party, caster : Unit, target : Unit, 
						spell : Global.Spell_Enum):
	
	match spell:
		Global.Spell_Enum.Piss:
			if (caster.manah <= 0):
				return
			print(caster.title + " is pissing on " + target.title + "\n")
			caster.manah = caster.manah * 2 / 3
			print("   " + caster.title + " has " + str(caster.manah) + "/" + str(caster.max_manah) + " mnha")
			target.c_hp -= 1
			print("   " + target.title + " has " + str(target.c_hp) + "/" + str(target.max_hp) + " hp")
		Global.Spell_Enum.Rocket:
			if (caster.c_hp <= 0):
				return
			print(caster.title + " launches a rocket at " + target.title + "\n")
			caster.c_hp -= 100
			print("   " + caster.title + " has " + str(caster.c_hp) + "/" + str(caster.max_hp) + " hp")
			target.c_hp -= 100
			print("   " + target.title + " has " + str(target.c_hp) + "/" + str(target.max_hp) + " hp")
		_:
			print("spell not found")
	

