package com.er453r.plot;

import haxe.ds.Vector;

import js.html.CanvasRenderingContext2D;
import js.html.Uint8ClampedArray;
import js.html.ImageData;
import js.html.CanvasElement;
import js.Browser;

import com.er453r.plot.colormaps.Inferno;

class Image {
	private var image:ImageData;
	private var context:CanvasRenderingContext2D;
	private var colormap:Colormap;

	public function new(width:UInt, height:UInt, colormap:Colormap = null, selector:String = "body") {
		this.colormap = colormap;

		var canvas:CanvasElement = Browser.document.createCanvasElement();
		canvas.width = width;
		canvas.height = height;

		context = canvas.getContext2d();
		image = context.getImageData(0, 0, width, height);

		if(this.colormap == null)
			this.colormap = new Inferno();

		Browser.document.querySelector(selector).appendChild(canvas);
	}

	public function generic<T>(vector:Vector<T>, collector:T->Float) {
		var data:Array<Float> = collect(vector, collector);

		var min:Float = PlotUtils.min(data);
		var max:Float = PlotUtils.max(data);

		var scale:Float = (max == min) ? 0 : 1 / (max - min);

		var pixels:Uint8ClampedArray = image.data;

		for(n in 0...Std.int(pixels.length/4)){
			var color:Color = colormap.getColor((data[n] - min) * scale);

			pixels[4 * n + 0] = color.r; // Red value
			pixels[4 * n + 1] = color.g; // Green value
			pixels[4 * n + 2] = color.b; // Blue value
			pixels[4 * n + 3] = 255; // Alpha value
		}

		context.putImageData(image, 0, 0);
	}

	private function collect<T>(data:Vector<T>, collector:T->Float):Array<Float>{
		return [for (item in data) collector(item)];
	}
}
