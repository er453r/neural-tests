package com.er453r.neural.tests.colormaps;

class Hot2 implements Colormap{
	public function new(){}

	public function getColor(value:Float):Color{
		var r:Float = 1;

		if(value < 0.3)
			r = value / 0.3;

		var g:Float = 0;

		if(value > 0.3)
			g = (value - 0.3) / 0.4;

		if(value > 0.7)
			g = 1;

		var b:Float = 0;

		if(value > 0.7)
			b = (value - 0.7) / 0.3;

		return new Color(Std.int(255 * r), Std.int(255 * g), Std.int(255 * b));
	}
}
