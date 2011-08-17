/***
SOUNDINFO
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
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
		public var SyncStop:Boolean;
		public var SyncNoMultiple:Boolean;
		public var HasOutPoint:Boolean;
		public var HasInPoint:Boolean;
		public var InPoint:uint;						//UI32
		public var OutPoint:uint;						//UI32
		public var LoopCount:int;						//UI16
		public var EnvelopeRecordV:Vector.<SOUNDENVELOPE>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset++];
			//Reserved=(flags<<24)>>>30;				//11000000
			SyncStop=((flags&0x20)?true:false);		//00100000
			SyncNoMultiple=((flags&0x10)?true:false);	//00010000
			HasOutPoint=((flags&0x02)?true:false);		//00000010
			HasInPoint=((flags&0x01)?true:false);		//00000001
			if(HasInPoint){
				InPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(HasOutPoint){
				OutPoint=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			}
			
			if(flags&0x04){//HasLoops					//00000100
				LoopCount=data[offset++]|(data[offset++]<<8);
			}else{
				LoopCount=-1;
			}
			
			if(flags&0x08){//HasEnvelope				//00001000
				var EnvPoints:int=data[offset++];
				if(EnvPoints){
					
					var EnvelopeRecordClass:Class;
					if(_initByDataOptions){
						if(_initByDataOptions.classes){
							EnvelopeRecordClass=_initByDataOptions.classes["zero.swf.records.sounds.SOUNDENVELOPE"];
						}
					}
					if(EnvelopeRecordClass){
					}else{
						EnvelopeRecordClass=SOUNDENVELOPE;
					}
					
					EnvelopeRecordV=new Vector.<SOUNDENVELOPE>();
					for(var i:int=0;i<EnvPoints;i++){
						EnvelopeRecordV[i]=new EnvelopeRecordClass();
						offset=EnvelopeRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
					}
				}else{
					EnvelopeRecordV=null;
				}
			}else{
				EnvelopeRecordV=null;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			//flags|=Reserved<<6;						//11000000
			if(SyncStop){
				flags|=0x20;							//00100000
			}
			if(SyncNoMultiple){
				flags|=0x10;								//00010000
			}
			
			var offset:int=1;
			if(HasInPoint){
				flags|=0x01;							//00000001
				data[offset++]=InPoint;
				data[offset++]=InPoint>>8;
				data[offset++]=InPoint>>16;
				data[offset++]=InPoint>>24;
			}
			
			if(HasOutPoint){
				flags|=0x02;							//00000010
				data[offset++]=OutPoint;
				data[offset++]=OutPoint>>8;
				data[offset++]=OutPoint>>16;
				data[offset++]=OutPoint>>24;
			}
			
			if(LoopCount>-1){
				flags|=0x04;							//00000100
				data[offset++]=LoopCount;
				data[offset++]=LoopCount>>8;
			}
			
			if(EnvelopeRecordV){
				var EnvPoints:int=EnvelopeRecordV.length;
				if(EnvPoints){
					flags|=0x80;						//00001000
					data[offset++]=EnvPoints;
					data.position=offset;
					for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
						data.writeBytes(EnvelopeRecord.toData(_toDataOptions));
					}
					offset=data.length;
				}
			
			}
			data[0]=flags;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.records.sounds.SOUNDINFO"
				SyncStop={SyncStop}
				SyncNoMultiple={SyncNoMultiple}
				HasOutPoint={HasOutPoint}
				HasInPoint={HasInPoint}
			/>;
			if(HasInPoint){
				xml.@InPoint=InPoint;
			}
			if(HasOutPoint){
				xml.@OutPoint=OutPoint;
			}
			if(LoopCount>-1){
				xml.@LoopCount=LoopCount;
			}
			if(EnvelopeRecordV){
				if(EnvelopeRecordV.length){
					var EnvelopeRecordListXML:XML=<EnvelopeRecordList count={EnvelopeRecordV.length}/>
					for each(var EnvelopeRecord:SOUNDENVELOPE in EnvelopeRecordV){
						EnvelopeRecordListXML.appendChild(EnvelopeRecord.toXML("EnvelopeRecord",_toXMLOptions));
					}
					xml.appendChild(EnvelopeRecordListXML);
				}
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			SyncStop=(xml.@SyncStop.toString()=="true");
			SyncNoMultiple=(xml.@SyncNoMultiple.toString()=="true");
			HasOutPoint=(xml.@HasOutPoint.toString()=="true");
			HasInPoint=(xml.@HasInPoint.toString()=="true");
			if(HasInPoint){
				InPoint=uint(xml.@InPoint.toString());
			}
			if(HasOutPoint){
				OutPoint=uint(xml.@OutPoint.toString());
			}
			var LoopCountXML:XML=xml.@LoopCount[0];
			if(LoopCountXML){
				LoopCount=int(LoopCountXML.toString());
			}else{
				LoopCount=-1;
			}
			var EnvelopeRecordXMLList:XMLList=xml.EnvelopeRecordList.EnvelopeRecord;
			if(EnvelopeRecordXMLList.length()){
				var i:int=-1;
				EnvelopeRecordV=new Vector.<SOUNDENVELOPE>();
				for each(var EnvelopeRecordXML:XML in EnvelopeRecordXMLList){
					i++;
					EnvelopeRecordV[i]=new SOUNDENVELOPE();
					EnvelopeRecordV[i].initByXML(EnvelopeRecordXML,_initByXMLOptions);
				}
			}else{
				EnvelopeRecordV=null;
			}
		}
		}//end of CONFIG::USE_XML
	}
}
