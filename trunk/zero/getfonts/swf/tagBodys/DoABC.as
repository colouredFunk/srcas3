/***
DoABC
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月29日 18:05:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DoABC
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 82
//Flags 		UI32 					A 32-bit flags value, which may contain the following bits set:kDoAbcLazyInitializeFlag = 1: Indicates that the ABC block should not be executed immediately, but only parsed. A later finddef may cause its scripts to execute.
//Name 			STRING 					The name assigned to the bytecode.
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.

package zero.getfonts.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.getfonts.swf.avm2.ABCFileWithSimpleConstant_pool;
	
	public class DoABC{
		
		public var Flags:uint;//UI32
		public var Name:String;//STRING
		public var ABCData:*;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var get_str_size:int;
			
			Flags=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			get_str_size=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			Name=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			
			var ABCDataClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ABCDataClass=_initByDataOptions.classes["zero.swf.avm2.ABCFile"];
				}
				if(ABCDataClass){
				}else{
					ABCDataClass=_initByDataOptions.ABCDataClass;
				}
			}
			ABCData=new (ABCDataClass||ABCFileWithSimpleConstant_pool)();
			return ABCData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Flags;
			data[1]=Flags>>8;
			data[2]=Flags>>16;
			data[3]=Flags>>24;
			
			data.position=4;
			data.writeUTFBytes(Name+"\x00");
//			//20111208
//			if(Name){
//				for each(var c:String in Name.split("")){
//					if(c.charCodeAt(0)>0xff){
//						data.writeUTFBytes(c);
//					}else{
//						data.writeByte(c.charCodeAt(0));
//					}
//				}
//			}
//			data.writeByte(0x00);
			
			data.writeBytes(ABCData.toData(_toDataOptions));
			
			return data;
			
		}
	}
}