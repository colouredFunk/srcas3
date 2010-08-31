/***
DefineBitsJPEG2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:09:47 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//DefineBitsJPEG2
//Field 			Type 					Comment
//Header 			RECORDHEADER 			(long) Tag type = 21
//CharacterID 		UI16 					ID for this character
//ImageData 		UI8[data size] 			Compressed image data in either JPEG, PNG, or GIF89a format
package zero.swf.tag_body{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineBitsJPEG2 extends TagBody{
		public var id:int;						//UI16
		public var ImageData:BytesData;			
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			id=data[offset]|(data[offset+1]<<8);
			ImageData=new BytesData();
			ImageData.initByData(data,offset+2,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ImageData.toData());
			//var offset:int=data.length;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineBitsJPEG2
				id={id}
			>
				<ImageData/>
			</DefineBitsJPEG2>;
			xml.ImageData.appendChild(ImageData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			ImageData=new BytesData();
			ImageData.initByXML(xml.ImageData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
