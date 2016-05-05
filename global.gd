extends Node

var current_scene = null
var score = 0
var play_time = 0

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func save_game():
	var savegame = File.new()
	savegame.open("user://mabite.save", File.WRITE)
	var data = {
		score=score
	}
	savegame.store_line(data.to_json())
	savegame.close()
	
func load_game():
	var savegame = File.new()
	if !savegame.file_exists("user://mabite.save"):
		return
	var curLine = {}
	savegame.open("user://mabite.save", File.READ)
	while (!savegame.eof_reached()):
		curLine.parse_json(savegame.get_line())
		