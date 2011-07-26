/***
TxtManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009-9-17 上午10:02:01
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	import zero.net.So;
	
	public class TxtManager{
		private static var dict:Dictionary=new Dictionary();
		public static function addTxt(
			txt:*,
			so:So,
			so_key:String
		):void{
			var tm:TxtManager=new TxtManager();
			dict[txt]=tm;
			tm.init(txt,so,so_key);
		}
		public static function clearTxt(txt:*):void{
			if(dict[txt]){
				dict[txt].clear();
				delete dict[txt];
			}
		}
		public static function clearAll():void{
			for(var txt:* in dict){
				clearTxt(txt);
			}
			dict=new Dictionary();
		}
		
		private var txt:*;
		private var so:So;
		private var so_key:String;
		public function TxtManager(){}
		private function clear():void{
			txt.removeEventListener(Event.CHANGE,change);
			txt=null;
			so=null;
		}
		private function init(
			_txt:*,
			_so:So,
			_so_key:String
		):void{
			txt=_txt;
			so=_so;
			so_key=_so_key;
			var text:String=so.getValue(so_key);
			if(text){
				txt.text=text;
			}else if(txt.text){
				so.setValue(so_key,txt.text);
			}
			txt.addEventListener(Event.CHANGE,change);
		}
		private function change(event:Event):void{
			so.setValue(so_key,txt.text);
		}
	}
}

