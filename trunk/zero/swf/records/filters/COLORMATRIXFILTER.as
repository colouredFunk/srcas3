/***
COLORMATRIXFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 22:43:35 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	public class COLORMATRIXFILTER extends FILTER{
		public var MatrixV:Vector.<Number>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.endian=Endian.LITTLE_ENDIAN;
			//#offsetpp
			MatrixV=new Vector.<Number>(20);
			MatrixV.fixed=true;
			data.position=offset;
			for(var i:int=0;i<20;i++){
				MatrixV[i]=data.readFloat();
			}
			return data.position;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data.endian=Endian.LITTLE_ENDIAN;
			//#offsetpp
			
			for each(var Matrix:Number in MatrixV){
				data.writeFloat(Matrix);
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<COLORMATRIXFILTER>
				<list vNames="MatrixV" count={MatrixV.length}/>
			</COLORMATRIXFILTER>;
			var listXML:XML=xml.list[0];
			for each(var Matrix:Number in MatrixV){
				listXML.appendChild(<Matrix value={Matrix}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var MatrixXMLList:XMLList=listXML.Matrix;
			var i:int=-1;
			MatrixV=new Vector.<Number>(20);
			for each(var MatrixXML:XML in MatrixXMLList){
				i++;
				MatrixV[i]=Number(MatrixXML.@value.toString());
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
