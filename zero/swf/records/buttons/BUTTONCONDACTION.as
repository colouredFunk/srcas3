/***
BUTTONCONDACTION
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//BUTTONCONDACTION
//Field 					Type 						Comment
//CondActionSize 			UI16 						Offset in bytes from start of this field to next BUTTONCONDACTION, or 0 if last action
//CondIdleToOverDown 		UB[1] 						Idle to OverDown
//CondOutDownToIdle 		UB[1] 						OutDown to Idle
//CondOutDownToOverDown 	UB[1] 						OutDown to OverDown
//CondOverDownToOutDown 	UB[1] 						OverDown to OutDown
//CondOverDownToOverUp 		UB[1] 						OverDown to OverUp
//CondOverUpToOverDown 		UB[1] 						OverUp to OverDown
//CondOverUpToIdle 			UB[1] 						OverUp to Idle
//CondIdleToOverUp 			UB[1] 						Idle to OverUp

//CondKeyPress 				UB[7] 						SWF 4 or later: key code Otherwise: always 0
//														Valid key codes:
//														1 = left arrow
//														2 = right arrow
//														3 = home
//														4 = end
//														5 = insert
//														6 = delete
//														8 = backspace
//														13 = enter
//														14 = up arrow
//														15 = down arrow
//														16 = page up
//														17 = page down
//														18 = tab
//														19 = escape
//														32 to 126: follows ASCII
//CondOverDownToIdle 		UB[1] 						OverDown to Idle
//Actions 					ACTIONRECORD[zero or more]	Actions to perform. See DoAction.
//ActionEndFlag 			UI8 						Must be 0
package zero.swf.records.buttons{
	import zero.swf.records.KeyPressKeyCodes;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	public class BUTTONCONDACTION/*{*/implements I_zero_swf_CheckCodesRight{
		public var CondIdleToOverDown:int;
		public var CondOutDownToIdle:int;
		public var CondOutDownToOverDown:int;
		public var CondOverDownToOutDown:int;
		public var CondOverDownToOverUp:int;
		public var CondOverUpToOverDown:int;
		public var CondOverUpToIdle:int;
		public var CondIdleToOverUp:int;
		public var CondKeyPress:int;
		public var CondOverDownToIdle:int;
		public var Actions:I_zero_swf_CheckCodesRight;	//Actions
		public var ActionEndFlag:int;					//UI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			var CondActionSize:int=data[offset]|(data[offset+1]<<8);
			if(CondActionSize){
				endOffset=offset+CondActionSize;
			}
			var flags:int=data[offset+2];
			CondIdleToOverDown=(flags<<24)>>>31;		//10000000
			CondOutDownToIdle=(flags<<25)>>>31;			//01000000
			CondOutDownToOverDown=(flags<<26)>>>31;		//00100000
			CondOverDownToOutDown=(flags<<27)>>>31;		//00010000
			CondOverDownToOverUp=(flags<<28)>>>31;		//00001000
			CondOverUpToOverDown=(flags<<29)>>>31;		//00000100
			CondOverUpToIdle=(flags<<30)>>>31;			//00000010
			CondIdleToOverUp=flags&0x01;				//00000001
			flags=data[offset+3];
			CondKeyPress=(flags<<24)>>>25;				//11111110
			CondOverDownToIdle=flags&0x01;				//00000001
			offset+=4;
			if(_initByDataOptions&&_initByDataOptions.ActionsClass){
				Actions=new _initByDataOptions.ActionsClass();
			}else{
				Actions=new (getDefinitionByName("zero.swf.BytesData"))();
			}
			offset=Actions.initByData(data,offset,endOffset-1,_initByDataOptions);
			ActionEndFlag=data[offset++];
			return offset;
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=0x00;//CondActionSize
			data[1]=0x00;//CondActionSize
			var flags:int=0;
			flags|=CondIdleToOverDown<<7;				//10000000
			flags|=CondOutDownToIdle<<6;				//01000000
			flags|=CondOutDownToOverDown<<5;			//00100000
			flags|=CondOverDownToOutDown<<4;			//00010000
			flags|=CondOverDownToOverUp<<3;				//00001000
			flags|=CondOverUpToOverDown<<2;				//00000100
			flags|=CondOverUpToIdle<<1;					//00000010
			flags|=CondIdleToOverUp;					//00000001
			data[2]=flags;
			
			flags=0;
			flags|=CondKeyPress<<1;						//11111110
			flags|=CondOverDownToIdle;					//00000001
			data[3]=flags;
			
			data.position=4;
			data.writeBytes(Actions.toData(_toDataOptions));
			data[data.length]=ActionEndFlag;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="BUTTONCONDACTION"
				CondIdleToOverDown={CondIdleToOverDown}
				CondOutDownToIdle={CondOutDownToIdle}
				CondOutDownToOverDown={CondOutDownToOverDown}
				CondOverDownToOutDown={CondOverDownToOutDown}
				CondOverDownToOverUp={CondOverDownToOverUp}
				CondOverUpToOverDown={CondOverUpToOverDown}
				CondOverUpToIdle={CondOverUpToIdle}
				CondIdleToOverUp={CondIdleToOverUp}
				CondKeyPress={KeyPressKeyCodes.keyCodeV[CondKeyPress]}
				CondOverDownToIdle={CondOverDownToIdle}
				ActionEndFlag={ActionEndFlag}
			/>;
			
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			CondIdleToOverDown=int(xml.@CondIdleToOverDown.toString());
			CondOutDownToIdle=int(xml.@CondOutDownToIdle.toString());
			CondOutDownToOverDown=int(xml.@CondOutDownToOverDown.toString());
			CondOverDownToOutDown=int(xml.@CondOverDownToOutDown.toString());
			CondOverDownToOverUp=int(xml.@CondOverDownToOverUp.toString());
			CondOverUpToOverDown=int(xml.@CondOverUpToOverDown.toString());
			CondOverUpToIdle=int(xml.@CondOverUpToIdle.toString());
			CondIdleToOverUp=int(xml.@CondIdleToOverUp.toString());
			CondKeyPress=KeyPressKeyCodes[xml.@CondKeyPress.toString()];
			CondOverDownToIdle=int(xml.@CondOverDownToIdle.toString());
			switch(xml.Actions[0]["@class"].toString()){
				case "ACTIONRECORD":
					Actions=new (getDefinitionByName("zero.swf.avm1.ACTIONRECORD"))();
				break;
				default:
					Actions=new (getDefinitionByName("zero.swf.BytesData"))();
				break;
			}
			Actions.initByXML(xml.Actions[0],_initByXMLOptions);
			ActionEndFlag=int(xml.@ActionEndFlag.toString());
		}
		}//end of CONFIG::USE_XML
	}
}
