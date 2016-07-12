extends Node

const SAVEFILE = "user://mabite.save"

var current_scene = null
var score = 0
var play_time = 0
var first_time = false
var highscore_names = ["Zob", "Zob", "Zob", "Zob", "Zob"]
var highscore_scores = [500, 300, 250, 100, 10]

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	load_game()
	
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
	savegame.open_encrypted_with_pass(SAVEFILE, File.WRITE, OS.get_unique_ID())
	var data = {
		highscore_names=highscore_names,
		highscore_scores=highscore_scores
	}
	savegame.store_var(data)
	savegame.close()
	
func load_game():
	var savegame = File.new()
	if not savegame.file_exists(SAVEFILE):
		first_time = true
		return
	var curLine = {}
	savegame.open_encrypted_with_pass(SAVEFILE, File.READ, OS.get_unique_ID())
	var data = savegame.get_var()
	highscore_names = data["highscore_names"]
	highscore_scores = data["highscore_scores"]
	savegame.close()