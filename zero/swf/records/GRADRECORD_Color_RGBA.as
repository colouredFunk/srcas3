/***
GRADRECORD_Color_RGBA 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:08:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The GRADRECORD defines a gradient control point:
//GRADRECORD
//Field 		Type 					Comment
//Ratio 		UI8 					Ratio value
//Color 		RGB (Shape1 or Shape2)	Color of gradient
//				RGBA (Shape3)
package zero.swf.records{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class GRADRECORD_Color_RGBA{
		public var Ratio:int;							//UI8
		public var Color:uint;							//RGBA
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			Ratio=data[offset];
			Color=(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3]|(data[offset+4]<<24);
			return offset+5;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=Ratio;
			data[1]=Color>>16;
			data[2]=Color>>8;
			data[3]=Color;
			data[4]=Color>>24;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			return <GRADRECORD_Color_RGBA
				Ratio={Ratio}
				Color={"0x"+BytesAndStr16._16V[(Color>>24)&0xff]+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff]}
			/>;
		}
		public function initByXML(xml:XML):void{
			Ratio=int(xml.@Ratio.toString());
			Color=uint(xml.@Color.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
