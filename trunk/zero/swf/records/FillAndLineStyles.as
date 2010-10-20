/***
FillAndLineStyles 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月10日 03:31:54 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.records{
	import zero.swf.records.FILLSTYLEARRAY;
	import zero.swf.records.LINESTYLEARRAY;
	import flash.utils.ByteArray;
	public class FillAndLineStyles extends Record{
		public var FillStyles:FILLSTYLEARRAY;
		public var LineStyles:LINESTYLEARRAY;
		public var NumFillBits:int;
		public var NumLineBits:int;
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
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<FillAndLineStyles
				NumFillBits={NumFillBits}
				NumLineBits={NumLineBits}
			>
				<FillStyles/>
				<LineStyles/>
			</FillAndLineStyles>;
			xml.FillStyles.appendChild(FillStyles.toXML());
			xml.LineStyles.appendChild(LineStyles.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			FillStyles=new FILLSTYLEARRAY();
			FillStyles.initByXML(xml.FillStyles.children()[0]);
			LineStyles=new LINESTYLEARRAY();
			LineStyles.initByXML(xml.LineStyles.children()[0]);
			NumFillBits=int(xml.@NumFillBits.toString());
			NumLineBits=int(xml.@NumLineBits.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
