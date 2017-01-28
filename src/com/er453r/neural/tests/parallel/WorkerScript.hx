package com.er453r.neural.tests.parallel;

class WorkerScript {
	#if macro
	public static function getFilePosInfos(){
		return Parallel.getCallerPosInfos();
	}
	#else

	public static function job(){}

	public static function __init__() {
		untyped __js__("onmessage = WorkerScript.messageHandler");
	}

	public static function messageHandler(event) {
		job(cast event.data);
	}
	#end
}
