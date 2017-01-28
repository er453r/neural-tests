package com.er453r.neural.tests.parallel;

import haxe.PosInfos;
class WorkerScript {
	#if !macro
	public static function __init__() {
		untyped __js__("onmessage = WorkerScript.prototype.messageHandler");
	}
	#end

	#if macro
	public static function getFilePosInfos():PosInfos{
		return Parallel.getCallerPosInfos();
	}
	#end

	public function new(){}

	public function messageHandler(event) {
		switch event.data {
			// Do whatever...
			// Here, for testing, we simply bounce back the data we got...
			case _: postMessage(event.data);
		}
	}

	// The following line seems to be needed only by the compiler...
	public function postMessage(message) {}
}
