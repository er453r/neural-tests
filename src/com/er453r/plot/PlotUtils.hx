package com.er453r.plot;

class PlotUtils {
	public static function min(data:Array<Float>):Float {
		var minValue:Float = data[0];

		for(n in 1...data.length)
			if(data[n] < minValue)
				minValue = data[n];

		return minValue;
	}

	public static function max(data:Array<Float>):Float {
		var maxValue:Float = data[0];

		for(n in 1...data.length)
			if(data[n] > maxValue)
				maxValue = data[n];

		return maxValue;
	}
}
