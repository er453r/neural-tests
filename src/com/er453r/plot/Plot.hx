package com.er453r.plot;

import js.html.svg.PathElement;
import js.html.svg.SVGElement;
import js.Browser;

class Plot {
	private var path:PathElement;

	private var width:UInt;
	private var height:UInt;

	public function new(width:UInt, height:UInt, selector:String = "body") {
		this.width = width;
		this.height = height;

		var svg:SVGElement = cast Browser.document.createElementNS("http://www.w3.org/2000/svg", "svg");

		svg.setAttribute("width", Std.string(width));
		svg.setAttribute("height", Std.string(height));

		path = cast Browser.document.createElementNS("http://www.w3.org/2000/svg", "path");

		svg.appendChild(path);

		path.setAttribute("stroke", "#000000");
		path.setAttribute("fill-opacity", "0");

		path.setAttribute("d", "M 0 0 L 100 100");

		Browser.document.querySelector(selector).appendChild(svg);
	}

	public function floats(data:Array<Float>) {
		var min:Float = min(data);
		var max:Float = max(data);

		var horizontalScale:Float = width / data.length;
		var verticalScale:Float = height / (max - min);

		var pathString:String = "";

		trace(max);

		for(n in 0...data.length){
			var value:Float = data[n];

			var x:Float = n * horizontalScale;
			var y:Float = height * (1 - ((value - min) * verticalScale));

			if(Math.isNaN(y))
				continue;

			if(n == 0)
				pathString += 'M ${x} ${y}';
			else
				pathString += ' L ${x} ${y}';
		}

		path.setAttribute("d", pathString);
	}

	private function min(data:Array<Float>):Float {
		var min:Float = data[0];

		for(n in 0...data.length)
			if(data[n] < min)
				min = data[n];

		return min;
	}

	private function max(data:Array<Float>):Float {
		var max:Float = data[0];

		for(n in 0...data.length)
			if(data[n] > max)
				max = data[n];

		return max;
	}
}
