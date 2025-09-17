extends TextureButton

var on_mouse: bool
var mouse_down: bool

func _ready():
	$Label.label_settings = $Label.label_settings.duplicate()
	on_mouse = false
	mouse_down = false
	update_text()

func update_text_content(v: int):
	$Label.text = "%d $" % v

func update_text():
	var lable_setting: LabelSettings = $Label.label_settings
	
	if on_mouse:
		lable_setting.font_color = Color.GREEN
		if mouse_down:
			$Label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		else:
			$Label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	else:
		lable_setting.font_color = Color.LIGHT_GRAY
		$Label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	

func update_font_color(total_money : int):
	var lable_setting: LabelSettings = $Label.label_settings

func enable(b: bool):
	if b:
		disabled = false
	else:
		disabled = true
		$Label.text = ""

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
