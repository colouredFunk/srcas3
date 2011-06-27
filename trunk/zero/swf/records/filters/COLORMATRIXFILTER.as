/***
COLORMATRIXFILTER
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Color Matrix filter
//A Color Matrix filter applies a color transformation on the pixels of a display list object. Given
//an input RGBA pixel in a display list object, the color transformation is calculated in the
//following way:
//The resulting RGBA values are saturated.
//The matrix values are stored from left to right and each row from top to bottom. The last row
//is always assumed to be (0,0,0,0,1) and does not need to be stored.

//COLORMATRIXFILTER
//Field 		Type 		Comment
//Matrix 		FLOAT[20] 	Color matrix values
package zero.swf.records.filters{
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	public class COLORMATRIXFILTER/*{*/implements I_zero_swf_CheckCodesRight{
		public var MatrixV:Vector.<Number>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			data.endian=Endian.LITTLE_ENDIAN;
			MatrixV=new Vector.<Number>(20);
			MatrixV.fixed=true;
			data.position=offset;
			for(var i:int=0;i<20;i++){
				MatrixV[i]=data.readFloat();
			}
			return data.position;
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data.endian=Endian.LITTLE_ENDIAN;
			
			for each(var Matrix:Number in MatrixV){
				data.writeFloat(Matrix);
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="COLORMATRIXFILTER"/>;
			if(MatrixV.length){
				var listXML:XML=<MatrixList count={MatrixV.length}/>
				for each(var Matrix:Number in MatrixV){
					listXML.appendChild(<Matrix value={Matrix}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			if(xml.MatrixList.length()){
				var listXML:XML=xml.MatrixList[0];
				var MatrixXMLList:XMLList=listXML.Matrix;
				var i:int=-1;
				MatrixV=new Vector.<Number>(20);
				for each(var MatrixXML:XML in MatrixXMLList){
					i++;
					MatrixV[i]=Number(MatrixXML.@value.toString());
				}
			}else{
				MatrixV=new Vector.<Number>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
