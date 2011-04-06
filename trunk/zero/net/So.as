/***
So 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年4月3日 20:10:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class So{
		
		private var so:SharedObject;
		public var name:String;
		private var initFinished:Function;
		
		private var xmlLoader:URLLoader;
		
		public function So(
			_name:String,
			_version:String,
			xmlOrXMLURL:*=null,
			_initFinished:Function=null
		){
			name=_name;
			so=SharedObject.getLocal(name,"/");
			
			if(version==_version){
			}else{
				
				reset();
				
				version=_version;
				
				trace("重置 so, version="+version);
			}
			
			if(xmlOrXMLURL is XML){
			}else{
				////===
				//加载 xml
				//创建时间：2011年4月6日 10:42:25
				xmlLoader=new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE,xmlLoadComplete);
				xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,xmlLoadError);
				xmlLoader.load(new URLRequest(xmlOrXMLURL));
				////===
			}
		}
		
		////===
		//加载 xml
		//创建时间：2011年4月6日 10:42:25
		private function xmlLoadComplete(event:Event):void{
			trace("xmlLoader.data="+xmlLoader.data);
			xmlLoader.removeEventListener(Event.COMPLETE,xmlLoadComplete);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,xmlLoadError);
			xmlLoader=null;
		}
		private function xmlLoadError(event:IOErrorEvent):void{
			trace("加载 xml 失败");
			xmlLoader.removeEventListener(Event.COMPLETE,xmlLoadComplete);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,xmlLoadError);
			xmlLoader=null;
		}
		////===
			
			
			
		
		public function get version():String{
			return so.data.version;
		}
		public function set version(_version:String):void{
			so.data.version=_version;
		}
		
		public function reset():void{
			//
			//so.data={version:so_version};//属性是只读的
			
			//
			for(var valueName:String in so.data){
				delete so.data[valueName];
			}
		}
		
		public function flush():void{
			so.flush();
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