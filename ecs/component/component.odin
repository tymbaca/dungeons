package component

import "core:fmt"
import rl "vendor:raylib"

BUFFER_SIZE :: 1024

ComponentKind :: enum {
	POSITION,
	VELOCITY,
	MOVEMENT,
	MOVEMENT_STATE,
	HEALTH,
	DISPLAY,
	SHAPE,
	PLAYER,
	ANIMATION,
}

Component :: union #no_nil {
	Position,
	Velocity,
	Movement,
	MovementState,
	Health,
	Display,
	Shape,
	Player,
	Animation,
}

resolve_and_add_component :: proc(id: int, component: Component) -> ComponentKind {
	switch c in component {
	case Position:
		PositionMap[id] = c
		return .POSITION
	case Velocity:
		VelocityMap[id] = c
		return .VELOCITY
	case Movement:
		MovementMap[id] = c
		return .MOVEMENT
	case MovementState:
		MovementStateMap[id] = c
		return .MOVEMENT_STATE
	case Health:
		HealthMap[id] = c
		return .HEALTH
	case Display:
		DisplayMap[id] = c
		return .DISPLAY
	case Shape:
		ShapeMap[id] = c
		return .SHAPE
	case Player:
		// no need for map
		return .PLAYER
	case Animation:
		AnimationMap[id] = c
		return .ANIMATION
	}

	return {}
}
