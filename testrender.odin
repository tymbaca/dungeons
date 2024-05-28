package main

import c "ecs/component"
import e "ecs/entity"
import s "ecs/system"

f :: proc() {
	player := e.new_entity(&WORLD, c.Position{}, c.Movement{5}, c.Player{})
}
