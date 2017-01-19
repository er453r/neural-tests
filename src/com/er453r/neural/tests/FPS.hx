package com.er453r.neural.tests;

import haxe.Timer;

class FPS {
	private var frames:UInt = 0;
	private var fps:UInt = 0;

	private var past:Float = Timer.stamp();

	public function new(){}

	public function update():UInt{
		frames++;

		var now:Float = Timer.stamp();

		var diff:Float = now - past;

		if(diff > 1){
			fps = Std.int(frames / diff);

			past = now;
			frames = 0;
		}

		return fps;
	}
}
