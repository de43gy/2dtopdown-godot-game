extends CanvasLayer

@export var arena_time_manager: Node
@onready var label: Label = %Label

func _process(_delta: float) -> void:
	if arena_time_manager == null:
		return
	
	var time_elapsed = arena_time_manager.get_time_elapsed()
	label.text = format_timer(time_elapsed)

func format_timer (seconds: float):
	var minutes := floori(seconds / 60)
	var remaining_seconds := floori(int(seconds) % 60)
	return "%02d:%02d" % [minutes, remaining_seconds]
