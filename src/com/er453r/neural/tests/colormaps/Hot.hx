package com.er453r.neural.tests.colormaps;

class Hot implements Colormap{
	public function new(){}

	public function getColor(value:Float):Color{
		var r:Float = 1;

		if(value < 0.33)
			r = value / 0.33;

		var g:Float = 0;

		if(value > 0.33)
			g = (value - 0.33) / 0.33;

		if(value > 0.66)
			g = 1;

		var b:Float = 0;

		if(value > 0.66)
			b = (value - 0.66) / 0.33;

		return new Color(Std.int(255 * r), Std.int(255 * g), Std.int(255 * b));
	}
}
