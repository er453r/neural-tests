package com.er453r.neural.tests.parallel;

class ParallelRuntime {
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

	public static function forEach() {
		if(parallel){
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
		}

	}
}
