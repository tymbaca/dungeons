package entity

import c "../component"
import rl "vendor:raylib"

ID_COUNT := 0
ID :: int

World :: distinct [dynamic]Entity

Entity :: struct {
	id:         ID,
	components: bit_set[c.ComponentKind],
}

new_entity :: proc(w: ^World, components: ..c.Component) {
	ID_COUNT += 1
	entity := Entity {
		id = ID_COUNT,
	}
	defer append(w, entity)

	for component in components {
		ck := c.resolve_and_add_component(entity.id, component)
		entity.components += {ck}
	}
}
