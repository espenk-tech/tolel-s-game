extends RichTextLabel
@onready var freeze_timer: Timer = $"../../freeze_timer"
@onready var clock_sound: AudioStreamPlayer2D = $clock_sound


@onready var textcolor = "[color=green]"

func _process(delta):
	if freeze_timer.time_left > 0:
		if freeze_timer.time_left > freeze_timer.wait_time * 0.75:
			textcolor = "[color=green]"
		elif freeze_timer.time_left > freeze_timer.wait_time * 0.5:
			textcolor = "[color=yellow]"
		elif freeze_timer.time_left > freeze_timer.wait_time * 0.25:
			textcolor = "[color=orange]"
		else:
			textcolor = "[color=red]"
		if freeze_timer.time_left < 10:
			text = "[b][font = mono]" + textcolor + str(freeze_timer.time_left).left(3)
		clock_sound.pitch_scale = 2 - freeze_timer.time_left*0.1

		if not clock_sound.playing:
			clock_sound.play()
	else:
		if clock_sound.pitch_scale != 0:
			clock_sound.pitch_scale = 0
		text = ""
