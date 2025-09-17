extends CanvasLayer
signal buy(type: int)

func ready_to_buy(b: bool):
	if b:
		for c in $BuyPanel.get_children():
			c.enable(true)
		$StatsPanel/SellButton.enable(false)
	else:
		for c in $BuyPanel.get_children():
			c.enable(false)

func show_stats(b: bool, v:int = 0):
	if b:
		for c in $BuyPanel.get_children():
			c.enable(false)
		$StatsPanel/SellButton.enable(true)
		$StatsPanel/SellButton.update_text_content(v)
	else:
		$StatsPanel/SellButton.enable(false)

func _ready():
	ready_to_buy(false)
	show_stats(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_buy_m_button_0_pressed():
	buy.emit(0)
	
func _on_buy_m_button_1_pressed():
	buy.emit(1)

func _on_buy_m_button_2_pressed():
	buy.emit(2)


