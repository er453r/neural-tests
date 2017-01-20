package com.er453r.neural.tests.colormaps;

class Colormap {
	private var lut:Array<Array<Float>>;
	private var cache:Array<Color>;
	private var buckets:UInt;

	public function	new(lut:Array<Array<Float>>, buckets:UInt = 256){
		this.lut = lut;
		this.buckets = buckets;
		this.cache = [];

		var step:Float = 1 / buckets;

		for(n in 0...buckets + 1)
			cache.push(getColorFromLut(n * step));
	}

	public function getColorFromLut(value:Float):Color{
		value = value < 0 ? 0 : (value > 1 ? 1 : value);

		var thisIndex:UInt = Math.floor((lut.length - 1) * value);
		var nextIndex:UInt = thisIndex + 1 == lut.length ? thisIndex : thisIndex + 1;

		var thisValue:Float = thisIndex / (lut.length - 1);
		var nextValue:Float = nextIndex / (lut.length - 1);

		var thisWeight:Float = 1 - (value - thisValue);
		var nextWeight:Float = 1 - thisWeight;

		var thisColor:Array<Float> = lut[thisIndex];
		var nextColor:Array<Float> = lut[nextIndex];

		var r:UInt = Math.round(255 * (thisColor[0] * thisWeight + nextColor[0] * nextWeight));
		var g:UInt = Math.round(255 * (thisColor[1] * thisWeight + nextColor[1] * nextWeight));
		var b:UInt = Math.round(255 * (thisColor[2] * thisWeight + nextColor[2] * nextWeight));

		return new Color(r, g, b);
	}

	public function getColor(value:Float):Color{
		value = value < 0 ? 0 : (value > 1 ? 1 : value);

		return cache[Math.round(value * buckets)];
	}
}
