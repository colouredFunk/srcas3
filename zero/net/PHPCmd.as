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
		
		public static const op_pushstring:int=0x81;
		public static const op_writefile:int=0x91;
		
		private var data:ByteArray;
		
		public function PHPCmd(){
			data=new ByteArray();
		}
		public function add(op:int,...values):void{
			for each(var value:* in values){
				_add(op,value);
			}
		}
		private function _add(op:int,value:*):void{
			data[data.length]=op;
			if(op<0x80){
			}else{
				var blockData:ByteArray;
				switch(op){
					case op_pushstring:
						blockData=new ByteArray();
						blockData.writeUTFBytes(value);
					break;
					case op_writefile:
						if(value is ByteArray){
							blockData=value;
						}else{
							blockData=new ByteArray();
							blockData.writeUTFBytes(value);
						}
					break;
				}
				var blockSize:int=blockData.length;
				trace("blockSize="+blockSize);
				if(blockSize>>>7){if(blockSize>>>14){if(blockSize>>>21){if(blockSize>>>28){data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=((blockSize>>>14)&0x7f)|0x80;data[data.length]=((blockSize>>>21)&0x7f)|0x80;data[data.length]=blockSize>>>28;}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=((blockSize>>>14)&0x7f)|0x80;data[data.length]=blockSize>>>21;}}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=((blockSize>>>7)&0x7f)|0x80;data[data.length]=blockSize>>>14;}}else{data[data.length]=(blockSize&0x7f)|0x80;data[data.length]=blockSize>>>7;}}else{data[data.length]=blockSize;}
				data.position=data.length;
				data.writeBytes(blockData);
			}
		}
		public function getData():ByteArray{
			var _data:ByteArray=new ByteArray();
			_data.writeBytes(data);
			return _data;
		}
		
		public function addFile(filePathName:String,fileName:String,fileData:*):void{
			add(op_pushstring,filePathName,fileName);
			add(op_writefile,fileData);
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