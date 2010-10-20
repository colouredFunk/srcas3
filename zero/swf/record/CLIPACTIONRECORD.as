/***
CLIPACTIONRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 12:19:36 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//CLIPACTIONRECORD
//Field 			Type 															Comment
//EventFlags 		CLIPEVENTFLAGS 													Events to which this handler applies
//ActionRecordSize 	UI32 															Offset in bytes from end of this field to next CLIPACTIONRECORD (or ClipActionEndFlag)
//KeyCode 			If EventFlags contain ClipEventKeyPress: UI8 Otherwise absent	Key code to trap (see"DefineButton2" on page 226)
//Actions 			ACTIONRECORD [one or more]										Actions to perform
package zero.swf.record{
	import zero.swf.record.CLIPEVENTFLAGS;
	import zero.swf.vmark.KeyPressKeyCodes;
	import zero.swf.avm1.ACTIONRECORD;
	import flash.utils.ByteArray;
	public class CLIPACTIONRECORD extends Record{
		public var EventFlags:CLIPEVENTFLAGS;
		public var ActionRecordSize:uint;				//UI32
		public var KeyCode:int;							//UI8
		public var Actions:ACTIONRECORD;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			EventFlags=new CLIPEVENTFLAGS();
			offset=EventFlags.initByData(data,offset,endOffset);
			ActionRecordSize=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			endOffset=offset+ActionRecordSize;
			//#offsetpp
			
			if(EventFlags.ClipEventKeyPress){
				KeyCode=data[offset++];
			}
			//#offsetpp
			
			Actions=new ACTIONRECORD();
			return Actions.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data.writeBytes(EventFlags.toData());
			var offset:int=data.length;
			offset+=4;
			var ActionRecordSizeOffset:int=offset;
			//#offsetpp
			if(EventFlags.ClipEventKeyPress){
				data[offset++]=KeyCode;
			}
			data.position=offset;
			data.writeBytes(Actions.toData());
			ActionRecordSize=data.length-ActionRecordSizeOffset;
			data[ActionRecordSizeOffset-4]=ActionRecordSize;
			data[ActionRecordSizeOffset-3]=ActionRecordSize>>8;
			data[ActionRecordSizeOffset-2]=ActionRecordSize>>16;
			data[ActionRecordSizeOffset-1]=ActionRecordSize>>24;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<CLIPACTIONRECORD
				ActionRecordSize={ActionRecordSize}
				KeyCode={KeyPressKeyCodes.keyCodeV[KeyCode]}
			>
				<EventFlags/>
				<Actions/>
			</CLIPACTIONRECORD>;
			xml.EventFlags.appendChild(EventFlags.toXML());
			if(EventFlags.ClipEventKeyPress){
				
			}else{
				delete xml.@KeyCode;
			}
			xml.Actions.appendChild(Actions.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			EventFlags=new CLIPEVENTFLAGS();
			EventFlags.initByXML(xml.EventFlags.children()[0]);
			ActionRecordSize=uint(xml.@ActionRecordSize.toString());
			if(EventFlags.ClipEventKeyPress){
				KeyCode=KeyPressKeyCodes[xml.@KeyCode.toString()];
			}
			Actions=new ACTIONRECORD();
			Actions.initByXML(xml.Actions.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
