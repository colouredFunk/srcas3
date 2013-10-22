/***
PBKCompiler
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月16日 21:07:50
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.File;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.output;
	import zero.outputError;
	
	public class PBKCompiler{
		
		private static var onCompletes:Function;
		private static var pbkFileArr:Array;
		private static var pbjFileArr:Array;
		public static function compiles(_pbkFileArr:Array,_onCompletes:Function):void{
			pbkFileArr=_pbkFileArr;
			pbjFileArr=new Array();
			onCompletes=_onCompletes;
			compileNext();
		}
		private static function compileNext():void{
			if(pbkFileArr.length){
				compile(pbkFileArr.shift(),compileNext,null);
				pbjFileArr.push(new File(pbkFile.url.replace(/\.pbk$/,".pbj")));
			}else{
				output("全部编译完成");
				if(onCompletes==null){
				}else{
					onCompletes(pbjFileArr);
					onCompletes=null;
				}
				pbkFileArr=null;
				pbjFileArr=null;
			}
		}
		
		private static const pbutilFile:File=new File(File.applicationDirectory.nativePath+"/../编译器/pbutil.exe");
		//trace("pbutilFile.exists="+pbutilFile.exists);
		
		private static var process:NativeProcess;
		private static var onComplete:Function;
		private static var onError:Function;
		
		private static var pbkFile:File;
		private static var tempPBJFile:File;
		
		public static function compile(_pbkFile:File,_onComplete:Function,_onError:Function):void{
			if(process){
				throw new Error("不能同时编译多个");
			}
			
			pbkFile=_pbkFile;
			onComplete=_onComplete;
			onError=_onError;
			
			var info:NativeProcessStartupInfo=new NativeProcessStartupInfo();
			info.executable=pbutilFile;
			var tempPBKFile:File=new File(File.applicationStorageDirectory.nativePath+"/temp.pbk");//貌似只能编译英文路径下的pbk
			pbkFile.copyTo(tempPBKFile,true);
			tempPBJFile=new File(tempPBKFile.url.replace(/\.pbk$/,".pbj"));
			info.arguments=new <String>[
				decodeURI(tempPBKFile.url).replace("file:///",""),
				decodeURI(tempPBJFile.url).replace("file:///","")
			];
			
			process=new NativeProcess();
			process.addEventListener(NativeProcessExitEvent.EXIT,_exit);
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,_output);
			process.start(info);
			process.closeInput();
		}
		private static function _exit(event:NativeProcessExitEvent):void{
			process.removeEventListener(NativeProcessExitEvent.EXIT,_exit);
			process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,_output);
			process=null;
			var _onComplete:Function=onComplete;
			var _onError:Function=onError;
			onComplete=null;
			onError=null;
			if(event.exitCode==0){
				var pbjFile:File=new File(pbkFile.url.replace(/\.pbk$/,".pbj"));
				tempPBJFile.copyTo(pbjFile,true);
				output("编译至："+decodeURI(pbjFile.url),"folder and file");
				pbkFile=null;
				tempPBJFile=null;
				if(_onComplete==null){
				}else{
					_onComplete();
				}
			}else{
				output("编译出错："+decodeURI(pbkFile.url),"folder and file");
				outputError("event.exitCode="+event.exitCode);
				pbkFile=null;
				tempPBJFile=null;
				if(_onError==null){
				}else{
					_onError();
				}
			}
		}
		private static function _output(event:ProgressEvent):void{
			output(process.standardOutput.readUTFBytes(process.standardOutput.bytesAvailable),"brown");
		}
		
		public static function close():void{
			if(process){
				process.exit(true);
			}
		}

	}
}