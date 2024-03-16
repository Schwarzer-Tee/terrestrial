extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var tex = Engine.get_frames_per_second()
	text = str(tex)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tex = Engine.get_frames_per_second()
	text = "FPS: "+str(tex)
	pass
