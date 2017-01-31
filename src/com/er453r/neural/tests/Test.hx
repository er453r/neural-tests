package com.er453r.neural.tests;

import com.er453r.plot.Plot;
import haxe.ds.Vector;
import haxe.Timer;

import js.html.Element;
import js.Browser;

import com.er453r.plot.colormaps.Viridis;
import com.er453r.plot.Image;

import com.er453r.neural.nets.FlatNet;
import com.er453r.neural.nets.Network;

class Test{
	private var output:Image;
	private var learning:Image;
	private var learningMask:Image;
	private var plot:Plot;

	private var fps:FPS = new FPS();
	private var stats:Element;

	private var network:Network;

	private var width:Int = 1 * 64;
	private var height:Int = 1 * 64;

	public static function main(){
		new Test();
	}

	public function new (){
		Browser.document.addEventListener("DOMContentLoaded", init);
	}

	private function init(){
		stats = Browser.document.getElementById("fps");
		output = new Image(width, height);
		learning = new Image(width, height, new Viridis());
		learningMask = new Image(width, height, new Viridis());
		network = new FlatNet(width, height, 1);
		plot = new Plot(width, height);

		var neurons:Vector<Neuron> = network.getNeurons();

		var synapses:Int = 0;

		for(neuron in neurons)
			synapses += neuron.inputs.length;

		trace('${neurons.length} neurons, ${synapses} synapses');

		loop();
	}

	private var skip:Int = 0;

	private var outs:Array<Float> = [];

	private function loop(){
		network.update();

		if(skip++ % 4 == 0){
			output.generic(network.getNeurons(), function(neuron:Neuron):Float{
				return neuron.value;
			});

			learningMask.generic(network.getNeurons(), function(neuron:Neuron):Float{
				return neuron.value > 0.000001 ? 1 : 0;
			});

			learning.generic(network.getNeurons(), function(neuron:Neuron):Float{
				return neuron.learning;
			});

			var outputIndex:UInt = Std.int(height / 2) * width + Std.int(3 * width / 4);

			outs.push(network.getNeurons().get(outputIndex).value);

			while(outs.length > 100)
				outs.shift();

			plot.floats(outs);

			stats.innerHTML = 'FPS ${fps.update()}';
		}
		else
			fps.update();

		Timer.delay(loop, 2);
	}
}
