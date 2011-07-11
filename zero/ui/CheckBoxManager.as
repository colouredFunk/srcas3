/***
CheckBoxManager 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月4日 11:17:24
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import zero.net.So;
	import spark.components.CheckBox;
	public class CheckBoxManager{
		private static var dict:Dictionary=new Dictionary();
		public static function addCb(
			cb:spark.components.CheckBox,
			so:So,
			so_key:String
		):void{
			var cbm:CheckBoxManager=new CheckBoxManager();
			dict[cb]=cbm;
			cbm.init(cb,so,so_key);
		}
		public static function clearCb(cb:spark.components.CheckBox):void{
			if(dict[cb]){
				dict[cb].clear();
				delete dict[cb];
			}
		}
		public static function clearAll():void{
			for(var cb:* in dict){
				clearCb(cb);
			}
			dict=new Dictionary();
		}
		
		
		private var cb:spark.components.CheckBox;
		private var so:Object;
		private var so_key:String;
		
		public function CheckBoxManager(){}
		private function clear():void{
			cb.removeEventListener(Event.CHANGE,change);
			cb=null;
			so=null;
		}
		private function init(
			_cb:spark.components.CheckBox,
			_so:So,
			_so_key:String
		):void{
			cb=_cb;
			so=_so;
			so_key=_so_key;
			
			if(so.getValue(so_key)=="true"){
				cb.selected=true;
			}
			cb.addEventListener(Event.CHANGE,change);
		}
		private function change(event:Event):void{
			so.setValue(so_key,cb.selected);
		}
		public static function updateByCb(cb:spark.components.CheckBox):void{
			dict[cb].change(null);
		}
	}
}

