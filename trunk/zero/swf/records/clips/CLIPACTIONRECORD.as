/***
CLIPACTIONRECORD
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//CLIPACTIONRECORD
//Field 			Type 															Comment
//EventFlags 		CLIPEVENTFLAGS 													Events to which this handler applies
//ActionRecordSize 	UI32 															Offset in bytes from end of this field to next CLIPACTIONRECORD (or ClipActionEndFlag)
//KeyCode 			If EventFlags contain ClipEventKeyPress: UI8 Otherwise absent	Key code to trap (see"DefineButton2" on page 226)
//Actions 			ACTIONRECORD [one or more]										Actions to perform
package zero.swf.records.clips{
	import zero.swf.records.clips.CLIPEVENTFLAGS;
	import zero.swf.records.KeyPressKeyCodes;
	import zero.swf.avm1.ACTIONRECORDs;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	public class CLIPACTIONRECORD{//implements I_zero_swf_CheckCodesRight{
		public var EventFlags:CLIPEVENTFLAGS;
		public var KeyCode:int;							//UI8
		public var Actions:*;							//Actions
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			EventFlags=new CLIPEVENTFLAGS();
			offset=EventFlags.initByData(data,offset,endOffset,_initByDataOptions);
			var ActionRecordSize:int=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			endOffset=offset+ActionRecordSize;
			if(EventFlags.ClipEventKeyPress>0){
				KeyCode=data[offset++];
			}
			var ActionsClass:Class;
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					ActionsClass=_initByDataOptions.classes["zero.swf.avm1.ACTIONRECORDs"];
				}
				if(ActionsClass){
				}else{
					ActionsClass=_initByDataOptions.ActionsClass;
				}
			}
			Actions=new (ActionsClass||ACTIONRECORDs)();
			return Actions.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(EventFlags.toData(_toDataOptions));
			var offset:int=data.length;
			offset+=4;
			var ActionRecordSizeOffset:int=offset;
			if(EventFlags.ClipEventKeyPress>0){
				data[offset++]=KeyCode;
			}
			data.position=offset;
			data.writeBytes(Actions.toData(_toDataOptions));
			var ActionRecordSize:int=data.length-ActionRecordSizeOffset;
			data[ActionRecordSizeOffset-4]=ActionRecordSize;
			data[ActionRecordSizeOffset-3]=ActionRecordSize>>8;
			data[ActionRecordSizeOffset-2]=ActionRecordSize>>16;
			data[ActionRecordSizeOffset-1]=ActionRecordSize>>24;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.records.clips.CLIPACTIONRECORD"/>;
			xml.appendChild(EventFlags.toXML("EventFlags",_toXMLOptions));
			if(EventFlags.ClipEventKeyPress>0){
				xml.@KeyCode=KeyPressKeyCodes.keyCodeV[KeyCode];
			}
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			EventFlags=new CLIPEVENTFLAGS();
			EventFlags.initByXML(xml.EventFlags[0],_initByXMLOptions);
			if(EventFlags.ClipEventKeyPress>0){
				KeyCode=KeyPressKeyCodes[xml.@KeyCode.toString()];
			}
			var ActionsXML:XML=xml.Actions[0];
			var classStr:String=ActionsXML["@class"].toString();
			var ActionsClass:Class=null;
			if(_initByXMLOptions&&_initByXMLOptions.customClasses){
				ActionsClass=_initByXMLOptions.customClasses[classStr];
			}
			if(ActionsClass){
			}else{
				try{
					ActionsClass=getDefinitionByName(classStr) as Class;
				}catch(e:Error){
					ActionsClass=null;
				}
			}
			Actions=new (ActionsClass||ACTIONRECORDs)();
			Actions.initByXML(ActionsXML,_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
