/***
SymbolClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月24日 13:33:50（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//SymbolClass
//Field 		Type 			Comment
//Header 		RECORDHEADER 	Tag type = 76
//NumSymbols 	UI16 			Number of symbols that will be associated by this tag.
//Tag1 			U16 			The 16-bit character tag ID for the symbol to associate
//Name1 		STRING 			The fully-qualified name of the ActionScript 3.0 class with which to associate this symbol. The class must have already been declared by a DoABC tag.
//... ... ...
//TagN 			U16 			Tag ID for symbol N
//NameN 		STRING 			Fully-qualified class name for symbol N

package zero.getfonts.swf.tagBodys{
	
	import flash.utils.ByteArray;
	
	public class SymbolClass{
		
		public var TagV:Vector.<int>;//UI16
		public var NameV:Vector.<String>;//STRING
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			var i:int;
			var get_str_size:int;
			
			var NumSymbols:int=data[offset++]|(data[offset++]<<8);
			
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(i=0;i<NumSymbols;i++){
				
				TagV[i]=data[offset++]|(data[offset++]<<8);
				
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
				
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var i:int;
			
			var data:ByteArray=new ByteArray();
			
			var NumSymbols:int=TagV.length;
			data[0]=NumSymbols;
			data[1]=NumSymbols>>8;
			
			i=-1;
			for each(var Tag:int in TagV){
				i++;
				
				data[data.length]=Tag;
				data[data.length]=Tag>>8;
				
				data.position=data.length;
				
				//data.writeUTFBytes(NameV[i]+"\x00");
				
				//20110912
				//if(NameV[i]){
				//	for each(var c:String in NameV[i].split("")){
				//		if(c.charCodeAt(0)>0xff){
				//			data.writeUTFBytes(c);
				//		}else{
				//			data.writeByte(c.charCodeAt(0));
				//		}
				//	}
				//}
				//data.writeByte(0x00);
				
				//20120413
				if(NameV[i]){
					if(NameV[i].search(/[\xf0-\xff]/)>-1){
						for each(var c:String in NameV[i].split("")){
							if(/[\xf0-\xff]/.test(c)){
								data.writeByte(c.charCodeAt(0));//这么写，个别字符能使 asv 显示不出来
							}else{
								data.writeUTFBytes(c);
							}
						}
						data.writeByte(0x00);
					}else{
						data.writeUTFBytes(NameV[i]+"\x00");
					}
				}else{
					data.writeByte(0x00);
				}
			}
			
			return data;
			
		}
	}
}