extends Spatial

onready var delay_timer = $DelayTimer
onready var single_fire = $SingleFireGun
onready var animation = $AnimationPlayer

var can_fire: bool = true
var firing: bool = false

func _ready() -> void:
	delay_timer.connect("timeout", self, "_reload")
	var parent_transform = get_parent().global_transform
	look_at(parent_transform.origin - parent_transform.basis.z * 500, parent_transform.basis.y)


func _process(delta: float) -> void:
	var aim_position = global_transform.origin - global_transform.basis.z * 100
	var pos = get_viewport().get_camera().unproject_position(aim_position)
	$Crosshair.rect_position = pos - 0.5 * $Crosshair.rect_size



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and single_fire.can_fire:
		single_fire.open_fire()
		animation.play("fire")
		Events.emit_signal("gun_fired")


func _reload() -> void:
	can_fire = true
