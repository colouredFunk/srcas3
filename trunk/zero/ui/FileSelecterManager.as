/***
FileSelecterManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月10日 15:58:14
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	
	import zero.net.So;
	
	//import mx.controls.ComboBox;

	public class FileSelecterManager{
		public static const OPEN:String="open";
		public static const OPEN_MULTIPLE:String="openMultiple";
		public static const SAVE:String="save";
		public static const DIR:String="dir";
		
		private var __frList:FileReferenceList;
		private var __fr:FileReference;
		
		private var __file:*;
		public function get file():*{
			if(__file){
				try{
					__file.url=cb.text;
					return __file;
				}catch(e:Error){
				}
				return null;
			}
			return __fr;
		}
		
		private var fileFilterList:Array;
		public var currId:int;
		public var dataV:Vector.<ByteArray>;
		private var browseType:String;
		private var browseTitle:String;
		
		public var fileList:Vector.<FileReference>;
		public var onLoadDatas:Function;
		public var onSelect:Function;
		
		public var cb:*;
		public var txt:*;
		public var btn:*;
		
		private static var lastFSMFile:*;//最近一次 FileSelecterManager 初始化的 File

		public function clear():void{
			if(btn){
				btn.removeEventListener(MouseEvent.CLICK,browse);
				btn=null;
			}
			if(cb){
				ComboBoxManager.clearCb(cb);
				cb.removeEventListener(Event.CHANGE,change);//20101112
			}
			if(__file){
				__file.removeEventListener(Event.SELECT,select);
				__file.removeEventListener((getDefinitionByName("flash.events.FileListEvent") as Object).SELECT_MULTIPLE,selectMultiple);
				__file=null;
			}
			if(__frList){
				__frList.removeEventListener(Event.SELECT,select);
				__frList=null;
			}
			if(__fr){
				__fr.removeEventListener(Event.SELECT,select);
				__fr=null;
			}
			
			fileFilterList=null;
			onLoadDatas=null;
			onSelect=null;
			dataV=null;
			fileList=null;
		}
		private function normalizeFileURLByLastFSMFile(fileURL:String):String{
			if(lastFSMFile){
				if(fileFilterList){
					if(lastFSMFile.type){
						var fileFilter:FileFilter=fileFilterList[0];
						if(fileFilter.extension.toLowerCase().indexOf("*"+lastFSMFile.type.toLowerCase())==-1){
							fileURL=lastFSMFile.parent.url;
						}
					}
				}else if(browseType==DIR){
					fileURL=lastFSMFile.parent.url;
				} 
				//trace("fileURL="+fileURL);
			}
			return fileURL;
		}
		public function init(
			fileTypeName:String,
			fileTypes:String="*",
			_browseType:String=OPEN,
			_browseTitle:String="选择一个文件: ",
			so:So=null,
			saveId:String=null,
			defaultFileURLOrFileURLArr:*=null
		):void{
			//init("图片","jpg,png,gif,bmp");
			if(btn){
				btn.addEventListener(MouseEvent.CLICK,browse);
			}
			
			var FileClass:Class;
			try{
				FileClass=getDefinitionByName("flash.filesystem.File") as Class;
			}catch(e:Error){
				FileClass=null;
			}
			
			if(fileTypeName){
				if(fileTypes){
					fileFilterList=[new FileFilter(fileTypeName,"*."+fileTypes.replace(/\,/g,";*."))];
				}
				browseType=_browseType;
				
				if(FileClass){
					if(defaultFileURLOrFileURLArr is Array){
						ComboBoxManager.addCb(cb,so,saveId,defaultFileURLOrFileURLArr);
					}else if(defaultFileURLOrFileURLArr){
						ComboBoxManager.addCb(cb,so,saveId,[decodeURI(defaultFileURLOrFileURLArr)]);
					}else{
						ComboBoxManager.addCb(cb,so,saveId);
					}
					cb.addEventListener(Event.CHANGE,change);//20101112
					
					//trace("cb.text="+cb.text);
					
					var __fileURL:String=cb.text;
					if(!__fileURL&&lastFSMFile){
						__fileURL=lastFSMFile.url;
					}
					
					__fileURL=normalizeFileURLByLastFSMFile(__fileURL);
					
					if(__fileURL){
						__file=new FileClass(__fileURL);
						if(lastFSMFile){
						}else{
							lastFSMFile=new FileClass(__fileURL);
						}
					}else{
						__file=new FileClass();
					}
					
					switch(browseType){
						case OPEN_MULTIPLE:
							__file.addEventListener((getDefinitionByName("flash.events.FileListEvent") as Object).SELECT_MULTIPLE,selectMultiple);
							cb.editable=false;
						break;
						default:
							cb.editable=true;
							__file.addEventListener(Event.SELECT,select);
						break;
					}
					browseTitle=_browseTitle;
					if(txt){
						txt.visible=false;
					}
				}else{
					switch(browseType){
						case OPEN_MULTIPLE:
							__frList=new FileReferenceList();
							__frList.addEventListener(Event.SELECT,select);
						break;
						case SAVE:
						case DIR:
							trace("不支持: "+browseType);
						break;
						default:
							__fr=new FileReference();
							__fr.addEventListener(Event.SELECT,select);
						break;
					}
					if(browseTitle||so||saveId){
						trace("不支持 browseTitle, so, 或 saveId");
					}
					if(cb){
						cb.visible=false;
					}
				}
			}
		}
		private function browse(event:MouseEvent=null):void{
			if(__file){
				var fileURL:String;
				try{
					fileURL=decodeURI(__file.url);
				}catch(e:Error){
					fileURL=null;
				}
				var lastFileURL:String;
				if(lastFSMFile){
					lastFileURL=lastFSMFile.url;
				}else{
					lastFileURL=null;
				}
				if(!fileURL&&lastFileURL){
					__file.url=fileURL=normalizeFileURLByLastFSMFile(lastFileURL);
				}
				if(!cb.text&&lastFileURL){
					__file.url=fileURL=normalizeFileURLByLastFSMFile(lastFileURL);
				}
				if(fileURL&&!__file.exists){
					while(fileURL&&!__file.exists){
						__file.url=fileURL=fileURL.substr(0,fileURL.lastIndexOf("/"));
					}
				}
				switch(browseType){
					case OPEN_MULTIPLE:
						__file.browseForOpenMultiple(browseTitle,fileFilterList);
					break;
					case SAVE:
						__file.browseForSave(browseTitle);
					break;
					case DIR:
						__file.browseForDirectory(browseTitle);
					break;
					default:
						__file.browseForOpen(browseTitle,fileFilterList);
					break;
				}
			}else{
				switch(browseType){
					case OPEN_MULTIPLE:
						__frList.browse(fileFilterList);
					break;
					case SAVE:
					case DIR:
						trace("不支持: "+browseType);
					break;
					default:
						__fr.browse(fileFilterList);
					break;
				}
			}
		}
		private function selectMultiple(event:Event):void{
			if(__file){
				fileList=Vector.<FileReference>((event as Object).files);
				//addFile((fileList[0] as Object).parent);
			}else{
				if(txt){
					txt.text="";
				}
				fileList=Vector.<FileReference>(__frList.fileList);
			}
			(onSelect==null)||onSelect();
			loadDatas();
		}
		private function select(event:Event):void{
			if(__file){
				fileList=Vector.<FileReference>([__file]);
				if(event){
					addFile(__file);
				}
			}else{
				if(browseType==OPEN_MULTIPLE){
					selectMultiple(null);
					return;
				}
				fileList=Vector.<FileReference>([__fr]);
				if(txt){
					txt.text=__fr.name;
				}
			}
			(onSelect==null)||onSelect();
			loadDatas();
		}
		private function loadDatas():void{
			if(onLoadDatas!=null){
				currId=-1;
				dataV=new Vector.<ByteArray>();
				loadNextData();
			}
		}
		private function loadNextData():void{
			if(++currId>=fileList.length){
				onLoadDatas();
				return;
			}
			var fr:FileReference=fileList[currId];
			fr.addEventListener(Event.COMPLETE,loadDataComplete);
			fr.load();
			if(__file){
				
			}else if(browseType==OPEN_MULTIPLE){
				if(txt){
					txt.text+=fr.name+" ";
				}
			}
		}
		private function loadDataComplete(event:Event):void{
			var fr:FileReference=fileList[currId];
			fr.removeEventListener(Event.COMPLETE,loadDataComplete);
			dataV[currId]=fr.data;
			loadNextData();
		}
		private function change(...args):void{
			try{
				__file.url=cb.text=cb.text.replace(/\\/g,"/");
			}catch(e:Error){
				try{
					__file.url=cb.text="file:///"+cb.text;
				}catch(e:Error){
					trace("e="+e);
					return;
				}
			}
			if(__file.exists){
				if(browseType==OPEN_MULTIPLE){
					return;
				}
				select(null);
			}
		}
		public function addURL(url:String):void{
			ComboBoxManager.addLabel(cb,decodeURI(url));
		}
		public function addFile(file:*):void{
			var FileClass:Class;
			try{
				FileClass=getDefinitionByName("flash.filesystem.File") as Class;
			}catch(e:Error){
				trace("不支持 addFile");
				return;
			}
			__file.url=file.url;
			if(__file.exists){
				lastFSMFile=new FileClass(__file.url);
				addURL(__file.url);
				select(null);
				//trace("__file.url="+__file.url);
			}
		}
		
		public function checkIsMatchType(fileArr:Array):Boolean{
			switch(browseType){
				case OPEN:
					if(fileArr.length==1){
						return checkFileIsMatchType(fileArr[0]);
					}
				break;
				case OPEN_MULTIPLE:
					trace("暂不支持拖入");
					return false;
					/*
					for each(var file:File in fileArr){
						if(checkFileIsMatchType(fileArr[0])){
						}else{
							return false
						}
					}
					return true;
					*/
				break;
				case DIR:
					if(fileArr.length==1&&fileArr[0].isDirectory){
						return true;
					}
				break;
			}
			return false;
		}
		private function checkFileIsMatchType(file:*):Boolean{
			for each(var fileFilter:FileFilter in fileFilterList){
				if(fileFilter.extension.indexOf("*.*")==-1){
					return new RegExp("^("+fileFilter.extension.replace(/;/g,"|").replace(/\./g,"\\.").replace(/\*/g,".*")+")$","i").test(decodeURI(file.url));
				}
				return true;
			}
			return false;
		}
		
		public function nativeDragDrop(fileArr:Array):Boolean{
			if(checkIsMatchType(fileArr)){
				addFile(fileArr[0]);
				return true;
			}
			return false;
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