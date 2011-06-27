/***
I_zero_swf_CheckCodesRight
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月2日 09:46:12
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
	
	public interface I_zero_swf_CheckCodesRight{//仅用于修改代码时检测一些函数，正式时去掉
		function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int
		function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray
		
		////
		CONFIG::USE_XML{
		function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML
		function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void
		}//end of CONFIG::USE_XML
	}
}
		