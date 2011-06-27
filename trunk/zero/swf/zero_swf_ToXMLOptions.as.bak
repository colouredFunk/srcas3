/***
zero_swf_ToXMLOptions
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月2日 18:52:56
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class zero_swf_ToXMLOptions{//仅用于修改代码时检测一些错误，正式时去掉
		//public var swf_Version:int;
		public var src:String;//适用于单个 src 时
		public var getSrcFun:Function;//适用于多个 src 时，例如多个 swf 混合
		public var optionV:Vector.<String>;
		
		public var BytesDataToXMLOption:String;//"数据块（字节码）","数据块（仅位置）"
		
		public var AVM2UseMarkStr:Boolean;//20110616
		
		public function toString():String{
			var xml:XML=describeType(this);
			var string:String="";
			for each(var variableXML:XML in xml.variable){
				string+=",\n\t"+variableXML.@name.toString()+":"+this[variableXML.@name.toString()];
			}
			return "zero_swf_ToXMLOptions{\n"+string.substr(2)+"\n}";
		}
	}
}
		