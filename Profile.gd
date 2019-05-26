extends Control

func set_values(name, hp, max_hp, xp, max_xp, level, type):
	$HBoxContainer/VBoxContainer/Name.text = name
	$HBoxContainer/VBoxContainer/HBoxContainer/Health.max_value = max_hp
	$HBoxContainer/VBoxContainer/HBoxContainer/Health.value = hp
	$HBoxContainer/VBoxContainer/HBoxContainer2/Exp.max_value = max_xp
	$HBoxContainer/VBoxContainer/HBoxContainer2/Exp.value = xp
	$HBoxContainer/Level.text = "Lvl: " + str(level)

func set_hp(hp):
	$HBoxContainer/VBoxContainer/HBoxContainer/Health.value = hp

func set_xp(xp):
	$HBoxContainer/VBoxContainer/HBoxContainer2/Exp.value = xp

