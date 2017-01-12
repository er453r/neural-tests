package com.er453r.neural.tests;

import js.html.Uint8ClampedArray;
import js.html.ImageData;
import js.html.CanvasRenderingContext2D;
import js.Browser;
import js.html.CanvasElement;

import haxe.ds.Vector;
import haxe.Timer;

class Test{
	var neurons:Vector<Neuron>;
	var context:CanvasRenderingContext2D;

	public static function main(){
		new Test();
	}

	public function new (){
		Browser.document.addEventListener("DOMContentLoaded", init);
	}

	private function init(){
		var size = 128;
		var d = 1;

		neurons = new Vector<Neuron>(size * size);

		for(n in 0...neurons.length)
			neurons[n] = new Neuron();

		for(n in 0...neurons.length){
			var neuron:Neuron = neurons[n];

			var x:Int = n % size;
			var y:Int = Math.floor(n / size);

			var startX:Int = x - d < 0 ? 0 : x - d;
			var startY:Int = y - d < 0 ? 0 : y - d;

			var endX:Int = x + d + 1 > size ? size : x + d + 1;
			var endY:Int = y + d + 1 > size ? size : y + d + 1;

			for(y_ in startY...endY)
				for(x_ in startX...endX)
					if(y_ != y && x_ != x)
						neuron.addInput(neurons[y_ * size + x_]);
		}

		var canvas:CanvasElement = Browser.document.createCanvasElement();
		canvas.width = size;
		canvas.height = size;

		Browser.document.body.appendChild(canvas);

		context = canvas.getContext2d();

		loop();
	}

	private function update(){
		var image:ImageData = context.getImageData(0, 0, context.canvas.width, context.canvas.height);

		var pixels:Uint8ClampedArray = image.data;

		for(n in 0...Std.int(pixels.length/4)){
			var value:UInt = Math.round(255 * neurons[n].value);

			pixels[4 * n + 0] = value; // Red value
			pixels[4 * n + 1] = value; // Green value
			pixels[4 * n + 2] = value; // Blue value
			pixels[4 * n + 3] = 255; // Alpha value
		}

		context.putImageData(image, 0, 0);
	}

	private function loop(){
		var size = 128;

		neurons[Std.int(size / 2) * size + Std.int(size / 4)].value = 1;

		for(neuron in neurons)
			neuron.fire();

		for(neuron in neurons)
			neuron.propagate();

		neurons[Std.int(size / 2) * size + Std.int(size / 4)].value = 1;

		update();

		Timer.delay(loop, 50);
	}
}
