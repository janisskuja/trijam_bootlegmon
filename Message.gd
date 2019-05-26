extends Control

func showMsg(msg):
	$Label.text = msg
	$Timer.start()

func _on_Timer_timeout():
	$Label.text = ""
