/***
DefineBinaryData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月9日 22:12:50 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineBinaryData
//The DefineBinaryData tag permits arbitrary binary data to be embedded in a SWF file.
//DefineBinaryData is a definition tag, like DefineShape and DefineSprite. It associates a blob
//of binary data with a standard SWF 16-bit character ID. The character ID is entered into the
//SWF file's character dictionary.
//DefineBinaryData is intended to be used in conjunction with the SymbolClass tag. The
//SymbolClass tag can be used to associate a DefineBinaryData tag with an AS3 class definition.
//The AS3 class must be a subclass of ByteArray. When the class is instantiated, it will be
//populated automatically with the contents of the binary data resource.
//
//DefineBinaryData
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 87
//Tag 				UI16 			16-bit character ID
//Reserved 			U32 			Reserved space; must be 0
//Data 				BINARY 			A blob of binary data, up to the end of the tag
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBinaryData extends TagBody{
		public var id:int;								//UI16
		public var Data:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			//Reserved=data[offset+2]|(data[offset+3]<<8)|(data[offset+4]<<16)|(data[offset+5]<<24);
			//#offsetpp
			offset+=6;
			Data=new BytesData();
			return Data.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data[2]=0x00;
			data[3]=0x00;
			data[4]=0x00;
			data[5]=0x00;
			data.position=6;
			data.writeBytes(Data.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineBinaryData
				id={id}
			>
				<Data/>
			</DefineBinaryData>;
			xml.Data.appendChild(Data.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			Data=new BytesData();
			Data.initByXML(xml.Data.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
