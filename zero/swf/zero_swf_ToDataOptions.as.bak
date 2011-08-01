/***
zero_swf_ToDataOptions
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月2日 18:52:08
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class zero_swf_ToDataOptions{//仅用于修改代码时检测一些错误，正式时去掉
		public var swf_Version:int;
		
		public function toString():String{
			var xml:XML=describeType(this);
			var string:String="";
			for each(var variableXML:XML in xml.variable){
				string+=",\n\t"+variableXML.@name.toString()+":"+this[variableXML.@name.toString()];
			}
			return "zero_swf_ToDataOptions{\n"+string.substr(2)+"\n}";
		}
	}
}
		