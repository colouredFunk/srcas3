/***
BrowseAndLoadFileDatas 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月3日 00:09:14
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.*;
	
	public class BrowseAndLoadFileDatas{
		
		private var onSelectFiles:Function;
		private var onCancelFiles:Function;
		private var onLoadFilesComplete:Function;
		private var onLoadFileError:Function;
		private var onLoadFilesProgress:Function;
		
		private var frs:*;
		
		private var frV:Vector.<FileReference>;
		private var frId:int;
		
		public function BrowseAndLoadFileDatas(
			fileTypeName:String,
			fileTypes:String="*",
			multiple:Boolean=false,
			_onSelectFiles:Function=null,
			_onCancelFiles:Function=null,
			_onLoadFilesComplete:Function=null,
			_onLoadFileError:Function=null,
			_onLoadFilesProgress:Function=null
		){
			onSelectFiles=_onSelectFiles;
			onCancelFiles=_onCancelFiles;
			onLoadFilesComplete=_onLoadFilesComplete;
			onLoadFileError=_onLoadFileError;
			onLoadFilesProgress=_onLoadFilesProgress;
			
			if(multiple){
				frs=new FileReferenceList();
			}else{
				frs=new FileReference();
			}
			frs.addEventListener(Event.SELECT,selectFiles);
			frs.addEventListener(Event.CANCEL,cancelFiles);
			var extension:String="*."+fileTypes.replace(/\,/g,";*.");
			frs.browse([new FileFilter(fileTypeName+"("+extension+")",extension)]);
		}
		private function clear():void{
			frs.removeEventListener(Event.SELECT,selectFiles);
			frs.removeEventListener(Event.CANCEL,cancelFiles);
			
			frs=null;
			onSelectFiles=null;
			onCancelFiles=null;
			onLoadFilesComplete=null;
			onLoadFileError=null;
			onLoadFilesProgress=null;
		}
		private function selectFiles(event:Event):void{
			if(frs is FileReference){
				frV=new Vector.<FileReference>();
				frV[0]=frs;
				if(onSelectFiles==null){
				}else{
					onSelectFiles((frs as FileReference).name);
				}
			}else{
				frV=Vector.<FileReference>((frs as FileReferenceList).fileList);
				if(onSelectFiles==null){
				}else{
					var fileNameV:Vector.<String>=new Vector.<String>();
					for each(var file:FileReference in (frs as FileReferenceList).fileList){
						fileNameV.push(file.name);
					}
					onSelectFiles(fileNameV);
				}
			}
			
			frId=-1;
			loadNextFile();
		}
		private function cancelFiles(event:Event):void{
			if(onCancelFiles==null){
			}else{
				onCancelFiles();
			}
			clear();
		}
		private function loadNextFile():void{
			if(++frId>=frV.length){
				if(onLoadFilesProgress==null){
				}else{
					onLoadFilesProgress(frV.length,frV);
				}
				if(onLoadFilesComplete==null){
				}else{
					if(frs is FileReference){
						onLoadFilesComplete(frV[0].data,frV[0].name);
					}else{
						var fileDataV:Vector.<ByteArray>=new Vector.<ByteArray>();
						var fileNameV:Vector.<String>=new Vector.<String>();
						for each(var file:FileReference in (frs as FileReferenceList).fileList){
							fileDataV.push(file.data);
							fileNameV.push(file.name);
						}
						onLoadFilesComplete(fileDataV,fileNameV);
					}
				}
				clear();
				return;
			}
			frV[frId].addEventListener(Event.COMPLETE,loadFileComplete);
			frV[frId].addEventListener(IOErrorEvent.IO_ERROR,loadFileError);
			frV[frId].load();
		}
		private function loadFileComplete(event:Event):void{
			frV[frId].removeEventListener(Event.COMPLETE,loadFileComplete);
			frV[frId].removeEventListener(IOErrorEvent.IO_ERROR,loadFileError);
			
			if(onLoadFilesProgress==null){
			}else{
				onLoadFilesProgress(frId,frV);
			}
			
			loadNextFile();
		}
		private function loadFileError(event:IOErrorEvent):void{
			frV[frId].removeEventListener(Event.COMPLETE,loadFileComplete);
			frV[frId].removeEventListener(IOErrorEvent.IO_ERROR,loadFileError);
			if(onLoadFileError==null){
			}else{
				onLoadFileError();
			}
			loadNextFile();
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/