package com.er453r.neural.tests.parallel;

import js.html.URL;
import js.html.Blob;
import js.html.Worker;
import js.Promise;

class ParallelRuntime {
	private static function createWorker<T>(n:UInt, url:String, data:T):Promise<Int>{
		return new Promise<Int>(function(resolve:Int->Void, reject:Dynamic->Void){
			var worker = new Worker(url);
			worker.postMessage(data);
			worker.onmessage = function(event){
				resolve(event.data);
			};
			worker.onerror = function(event) {
				trace(event);
				reject(event.error);
			};
		});
	}

	public static function forEachWorker<T>(data:Array<T>, workerBody:String){
		//trace(workerBody);

		var blob:Blob = new Blob([workerBody], {type:'text/javascript'});
		var url:String = URL.createObjectURL(blob);

		var workers:Array<Promise<Int>> = [for(n in 0...data.length) createWorker(n, url, data[n])];
	}
}
