extends Node2D

onready var transition_rect = $CanvasLayer/SceneTransitionRect

func _on_Button_pressed():
    transition_rect.transition_to("res://scenes/World.tscn")
    
