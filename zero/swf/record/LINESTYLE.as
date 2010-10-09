/***
LINESTYLE 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月8日 17:17:56 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A line style has two parts, an unsigned 16-bit integer indicating the width of a line in twips,
//and a color. Here is the file description:
//LINESTYLE
//Field 			Type 					Comment
//Width 			UI16 					Width of line in twips
//Color 			RGB (Shape1 or Shape2)
//					RGBA (Shape3)			Color value including alpha channel information for Shape3
//The color in this case is a 24-bit RGB, but if we were doing a DefineShape3, it would be a 32-
//bit RGBA where alpha is the opacity of the color.
package zero.swf.record{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class LINESTYLE extends Record{
		public var Width:int;							//UI16
		public var Color:int;							//RGB
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			Width=data[offset]|(data[offset+1]<<8);
			Color=(data[offset+2]<<16)|(data[offset+3]<<8)|data[offset+4];
			return offset+5;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=Width;
			data[1]=Width>>8;
			data[2]=Color>>16;
			data[3]=Color>>8;
			data[4]=Color;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <LINESTYLE
				Width={Width}
				Color={"0x"+BytesAndStr16._16V[(Color>>16)&0xff]+BytesAndStr16._16V[(Color>>8)&0xff]+BytesAndStr16._16V[Color&0xff]}
			/>;
		}
		override public function initByXML(xml:XML):void{
			Width=int(xml.@Width.toString());
			Color=int(xml.@Color.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
