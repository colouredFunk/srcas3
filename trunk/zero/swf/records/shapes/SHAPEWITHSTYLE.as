/***
SHAPEWITHSTYLE
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//SHAPEWITHSTYLE
//The SHAPEWITHSTYLE structure extends the SHAPE structure by including fill style and
//line style information. SHAPEWITHSTYLE is used by the DefineShape tag.

//SHAPEWITHSTYLE
//Field 			Type 						Comment
//FillStyles 		FILLSTYLEARRAY 				Array of fill styles.
//LineStyles 		LINESTYLEARRAY 				Array of line styles.
//NumFillBits 		UB[4] 						Number of fill index bits.
//NumLineBits 		UB[4] 						Number of line index bits.
//ShapeRecords 		SHAPERECORD[one or more] 	Shape records (see following).
package zero.swf.records.shapes{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class SHAPEWITHSTYLE/*{*/implements I_zero_swf_CheckCodesRight{
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="SHAPEWITHSTYLE"/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
