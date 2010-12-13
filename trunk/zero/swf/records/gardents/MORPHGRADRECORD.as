/***
MORPHGRADRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 22:49:14 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//MORPHGRADRECORD
//The gradient record format is described in the following table:
//MORPHGRADRECORD
//Field 				Type 				Comment
//StartRatio 			UI8 				Ratio value for start shape.
//StartColor 			RGBA 				Color of gradient for start shape.
//EndRatio 				UI8 				Ratio value for end shape.
//EndColor				RGBA 				Color of gradient for end shape.
package zero.swf.records.gardents{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class MORPHGRADRECORD extends BaseGardent{
		public var StartRatio:int;						//UI8
		public var StartColor:uint;						//RGBA
		public var EndRatio:int;						//UI8
		public var EndColor:uint;						//RGBA
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			StartRatio=data[offset];
			StartColor=(data[offset+1]<<16)|(data[offset+2]<<8)|data[offset+3]|(data[offset+4]<<24);
			EndRatio=data[offset+5];
			EndColor=(data[offset+6]<<16)|(data[offset+7]<<8)|data[offset+8]|(data[offset+9]<<24);
			return offset+10;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=StartRatio;
			data[1]=StartColor>>16;
			data[2]=StartColor>>8;
			data[3]=StartColor;
			data[4]=StartColor>>24;
			data[5]=EndRatio;
			data[6]=EndColor>>16;
			data[7]=EndColor>>8;
			data[8]=EndColor;
			data[9]=EndColor>>24;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="MORPHGRADRECORD"
				StartRatio={StartRatio}
				StartColor={"0x"+BytesAndStr16._16V[(StartColor>>24)&0xff]+BytesAndStr16._16V[(StartColor>>16)&0xff]+BytesAndStr16._16V[(StartColor>>8)&0xff]+BytesAndStr16._16V[StartColor&0xff]}
				EndRatio={EndRatio}
				EndColor={"0x"+BytesAndStr16._16V[(EndColor>>24)&0xff]+BytesAndStr16._16V[(EndColor>>16)&0xff]+BytesAndStr16._16V[(EndColor>>8)&0xff]+BytesAndStr16._16V[EndColor&0xff]}
			/>;
		}
		override public function initByXML(xml:XML):void{
			StartRatio=int(xml.@StartRatio.toString());
			StartColor=uint(xml.@StartColor.toString());
			EndRatio=int(xml.@EndRatio.toString());
			EndColor=uint(xml.@EndColor.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
