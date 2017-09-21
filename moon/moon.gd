extends PathFollow2D

const MODE_NEW_MOON = 0
const MODE_NORMAL_MOON = 1
const FULL_MOON = 2

var mode = MODE_NEW_MOON

var accum = 0

var moon_angle = 0

func _ready():
	set_process(true)
func _process(delta):
	accum += delta
	set_offset(get_offset() + delta * 5)