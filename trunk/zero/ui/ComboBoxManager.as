/***
ComboBoxManager 版本:v1.0
简要说明:可编辑, 可保存的 comboBox 
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月4日 09:55:08
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
	//import mx.controls.ComboBox;
	public class ComboBoxManager{
		private static var dict:Dictionary=new Dictionary();
		public static function addCb(cb:*,so:SharedObject,saveId:String,dataProvider:Array=null):void{
			var cbm:ComboBoxManager=new ComboBoxManager();
			dict[cb]=cbm;
			cbm.init(cb,so,saveId,dataProvider);
		}
		public static function clearCb(cb:*):void{
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
		
		public static function addLabel(cb:*,label:String):void{
			dict[cb].addLabel(label);
		}
		
		
		private var cb:*;
		private var saveObj:Object;
		private var labelArr:Array;
		public function ComboBoxManager(){}
		private function clear():void{
			cb.removeEventListener(FocusEvent.FOCUS_OUT,focusOut);
			cb=null;
		}
		private function init(_cb:*,so:SharedObject,saveId:String,dataProvider:Array):void{
			cb=_cb;
			if(so){
				saveObj=so.data[saveId];
				if(!saveObj){
					so.data[saveId]=saveObj={
						currId:0,
						labelArr:[]
					}
				}
				if(dataProvider&&saveObj.labelArr.length==0){
					saveObj.labelArr=dataProvider;
				}
				cb.dataProvider=saveObj.labelArr;
				cb.selectedIndex=saveObj.currId;
				labelArr=saveObj.labelArr;
			}else{
				labelArr=dataProvider||[];
				saveObj=null;
			}
			cb.addEventListener(FocusEvent.FOCUS_OUT,focusOut);
		}
		private function focusOut(event:FocusEvent):void{
			addLabel(cb.text);
		}
		private function addLabel(label:String):void{
			if(label){
				label=label.replace(/^\s*|\s*$/g,"");
				if(label){
					if(labelArr.indexOf(label)==-1){
						labelArr.push(label);
						labelArr.sort();
						cb.dataProvider=labelArr;
					}
					cb.selectedIndex=labelArr.indexOf(label);
					if(saveObj){
						saveObj.currId=cb.selectedIndex;
					}
				}
			}
		}
	}
}