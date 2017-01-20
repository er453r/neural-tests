package com.er453r.neural.tests;

import com.er453r.neural.tests.Colormap;
import haxe.ds.Vector;

import js.html.CanvasRenderingContext2D;
import js.html.Uint8ClampedArray;
import js.html.ImageData;
import js.html.CanvasElement;
import js.Browser;

import com.er453r.neural.nets.Network;

class Display {
	public static function insertCanvas(width:UInt, height:UInt, selector:String = "body") {
		var canvas:CanvasElement = Browser.document.createCanvasElement();
		canvas.width = width;
		canvas.height = height;

		Browser.document.querySelector(selector).appendChild(canvas);

		return canvas.getContext2d();
	}

	public static function flatNet(network:Network, context:CanvasRenderingContext2D, colormap:Colormap) {
		var image:ImageData = context.getImageData(0, 0, context.canvas.width, context.canvas.height);

		var pixels:Uint8ClampedArray = image.data;

		var neurons:Vector<Neuron> = network.getNeurons();

		for(n in 0...Std.int(pixels.length/4)){
			var color:Color = colormap.getColor(neurons[n].value);

			pixels[4 * n + 0] = color.r; // Red value
			pixels[4 * n + 1] = color.g; // Green value
			pixels[4 * n + 2] = color.b; // Blue value
			pixels[4 * n + 3] = 255; // Alpha value
		}

		context.putImageData(image, 0, 0);
	}
}
