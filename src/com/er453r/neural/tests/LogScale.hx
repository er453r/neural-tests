package com.er453r.neural.tests;

class LogScale {
	private var min:Float;
	private var max:Float;

	private var scalar:Float;
	private var offset:Float;

	public function new(min:Float = 1e-16, max:Float = 1) {
		this.min = min;
		this.max = max;

		this.scalar = 1 / (Math.log(max) - Math.log(min));
		this.offset = -Math.log(min) * scalar;
	}

	public function scale(value:Float):Float{
		if(value < min)
			return 0;

		if(value > max)
			return 1;

		return Math.log(value) * scalar + offset;
	}
}
