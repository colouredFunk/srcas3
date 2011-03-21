/***
FormVariables 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月2日 09:38:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class FormVariables{
		private var values:Object;
		private var filenames:Object;
		
		public var contentType:String;
		public var boundary:String;
		public function FormVariables(_values:Object=null,_filenames:Object=null){
			values=_values||new Object();
			filenames=_filenames||new Object();
			boundary="-=-=-=-=-=-=-=-=-=-"+Math.random();
			contentType="multipart/form-data; boundary="+boundary;//只能用户点击时上传
			//contentType="application/octet-stream; boundary="+boundary;
			
		}
		public function add(name:String,value:*,filename:String=null):void{
			values[name]=value;
			if(filename){
				filenames[name]=filename;
			}
		}
		public function get data():ByteArray{
			var data:ByteArray=new ByteArray();
			for(var name:String in values){
				var value:*=values[name];
				data.writeUTFBytes("--" + boundary + "\r\n");
				if(value is ByteArray){
					//trace(name+".length="+value.length);
					//var dotId:int=name.lastIndexOf(".");
					//if(dotId>=0){
					//	
					//}
					data.writeUTFBytes(
						"Content-Disposition: form-data; name=\"" + name + 
						"\"; filename=\"\\" + (filenames[name]||name) +
						"\"\r\nContent-Type: application/octet-stream\r\n\r\n"
					);
					data.writeBytes(values[name]);
					data.writeUTFBytes("\r\n");
				}else{
					//trace(name+"=\""+value+"\"");
					data.writeUTFBytes(
						"Content-Disposition: form-data; name=\"" + name + 
						"\"\r\n\r\n"+values[name]+
						"\r\n"
					);
				}
			}
			data.writeUTFBytes("--" + this.boundary + "--\r\n");
			return data;
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