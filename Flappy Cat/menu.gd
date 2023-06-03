extends Node2D

@onready var playLabel = $CanvasLayer/PlayLabel
@onready var BestScoreLabel = $CanvasLayer/BestScoreLabel
	
func _ready():
	var best_score = Global.load_score()
	BestScoreLabel.text = "BEST SCORE: " + str(best_score)
	
func _process(delta):		
	if $CanvasLayer/Timer.is_stopped():
		if playLabel.position.y == 50:
			hover_tween(playLabel, 25)
			$CanvasLayer/Timer.start()
		if playLabel.position.y == 25:
			hover_tween(playLabel, 50)
			$CanvasLayer/Timer.start()
		
func hover_tween(node, target):
	var tween = get_tree().create_tween()
	tween.tween_property(node,"position:y",target,0.7)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.play()


func _on_button_button_up():
	get_tree().change_scene_to_file("res://world.tscn")
