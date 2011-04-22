/***
DescribeTypes
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年4月14日 12:30:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class DescribeTypes{
		private static var dict:Dictionary=new Dictionary();
		private static function describe(obj:Object):void{
			var clazz:Class=obj["constructor"];
			if(dict[clazz]){
			}else{
				var describeTypeXML:XML=describeType(obj);
				var accessorMark:Object=new Object();
				for each(var accessorXML:XML in describeTypeXML.accessor){
					accessorMark["~"+accessorXML.@name.toString()]=accessorXML;
				}
				dict[clazz]=accessorMark;
				//trace(describeTypeXML);
			}
		}
		public static function getType(obj:Object,valueName:String):String{
			var clazz:Class=obj["constructor"];
			if(dict[clazz]){
			}else{
				describe(obj);
			}
			return dict[clazz]["~"+valueName].@type.toString();
		}
		
		public static function setValueByStr(obj:Object,valueName:String,value:String):void{
			var type:String=getType(obj,valueName);
			if(DescribeTypes["getValueByStrFun_"+type]){
				obj[valueName]=DescribeTypes["getValueByStrFun_"+type](value);
			}else{
				obj[valueName]=value;
			}
		}
		
		private static function getValueByStrFun_Boolean(value:String):Boolean{
			switch(value){
				case "true":
					return true;
				break;
				case "false":
					return false;
				break;
				default:
					throw new Error("不合法的 Boolean: "+value);
				break;
			}
			return false;
		}
	}
}
		