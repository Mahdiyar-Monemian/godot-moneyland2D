class_name Machine extends AnimatedSprite2D

@export var index : int
var amount
var sell_value: int
var generating_money = false
signal on_money_generated(amount:int)


# Called when the node enters the scene tree for the first time.
func _ready():
	var machineResource :MachineResourse = load("res://Resources/machine%d.tres" % index)
	amount = machineResource.amount
	sell_value = machineResource.sell_value
	play("default")
	$GenerateTimer.wait_time = machineResource.rate
	$GenerateTimer.start()

func enable(b: bool):
	set_process(b)
	visible = b
	if b:
		$GenerateTimer.start()
	else:
		$GenerateTimer.stop()

func _on_generate_timer_timeout():
	play("generate")
	generating_money = true
	$GenerateTimer.paused = true


func _on_animation_finished():
	if generating_money:
		play("default")
		generating_money = false
		$GenerateTimer.paused = false
		on_money_generated.emit(amount)
