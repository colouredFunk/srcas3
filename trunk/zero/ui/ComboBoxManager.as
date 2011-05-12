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
	import flash.utils.*;
	
	import zero.net.So;
	
	//import mx.controls.ComboBox;
	
	public class ComboBoxManager{
		private static var dict:Dictionary=new Dictionary();
		public static function addCb(
			cb:*,
			so:So,
			so_key:String,
			dataProvider:Array=null,
			setDataProvider:Boolean=false
		):void{
			var cbm:ComboBoxManager=new ComboBoxManager();
			dict[cb]=cbm;
			cbm.init(cb,so,so_key,dataProvider,setDataProvider);
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
		private var so:So;
		private var so_key:String;
		private var xml:XML;
		
		
		public function ComboBoxManager(){}
		private function clear():void{
			cb.removeEventListener(FocusEvent.FOCUS_OUT,focusOut);
			cb=null;
		}
		private function init(
			_cb:*,
			_so:So,
			_so_key:String,
			dataProvider:Array,
			setDataProvider:Boolean
		):void{
			cb=_cb;
			so=_so;
			so_key=_so_key;
			if(so){
				xml=so.getXMLByKey(so_key);
				if(xml){
				}else{
					xml=<ComboBoxManager currId="0">
							<labels/>
						</ComboBoxManager>;
					so.setXMLByKey(so_key,xml);
				}
				
				
				if(
					dataProvider
					&&
					(
						labelsXML2labelArr(xml.labels[0]).length==0
						||
						setDataProvider
					)
				){
					xml.labels=labelArr2labelsXML(dataProvider);
				}
				
				if(cb){
					cb.dataProvider=labelsXML2labelArr(xml.labels[0]);
					cb.selectedIndex=int(xml.@currId.toString());
				}
			}else{
				//
			}
			
			if(cb){
				cb.addEventListener(FocusEvent.FOCUS_OUT,focusOut);
			}
		}
		private function labelArr2labelsXML(labelArr:Array):XML{
			var labelsXML:XML=<labels/>;
			for each(var label:String in labelArr){
				labelsXML.appendChild(<label value={label}/>);
			}
			return labelsXML;
		}
		private function labelsXML2labelArr(labelsXML:XML):Array{
			var labelArr:Array=new Array();
			if(labelsXML){
				for each(var labelXML:XML in labelsXML.label){
					labelArr[labelArr.length]=labelXML.@value.toString();
				}
			}
			return labelArr;
		}
		private function focusOut(event:FocusEvent):void{
			addLabel(cb.text);
		}
		private function addLabel(label:String):void{
			if(label){
				label=label.replace(/^\s*|\s*$/g,"");
				if(label){
					var labelArr:Array=labelsXML2labelArr(xml.labels[0]);
					if(labelArr.indexOf(label)==-1){
						labelArr.push(label);
						labelArr.sort();
						cb.dataProvider=labelArr;
					}
					cb.selectedIndex=labelArr.indexOf(label);
					if(so){
						xml.labels=labelArr2labelsXML(labelArr);
						xml.@currId=cb.selectedIndex;
						so.setXMLByKey(so_key,xml);
					}
				}
			}
		}
	}
}