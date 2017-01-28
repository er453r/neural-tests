package com.er453r.neural.tests.parallel;

#if macro
import haxe.PosInfos;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;
import haxe.macro.ExprTools;

import sys.FileSystem;
import sys.io.FileOutput;
import sys.io.File;
#end

class Parallel {
	#if macro
	private static var fileNameRegEx:EReg = ~/#pos\((.+):\d/;
	private static var importRegEx:EReg = ~/package.+?;(.+)class/ms;
	private static var packageRegEx:EReg = ~/package.+?;/;

	public static function getCallerPosInfos(?pos:haxe.PosInfos){
		return pos;
	}

	private static function generateJsCode<T>(data:ExprOf<Array<T>>, job:ExprOf<T->Void>):String{
		var jobCode:String = ExprTools.toString(job);

		jobCode = StringTools.replace(jobCode, "function(", "function job(");

		var positionString:String = Std.string(job.pos);

		fileNameRegEx.match(positionString);

		var filePath:String = fileNameRegEx.matched(1);
		var fileCode:String = File.getContent(filePath);

		importRegEx.match(fileCode);

		var fileImports:String = importRegEx.matched(1);

		var workerFile:String = WorkerScript.getFilePosInfos().fileName;
		var workerCode:String = File.getContent(Context.resolvePath(workerFile));

		workerCode = packageRegEx.replace(workerCode, "package;");

		workerCode = StringTools.replace(workerCode, "function job(){}", jobCode);

		var tempFile:String = workerFile.split("/").pop();
		var className:String = WorkerScript.getFilePosInfos().className.split(".").pop();
		var tempJsFile:String = className + ".js";

		File.write(tempFile).close();

		var fileOutput:FileOutput = File.append(tempFile);
		fileOutput.writeString(workerCode);
		fileOutput.close();

		var result:Int = Sys.command("haxe", ["-js", tempJsFile, className]);

		if(result != 0){
			Sys.command("cat", ["-n", tempFile]); // to do - what on windows?

			FileSystem.deleteFile(tempFile);

			Context.error("Error in parallel job!", Context.currentPos());
		}

		var workerJsCode:String = File.getContent(Context.resolvePath(tempJsFile));

		FileSystem.deleteFile(tempFile);
		FileSystem.deleteFile(tempJsFile);

		return workerJsCode;
	}
	#end

	public static macro function forEach<T>(data:ExprOf<Array<T>>, job:ExprOf<T->Void>):Expr{
		var code:String = generateJsCode(data, job);

		return macro {
			com.er453r.neural.tests.parallel.ParallelRuntime.forEachWorker(${data}, $v{code});
		};
	}
}
