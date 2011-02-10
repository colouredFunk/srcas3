/***
PHPCmd 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月18日 18:20:17
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class PHPCmd{
		//不带长度的命令
		public static const op_date:int=0x71;
		
		//带长度的命令
		public static const op_pushstring:int=0x81;
		
		public static const op_writefile:int=0x91;
		
		public static const op_addstring:int=0xa1;
		
		private var data:ByteArray;
		
		public function PHPCmd(){
			data=new ByteArray();
		}
		public function add(op:int,...values):void{
			if(op<0x80){
				if(values.length){
					throw new Error("小于 0x80 的命令不支持任何参数");
				}
				data[data.length]=op;
			}else{
				for each(var value:* in values){
					_add(op,value);
				}
			}
		}
		private function _add(op:int,value:*):void{
			data[data.length]=op;
			var blockData:ByteArray;
			
			/*
			switch(op){
				case op_pushstring:
					blockData=new ByteArray();
					blockData.writeUTFBytes(value);
				break;
				case op_writefile:
				case op_overwritefile:
					if(value is ByteArray){
						blockData=value;
					}else{
						blockData=new ByteArray();
						blockData.writeUTFBytes(value);
					}
				break;
				case op_addstring:
					blockData=new ByteArray();
					blockData.writeUTFBytes(value);
				break;
			}
			*/
			
			if(value is ByteArray){
				blockData=value;
			}else{
				blockData=new ByteArray();
				blockData.writeUTFBytes(value);
			}
			
			var blockSize:int=blockData.length;
			//trace("blockSize="+blockSize);
			if(blockSize>>>7){if(blockSize>>>14){if(blockSize>>>21){if(blockSize>>>28){data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=((blockSize>>>14)&0x7f)|0x80;data[data.length]=((blockSize>>>21)&0x7f)|0x80;data[data.length]=blockSize>>>28;}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=((blockSize>>>14)&0x7f)|0x80;data[data.length]=blockSize>>>21;}}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=blockSize>>>14;}}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=blockSize>>>7;}}else{data[data.length]=blockSize;}
			data.position=data.length;
			data.writeBytes(blockData);
		}
		public function getData():ByteArray{
			var _data:ByteArray=new ByteArray();
			_data.writeBytes(data);
			return _data;
		}
		
		public function getDate(dateName:String,dateFormat:String=null):void{
			add(op_pushstring,dateName,dateFormat||"U");
			add(op_date);
		}
		
		/*
		public function addWriteFile(filePathName:String,fileName:String,fileData:*):void{
			//上传文件数据，后台保存到一个不覆盖的地址，并返回此地址（如果地址为 "" 表示保存失败，否则表示保存成功）
			add(op_pushstring,filePathName,fileName);
			add(op_writefile,fileData);
		}
		public function addOverwriteFile(filePathName:String,fileSrc:String,fileData:*):void{
			//上传文件数据，后台保存到一个指定的地址（如果已有文件存在将被覆盖），并返回此地址（如果地址为 "" 表示保存失败，否则表示保存成功）
			add(op_pushstring,filePathName,fileSrc);
			add(op_overwritefile,fileData);
		}
		public function addAppendFile(filePathName:String,fileSrc:String,fileData:*):void{
			//上传文件数据，后台把数据添加到一个指定的地址的文件的末尾（如果文件不存在则创建），并返回此地址（如果地址为 "" 表示保存失败，否则表示保存成功）
			//例如可用于大文件的分块上传
			add(op_pushstring,filePathName,fileSrc);
			add(op_appendfile,fileData);
		}
		*/
		
		public function addFile(filePathName:String,filePath:String,fileDataPos:int,fileData:*):void{
			//上传文件数据
			//1 stack: filePathName, "", 0（或 >0 ）		自动计算不覆盖的地址 $filePath 然后 file_put_contents($filePath,$fileData);
			//2 stack: filePathName, filePath, 0		file_put_contents($filePath,$fileData);
			//3 stack: filePathName, filePath, >0		file_put_contents($filePath,$fileData,FILE_APPEND);
			add(op_pushstring,filePathName,filePath,fileDataPos.toString());
			add(op_writefile,fileData);
		}
		
		public function addString(strName:String,str:String):void{
			add(op_pushstring,str);
			add(op_addstring,strName);
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