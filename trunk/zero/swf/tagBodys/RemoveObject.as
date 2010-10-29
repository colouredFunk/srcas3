/***
RemoveObject 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 15:10:44 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//RemoveObject
//The RemoveObject tag removes the specified character (at the specified depth) from the
//display list.
//The minimum file format version is SWF 1.

//RemoveObject
//Field 		Type 			Comment
//Header 		RECORDHEADER 	Tag type = 5
//CharacterId 	UI16 			ID of character to remove
//Depth 		UI16 			Depth of character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class RemoveObject{
		public var CharacterId:int;						//UI16
		public var Depth:int;							//UI16
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			CharacterId=data[offset]|(data[offset+1]<<8);
			Depth=data[offset+2]|(data[offset+3]<<8);
			return offset+4;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data[2]=Depth;
			data[3]=Depth>>8;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return <RemoveObject
				CharacterId={CharacterId}
				Depth={Depth}
			/>;
		}
		public function initByXML(xml:XML):void{
			CharacterId=int(xml.@CharacterId.toString());
			Depth=int(xml.@Depth.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
