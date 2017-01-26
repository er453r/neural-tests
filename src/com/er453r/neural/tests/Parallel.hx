package com.er453r.neural.tests;

import haxe.macro.ExprTools;
import haxe.macro.Expr.ExprOf;
import haxe.macro.Expr;

/*import js.html.Worker;
import js.Promise;
import js.html.URL;
import js.html.Blob;*/

import haxe.ds.Vector;

class Parallel {
	public function new() {
	}
/*
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
*/
	public static macro function forEach<T>(data:ExprOf<Vector<T>>, job:ExprOf<T->Void>):Expr{
		trace(job.pos);
		trace(ExprTools.toString(job));

		/*if(parallel){
			var jobBody:String = untyped __js__('job.toString()') + "\n\n";

			jobBody = StringTools.replace(jobBody, "function (", "function jon(");

			var workerBody:String  = jobBody + '(' + untyped __js__('com_er453r_neural_tests_Parallel.workerBase.toString()') + ')()';

			trace(workerBody);

			var blob:Blob = new Blob([workerBody], {type:'text/javascript'});
			var url:String = URL.createObjectURL(blob);

			var workers:Array<Promise<Int>> = [];

			for(n in 0...5){
				//workers.push(createWorker(n, url));

				var worker = new Worker(url);
			}

		}
		else{
			for(object in data)
				job(object);
		}*/

		return macro {};
	}
}
