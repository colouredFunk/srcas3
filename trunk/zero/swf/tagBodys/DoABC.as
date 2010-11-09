/***
DoABC 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:48:24 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DoABC
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 82
//Flags 		UI32 					A 32-bit flags value, which may contain the following bits set:kDoAbcLazyInitializeFlag = 1: Indicates that the ABC block should not be executed immediately, but only parsed. A later finddef may cause its scripts to execute.
//Name 			STRING 					The name assigned to the bytecode.
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.
package zero.swf.tagBodys{
	import flash.utils.getDefinitionByName;
	import zero.swf.avm2.AVM2Obj;
	import flash.utils.ByteArray;
	public class DoABC{
		public var Flags:uint;							//UI32
		public var Name:String;							//STRING
		public var ABCData:AVM2Obj;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			Flags=data[offset]|(data[offset+1]<<8)|(data[offset+2]<<16)|(data[offset+3]<<24);
			offset+=4;
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			Name=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			ABCData=new AVM2Obj.ABCFileClass();
			return ABCData.initByData(data,offset,endOffset);
			
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=Flags;
			data[1]=Flags>>8;
			data[2]=Flags>>16;
			data[3]=Flags>>24;
			data.position=4;
			data.writeUTFBytes(Name+"\x00");
			data.writeBytes(ABCData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DoABC"
				Flags={Flags}
				Name={Name}
			/>;
			xml.appendChild(ABCData.toXML("ABCData"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			Flags=uint(xml.@Flags.toString());
			Name=xml.@Name.toString();
			var ABCDataXML:XML=xml.ABCData[0];
			ABCData=new (getDefinitionByName("zero.swf.avm2."+ABCDataXML["@class"].toString()))();
			ABCData.initByXML(ABCDataXML);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
