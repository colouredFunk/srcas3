/***
DoAction
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DoAction instructs Flash Player to perform a list of actions when the current frame is
//complete. The actions are performed when the ShowFrame tag is encountered, regardless of
//where in the frame the DoAction tag appears.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoAction tag will be ignored.

//Field 			Type 							Comment
//Header 			RECORDHEADER 					Tag type = 12
//Actions 			ACTIONRECORD [zero or more] 	List of actions to perform (see following table, ActionRecord)
//ActionEndFlag 	UI8 = 0 						Always set to 0
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	public class DoAction{//implements I_zero_swf_CheckCodesRight{
		public var Actions:*;	//Actions
		public var ActionEndFlag:int;					//UI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(_initByDataOptions&&_initByDataOptions.ActionsClass){
				Actions=new _initByDataOptions.ActionsClass();
			}else{
				Actions=new (getDefinitionByName("zero.swf.BytesData"))();
			}
			offset=Actions.initByData(data,offset,endOffset-1,_initByDataOptions);
			ActionEndFlag=data[offset++];
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeBytes(Actions.toData(_toDataOptions));
			data[data.length]=ActionEndFlag;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DoAction"
				ActionEndFlag={ActionEndFlag}
			/>;
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
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
