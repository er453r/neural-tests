package com.er453r.neural.tests;

import com.er453r.neural.tests.colormaps.Jet;
import com.er453r.neural.tests.colormaps.Inferno;
import com.er453r.neural.tests.colormaps.Magma;
import com.er453r.neural.tests.colormaps.Plasma;
import com.er453r.neural.tests.colormaps.Viridis;
import com.er453r.neural.tests.colormaps.Cold;
import com.er453r.neural.tests.Colormap;
import com.er453r.neural.tests.colormaps.Hot;
import haxe.ds.Vector;
import haxe.Timer;

import js.html.Element;
import js.html.CanvasRenderingContext2D;
import js.Browser;

import com.er453r.neural.nets.FlatNet;
import com.er453r.neural.nets.Network;

class Test{
	private var context:CanvasRenderingContext2D;
	private var colormap:Colormap = new Hot();

	private var fps:FPS = new FPS();
	private var stats:Element;

	private var network:Network;

	private var width:Int = 2 * 64;
	private var height:Int = 2 * 64;

	public static function main(){
		new Test();
	}

	public function new (){
		Browser.document.addEventListener("DOMContentLoaded", init);
	}

	private function init(){
		stats = Browser.document.getElementById("fps");
		context = Display.insertCanvas(width, height);
		network = new FlatNet(width, height, 1);

		var neurons:Vector<Neuron> = network.getNeurons();

		var synapses:Int = 0;

		for(neuron in neurons)
			synapses += neuron.inputs.length;

		trace('${neurons.length} neurons, ${synapses} synapses');

		loop();
	}

	private function loop(){
		network.update();
		Display.flatNet(network, context, colormap);
		stats.innerHTML = 'FPS ${fps.update()}';

		Timer.delay(loop, 20);
	}
}
