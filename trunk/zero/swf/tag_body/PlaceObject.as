/***
PlaceObject 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月7日 15:12:05 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//﻿PlaceObject 	 
//The PlaceObject tag adds a character to the display list. The CharacterId identifies the 	 
//character to be added. The Depth field specifies the stacking order of the character. The 	 
//Matrix field species the position, scale, and rotation of the character. 
//If the size of the 	 
//PlaceObject tag exceeds the end of the transformation matrix, it is assumed that a 	 
//ColorTransform field is appended to the record. 
//如果Matrix后面还有数据,那么就有ColorTransform
//The ColorTransform field specifies a color 	 
//effect (such as transparency) that is applied to the character. The same character can be added 	 
//more than once to the display list with a different depth and transformation matrix. 
//	 
//﻿NOTE
//PlaceObject is rarely used in SWF 3 and later versions; it is superseded by PlaceObject2 and PlaceObject3. 	 
//
//﻿The minimum file format version is SWF 1. 
//	 
//﻿PlaceObject 			 
//Field 						Type 			Comment 	 
//Header 						RECORDHEADER 	Tag type = 4 	 
//CharacterId 					UI16 			ID of character to place 	 
//Depth 						UI16 			Depth of character 	 
//Matrix 						MATRIX 			Transform matrix data 	 
//ColorTransform (optional) 	CXFORM 			Color transform data 
package zero.swf.tag_body{
	import zero.swf.record.MATRIX;
	import zero.swf.record.CXFORM;
	import flash.utils.ByteArray;
	public class PlaceObject extends TagBody{
		public var CharacterId:int;				//UI16
		public var Depth:int;					//UI16
		public var Matrix:MATRIX;				
		public var ColorTransform:CXFORM;		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			CharacterId=data[offset]|(data[offset+1]<<8);
			Depth=data[offset+2]|(data[offset+3]<<8);
			offset+=4;
			//#offsetpp
			Matrix=new MATRIX();
			offset=Matrix.initByData(data,offset,endOffset);
			//#offsetpp
			if(offset<endOffset){
				//#offsetpp
				ColorTransform=new CXFORM();
				offset=ColorTransform.initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data[2]=Depth;
			data[3]=Depth>>8;
			data.position=4;
			data.writeBytes(Matrix.toData());
			
			//#offsetpp
			if(ColorTransform){
				data.writeBytes(ColorTransform.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<PlaceObject
				CharacterId={CharacterId}
				Depth={Depth}
			>
				<Matrix/>
				<ColorTransform/>
			</PlaceObject>;
			xml.Matrix.appendChild(Matrix.toXML());
			if(ColorTransform){
				xml.ColorTransform.appendChild(ColorTransform.toXML());
			}else{
				delete xml.ColorTransform;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			CharacterId=int(xml.@CharacterId.toString());
			Depth=int(xml.@Depth.toString());
			Matrix=new MATRIX();
			Matrix.initByXML(xml.Matrix.children()[0]);
			if(xml.ColorTransform.length()==1){
				ColorTransform=new CXFORM();
				ColorTransform.initByXML(xml.ColorTransform.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
