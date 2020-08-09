extends Spatial

var previous: int = -1


func _ready() -> void:
	Events.connect("target_hit", self, "_raise_target")
	_raise_target()


func _raise_target() -> void:
	var new_target = _choose_target()
	if new_target == previous:
		new_target = (new_target + 1) % get_child_count()
	previous = new_target
	get_child(new_target).up()


func _choose_target() -> int:
	return randi() % get_child_count()
