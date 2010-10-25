/***
BUTTONCONDACTION 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:08:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
package zero.swf.records{
	import zero.swf.vmarks.KeyPressKeyCodes;
	import zero.swf.avm1.ACTIONRECORD;
	import flash.utils.ByteArray;
	public class BUTTONCONDACTION extends Record{
		public var CondActionSize:int;					//UI16
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
		public var Actions:ACTIONRECORD;
		public var ActionEndFlag:int;					//UI8
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			CondActionSize=data[offset]|(data[offset+1]<<8);
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
			Actions=new ACTIONRECORD();
			offset=Actions.initByData(data,offset,endOffset-1);
			ActionEndFlag=data[offset++];
			return offset;
		}
		override public function toData():ByteArray{
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
			data.writeBytes(Actions.toData());
			data[data.length]=ActionEndFlag;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<BUTTONCONDACTION
				CondActionSize={CondActionSize}
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
			>
				<Actions/>
			</BUTTONCONDACTION>;
			xml.Actions.appendChild(Actions.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			CondActionSize=int(xml.@CondActionSize.toString());
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
			Actions=new ACTIONRECORD();
			Actions.initByXML(xml.Actions.children()[0]);
			ActionEndFlag=int(xml.@ActionEndFlag.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
