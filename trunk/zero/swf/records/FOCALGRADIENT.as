/***
FOCALGRADIENT 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:08:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A FOCALGRADIENT must be declared in DefineShape4—not DefineShape, DefineShape2
//or DefineShape3.
//The value range is from -1.0 to 1.0, where -1.0 means the focal point is close to the left border
//of the radial gradient circle, 0.0 means that the focal point is in the center of the radial
//gradient circle, and 1.0 means that the focal point is close to the right border of the radial
//gradient circle.
//FOCALGRADIENT
//Field 				Type 				Comment
//SpreadMode 			UB[2] 				0 = Pad mode
//											1 = Reflect mode
//											2 = Repeat mode
//											3 = Reserved
//InterpolationMode 	UB[2] 				0 = Normal RGB mode interpolation
//											1 = Linear RGB mode interpolation
//											2 and 3 = Reserved
//NumGradients 			UB[4] 				1 to 15
//GradientRecords 		GRADRECORD[nGrads] 	Gradient records (see following)
//FocalPoint 			FIXED8 				Focal point location
package zero.swf.records{
	import zero.swf.records.GRADRECORD;
	import flash.utils.ByteArray;
	public class FOCALGRADIENT{
		public var SpreadMode:int;
		public var InterpolationMode:int;
		public var NumGradients:int;
		public var GradientRecordV:Vector.<GRADRECORD>;
		public var FocalPoint:Number;					//FIXED8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			SpreadMode=(flags<<24)>>>30;				//11000000
			InterpolationMode=(flags<<26)>>>30;			//00110000
			NumGradients=flags&0x0f;					//00001111
			++offset;
			GradientRecordV=new Vector.<GRADRECORD>(NumGradients);
			for(var i:int=0;i<NumGradients;i++){
			
				GradientRecordV[i]=new GRADRECORD();
				offset=GradientRecordV[i].initByData(data,offset,endOffset);
			}
			FocalPoint=data[offset++]/256+data[offset++];
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=SpreadMode<<6;						//11000000
			flags|=InterpolationMode<<4;				//00110000
			flags|=NumGradients;						//00001111
			data[0]=flags;
			
			data.position=1;
			for each(var GradientRecord:GRADRECORD in GradientRecordV){
				data.writeBytes(GradientRecord.toData());
			}
			var offset:int=data.length;
			data[offset++]=FocalPoint*256;
			data[offset++]=FocalPoint;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<FOCALGRADIENT
				SpreadMode={SpreadMode}
				InterpolationMode={InterpolationMode}
				NumGradients={NumGradients}
				FocalPoint={FocalPoint}
			>
				<GradientRecordList/>
			</FOCALGRADIENT>;
			if(GradientRecordV.length){
				var listXML:XML=xml.GradientRecordList[0];
				listXML.@count=GradientRecordV.length;
				for each(var GradientRecord:GRADRECORD in GradientRecordV){
					var itemXML:XML=<GradientRecord/>;
					itemXML.appendChild(GradientRecord.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.GradientRecordList;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			SpreadMode=int(xml.@SpreadMode.toString());
			InterpolationMode=int(xml.@InterpolationMode.toString());
			NumGradients=int(xml.@NumGradients.toString());
			if(xml.GradientRecordList.length()){
				var listXML:XML=xml.GradientRecordList[0];
				var GradientRecordXMLList:XMLList=listXML.GradientRecord;
				var i:int=-1;
				GradientRecordV=new Vector.<GRADRECORD>(GradientRecordXMLList.length());
				for each(var GradientRecordXML:XML in GradientRecordXMLList){
					i++;
					GradientRecordV[i]=new GRADRECORD();
					GradientRecordV[i].initByXML(GradientRecordXML.children()[0]);
				}
			}else{
				GradientRecordV=new Vector.<GRADRECORD>();
			}
			FocalPoint=Number(xml.@FocalPoint.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
