/***
CONVOLUTIONFILTER 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:59:35 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The Convolution filter is a two-dimensional discrete convolution. It is applied on each pixel
//of a display object. In the following mathematical representation, F is the input pixel plane, G
//is the input matrix, and H is the output pixel plane:
//The convolution is applied on each of the RGBA color components and then saturated,
//except when the PreserveAlpha flag is set; in this case, the alpha channel value is not modified.
//The clamping flag specifies how pixels outside of the input pixel plane are handled. If set to
//false, the DefaultColor value is used, and otherwise, the pixel is clamped to the closest valid
//input pixel.

//CONVOLUTIONFILTER
//Field 			Type 						Comment
//MatrixX 			UI8 						Horizontal matrix size
//MatrixY 			UI8 						Vertical matrix size
//Divisor 			FLOAT 						Divisor applied to the matrix values
//Bias 				FLOAT 						Bias applied to the matrix values
//Matrix 			FLOAT[MatrixX * MatrixY] 	Matrix values
//DefaultColor 		RGBA 						Default color for pixels outside the image
//Reserved 			UB[6] 						Must be 0
//Clamp 			UB[1] 						Clamp mode
//PreserveAlpha 	UB[1] 						Preserve the alpha
package zero.swf.records.filters{
	import flash.utils.Endian;
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class CONVOLUTIONFILTER extends FILTER{
		public var MatrixX:int;							//UI8
		public var MatrixY:int;							//UI8
		public var Divisor:Number;						//FLOAT
		public var Bias:Number;							//FLOAT
		public var MatrixV:Vector.<Number>;
		public var DefaultColor:uint;					//RGBA
		public var Clamp:int;
		public var PreserveAlpha:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			data.endian=Endian.LITTLE_ENDIAN;
			MatrixX=data[offset];
			MatrixY=data[offset+1];
			data.position=offset+2;
			Divisor=data.readFloat();
			Bias=data.readFloat();
			offset=data.position;
			var count:int=MatrixX*MatrixY;
			MatrixV=new Vector.<Number>(count);
			data.position=offset;
			for(var i:int=0;i<count;i++){
				MatrixV[i]=data.readFloat();
			}
			offset=data.position;
			DefaultColor=(data[offset++]<<16)|(data[offset++]<<8)|data[offset++]|(data[offset++]<<24);
			var flags:int=data[offset++];
			//Reserved=(flags<<24)>>>26;				//11111100
			Clamp=(flags<<30)>>>31;						//00000010
			PreserveAlpha=flags&0x01;					//00000001
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.endian=Endian.LITTLE_ENDIAN;
			data[0]=MatrixX;
			data[1]=MatrixY;
			data.position=2;
			data.writeFloat(Divisor);
			data.writeFloat(Bias);
			var offset:int=data.length;
			var count:int=MatrixV.length;
			data.position=offset;
			for each(var Matrix:Number in MatrixV){
				data.writeFloat(Matrix);
			}
			offset=data.length;
			data[offset++]=DefaultColor>>16;
			data[offset++]=DefaultColor>>8;
			data[offset++]=DefaultColor;
			data[offset++]=DefaultColor>>24;
			var flags:int=0;
			//flags|=Reserved<<2;						//11111100
			flags|=Clamp<<1;							//00000010
			flags|=PreserveAlpha;						//00000001
			data[offset++]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="CONVOLUTIONFILTER"
				MatrixX={MatrixX}
				MatrixY={MatrixY}
				Divisor={Divisor}
				Bias={Bias}
				DefaultColor={"0x"+BytesAndStr16._16V[(DefaultColor>>24)&0xff]+BytesAndStr16._16V[(DefaultColor>>16)&0xff]+BytesAndStr16._16V[(DefaultColor>>8)&0xff]+BytesAndStr16._16V[DefaultColor&0xff]}
				Clamp={Clamp}
				PreserveAlpha={PreserveAlpha}
			/>;
			if(MatrixV.length){
				var listXML:XML=<MatrixList count={MatrixV.length}/>
				for each(var Matrix:Number in MatrixV){
					listXML.appendChild(<Matrix value={Matrix}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			MatrixX=int(xml.@MatrixX.toString());
			MatrixY=int(xml.@MatrixY.toString());
			Divisor=Number(xml.@Divisor.toString());
			Bias=Number(xml.@Bias.toString());
			if(xml.MatrixList.length()){
				var listXML:XML=xml.MatrixList[0];
				var MatrixXMLList:XMLList=listXML.Matrix;
				var i:int=-1;
				MatrixV=new Vector.<Number>(MatrixXMLList.length());
				for each(var MatrixXML:XML in MatrixXMLList){
					i++;
					MatrixV[i]=Number(MatrixXML.@value.toString());
				}
			}else{
				MatrixV=new Vector.<Number>();
			}
			DefaultColor=uint(xml.@DefaultColor.toString());
			Clamp=int(xml.@Clamp.toString());
			PreserveAlpha=int(xml.@PreserveAlpha.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
