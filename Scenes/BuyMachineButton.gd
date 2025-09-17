extends TextureButton

var value: int
var on_mouse: bool
var mouse_down: bool
var enough_to_buy: bool

func _ready():
	$Label.label_settings = $Label.label_settings.duplicate()
	on_mouse = false
	mouse_down = false
	update_text()

func update_text_content(v: int):
	value = v
	$Label.text = "%d" % value
	update_text()

func update_text():
	if(disabled):
		$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		return
		
	var lable_setting: LabelSettings = $Label.label_settings
	
	if on_mouse:
		if mouse_down:
			$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		else:
			$Label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	else:
		$Label.vertical_alignment = VERTICAL_ALIGNMENT_TOP

func enable(b: bool):
	if b:
		disabled = false
	else:
		disabled = true
	update_font_color()
	update_text()

func update_font_color(total_money : int = -1):
	if total_money != -1:
		enough_to_buy = (total_money >= value)
	
	var lable_setting: LabelSettings = $Label.label_settings
	if(disabled):
		if enough_to_buy:
			lable_setting.font_color = Color.DARK_GRAY
		else:
			$Label.label_settings.font_color = Color.hex(0x595652ff)
	else:
		if enough_to_buy:
			lable_setting.font_color = Color.GREEN
		else:
			lable_setting.font_color = Color.DARK_GRAY


func _on_mouse_entered():
	on_mouse = true
	update_text()

func _on_mouse_exited():
	on_mouse = false
	update_text()

func _on_button_down():
	mouse_down = true
	update_text()

func _on_button_up():
	mouse_down = false
	update_text()
