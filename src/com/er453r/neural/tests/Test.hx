package com.er453r.neural.tests;

import js.html.Uint8ClampedArray;
import js.html.ImageData;
import js.html.CanvasRenderingContext2D;
import js.Browser;
import js.html.CanvasElement;

import haxe.ds.Vector;

class Test {
	public static function main() {
		Browser.document.addEventListener("DOMContentLoaded", init);
	}

	private static function init(){
		var size = 128;

		var neurons:Vector<Neuron> = new Vector<Neuron>(size * size);

		for(n in 0...neurons.length){
			neurons[n] = new Neuron();
		}

		var canvas:CanvasElement = Browser.document.createCanvasElement();
		canvas.width = size;
		canvas.height = size;

		Browser.document.body.appendChild(canvas);

		var context:CanvasRenderingContext2D = canvas.getContext2d();

		var image:ImageData = context.getImageData(0, 0, size, size);

		var pixels:Uint8ClampedArray = image.data;

		for(n in 0...size*size){
			pixels[4*n + 0] = Math.round(255 * neurons[n].value); // Red value
			pixels[4*n + 1] = Math.round(255 * neurons[n].value); // Green value
			pixels[4*n + 2] = Math.round(255 * neurons[n].value); // Blue value
			pixels[4*n + 3] = 255; // Alpha value
		}

		context.putImageData(image, 0, 0);
	}
}
