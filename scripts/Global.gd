extends Node

var mobInLanes = [0, 0, 0, 0, 0]
var score = 0

func _ready():
    pass

func addMob(laneIndex):
    mobInLanes[laneIndex] += 1
    
func isMobInLane(laneIndex):
    return mobInLanes[laneIndex] > 0

func addToScore():
    score += 25
