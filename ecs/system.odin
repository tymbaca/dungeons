package ecs

import rl "vendor:raylib"

System :: proc(w: ^World)

run_all_systems :: proc(w: ^World) {
	movement_system(w)
	health_regenerate_system(w)
	velocity_system(w)
	render_system(w)
}

velocity_system :: proc(w: ^World) {
	for e in w {
		if e.components >= {.POSITION, .VELOCITY} {
			pos, vel := PositionMap[e.id], VelocityMap[e.id]
			pos += Position(vel)
		}
	}
}

movement_system :: proc(w: ^World) {
	for e in w {
		if e.components >= {.MOVEMENT, .POSITION} {
			movement := MovementMap[e.id]

			diff: rl.Vector2 = {}
			if rl.IsKeyDown(.W) {
				diff += {0, -1}
			}
			if rl.IsKeyDown(.S) {
				diff += {0, 1}
			}
			if rl.IsKeyDown(.A) {
				diff += {-1, 0}
			}
			if rl.IsKeyDown(.D) {
				diff += {1, 0}
			}

			// Add movement diff to current force
			change := rl.Vector2Normalize(diff) * movement.speed
			PositionMap[e.id] += Position(change)
		}
	}
}

health_regenerate_system :: proc(w: ^World) {
	for e in w {
		if e.components >= {.HEALTH} {
			HealthMap[e.id] += 1
		}
	}
}

render_system :: proc(w: ^World) {
	for e in w {
		if e.components >= {.POSITION, .SHAPE, .DISPLAY} {
			display := &DisplayMap[e.id]
			if rl.IsKeyReleased(.SPACE) {
				display^ = !display^
			}

			if !display^ {
				continue
			}

			pos := PositionMap[e.id]
			shape := ShapeMap[e.id]
			switch s in shape {
			case Rectangle:
				rl.DrawRectanglePro({pos[0], pos[1], s.width, s.height}, {}, 0, rl.BEIGE)
			case Circle:
				rl.DrawCircleV(rl.Vector2(pos), s.radius, rl.BEIGE)
			}
		}
	}
}
