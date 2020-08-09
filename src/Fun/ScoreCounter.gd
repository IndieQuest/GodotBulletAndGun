extends Viewport

var score: int = 0
var shoots: float = 0

func _ready() -> void:
	Events.connect("target_hit", self, "_on_hit")
	Events.connect("gun_fired", self, "_on_fire")
	_update_board()


func _on_hit() -> void:
	score += 1
	_update_board()


func _on_fire() -> void:
	shoots += 1
	yield(get_tree().create_timer(0.5), "timeout")
	_update_board()

func _update_board() -> void:
	$Score/HBoxContainer/Score/Count.text = str(score)
	
	var acc = score / shoots if shoots else 0.0
	$Score/HBoxContainer/Accuracy/Count.text = str("%d" % [acc * 100], "%")
	render_target_update_mode = Viewport.UPDATE_ONCE
