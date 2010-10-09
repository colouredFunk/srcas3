/***
SHAPEWITHSTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 14:03:45 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//SHAPEWITHSTYLE
//Field 		Type 						Comment
//FillStyles 	FILLSTYLEARRAY 				Array of fill styles
//LineStyles 	LINESTYLEARRAY 				Array of line styles
//NumFillBits 	UB[4] 						Number of fill index bits
//NumLineBits 	UB[4] 						Number of line index bits
//ShapeRecords 	SHAPERECORD[one or more] 	Shape records (see following)
//A fill style array itself has three fields. The first field is an 8-bit integer count which indicates
//how many fill styles are in the array. This count works similar to the tag's length field in that if
//it is all 1s, you have to look at the next 16 bits to get the actual length.
package zero.swf.record{
	import zero.swf.record.FILLSTYLEARRAY;
	import zero.swf.record.LINESTYLEARRAY;
	import zero.swf.record.shape_records.SHAPERECORD;
	import flash.utils.ByteArray;
	public class SHAPEWITHSTYLE extends Record{
		public var FillStyles:FILLSTYLEARRAY;
		public var LineStyles:LINESTYLEARRAY;
		public var NumFillBits:int;
		public var NumLineBits:int;
		public var ShapeRecordV:Vector.<SHAPERECORD>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			FillStyles=new FILLSTYLEARRAY();
			offset=FillStyles.initByData(data,offset,endOffset);
			//#offsetpp
			
			LineStyles=new LINESTYLEARRAY();
			offset=LineStyles.initByData(data,offset,endOffset);
			var flags:int=data[offset++];
			NumFillBits=(flags<<24)>>>28;				//11110000
			NumLineBits=flags&0x0f;						//00001111
			ShapeRecordV=new Vector.<SHAPERECORD>();
			//#offsetpp
			
			var i:int=-1;
			while(data[offset]){
				i++;
				//#offsetpp
			
				ShapeRecordV[i]=new SHAPERECORD();
				offset=ShapeRecordV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data.writeBytes(FillStyles.toData());
			data.writeBytes(LineStyles.toData());
			var offset:int=data.length;
			var flags:int=0;
			flags|=NumFillBits<<4;						//11110000
			flags|=NumLineBits;							//00001111
			data[offset]=flags;
			
			//ENDSHAPERECORD
			STYLECHANGERECORD
			STRAIGHTEDGERECORD
			CURVEDEDGERECORD
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<SHAPEWITHSTYLE
				NumFillBits={NumFillBits}
				NumLineBits={NumLineBits}
			>
				<FillStyles/>
				<LineStyles/>
				<list vNames="ShapeRecordV" count={ShapeRecordV.length}/>
			</SHAPEWITHSTYLE>;
			xml.FillStyles.appendChild(FillStyles.toXML());
			xml.LineStyles.appendChild(LineStyles.toXML());
			var listXML:XML=xml.list[0];
			for each(var ShapeRecord:SHAPERECORD in ShapeRecordV){
				var itemXML:XML=<ShapeRecord/>;
				itemXML.appendChild(ShapeRecord.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			FillStyles=new FILLSTYLEARRAY();
			FillStyles.initByXML(xml.FillStyles.children()[0]);
			LineStyles=new LINESTYLEARRAY();
			LineStyles.initByXML(xml.LineStyles.children()[0]);
			NumFillBits=int(xml.@NumFillBits.toString());
			NumLineBits=int(xml.@NumLineBits.toString());
			var listXML:XML=xml.list[0];
			var ShapeRecordXMLList:XMLList=listXML.ShapeRecord;
			ShapeRecordV=new Vector.<SHAPERECORD>();
			var i:int=-1;
			for each(var ShapeRecordXML:XML in ShapeRecordXMLList){
				i++;
				ShapeRecordV[i]=new SHAPERECORD();
				ShapeRecordV[i].initByXML(ShapeRecordXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
