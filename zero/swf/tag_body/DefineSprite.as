/***
DefineSprite 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月23日 15:39:54 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tag_body{

	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;
	import zero.swf.DataAndTags;
	
	public class DefineSprite extends TagBody{
		public var id:int;
		public var dataAndTags:DataAndTags;
		public function DefineSprite(){
			dataAndTags=new DataAndTags();
		}

		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			throw new Error("请直接访问 dataAndTags.initByData");
		}
		override public function toData():ByteArray{
			throw new Error("请直接访问 dataAndTags.toData");
			return null;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			throw new Error("请直接访问 dataAndTags.toXML");
			return null;
		}
		override public function initByXML(xml:XML):void{
			throw new Error("请直接访问 dataAndTags.initByXML");
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
	
