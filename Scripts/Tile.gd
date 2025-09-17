class_name Tile extends Area2D

@export var msg: String

signal on_click(slf: Node)

var machine: Machine 
var selected: bool

func _ready():
	select(false)

func kill():
	print(self)

func build(type: PackedScene) -> Machine:
	var created_machine = type.instantiate()
#	created_machine.position = position
	if machine != null:
		machine.queue_free()
	machine = created_machine
	add_child(created_machine)
	machine.enable(true)
	return machine

func destroy_machine():
	machine.queue_free()
	machine = null

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("mouse_click"):
		on_click.emit(self)

func select(b: bool):
	selected = b
	if b:
		$AnimatedSprite2D.play("select")
	else:
		$AnimatedSprite2D.play("default")


func _on_mouse_entered():
	if !selected:
		$AnimatedSprite2D.play("hover")
	
func _on_mouse_exited():
	if !selected:
		$AnimatedSprite2D.play("default")
