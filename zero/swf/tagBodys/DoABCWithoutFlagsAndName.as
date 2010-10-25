/***
DoABCWithoutFlagsAndName 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月21日 20:03:45 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DoABCWithoutFlagsAndName
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 72
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.
package zero.swf.tagBodys{
	import zero.swf.avm2.AVM2Obj;
	import flash.utils.ByteArray;
	public class DoABCWithoutFlagsAndName extends TagBody{
		public var ABCData:AVM2Obj;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ABCData=new (AVM2Obj.getClassByClassId(AVM2Obj.decodeLevel))();
			return ABCData.initByData(data,offset,endOffset);
			
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(ABCData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DoABCWithoutFlagsAndName>
				<ABCData/>
			</DoABCWithoutFlagsAndName>;
			xml.ABCData.appendChild(ABCData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var ABCDataXML:XML=xml.ABCData.children()[0];
			ABCData=new (AVM2Obj.getClassByClassName(ABCDataXML.name().toString()))();
			ABCData.initByXML(ABCDataXML);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
