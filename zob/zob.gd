extends KinematicBody2D

const velocity = 200
const accel_threshold = 2
const wank_threshold = 10

var sperm_scn = preload("res://sperm/sperm.scn")
var spread_scn = preload("res://spread/spread.scn")
onready var balls = get_node("balls")
onready var penis = get_node("penis")
onready var cover = get_node("cover")
var left = false
var right = false
var down = false
var up = false
var fire_action = false;
var sperm_level = 0

func _ready():
	add_user_signal("sperm_increase")
	add_user_signal("sperm_decrease")
	set_meta("zob", true)
	set_process(true)
	set_process_input(true)

func _process(delta):
	set_balls()
	if fire_action:
		fire()
	var mov = Input.get_accelerometer()
	if left or mov.x > accel_threshold:
		move(Vector2(-velocity*delta, 0))
		penis.set_frame(1)
		cover.set_frame(1)
	elif right or mov.x < -accel_threshold:
		move(Vector2(velocity*delta, 0))
		penis.set_frame(2)
		cover.set_frame(2)
	else:
		penis.set_frame(0)
		cover.set_frame(0)
	if mov.y < -wank_threshold:
		down = true
	elif mov.y > wank_threshold and down:
		down = false
		sperm_level += 1
		play_random_fap()

func _input(event):
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("ui_down"):
		down = true
	elif Input.is_action_pressed("ui_up") and down:
		sperm_level += 1
		emit_signal("sperm_increase", sperm_level)
		play_random_fap()
		down = false
	if Input.is_action_pressed("Space"):
		fire_action = true
	if left and right:
		left = false
		right = false
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		fire_action = true
		
func fire():
	if sperm_level > 0:
		get_node("zob_player").play("splouch")
		var sperm = sperm_scn.instance()
		var sperm_pos = sperm.get_pos()
		sperm_pos.x = get_pos().x
		sperm_pos.y = get_pos().y - 80
		sperm.set_pos(sperm_pos)
		get_tree().get_root().add_child(sperm)
		var spread = spread_scn.instance()
		spread.set_emitting(true)
		var spread_pos = spread.get_pos()
		spread_pos.x = get_pos().x
		spread_pos.y = get_pos().y - 100
		spread.set_pos(spread_pos)
		get_tree().get_root().add_child(spread)
		sperm_level -= 1
		emit_signal("sperm_decrease", sperm_level)
	fire_action = false
	
func play_random_fap():
	var i = randi() % 7
	get_node("zob_player").play("fap"+str(i))

# Set balls frame according to sperm level
func set_balls():
	if sperm_level == 0:
		balls.set_frame(0)
	elif sperm_level < 10:
		balls.set_frame(1)
	elif sperm_level < 20:
		balls.set_frame(2)
	elif sperm_level < 30:
		balls.set_frame(3)
	elif sperm_level < 40:
		balls.set_frame(4)
	elif sperm_level < 50:
		balls.set_frame(5)
	else:
		balls.set_frame(6)