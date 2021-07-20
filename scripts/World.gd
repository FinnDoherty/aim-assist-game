extends Node2D

onready var transition_rect = $CanvasLayer/SceneTransitionRect
onready var Enemy = preload("res://scenes/Enemy.tscn")

onready var positions = [
    $Position2D1,
    $Position2D2,
    $Position2D3,
    $Position2D4,
    $Position2D5
]

var enemies = [[],[],[],[],[]]

func _ready():
    randomize()
    $Turrets/Turret1.connect("turret_entered", $panel, "on_turret_entered")
    $Turrets/Turret2.connect("turret_entered", $panel, "on_turret_entered")
    $Turrets/Turret3.connect("turret_entered", $panel, "on_turret_entered")
    $Turrets/Turret4.connect("turret_entered", $panel, "on_turret_entered")
    $Turrets/Turret5.connect("turret_entered", $panel, "on_turret_entered")
    
    $Turrets/Turret1.connect("turret_exited", $panel, "on_turret_exited")
    $Turrets/Turret2.connect("turret_exited", $panel, "on_turret_exited")
    $Turrets/Turret3.connect("turret_exited", $panel, "on_turret_exited")
    $Turrets/Turret4.connect("turret_exited", $panel, "on_turret_exited")
    $Turrets/Turret5.connect("turret_exited", $panel, "on_turret_exited")
    
    $panel.connect("turret_fire", self, "on_turret_fire")
    $panel.connect("turret_fire", $Turrets/Turret1, "on_turret_fire")
    $panel.connect("turret_fire", $Turrets/Turret2, "on_turret_fire")
    $panel.connect("turret_fire", $Turrets/Turret3, "on_turret_fire")
    $panel.connect("turret_fire", $Turrets/Turret4, "on_turret_fire")
    $panel.connect("turret_fire", $Turrets/Turret5, "on_turret_fire")

    [$music1, $music2][randi() % 2].play()
    Global.score = 0
    addEnemy(2)   
    
func addEnemy(laneIndex):
    var e = Enemy.instance()
    add_child(e)
    enemies[laneIndex].append(e)
    
    e.transform = positions[laneIndex].global_transform
    Global.mobInLanes[laneIndex] += 1
    
func on_turret_fire(i, hit):
    if hit:
        Global.mobInLanes[i] -= 1
        enemies[i][0].die()
        enemies[i].remove(0)
        $score.text = str(Global.score)
    
func _on_Timer_timeout():
    addEnemy(randi() % 5)

func _on_crossing_line_body_entered(body):
    body.die()
    yield(get_tree().create_timer(0.5), "timeout")
    if (is_instance_valid(body)):
        transition_rect.transition_to("res://scenes/Game Over.tscn")
    

func _on_IncreaseDifficulty_timeout():
    $Timer.wait_time -= 0.2


func _on_music1_finished():
    $music2.play()

func _on_music2_finished():
    $music1.play()
