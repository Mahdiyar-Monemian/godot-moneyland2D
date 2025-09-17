extends Node2D

@export var selected_tile: Tile
@export var money: int = 10
@export var win_money: int = 1000
var machineResourses : Array[MachineResourse]

@onready var placed_machines = 0

signal win

func update_buttons_font_color():
	get_tree().call_group("BuyMachineButton", "update_font_color", money)

# Called when the node enters the scene tree for the first time.
func _ready():
	change_money(0)
	var m_buttons = $HUD/BuyPanel.get_children()
	for i in 3:
		machineResourses.append(load("res://Resources/machine%d.tres" % i))
	for i in 3:
		m_buttons[i].update_text_content(machineResourses[i].price)
	update_buttons_font_color()
	for t in get_tree().get_nodes_in_group("tiles"):
		t.on_click.connect(_on_tile_click)
		

func _on_tile_click(slf: Node):
	
	if selected_tile:
		selected_tile.select(false)
	if selected_tile == slf:
		selected_tile = null
		update_hud()
		return
	selected_tile = slf
	selected_tile.select(true)
	update_hud()

func update_hud():
	if selected_tile == null:
		$HUD.ready_to_buy(false)
		$HUD.show_stats(false)
		return
	
	if selected_tile.machine == null:
		$HUD.ready_to_buy(true)
	else:
		if placed_machines > 1:
			$HUD.show_stats(true, selected_tile.machine.sell_value)
		else:
			$HUD.ready_to_buy(false)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("space"):
		get_tree().call_group("tiles", "select", false)
		selected_tile = null
		update_hud()
	
	#CHEAT
	if Input.is_key_pressed(KEY_F3):
		change_money(10)

func change_money(amount: int):
	money += amount
	$HUD/TextureRect/MoneyText.set_text("%d $" % money)
	$HUD/MoneyBar.value = float(money) / float(win_money)
	update_buttons_font_color()
	if money >= win_money:
		win.emit()

func _on_hud_buy(type):
	var machine = machineResourses[type]
	if money >= machine.price:
		placed_machines += 1
		var new_machine = selected_tile.build(machine.scene)
		new_machine.on_money_generated.connect(change_money)
		change_money(-machine.price)
		update_hud()


func _on_sell_button_pressed():
	placed_machines -= 1
	change_money(selected_tile.machine.sell_value)
	selected_tile.destroy_machine()
	selected_tile.select(false)
	selected_tile = null
	update_hud()
	

