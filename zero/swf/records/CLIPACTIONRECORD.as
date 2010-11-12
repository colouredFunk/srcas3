/***
CLIPACTIONRECORD 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 18:38:20 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//CLIPACTIONRECORD
//Field 			Type 															Comment
//EventFlags 		CLIPEVENTFLAGS 													Events to which this handler applies
//ActionRecordSize 	UI32 															Offset in bytes from end of this field to next CLIPACTIONRECORD (or ClipActionEndFlag)
//KeyCode 			If EventFlags contain ClipEventKeyPress: UI8 Otherwise absent	Key code to trap (see"DefineButton2" on page 226)
//Actions 			ACTIONRECORD [one or more]										Actions to perform
package zero.swf.records{
	import zero.swf.records.CLIPEVENTFLAGS;
	import zero.swf.vmarks.KeyPressKeyCodes;
	import zero.swf.avm1.ACTIONRECORD;
	import flash.utils.ByteArray;
	public class CLIPACTIONRECORD{
		public var EventFlags:CLIPEVENTFLAGS;
		
		public var KeyCode:int;							//UI8
		public var Actions:ACTIONRECORD;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			EventFlags=new CLIPEVENTFLAGS();
			offset=EventFlags.initByData(data,offset,endOffset);
			var ActionRecordSize:int=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			endOffset=offset+ActionRecordSize;
			
			if(EventFlags.ClipEventKeyPress){
				KeyCode=data[offset++];
			}
			Actions=new ACTIONRECORD();
			return Actions.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(EventFlags.toData());
			var offset:int=data.length;
			offset+=4;
			var ActionRecordSizeOffset:int=offset;
			if(EventFlags.ClipEventKeyPress){
				data[offset++]=KeyCode;
			}
			data.position=offset;
			data.writeBytes(Actions.toData());
			var ActionRecordSize:int=data.length-ActionRecordSizeOffset;
			data[ActionRecordSizeOffset-4]=ActionRecordSize;
			data[ActionRecordSizeOffset-3]=ActionRecordSize>>8;
			data[ActionRecordSizeOffset-2]=ActionRecordSize>>16;
			data[ActionRecordSizeOffset-1]=ActionRecordSize>>24;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="CLIPACTIONRECORD"
				KeyCode={KeyPressKeyCodes.keyCodeV[KeyCode]}
			/>;
			xml.appendChild(EventFlags.toXML("EventFlags"));
			
			if(EventFlags.ClipEventKeyPress){
				
			}else{
				delete xml.@KeyCode;
			}
			xml.appendChild(Actions.toXML("Actions"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			EventFlags=new CLIPEVENTFLAGS();
			EventFlags.initByXML(xml.EventFlags[0]);
			
			if(EventFlags.ClipEventKeyPress){
				KeyCode=KeyPressKeyCodes[xml.@KeyCode.toString()];
			}
			Actions=new ACTIONRECORD();
			Actions.initByXML(xml.Actions[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
