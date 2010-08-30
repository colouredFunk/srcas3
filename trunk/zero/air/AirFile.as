/***
AirFile 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月3日 14:16:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.air{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.utils.*;
	public class AirFile{
		/*public static function getFiles(file:File,reg:*=null):Array{
			var fileList:Array=new Array();
			if(file.isDirectory){
				for each(var subFile:File in file.getDirectoryListing()){
					fileList.push.apply(fileList,getFiles(subFile,reg));
				}
			}else{
				if(reg){
					if(file.name.search(reg)>=0){
						fileList.push(file);
					}
				}else{
					fileList.push(file);
				}
			}
			return fileList;
		}*/
		
		private static var getFiles_intervalId:int=-1;
		public static var getFiles_file:File;
		private static var getFiles_reg:*;
		private static var getFiles_noSameFile:Boolean;//忽略相同的 file(只是比较 大小和（日期或名字) ）
		private static var getFiles_onGetFile:Function;//得到一个 file 后进行处理
		private static var getFiles_sameFileMark:Object;
		private static var getFiles_stack_i:Array;
		private static var getFiles_stack_list:Array;
		private static var getFiles_fileList:Array;
		private static var getFiles_list:Array;
		private static var getFiles_i:int;
		private static var getFiles_fileNum:int;
		private static var getFiles_totalFileNum:int;
		public static var getFiles_onProgress:Function;
		public static var getFiles_onComplete:Function;
		public static var getFiles_running:Boolean;
		
		public static function getFiles(file:File,reg:*=null,noSameFile:Boolean=false,onGetFile:Function=null):void{
			getFiles_running=true;
			
			clearInterval(getFiles_intervalId);
			
			getFiles_file=file;
			getFiles_reg=reg;
			getFiles_noSameFile=noSameFile;
			getFiles_onGetFile=onGetFile;
			if(getFiles_noSameFile){
				getFiles_sameFileMark=new Object();
			}
			getFiles_stack_i=new Array();
			getFiles_stack_list=new Array();
			getFiles_fileList=new Array();
			
			getFiles_list=file.getDirectoryListing();
			getFiles_i=getFiles_list.length;
			
			getFiles_fileNum=0;
			getFiles_totalFileNum=0;
			getFiles_intervalId=setInterval(getFiles_run,30);
		}
		public static function getFiles_clear():void{
			clearInterval(getFiles_intervalId);
			getFiles_file=null;
			getFiles_reg=null;
			getFiles_onGetFile=null;
			getFiles_sameFileMark=null;
			getFiles_stack_i=null;
			getFiles_stack_list=null;
			getFiles_fileList=null;
			getFiles_list=null;
			getFiles_onProgress=null;
			getFiles_onComplete=null;
			getFiles_running=false;
		}
		private static function getFiles_getFile(file:File):void{
			getFiles_fileList.push(file);
			if(getFiles_onGetFile!=null){
				getFiles_onGetFile(file);
			}
		}
		public static function getFiles_run():void{
			var t:int=getTimer();
			while(getTimer()-t<100){
				while(getFiles_i<=0){
					if(getFiles_stack_list.length<=0){
						getFiles_complete();
						return;
					}
					getFiles_list=getFiles_stack_list.pop();
					getFiles_i=getFiles_stack_i.pop();
				}
				getFiles_file=getFiles_list[--getFiles_i];
				if(getFiles_file.isDirectory){
					getFiles_stack_list.push(getFiles_list);
					getFiles_stack_i.push(getFiles_i);
					getFiles_list=getFiles_file.getDirectoryListing();
					getFiles_i=getFiles_list.length;
				}else{
					getFiles_totalFileNum++;
					var fileSize:int,fileTime:int;
					if(getFiles_reg){
						if(getFiles_file.name.search(getFiles_reg)>=0){
							if(getFiles_noSameFile){
								fileSize=getFiles_file.size;
								fileTime=getFiles_file.creationDate.getTime();
								if(!(getFiles_sameFileMark[fileSize+"_"+fileTime]||getFiles_sameFileMark[fileSize+"_"+getFiles_file.name])){
									//比较 大小和（日期或名字)
									getFiles_sameFileMark[fileSize+"_"+fileTime]=getFiles_sameFileMark[fileSize+"_"+getFiles_file.name]=true;
									getFiles_getFile(getFiles_file);
								}
							}else{
								getFiles_getFile(getFiles_file);
							}
						}
					}else{
						if(getFiles_noSameFile){
							fileSize=getFiles_file.size;
							fileTime=getFiles_file.creationDate.getTime();
							if(!(getFiles_sameFileMark[fileSize+"_"+fileTime]||getFiles_sameFileMark[fileSize+"_"+getFiles_file.name])){
								//比较 大小和（日期或名字)
								getFiles_sameFileMark[fileSize+"_"+fileTime]=getFiles_sameFileMark[fileSize+"_"+getFiles_file.name]=true;
								getFiles_getFile(getFiles_file);
							}
						}else{
							getFiles_getFile(getFiles_file);
						}
					}
				}
			}
			if(getFiles_onProgress!=null){
				getFiles_onProgress(getFiles_fileList.length,getFiles_totalFileNum);
			}
		}
		private static function getFiles_complete():void{
			getFiles_running=false;
			if(getFiles_onProgress!=null){
				getFiles_onProgress(getFiles_fileList.length,getFiles_totalFileNum);
			}
			if(getFiles_onComplete!=null){
				getFiles_onComplete(getFiles_fileList);
			}
			getFiles_clear();
		}
		
		/*public static function moveFiles(fileList:Array,srcFolder:File,destFolder:File,isCut:Boolean=false):void{
			var srcFolderURLLength:int=decodeURI(srcFolder.url).length+1;
			var destFolderURL:String=decodeURI(destFolder.url)+"/";
			
			var file:File;
			var file_copy:File=new File();
			var dest:String;
			if(isCut){
				for each(file in fileList){
					dest=decodeURI(file.url).substr(srcFolderURLLength);
					file_copy.url=destFolderURL+dest;
					file.moveTo(file_copy,true);
				}
			}else{
				for each(file in fileList){
					dest=decodeURI(file.url).substr(srcFolderURLLength);
					file_copy.url=destFolderURL+dest;
					file.copyTo(file_copy,true);
				}
			}
		}*/
		
		private static var moveFiles_intervalId:int=-1;
		private static var moveFiles_fileList:Array;
		private static var moveFiles_srcFolderURLLength:int;
		private static var moveFiles_destFolderURL:String
		private static var moveFiles_file_copy:File;
		private static var moveFiles_isCut:Boolean;
		private static var moveFiles_fileList_i:int;
		private static var moveFiles_fileList_L:int;
		public static var moveFiles_onProgress:Function;
		public static var moveFiles_onComplete:Function;
		public static var moveFiles_running:Boolean;
		public static function moveFiles(fileList:Array,srcFolder:File,destFolder:File,isCut:Boolean=false):void{
			moveFiles_running=true;
			
			clearInterval(moveFiles_intervalId);
			
			moveFiles_srcFolderURLLength=decodeURI(srcFolder.url).length+1;
			moveFiles_destFolderURL=decodeURI(destFolder.url)+"/";
			moveFiles_file_copy=new File();
			moveFiles_isCut=isCut;
			
			moveFiles_fileList=fileList;
			moveFiles_fileList_L=moveFiles_fileList.length;
			moveFiles_fileList_i=0;
			moveFiles_intervalId=setInterval(moveFiles_run,30);
		}
		public static function moveFiles_clear():void{
			clearInterval(moveFiles_intervalId);
			moveFiles_fileList=null;
			moveFiles_file_copy=null;
			moveFiles_onProgress=null;
			moveFiles_onComplete=null;
		}
		private static function moveFiles_run():void{
			var t:int=getTimer();
			while(getTimer()-t<100){
				var file:File=moveFiles_fileList[moveFiles_fileList_i++];
				moveFiles_file_copy.url=moveFiles_destFolderURL+decodeURI(file.url).substr(moveFiles_srcFolderURLLength);
				if(moveFiles_isCut){
					file.moveTo(moveFiles_file_copy,true);
				}else{
					file.copyTo(moveFiles_file_copy,true);
				}
				if(moveFiles_fileList_i>=moveFiles_fileList_L){
					moveFiles_complete();
					return;
				}
			}
			if(moveFiles_onProgress!=null){
				moveFiles_onProgress(moveFiles_fileList_i,moveFiles_fileList_L);
			}
		}
		private static function moveFiles_complete():void{
			moveFiles_running=false;
			if(moveFiles_onProgress!=null){
				moveFiles_onProgress(moveFiles_fileList_i,moveFiles_fileList_L);
			}
			if(moveFiles_onComplete!=null){
				moveFiles_onComplete(moveFiles_fileList);
			}
			moveFiles_clear();
		}
		
		//
		public static function url2File(rootFolder:String,url:String):File{
			if(url.substr(url.length-1)=="/"){
				url+="index.htm";
			}
			
			var id:int=url.indexOf("?");
			if(id>=0){
				id=url.lastIndexOf("/",id);
			}else{
				id=url.lastIndexOf("/");
			}
			var fileName:String=url.substr(id+1);
			fileName=fileName.replace(/[\?\&\/\\]/g,"_");
			if(fileName.lastIndexOf(".")==-1){
				fileName+=".htm";
			}
			url=url.substr(0,id)+"/"+fileName;
			var file:File=new File(rootFolder+url.replace(/(https?):\/\//i,"$1_").replace(/:/g,"_").toLowerCase());
			if(!file.isDirectory){
				return file;
			}
			return null;
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