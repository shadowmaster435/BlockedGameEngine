@tool
extends Node2D

var id = ""

func save():
	StateHelper.save_state(self, id)
