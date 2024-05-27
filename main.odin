package main

import "core:fmt"
import "ecs"
import rl "vendor:raylib"

//--------------------------------------------------------------------------------------------------
// MAIN
//--------------------------------------------------------------------------------------------------

_screenWidth: i32 = 640
_screenHeight: i32 = 480

WORLD := make(ecs.World, 0, ecs.BUFFER_SIZE)

main :: proc() {
	rl.InitWindow(_screenWidth, _screenHeight, "asteroids")
	rl.SetTargetFPS(60)

	ecs.new_entity(
		&WORLD,
		ecs.Position{10, 12},
		ecs.Movement{2},
		ecs.Shape(ecs.Rectangle{width = 45, height = 25}),
		ecs.Display{},
	)
	fmt.println(WORLD)
	fmt.println(ecs.PositionMap, ecs.MovementMap, ecs.ShapeMap)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.DARKGRAY)

		ecs.run_all_systems(&WORLD)

		fmt.println(WORLD)
		fmt.println(ecs.PositionMap, ecs.MovementMap, ecs.ShapeMap)

		rl.EndDrawing()
	}
}
