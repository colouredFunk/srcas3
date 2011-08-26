/***
DefineBitsLossless
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月25日 11:51:43（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DefineBitsLossless
//Defines a lossless bitmap character that contains RGB bitmap data compressed with ZLIB.
//The data format used by the ZLIB library is described by Request for Comments (RFCs)
//documents 1950 to 1952.
//Two kinds of bitmaps are supported. Colormapped images define a colormap of up to 256
//colors, each represented by a 24-bit RGB value, and then use 8-bit pixel values to index into
//the colormap. Direct images store actual pixel color values using 15 bits (32,768 colors) or 24
//bits (about 17 million colors).
//The minimum file format version for this tag is SWF 2.

//DefineBitsLossless
//Field 					Type 									Comment
//Header 					RECORDHEADER (long) 					Tag type = 20
//CharacterID 				UI16 									ID for this character
//BitmapFormat 				UI8 									Format of compressed data
//																	3 = 8-bit colormapped image
//																	4 = 15-bit RGB image
//																	5 = 24-bit RGB image
//BitmapWidth 				UI16 									Width of bitmap image
//BitmapHeight 				UI16 									Height of bitmap image
//BitmapColorTableSize 		If BitmapFormat = 3, UI8				This value is one less than the actual number of colors in the color table, allowing for up to 256 colors.
//							Otherwise absent
//
//ZlibBitmapData 			If BitmapFormat = 3, COLORMAPDATA		ZLIB compressed bitmap data
//							If BitmapFormat = 4 or 5, BITMAPDATA

package zero.swf.tagBodys{
	
	import flash.utils.ByteArray;
	import zero.swf.BytesData;
	
	public class DefineBitsLossless{
		
		public var id:int;//UI16
		public var BitmapFormat:int;//UI8
		public var BitmapWidth:int;//UI16
		public var BitmapHeight:int;//UI16
		public var BitmapColorTableSize:int;//UI8
		public var ZlibBitmapData:BytesData;
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			id=data[offset++]|(data[offset++]<<8);
			
			BitmapFormat=data[offset++];
			
			BitmapWidth=data[offset++]|(data[offset++]<<8);
			
			BitmapHeight=data[offset++]|(data[offset++]<<8);
			
			if(BitmapFormat==3){
				BitmapColorTableSize=data[offset++];
			}else{
				BitmapColorTableSize=-1;
			}
			
			ZlibBitmapData=new BytesData();
			return ZlibBitmapData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=id;
			data[1]=id>>8;
			
			data[2]=BitmapFormat;
			
			data[3]=BitmapWidth;
			data[4]=BitmapWidth>>8;
			
			data[5]=BitmapHeight;
			data[6]=BitmapHeight>>8;
			
			if(BitmapColorTableSize>-1){
				data[7]=BitmapColorTableSize;
			}
			
			data.position=data.length;
			data.writeBytes(ZlibBitmapData.toData(_toDataOptions));
			
			return data;
			
		}
		
		CONFIG::USE_XML{
			public function toXML(xmlName:String,_toXMLOptions:Object):XML{
				
				var xml:XML=<{xmlName} class="zero.swf.tagBodys.DefineBitsLossless"
					id={id}
					BitmapFormat={BitmapFormat}
					BitmapWidth={BitmapWidth}
					BitmapHeight={BitmapHeight}
				/>;
				
				if(BitmapColorTableSize>-1){
					xml.@BitmapColorTableSize=BitmapColorTableSize;
				}
				
				xml.appendChild(ZlibBitmapData.toXML("ZlibBitmapData",_toXMLOptions));
				
				return xml;
				
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				
				id=int(xml.@id.toString());
				
				BitmapFormat=int(xml.@BitmapFormat.toString());
				
				BitmapWidth=int(xml.@BitmapWidth.toString());
				
				BitmapHeight=int(xml.@BitmapHeight.toString());
				
				var BitmapColorTableSizeXML:XML=xml.@BitmapColorTableSize[0];
				if(BitmapColorTableSizeXML){
					BitmapColorTableSize=int(BitmapColorTableSizeXML.toString());
				}else{
					BitmapColorTableSize=-1;
				}
				
				ZlibBitmapData=new BytesData();
				ZlibBitmapData.initByXML(xml.ZlibBitmapData[0],_initByXMLOptions);
				
			}
		}
	}
}