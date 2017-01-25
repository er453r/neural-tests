package com.er453r.neural.tests;

import js.Browser;
import js.html.Worker;
import js.Promise;
import js.html.URL;
import js.html.Blob;
import js.Browser;

import haxe.ds.Vector;

class Parallel {
	public function new() {
	}

	private static function createWorker(n:UInt, url:String):Promise<Int>{
		return new Promise<Int>(function(resolve:Int->Void, reject:Dynamic->Void){
			var worker = new Worker(url);
			worker.postMessage({id: n});
			worker.onmessage = function(event){
				resolve(event.data);
			};
			worker.onerror = function(event) {
				trace(event);
				reject(event.error);
			};
		});
	}

	private static function workerBase() {
		trace('started!');

		function messageHandler(event){
			var n = event.data.id;

			trace('id = ' + event.data.id);

			untyped __js__('postMessage(0)');
		};

		untyped __js__('onmessage = messageHandler');
	}

	public static function forEach<T>(data:Vector<T>, job:T->Void, parallel:Bool = true){
		if(parallel){
			var workerBody:String = "";//untyped __js__('job.toString()');

			workerBody += "\n\n(" + untyped __js__('com_er453r_neural_tests_Parallel.workerBase.toString()') + ")()";

			trace(workerBody);

			var blob:Blob = new Blob(['(', workerBody, ')()'], {type:'text/javascript'});
			var url:String = URL.createObjectURL(blob);

			var workers:Array<Promise<Int>> = [];

			for(n in 0...5)
				workers.push(createWorker(n, url));
		}
		else{
			for(object in data)
				job(object);
		}
	}
}
