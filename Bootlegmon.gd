extends Node2D

export (bool) var is_enemy = false
var type = "fire"

var health
var experience = 0
var level = 1

var mon_name

var is_fainted = false
var can_attack = false

var types = ["fire", "water", "grass"]

export (int) var max_hp = 10
export (int) var max_exp = 3
export (int) var atk = 5
export (int) var def = 5

signal attacked
signal evolved
signal no_dmg
signal got_dmg
signal got_effective_dmg
signal run
signal faint

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_type = randi() % types.size()
	type = types[random_type]
	mon_name = "Le" + type + "mon"
	health = max_hp
	if is_enemy:
		experience = 1

func change_enemy(animation):
	$AnimationPlayer.disconnect("animation_finished", self, "change_enemy")
	$Sprite.position = Vector2.ZERO
	is_fainted = false
	can_attack = false
	experience += 1
	health = max_hp
	var random_type = randi() % types.size()
	type = types[random_type]

func player_run_away():
	$Sprite.position = Vector2.ZERO
	is_fainted = false
	can_attack = false
	health = max_hp
	var random_type = randi() % types.size()
	type = types[random_type]
	print_debug(type, random_type)
	
func _process(delta):
	mon_name = "Le" + type + "mon"
	if !is_fainted:
		if health <= 0:
			emit_signal("faint")
			can_attack = false
			is_fainted = true
			if is_enemy:
				$AnimationPlayer.play("Faint_enemy")
				$AnimationPlayer.connect("animation_finished", self, "change_enemy")
			else:
				$AnimationPlayer.play("Faint")
		if can_attack and is_enemy:
			can_attack = false
			action()
			

func _effective_dmg(damage):
	var total_dmg = damage + 2 - def
	print_debug("effective", total_dmg)
	if total_dmg > 0:
		health -= total_dmg
		emit_signal("got_effective_dmg", total_dmg)
		$AnimationPlayer.play("Hurt")
	else:
		emit_signal("no_dmg")

func _not_effective_dmg(damage):
	var total_dmg = damage - def * 2
	print_debug("normal", total_dmg)
	if total_dmg > 0:
		health -= total_dmg
		emit_signal("got_dmg", total_dmg)
		$AnimationPlayer.play("Hurt")
	else:
		emit_signal("no_dmg")

func action():
	if is_enemy:
		$AnimationPlayer.play("Attack_enemy")
	else:
		$AnimationPlayer.play("Attack")
	emit_signal("attacked")

func run():
	emit_signal("run")

func hurt(attacker_type, damage):
	if !is_fainted:
		if (attacker_type == "water" and type == "fire") or (attacker_type == "fire" and type == "grass") or (attacker_type == "grass" and type == "water"):
			_effective_dmg(damage)
		else:
			_not_effective_dmg(damage)

func evolve():
	emit_signal("evolved")

func level_up():
	max_hp += 2
	max_exp += 3
	atk += 1
	def += 1
	health = max_hp
	experience = 0
	level += 1
	