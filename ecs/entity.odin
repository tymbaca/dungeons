package ecs

import rl "vendor:raylib"

BUFFER_SIZE :: 1024
ID_COUNT := 0
ID :: int

World :: distinct [dynamic]Entity

Entity :: struct {
	id:         ID,
	components: bit_set[ComponentKind],
}

new_entity :: proc(w: ^World, components: ..Component) {
	ID_COUNT += 1
	entity := Entity {
		id = ID_COUNT,
	}
	defer append(w, entity)

	for component in components {
		ck := resolve_and_add_component(entity.id, component)
		entity.components += {ck}
	}
}
