/***
SymbolClass 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月30日 20:56:05 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
package zero.swf.tag_body{

	import flash.utils.ByteArray;

	import zero.BytesAndStr16;
	import zero.swf.BytesData;

	public class SymbolClass extends TagBody{
		public var NumSymbols:int;				//UI16
		public var TagV:Vector.<int>;			
		public var NameV:Vector.<String>;		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			NumSymbols=data[offset]|(data[offset+1]<<8);
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			offset+=2;
			//#offsetpp
			for(var i:int=0;i<NumSymbols;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			NumSymbols=TagV.length;
			data[0]=NumSymbols;
			data[1]=NumSymbols>>8;
			var offset:int=2;
			//#offsetpp
			for(var i:int=0;i<NumSymbols;i++){
				data[offset++]=TagV[i];
				data[offset++]=TagV[i]>>8;
				data.position=offset;
				data.writeUTFBytes(NameV[i]);
				offset=data.length;
				data[offset++]=0;//字符串结束
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			NumSymbols=TagV.length;
			var xml:XML=<SymbolClass
				NumSymbols={NumSymbols}
			>
				<list vNames="TagV,NameV" count={NumSymbols}/>
			</SymbolClass>;
			var listXML:XML=xml.list[0];
			for(var i:int=0;i<NumSymbols;i++){
				listXML.appendChild(<Tag value={TagV[i]}/>);
				listXML.appendChild(<Name value={NameV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			NumSymbols=int(xml.@NumSymbols.toString());
			var listXML:XML=xml.list[0];
			var TagXMLList:XMLList=listXML.Tag;
			TagV=new Vector.<int>();
			var NameXMLList:XMLList=listXML.Name;
			NameV=new Vector.<String>();
			NumSymbols=TagXMLList.length();
			for(var i:int=0;i<NumSymbols;i++){
				TagV[i]=int(TagXMLList[i].@value.toString());
				NameV[i]=NameXMLList[i].@value.toString();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
