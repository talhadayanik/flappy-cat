extends CharacterBody2D

const UP = Vector2(0,-1)
const FLAP = 230.0
const MAX_FALL_SPEED = 500.0
const GRAVITY = 12.0

var wall = preload("res://wall_node.tscn")
var score = 0
var wall_distance = 150

@onready var jumpSprite = $jump
@onready var fallSprite = $fall
@onready var loseParticle = get_parent().get_parent().get_node("lose_particle")

@onready var goPanel = get_parent().get_parent().get_node("Panel")
@onready var goScore = get_parent().get_parent().get_node("Panel/ScoreLabel")
@onready var goBestScore = get_parent().get_parent().get_node("Panel/BestScoreLabel")
@onready var goAnim = get_parent().get_parent().get_node("Panel/PopupAnimation")
		
func _physics_process(delta):
	if Global.gameOver == true:
		velocity = Vector2(0,0)
	if velocity.y < 0 and !Global.gameOver:
		jumpSprite.visible = true
		fallSprite.visible = false
	elif velocity.y >= 0 and !Global.gameOver:
		jumpSprite.visible = false
		fallSprite.visible = true
		
	velocity.y += GRAVITY
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
		
	if Input.is_action_just_pressed("FLAP"):
		velocity.y = -FLAP
		
	move_and_slide()
	
	if $Timer.is_stopped(): spawn_wall()
	
	loseParticle.position.x = position.x
	loseParticle.position.y = position.y
	get_parent().get_parent().get_node("CanvasLayer/ScoreLabel").text = str(score)

func spawn_wall():
	$Timer.start()
	var wall_instance = wall.instantiate()
	wall_instance.position = Vector2(225, randf_range(-90,90))
	get_parent().call_deferred("add_child",wall_instance)
	
func _on_resetter_body_entered(body):
	if body.name == "Walls": 
		body.queue_free()

func _on_detect_area_entered(area):
	if area.name == "PointArea":
		score += 1

func _on_detect_body_entered(body):
	if body.name == "Walls":
		Global.gameOver = true
		jumpSprite.visible = false
		fallSprite.visible = false
		loseParticle.emitting = true
		var best_score = Global.load_score()
		if score > best_score:
			best_score = score
			Global.save_score(best_score)
		goScore.text = "SCORE: " + str(score)
		goBestScore.text = "BEST: " + str(best_score)
		goPanel.visible = true
		goAnim.play("popup")
