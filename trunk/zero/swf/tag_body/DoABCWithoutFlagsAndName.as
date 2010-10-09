/***
DoABCWithoutFlagsAndName 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月7日 02:03:11 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DoABCWithoutFlagsAndName
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 72
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.
package zero.swf.tag_body{
	import zero.swf.avm2.ABCFile;
	import flash.utils.ByteArray;
	public class DoABCWithoutFlagsAndName extends TagBody{
		public var ABCData:ABCFile;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			ABCData=new ABCFile();
			return ABCData.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
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
			ABCData=new ABCFile();
			ABCData.initByXML(xml.ABCData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
