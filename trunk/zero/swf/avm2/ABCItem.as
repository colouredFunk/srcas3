/***
ABCItem
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 17:51:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The item_info entry consists of item_count elements that are interpreted as key/value pairs of indices into the
//string table of the constant pool. If the value of key is zero, this is a keyless entry and only carries a value.

//item_info
//{
//	u30 key
//	u30 value
//}
package zero.swf.avm2{
	import flash.utils.Dictionary;
	public class ABCItem{
		public var key:String;
		public var value:String;
		//
		public function initByInfo(
			item_info:Item_info,
			stringV:Vector.<String>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			key=stringV[item_info.key];//stringV[0]==null
			
			value=stringV[item_info.value];//stringV[0]==null
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			productMark.productString(key);
			
			productMark.productString(value);
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Item_info{
			var item_info:Item_info=new Item_info();
			
			item_info.key=productMark.getStringId(key);
			
			item_info.value=productMark.getStringId(value);
			
			return item_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName}/>;
			
			if(key is String){
				xml.@key=key;
			}
			
			if(value is String){
				xml.@value=value;
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var keyXML:XML=xml.@key[0];
			if(keyXML){
				key=keyXML.toString();
			}else{
				key=null;
			}
			
			var valueXML:XML=xml.@value[0];
			if(valueXML){
				value=valueXML.toString();
			}else{
				value=null;
			}
		}
		}//end of CONFIG::USE_XML
	}
}	