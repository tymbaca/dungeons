package system

import c "../component"
import e "../entity"
import rl "vendor:raylib"

System :: proc(w: ^e.World)

run_all_systems :: proc(w: ^e.World) {
	player_movement_system(w)
	health_regenerate_system(w)
	velocity_system(w)
	render_system(w)
}

velocity_system :: proc(w: ^e.World) {
	for e in w {
		if e.components >= {.POSITION, .VELOCITY} {
			pos, vel := c.PositionMap[e.id], c.VelocityMap[e.id]
			pos += c.Position(vel)
		}
	}
}

player_movement_system :: proc(w: ^e.World) {
	for e in w {
		if e.components >= {.PLAYER, .MOVEMENT, .MOVEMENT_STATE, .POSITION} {
			movement := c.MovementMap[e.id]
			state := c.MovementStateMap[e.id]

			diff: rl.Vector2 = {}
			if rl.IsKeyDown(.W) {
				diff += {0, -1}
				state = .UP
			}
			if rl.IsKeyDown(.S) {
				diff += {0, 1}
				state = .DOWN
			}
			if rl.IsKeyDown(.A) {
				diff += {-1, 0}
				state = .LEFT
			}
			if rl.IsKeyDown(.D) {
				diff += {1, 0}
				state = .RIGHT
			}

			// Add movement diff to current force
			change := rl.Vector2Normalize(diff) * movement.speed
			if change == {} {
				state = .IDLE
			}
			c.PositionMap[e.id] += c.Position(change)
		}
	}
}

health_regenerate_system :: proc(w: ^e.World) {
	for e in w {
		if e.components >= {.HEALTH} {
			c.HealthMap[e.id] += 1
		}
	}
}

render_system :: proc(w: ^e.World) {
	for e in w {
		if e.components >= {.POSITION, .SHAPE, .DISPLAY} {
			display := &c.DisplayMap[e.id]
			if rl.IsKeyReleased(.SPACE) {
				display^ = !display^
			}

			if !display^ {
				continue
			}

			pos := c.PositionMap[e.id]
			shape := c.ShapeMap[e.id]
			switch s in shape {
			case c.Rectangle:
				rl.DrawRectanglePro({pos[0], pos[1], s.width, s.height}, {}, 0, rl.BEIGE)
			case c.Circle:
				rl.DrawCircleV(rl.Vector2(pos), s.radius, rl.BEIGE)
			}
		}
	}
}
