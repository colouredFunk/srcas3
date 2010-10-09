/***
ENDSHAPERECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月9日 18:25:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The end shape record simply indicates the end of the shape record array. It is a non-edge
//record with all five flags equal to zero.
//ENDSHAPERECORD
//Field 		Type 		Comment
//TypeFlag 		UB[1] 		Non-edge record flag. Always 0.
//EndOfShape 	UB[5] 		End of shape flag. Always 0.
package zero.swf.record.shape_records{
	import flash.utils.ByteArray;
	public class ENDSHAPERECORD extends SHAPERECORD{
		public var TypeFlag:int;
		public var EndOfShape:int;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			TypeFlag=(flags<<24)>>>31;					//10000000
			EndOfShape=(flags<<25)>>>27;				//01111100
			return offset+1;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var flags:int=0;
			flags|=TypeFlag<<7;							//10000000
			flags|=EndOfShape<<2;						//01111100
			data[0]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <ENDSHAPERECORD
				TypeFlag={TypeFlag}
				EndOfShape={EndOfShape}
			/>;
		}
		override public function initByXML(xml:XML):void{
			TypeFlag=int(xml.@TypeFlag.toString());
			EndOfShape=int(xml.@EndOfShape.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
