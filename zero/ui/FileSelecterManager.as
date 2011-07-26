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
	import flash.net.*;
	import flash.utils.*;
	
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
		public var onDragDrop:Function;
		
		public var dragDropClient:*;
		public var cb:*;
		public var txt:*;
		public var btn:*;
		
		private static var lastFSMFile:*;//最近一次 FileSelecterManager 初始化的 File

		public function clear():void{
			(cb||txt||btn).removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			
			var NativeDragEventClass:Class;
			try{
				NativeDragEventClass=getDefinitionByName("flash.events.NativeDragEvent") as Class;
			}catch(e:Error){
				NativeDragEventClass=null;
			}
			
			if(NativeDragEventClass){
				(dragDropClient||cb||txt||btn).removeEventListener(NativeDragEventClass.NATIVE_DRAG_ENTER,evt_nativeDragEnter);
				(dragDropClient||cb||txt||btn).removeEventListener(NativeDragEventClass.NATIVE_DRAG_DROP,evt_nativeDragDrop);
			}
			
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
			onDragDrop=null;
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
			trace("FileSelecterManager 考虑简化");
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
					if(cb){
						if(defaultFileURLOrFileURLArr is Array){
							ComboBoxManager.addCb(cb,so,saveId,defaultFileURLOrFileURLArr);
						}else if(defaultFileURLOrFileURLArr){
							ComboBoxManager.addCb(cb,so,saveId,[decodeURI(defaultFileURLOrFileURLArr)]);
						}else{
							ComboBoxManager.addCb(cb,so,saveId);
						}
						cb.addEventListener(Event.CHANGE,change);//20101112
					}
					
					//trace("cb.text="+cb.text);
					
					var __fileURL:String=null;
					if(cb){
						__fileURL=cb.text;
					}
					if(!__fileURL&&lastFSMFile){
						__fileURL=lastFSMFile.url;
					}
					
					__fileURL=normalizeFileURLByLastFSMFile(__fileURL);
					
					if(__fileURL&&__fileURL.indexOf("http://")==-1){
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
							if(cb){
								cb.editable=false;
							}
						break;
						default:
							if(cb){
								cb.editable=true;
							}
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
			
			var NativeDragEventClass:Class;
			try{
				NativeDragEventClass=getDefinitionByName("flash.events.NativeDragEvent") as Class;
			}catch(e:Error){
				NativeDragEventClass=null;
			}
			
			if(NativeDragEventClass){
				(dragDropClient||cb||txt||btn).addEventListener(NativeDragEventClass.NATIVE_DRAG_ENTER,evt_nativeDragEnter);
				(dragDropClient||cb||txt||btn).addEventListener(NativeDragEventClass.NATIVE_DRAG_DROP,evt_nativeDragDrop);
			}
			
			
			(cb||txt||btn).addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		
		private function removed(event:Event):void{
			clear();
		}
		
		private function evt_nativeDragEnter(event:*):void{//NativeDragEvent
			if(checkIsMatchType(event.clipboard.getData(getDefinitionByName("flash.desktop.ClipboardFormats").FILE_LIST_FORMAT) as Array)){
				getDefinitionByName("flash.desktop.NativeDragManager").acceptDragDrop(event.currentTarget);
			}
		}
		
		private function evt_nativeDragDrop(event:*):void{//NativeDragEvent
			nativeDragDrop(event.clipboard.getData(getDefinitionByName("flash.desktop.ClipboardFormats").FILE_LIST_FORMAT) as Array);
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
				if((!cb||!cb.text)&&lastFileURL){
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
			if(cb.text.indexOf("http://")>-1){
				select(null);
				return;
			}
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
			}else{
				(onSelect==null)||onSelect();//- -
			}
		}
		public function addURL(url:String):void{
			if(cb){
				ComboBoxManager.addLabel(cb,decodeURI(url));
			}
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
					var newFileArr:Array=new Array();
					getFiles(fileArr,newFileArr);
					for each(var file:* in newFileArr){
						if(checkFileIsMatchType(file)){
							return true;
						}
					}
					return false;
				break;
				case DIR:
					if(fileArr.length==1&&fileArr[0].isDirectory){
						return true;
					}
				break;
			}
			return false;
		}
		
		private function getFiles(files:*,_fileArr:Array):void{
			if(files is Array){
				for each(var file:* in files){
					getFiles(file,_fileArr);
				}
			}else if(files.isDirectory){
				getFiles(files.getDirectoryListing(),_fileArr);
			}else{
				_fileArr.push(files);
			}
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
				switch(browseType){
					case OPEN:
						addFile(fileArr[0]);
					break;
					case OPEN_MULTIPLE:
						var newFileArr:Array=new Array();
						getFiles(fileArr,newFileArr);
						fileArr=new Array();
						for each(var file:* in newFileArr){
							if(checkFileIsMatchType(file)){
								fileArr.push(file);
							}
						}
						fileList=Vector.<FileReference>(fileArr);
					break;
					case DIR:
						addFile(fileArr[0]);
					break;
				}
				
				if(onDragDrop==null){
				}else{
					onDragDrop();
				}
				return true;
			}
			return false;
		}
	}
}

