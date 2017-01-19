package com.er453r.neural.tests;

import haxe.Timer;

import js.html.Element;
import js.html.CanvasRenderingContext2D;
import js.Browser;

import com.er453r.neural.nets.FlatNet;
import com.er453r.neural.nets.Network;

class Test{
	private var context:CanvasRenderingContext2D;

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
		context = Display.insertCanvas(width, height);
		network = new FlatNet(width, height);

		loop();
	}

	private function loop(){
		network.update();
		Display.flatNet(network, context);
		stats.innerHTML = 'FPS ${fps.update()}';

		Timer.delay(loop, 20);
	}
}
