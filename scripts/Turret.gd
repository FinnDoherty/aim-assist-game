extends Node2D

export var turretNumber = 0

signal turret_entered
signal turret_exited

func _ready():
    pass

func _on_area_body_entered(body):
    $button.frame = 1
    emit_signal("turret_entered", turretNumber)
    
func _on_area_body_exited(body):
    $button.frame = 0
    emit_signal("turret_exited")

func on_turret_fire(turretShooting, hit):
    if (turretNumber == turretShooting):
        $AnimationPlayer.play("shoot")
