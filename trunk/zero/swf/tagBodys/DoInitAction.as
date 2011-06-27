/***
DoInitAction
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The DoInitAction tag is similar to the DoInitAction tag: it defines a series of bytecodes to be
//executed. However, the actions defined with DoInitAction are executed earlier than the usual
//DoInitAction actions, and are executed only once.
//In some situations, actions must be executed before the ActionScript representation of the first
//instance of a particular sprite is created. The most common such action is calling
//Object.registerClass to associate an ActionScript class with a sprite. Such a call is generally
//found within the #initclip pragma in the ActionScript language. DoInitAction is used to
//implement the #initclip pragma.
//A DoInitAction tag specifies a particular sprite to which its actions apply. A single frame can
//contain multiple DoInitAction tags; their actions are executed in the order in which the tags
//appear. However, the SWF file can contain only one DoInitAction tag for any particular
//sprite.
//The specified actions are executed immediately before the normal actions of the frame in
//which the DoInitAction tag appears. This only occurs the first time that this frame is
//encountered; playback reaches the same frame again later, actions provided in DoInitAction
//are skipped.
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, the contents of
//the DoInitAction tag will be ignored.

//NOTE
//Specifying actions at the beginning of a DoInitAction tag is not the same as specifying them
//in a DoInitAction tag. Flash Player takes steps before the first action in a DoInitAction tag,
//most relevantly the creation of ActionScript objects that represent sprites. The actions in
//DoInitAction occur before these implicit steps are performed.

//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 59
//Sprite ID 		UI16 						Sprite to which these actions apply
//Actions 			ACTIONRECORD[zero or more] 	List of actions to perform
//ActionEndFlag 	UI8 						Always set to 0
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	public class DoInitAction{//implements I_zero_swf_CheckCodesRight{
		public var SpriteID:int;						//UI16
		public var Actions:*;	//Actions
		public var ActionEndFlag:int;					//UI8
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			SpriteID=data[offset]|(data[offset+1]<<8);
			offset+=2;
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
			data[0]=SpriteID;
			data[1]=SpriteID>>8;
			data.position=2;
			data.writeBytes(Actions.toData(_toDataOptions));
			data[data.length]=ActionEndFlag;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DoInitAction"
				SpriteID={SpriteID}
				ActionEndFlag={ActionEndFlag}
			/>;
			xml.appendChild(Actions.toXML("Actions",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			SpriteID=int(xml.@SpriteID.toString());
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
