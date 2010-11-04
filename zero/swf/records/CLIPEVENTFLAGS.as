/***
CLIPEVENTFLAGS 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月3日 13:28:45 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The CLIPEVENTFLAGS sequence specifies one or more sprite events to which an event
//handler applies. In SWF 5 and earlier, CLIPEVENTFLAGS is 2 bytes; in SWF 6 and later, it
//is 4 bytes.

//CLIPEVENTFLAGS
//Field 					Type 						Comment
//ClipEventKeyUp 			UB[1] 						Key up event
//ClipEventKeyDown 			UB[1] 						Key down event
//ClipEventMouseUp 			UB[1] 						Mouse up event
//ClipEventMouseDown 		UB[1] 						Mouse down event
//ClipEventMouseMove 		UB[1] 						Mouse move event
//ClipEventUnload 			UB[1] 						Clip unload event
//ClipEventEnterFrame 		UB[1] 						Frame event
//ClipEventLoad 			UB[1] 						Clip load event

//ClipEventDragOver 		UB[1] 						SWF 6 and later: mouse drag over event Otherwise: always 0
//ClipEventRollOut 			UB[1] 						SWF 6 and later: mouse rollout event Otherwise: always 0
//ClipEventRollOver 		UB[1] 						SWF 6 and later: mouse rollover event Otherwise: always 0
//ClipEventReleaseOutside 	UB[1] 						SWF 6 and later: mouse release outside event Otherwise: always 0
//ClipEventRelease 			UB[1] 						SWF 6 and later: mouse release inside event Otherwise: always 0
//ClipEventPress 			UB[1] 						SWF 6 and later: mouse press event Otherwise: always 0
//ClipEventInitialize 		UB[1] 						SWF 6 and later: initialize event Otherwise: always 0
//ClipEventData 			UB[1] 						Data received event

//Reserved 					If SWF version >= 6, UB[5] 	Always 0
//ClipEventConstruct 		If SWF version >= 6, UB[1] 	SWF 7 and later: construct event Otherwise: always 0
//ClipEventKeyPress 		If SWF version >= 6, UB[1] 	Key press event
//ClipEventDragOut 			If SWF version >= 6, UB[1] 	Mouse drag out event
//Reserved 					If SWF version >= 6, UB[8] 	Always 0
package zero.swf.records{
	import flash.utils.ByteArray;
	public class CLIPEVENTFLAGS{
		public var ClipEventKeyUp:int;
		public var ClipEventKeyDown:int;
		public var ClipEventMouseUp:int;
		public var ClipEventMouseDown:int;
		public var ClipEventMouseMove:int;
		public var ClipEventUnload:int;
		public var ClipEventEnterFrame:int;
		public var ClipEventLoad:int;
		public var ClipEventDragOver:int;
		public var ClipEventRollOut:int;
		public var ClipEventRollOver:int;
		public var ClipEventReleaseOutside:int;
		public var ClipEventRelease:int;
		public var ClipEventPress:int;
		public var ClipEventInitialize:int;
		public var ClipEventData:int;
		public var ClipEventConstruct:int;
		public var ClipEventKeyPress:int;
		public var ClipEventDragOut:int;
		public var HasEndReservedUI8:Boolean;			//HasEndReservedUI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ClipEventConstruct=-1;
			var flags:int=data[offset];
			ClipEventKeyUp=(flags<<24)>>>31;			//10000000
			ClipEventKeyDown=(flags<<25)>>>31;			//01000000
			ClipEventMouseUp=(flags<<26)>>>31;			//00100000
			ClipEventMouseDown=(flags<<27)>>>31;		//00010000
			ClipEventMouseMove=(flags<<28)>>>31;		//00001000
			ClipEventUnload=(flags<<29)>>>31;			//00000100
			ClipEventEnterFrame=(flags<<30)>>>31;		//00000010
			ClipEventLoad=flags&0x01;					//00000001
			flags=data[offset+1];
			ClipEventDragOver=(flags<<24)>>>31;			//10000000
			ClipEventRollOut=(flags<<25)>>>31;			//01000000
			ClipEventRollOver=(flags<<26)>>>31;			//00100000
			ClipEventReleaseOutside=(flags<<27)>>>31;	//00010000
			ClipEventRelease=(flags<<28)>>>31;			//00001000
			ClipEventPress=(flags<<29)>>>31;			//00000100
			ClipEventInitialize=(flags<<30)>>>31;		//00000010
			ClipEventData=flags&0x01;					//00000001
			offset+=2;
			if(offset<endOffset){
				flags=data[offset++];
				//Reserved=(flags<<24)>>>27;				//11111000
				ClipEventConstruct=(flags<<29)>>>31;		//00000100
				ClipEventKeyPress=(flags<<30)>>>31;			//00000010
				ClipEventDragOut=flags&0x01;				//00000001
			}
			if(offset<endOffset){
				offset++;
				HasEndReservedUI8=true;
			}
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			flags|=ClipEventKeyUp<<7;					//10000000
			flags|=ClipEventKeyDown<<6;					//01000000
			flags|=ClipEventMouseUp<<5;					//00100000
			flags|=ClipEventMouseDown<<4;				//00010000
			flags|=ClipEventMouseMove<<3;				//00001000
			flags|=ClipEventUnload<<2;					//00000100
			flags|=ClipEventEnterFrame<<1;				//00000010
			flags|=ClipEventLoad;						//00000001
			data[0]=flags;
			
			flags=0;
			flags|=ClipEventDragOver<<7;				//10000000
			flags|=ClipEventRollOut<<6;					//01000000
			flags|=ClipEventRollOver<<5;				//00100000
			flags|=ClipEventReleaseOutside<<4;			//00010000
			flags|=ClipEventRelease<<3;					//00001000
			flags|=ClipEventPress<<2;					//00000100
			flags|=ClipEventInitialize<<1;				//00000010
			flags|=ClipEventData;						//00000001
			data[1]=flags;
			
			var offset:int=2;
			if(ClipEventConstruct>=0){
				flags=0;
				//flags|=Reserved<<3;						//11111000
				flags|=ClipEventConstruct<<2;				//00000100
				flags|=ClipEventKeyPress<<1;				//00000010
				flags|=ClipEventDragOut;					//00000001
				data[offset++]=flags;
			}
			if(HasEndReservedUI8){
				data[data.length]=0x00;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="CLIPEVENTFLAGS"
				ClipEventKeyUp={ClipEventKeyUp}
				ClipEventKeyDown={ClipEventKeyDown}
				ClipEventMouseUp={ClipEventMouseUp}
				ClipEventMouseDown={ClipEventMouseDown}
				ClipEventMouseMove={ClipEventMouseMove}
				ClipEventUnload={ClipEventUnload}
				ClipEventEnterFrame={ClipEventEnterFrame}
				ClipEventLoad={ClipEventLoad}
				ClipEventDragOver={ClipEventDragOver}
				ClipEventRollOut={ClipEventRollOut}
				ClipEventRollOver={ClipEventRollOver}
				ClipEventReleaseOutside={ClipEventReleaseOutside}
				ClipEventRelease={ClipEventRelease}
				ClipEventPress={ClipEventPress}
				ClipEventInitialize={ClipEventInitialize}
				ClipEventData={ClipEventData}
				ClipEventConstruct={ClipEventConstruct}
				ClipEventKeyPress={ClipEventKeyPress}
				ClipEventDragOut={ClipEventDragOut}
				HasEndReservedUI8={HasEndReservedUI8}
			/>;
			if(ClipEventConstruct>=0){
				
			}else{
				delete xml.@ClipEventConstruct;
				delete xml.@ClipEventKeyPress;
				delete xml.@ClipEventDragOut;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			ClipEventConstruct=-1;
			ClipEventKeyUp=int(xml.@ClipEventKeyUp.toString());
			ClipEventKeyDown=int(xml.@ClipEventKeyDown.toString());
			ClipEventMouseUp=int(xml.@ClipEventMouseUp.toString());
			ClipEventMouseDown=int(xml.@ClipEventMouseDown.toString());
			ClipEventMouseMove=int(xml.@ClipEventMouseMove.toString());
			ClipEventUnload=int(xml.@ClipEventUnload.toString());
			ClipEventEnterFrame=int(xml.@ClipEventEnterFrame.toString());
			ClipEventLoad=int(xml.@ClipEventLoad.toString());
			ClipEventDragOver=int(xml.@ClipEventDragOver.toString());
			ClipEventRollOut=int(xml.@ClipEventRollOut.toString());
			ClipEventRollOver=int(xml.@ClipEventRollOver.toString());
			ClipEventReleaseOutside=int(xml.@ClipEventReleaseOutside.toString());
			ClipEventRelease=int(xml.@ClipEventRelease.toString());
			ClipEventPress=int(xml.@ClipEventPress.toString());
			ClipEventInitialize=int(xml.@ClipEventInitialize.toString());
			ClipEventData=int(xml.@ClipEventData.toString());
			if(xml.@ClipEventConstruct){
				ClipEventConstruct=int(xml.@ClipEventConstruct.toString());
				ClipEventKeyPress=int(xml.@ClipEventKeyPress.toString());
				ClipEventDragOut=int(xml.@ClipEventDragOut.toString());
			}
			HasEndReservedUI8=(xml.@HasEndReservedUI8.toString()==="true");
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
