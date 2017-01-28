package com.er453r.neural.tests.parallel;

import haxe.ds.Vector;

#if macro
import haxe.PosInfos;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.ExprOf;

import sys.FileSystem;
import sys.io.FileOutput;
import sys.io.File;
#end

class Parallel {
	private static var fileNameRegEx:EReg = ~/#pos\((.+):\d/;
	private static var importRegEx:EReg = ~/package.+?;(.+)class/ms;
	private static var packageRegEx:EReg = ~/package.+?;/;

	public static function getCallerPosInfos(?pos:haxe.PosInfos){
		return pos;
	}

	private static macro function generateJsCode<T>(data:ExprOf<Vector<T>>, job:ExprOf<T->Void>):String{
		var positionString:String = Std.string(job.pos);

		fileNameRegEx.match(positionString);

		var filePath:String = fileNameRegEx.matched(1);
		var fileCode:String = File.getContent(filePath);

		importRegEx.match(fileCode);

		var fileImports:String = importRegEx.matched(1);

		var workerFile:String = WorkerScript.getFilePosInfos().fileName;
		var workerCode:String = File.getContent(Context.resolvePath(workerFile));

		workerCode = packageRegEx.replace(workerCode, "package;");

		var tempFile:String = workerFile.split("/").pop();
		var className:String = WorkerScript.getFilePosInfos().className.split(".").pop();
		var tempJsFile:String = className + ".js";

		File.write(tempFile).close();

		var fileOutput:FileOutput = File.append(tempFile);
		fileOutput.writeString(workerCode);
		fileOutput.close();

		Sys.command("haxe", ["-js", tempJsFile, className]);

		var workerJsCode:String = File.getContent(Context.resolvePath(tempJsFile));

		FileSystem.deleteFile(tempFile);
		FileSystem.deleteFile(tempJsFile);

		return workerJsCode;
	}

	public static macro function forEach<T>(data:ExprOf<Vector<T>>, job:ExprOf<T->Void>):Expr{
		return macro {};
	}
}
