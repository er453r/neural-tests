package com.er453r.neural.tests.colormaps;

class Jet implements Colormap{
	public function new(){}

	public function getColor(value:Float):Color{
		if(value < 0)
			value = 0;

		if(value > 1)
			value = 1;

		var step:Float = 1 / 8;

		// red
		var r:Float = 0;

		if(value > 3 * step)
			r = (value - (3 * step)) / (2 * step);

		if(value > 5 * step)
			r = 1;

		if(value > 7 * step)
			r = 1 - ((value - (7 * step)) / (2 * step));

		// green
		var g:Float = 0;

		if(value > 1 * step)
			g = (value - (1 * step)) / (2 * step);

		if(value > 3 * step)
			g = 1;

		if(value > 5 * step)
			g = 1 - ((value - (5 * step)) / (2 * step));

		if(value > 7 * step)
			g = 0;

		// blue
		var b:Float = 0.5 + (value / (2*step));

		if(value > 1 * step)
			b = 1;

		if(value > 3 * step)
			b = 1 - ((value - (3 * step)) / (2 * step));

		if(value > 5 * step)
			b = 0;

		return new Color(Std.int(255 * r), Std.int(255 * g), Std.int(255 * b));
	}
}
