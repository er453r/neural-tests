package com.er453r.neural.tests;

import com.er453r.neural.tests.colormaps.Parula;
import com.er453r.neural.tests.colormaps.Viridis;
import haxe.ds.Vector;
import haxe.Timer;

import js.html.Element;
import js.Browser;

import com.er453r.neural.nets.FlatNet;
import com.er453r.neural.nets.Network;

class Test{
	private var output:Display;
	private var learning:Display;
	private var learningMask:Display;

	private var fps:FPS = new FPS();
	private var stats:Element;

	private var network:Network;

	private var width:Int = 4 * 64;
	private var height:Int = 4 * 64;

	public static function main(){
		new Test();
	}

	public function new (){
		Browser.document.addEventListener("DOMContentLoaded", init);
	}

	private function init(){
		stats = Browser.document.getElementById("fps");
		output = new Display(width, height);
		learning = new Display(width, height, new Viridis());
		network = new FlatNet(width, height, 1);

		var neurons:Vector<Neuron> = network.getNeurons();

		var synapses:Int = 0;

		for(neuron in neurons)
			synapses += neuron.inputs.length;

		trace('${neurons.length} neurons, ${synapses} synapses');

		loop();
	}

	private var skip:Int = 0;

	private function loop(){
		network.update();

		if(skip++ % 4 == 0){
			output.generic(network.getNeurons(), function(neuron:Neuron):Float{
				return neuron.value;
			});

			learning.generic(network.getNeurons(), function(neuron:Neuron):Float{
				return neuron.learning;
			});

			stats.innerHTML = 'FPS ${fps.update()}';
		}
		else
			fps.update();

		Timer.delay(loop, 2);
	}
}
