class_name DuelFoe extends Node2D
const ENEMY_COUNT:int = 6

@export var enemies: Array[DuelEnemy]

func set_state(state: DuelState):
	var count = ENEMY_COUNT if state.foe_enemies.size() > ENEMY_COUNT else state.foe_enemies.size()
	for i in range(count):
		set_enemy(state.foe_enemies[i], i)

func set_enemy(enemy: Enemy, index: int):
	enemies[index].set_enemy(enemy)
