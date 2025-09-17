extends Node2D

@export var mainGame: PackedScene
@export var winPanel: PackedScene

var currentGame
var currentWinPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func win():
	currentGame.queue_free()
	currentWinPanel = winPanel.instantiate()
	add_child(currentWinPanel)
	currentWinPanel.restart.connect(restart)
	
func restart():
	currentWinPanel.queue_free()
	start()
	
func start():
	currentGame = mainGame.instantiate()
	add_child(currentGame)
	currentGame.win.connect(win)
