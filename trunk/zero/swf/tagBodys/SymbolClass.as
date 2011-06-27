/***
SymbolClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
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
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class SymbolClass{//implements I_zero_swf_CheckCodesRight{
		public var TagV:Vector.<int>;
		public var NameV:Vector.<String>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var NumSymbols:int=data[offset++]|(data[offset++]<<8);
			TagV=new Vector.<int>(NumSymbols);
			NameV=new Vector.<String>(NumSymbols);
			for(var i:int=0;i<NumSymbols;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
			
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var NumSymbols:int=TagV.length;
			data[0]=NumSymbols;
			data[1]=NumSymbols>>8;
			var offset:int=2;
			var i:int=-1;
			for each(var Tag:int in TagV){
				i++;
				data[offset++]=Tag;
				data[offset++]=Tag>>8;
				data.position=offset;
				data.writeUTFBytes(NameV[i]+"\x00");
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="SymbolClass"/>;
			if(TagV.length){
				var listXML:XML=<TagAndNameList count={TagV.length}/>
				var i:int=-1;
				for each(var Tag:int in TagV){
					i++;
					listXML.appendChild(<Tag value={Tag}/>);
					listXML.appendChild(<Name value={NameV[i]}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			if(xml.TagAndNameList.length()){
				var listXML:XML=xml.TagAndNameList[0];
				var TagXMLList:XMLList=listXML.Tag;
				var NameXMLList:XMLList=listXML.Name;
				var i:int=-1;
				TagV=new Vector.<int>(TagXMLList.length());
				NameV=new Vector.<String>(NameXMLList.length());
				for each(var TagXML:XML in TagXMLList){
					i++;
					TagV[i]=int(TagXML.@value.toString());
					NameV[i]=NameXMLList[i].@value.toString();
				}
			}else{
				TagV=new Vector.<int>();
				NameV=new Vector.<String>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
