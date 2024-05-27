package ecs

import "core:fmt"
import rl "vendor:raylib"

ComponentKind :: enum {
	POSITION,
	VELOCITY,
	MOVEMENT,
	HEALTH,
	DISPLAY,
	SHAPE,
}

Component :: union #no_nil {
	Position,
	Velocity,
	Movement,
	Health,
	Display,
	Shape,
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
	case Health:
		HealthMap[id] = c
		return .HEALTH
	case Display:
		DisplayMap[id] = c
		return .DISPLAY
	case Shape:
		ShapeMap[id] = c
		return .SHAPE
	}

	return {}
}

ShapeMap := make(map[ID]Shape, BUFFER_SIZE)
Shape :: union #no_nil {
	Rectangle,
	Circle,
}
Rectangle :: struct {
	width, height: f32,
}
Circle :: struct {
	radius: f32,
}

DisplayMap := make(map[ID]Display, BUFFER_SIZE)
Display :: distinct bool

HealthMap := make(map[ID]Health, BUFFER_SIZE)
Health :: distinct f32

MovementMap := make(map[ID]Movement, BUFFER_SIZE)
Movement :: struct {
	speed: f32,
}

VelocityMap := make(map[ID]Velocity, BUFFER_SIZE)
Velocity :: distinct rl.Vector2

PositionMap := make(map[ID]Position, BUFFER_SIZE)
Position :: distinct rl.Vector2
