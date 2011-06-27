/***
DoABCWithoutFlagsAndName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DoABCWithoutFlagsAndName
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 72
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	public class DoABCWithoutFlagsAndName{//implements I_zero_swf_CheckCodesRight{
		public var ABCData:*;	//ABCFile
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(_initByDataOptions&&_initByDataOptions.ABCFileClass){
				ABCData=new _initByDataOptions.ABCFileClass();
			}else{
				ABCData=new (getDefinitionByName("zero.swf.BytesData"))();
			}
			return ABCData.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(ABCData.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DoABCWithoutFlagsAndName"/>;
			xml.appendChild(ABCData.toXML("ABCData",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			switch(xml.ABCData[0]["@class"].toString()){
				case "ABCFileWithSimpleConstant_pool":
					ABCData=new (getDefinitionByName("zero.swf.avm2.ABCFileWithSimpleConstant_pool"))();
				break;
				case "ABCFile":
					ABCData=new (getDefinitionByName("zero.swf.avm2.ABCFile"))();
				break;
				case "ABCClasses":
					ABCData=new (getDefinitionByName("zero.swf.avm2.ABCClasses"))();
				break;
				default:
					ABCData=new (getDefinitionByName("zero.swf.BytesData"))();
				break;
			}
			ABCData.initByXML(xml.ABCData[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
