extends StaticBody2D

func _physics_process(delta):
	if !Global.gameOver:
		position += Vector2(-1.5,0)
	
