extends Node2D

var evolve_messages = [
	"Your Bootlegmon grew a 3rd hair",
	"Your Bootlegmon is evolved into... the same thing, because evolution takes 1000s of years",
	"Your Bootlegmon evolved into.. a slight older Bootlegmon!",
	"Your Bootlegmon reflects on his life choices!"
]

func _process(delta):
	$CanvasLayer/Player_profile.set_values($Player.mon_name, $Player.health, $Player.max_hp, $Player.experience, $Player.max_exp, $Player.level, $Player.type)
	$CanvasLayer/Enemy_profile.set_values($Enemy.mon_name, $Enemy.health, $Enemy.max_hp, $Enemy.experience, $Enemy.max_exp, $Enemy.level, $Enemy.type)
	if $Player.experience >= $Player.max_exp:
		$Player.level_up()
	if $Player.level % 5 == 0:
		$Player.evolve()
	if $Enemy.experience >= $Enemy.max_exp:
		$Enemy.level_up()

func _on_Player_attacked():
	$Enemy.hurt($Player.type, $Player.atk)
	$EnemyAtkTimer.start()

func _on_Enemy_faint():
	$Player.experience += 1

func _on_Enemy_attacked():
	print_debug("enemy attack")
	$Player.hurt($Enemy.type, $Enemy.atk)

func _on_EnemyAtkTimer_timeout():	
	$Enemy.can_attack = true

func _on_Player_run():
	$Enemy.player_run_away()

func _on_Player_faint():
	$CanvasLayer/Message.showMsg("Your Bootlegmon fainted, you black out!")
	$CanvasLayer/AttackMenu.actions_disabled = true
	$CanvasLayer/AttackMenu.dead = true

func _on_Player_evolved():
	var random_msg = randi() % evolve_messages.size()
	var msg = evolve_messages[random_msg]
	$CanvasLayer/Message.showMsg(msg)