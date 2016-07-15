extends Node

const SAVEFILE = "user://mabite.save"

var current_scene = null
var score = 0
var play_time = 0
var first_time = false
var highscore_names = ["Zob", "Zob", "Zob", "Zob", "Zob"]
var highscore_scores = [500, 300, 250, 100, 0]

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
	
func is_highscore():
	for i in highscore_scores:
		if score > i:
			return true
	return false
	
func add_highscore(score, name):
	var new_scores = []
	var new_names = []
	for i in range(highscore_scores.size()):
		if score >= highscore_scores[i]:
			new_scores.append(score)
			new_names.append(name)
		new_scores.append(highscore_scores[i])
		new_names.append(highscore_names[i])
	new_names.resize(5)
	new_scores.resize(5)
	highscore_names = new_names
	highscore_scores = new_scores