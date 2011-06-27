/***
SOUNDINFO
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The SOUNDINFO record modifies how an event sound is played. An event sound is defined
//with the DefineSound tag. Sound characteristics that can be modified include:
//■ Whether the sound loops (repeats) and how many times it loops.
//■ Where sound playback begins and ends.
//■ A sound envelope for time-based volume control.
//
//SOUNDINFO
//Field 				Type 										Comment
//Reserved 				UB[2] 										Always 0.
//SyncStop 				UB[1] 										Stop the sound now.
//SyncNoMultiple 		UB[1] 										Don't start the sound if already playing.
//HasEnvelope 			UB[1] 										Has envelope information.
//HasLoops 				UB[1] 										Has loop information.
//HasOutPoint 			UB[1] 										Has out-point information.
//HasInPoint 			UB[1] 										Has in-point information.
//InPoint 				If HasInPoint, UI32 						Number of samples to skip at beginning of sound.
//OutPoint 				If HasOutPoint, UI32 						Position in samples of last sample to play.
//LoopCount 			If HasLoops, UI16 							Sound loop count.
//EnvPoints 			If HasEnvelope, UI8 						Sound Envelope point count.
//EnvelopeRecords 		If HasEnvelope, SOUNDENVELOPE[EnvPoints]	Sound Envelope records.
package zero.swf.records.sounds{
	import zero.swf.records.sounds.SOUNDENVELOPE;
	import flash.utils.ByteArray;
	public class SOUNDINFO{//implements I_zero_swf_CheckCodesRight{
		public var SyncStop:int;
		public var SyncNoMultiple:int;
		public var HasEnvelope:int;
		public var HasLoops:int;
		public var HasOutPoint:int;
		public var HasInPoint:int;
		public var InPoint:uint;						//UI32
		public var OutPoint:uint;						//UI32
		public var LoopCount:int;						//UI16
		public var EnvelopeRecordV:Vector.<SOUNDENVELOPE>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset];
			//Reserved=(flags<<24)>>>30;				//11000000
			SyncStop=(flags<<26)>>>31;					//00100000
			SyncNoMultiple=(flags<<27)>>>31;			//00010000
			HasEnvelope=(flags<<28)>>>31;				//00001000
			HasLoops=(flags<<29)>>>31;					//00000100
			HasOutPoint=(flags<<30)>>>31;				//00000010
			HasInPoint=flags&0x01;						//00000001
			++offset;
			if(HasInPoint){
				InPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(HasOutPoint){
				OutPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(HasLoops){
				LoopCount=data[offset++]|(data[offset++]<<8);
			}
			
			if(HasEnvelope){
			
				var EnvPoints:int=data[offset++];
				EnvelopeRecordV=new Vector.<SOUNDENVELOPE>(EnvPoints);
				for(var i:int=0;i<EnvPoints;i++){
			
					EnvelopeRecordV[i]=new SOUNDENVELOPE();
					offset=EnvelopeRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			//flags|=Reserved<<6;						//11000000
			flags|=SyncStop<<5;							//00100000
			flags|=SyncNoMultiple<<4;					//00010000
			flags|=HasEnvelope<<3;						//00001000
			flags|=HasLoops<<2;							//00000100
			flags|=HasOutPoint<<1;						//00000010
			flags|=HasInPoint;							//00000001
			data[0]=flags;
			
			var offset:int=1;
			if(HasInPoint){
				data[offset++]=InPoint;
				data[offset++]=InPoint>>8;
				data[offset++]=InPoint>>16;
				data[offset++]=InPoint>>24;
			}
			
			if(HasOutPoint){
				data[offset++]=OutPoint;
				data[offset++]=OutPoint>>8;
				data[offset++]=OutPoint>>16;
				data[offset++]=OutPoint>>24;
			}
			
			if(HasLoops){
				data[offset++]=LoopCount;
				data[offset++]=LoopCount>>8;
			}
			
			if(HasEnvelope){
				var EnvPoints:int=EnvelopeRecordV.length;
				data[offset++]=EnvPoints;
			
				data.position=offset;
				for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
					data.writeBytes(EnvelopeRecord.toData(_toDataOptions));
				}
			offset=data.length;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="SOUNDINFO"
				SyncStop={SyncStop}
				SyncNoMultiple={SyncNoMultiple}
				HasEnvelope={HasEnvelope}
				HasLoops={HasLoops}
				HasOutPoint={HasOutPoint}
				HasInPoint={HasInPoint}
				InPoint={InPoint}
				OutPoint={OutPoint}
				LoopCount={LoopCount}
			/>;
			if(HasInPoint){
				
			}else{
				delete xml.@InPoint;
			}
			if(HasOutPoint){
				
			}else{
				delete xml.@OutPoint;
			}
			if(HasLoops){
				
			}else{
				delete xml.@LoopCount;
			}
			if(HasEnvelope){
				if(EnvelopeRecordV.length){
					var listXML:XML=<EnvelopeRecordList count={EnvelopeRecordV.length}/>
					for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
						listXML.appendChild(EnvelopeRecord.toXML("EnvelopeRecord",_toXMLOptions));
					}
					xml.appendChild(listXML);
				}
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			SyncStop=int(xml.@SyncStop.toString());
			SyncNoMultiple=int(xml.@SyncNoMultiple.toString());
			HasEnvelope=int(xml.@HasEnvelope.toString());
			HasLoops=int(xml.@HasLoops.toString());
			HasOutPoint=int(xml.@HasOutPoint.toString());
			HasInPoint=int(xml.@HasInPoint.toString());
			if(HasInPoint){
				InPoint=uint(xml.@InPoint.toString());
			}
			if(HasOutPoint){
				OutPoint=uint(xml.@OutPoint.toString());
			}
			if(HasLoops){
				LoopCount=int(xml.@LoopCount.toString());
			}
			if(HasEnvelope){
				if(xml.EnvelopeRecordList.length()){
					var listXML:XML=xml.EnvelopeRecordList[0];
					var EnvelopeRecordXMLList:XMLList=listXML.EnvelopeRecord;
					var i:int=-1;
					EnvelopeRecordV=new Vector.<SOUNDENVELOPE>(EnvelopeRecordXMLList.length());
					for each(var EnvelopeRecordXML:XML in EnvelopeRecordXMLList){
						i++;
						EnvelopeRecordV[i]=new SOUNDENVELOPE();
						EnvelopeRecordV[i].initByXML(EnvelopeRecordXML,_initByXMLOptions);
					}
				}else{
					EnvelopeRecordV=new Vector.<SOUNDENVELOPE>();
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}
