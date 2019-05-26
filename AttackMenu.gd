extends Control

export (NodePath) var Player
var actions_disabled = false
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node(Player)

func _process(delta):
	if dead:
		actions_disabled = true
	$HBoxContainer/Attack.set_disabled(actions_disabled)
	$HBoxContainer/Run.set_disabled(actions_disabled)

func _on_Timer_timeout():
	actions_disabled = false

func _do_player_action(action):
	actions_disabled = true
	if action == "atk":
		Player.action()
	elif action == "run":
		Player.run()
	$Timer.start()

func _on_Attack1_pressed():
	_do_player_action("atk")

func _on_Run_pressed():
	_do_player_action("run")
