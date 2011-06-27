/***
DefineButton2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineButton2
//DefineButton2 extends the capabilities of DefineButton by allowing any state transition to
//trigger actions.
//The minimum file format version is SWF 3:
//Starting with SWF 9, if the ActionScript3 field of the FileAttributes tag is 1, there must be no
//BUTTONCONDACTION fields in the DefineButton2 tag. ActionOffset must be 0. This
//structure is not supported because it is not permitted to mix ActionScript 1/2 and
//ActionScript 3.0 code within the same SWF file.


//Field 							Type 							Comment
//Header 							RECORDHEADER 					Tag type = 34
//ButtonId 							UI16 							ID for this character
//ReservedFlags 					UB[7] 							Always 0
//TrackAsMenu 						UB[1] 							0 = track as normal button
//																	1 = track as menu button
//ActionOffset 						UI16 							Offset in bytes from start of this
//Characters 						BUTTONRECORD[one or more]		Characters that make up the button
//CharacterEndFlag 					UI8 							Must be 0
//Actions 							BUTTONCONDACTION[zero or more]	Actions to execute at particular button events field to the first BUTTONCONDACTION, or 0 if no actions occur
package zero.swf.tagBodys{
	import zero.swf.records.buttons.BUTTONRECORD;
	import zero.swf.records.buttons.BUTTONCONDACTION;
	import flash.utils.ByteArray;
	public class DefineButton2/*{*/implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var TrackAsMenu:int;
		public var CharacterV:Vector.<BUTTONRECORD>;
		public var CharacterEndFlag:int;				//UI8
		public var ActionsV:Vector.<BUTTONCONDACTION>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:zero_swf_InitByDataOptions):int{
			id=data[offset]|(data[offset+1]<<8);
			var flags:int=data[offset+2];
			//Reserved=(flags<<24)>>>25;				//11111110
			TrackAsMenu=flags&0x01;						//00000001
			//Reserved=data[offset+3]|(data[offset+4]<<8);
			offset+=5;
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD>();
			while(data[offset]){
				i++;
			
				CharacterV[i]=new BUTTONRECORD();
				offset=CharacterV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			CharacterEndFlag=data[offset++];
			
			i=-1;
			ActionsV=new Vector.<BUTTONCONDACTION>();
			while(offset<endOffset){
				i++;
			
				ActionsV[i]=new BUTTONCONDACTION();
				offset=ActionsV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			return offset;
		}
		public function toData(_toDataOptions:zero_swf_ToDataOptions):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			var flags:int=0;
			//flags|=Reserved<<1;						//11111110
			flags|=TrackAsMenu;							//00000001
			data[2]=flags;
			
			data[3]=0x00;
			data[4]=0x00;
			data.position=5;
			for each(var Character:BUTTONRECORD in CharacterV){
				data.writeBytes(Character.toData(_toDataOptions));
			}
			var offset:int=data.length;
			data[offset++]=CharacterEndFlag;
			if(ActionsV.length){
				var ActionOffset:int=offset-3;
				data[3]=ActionOffset;
				data[4]=ActionOffset>>8;
			}
			data.position=offset;
			var restActionsNum:int=ActionsV.length;
			for each(var Actions:BUTTONCONDACTION in ActionsV){
				var ActionsData:ByteArray=Actions.toData(_toDataOptions);
				if(--restActionsNum){
					var CondActionSize:int=ActionsData.length;
					ActionsData[0]=CondActionSize;
					ActionsData[1]=CondActionSize>>8;
				}//else{
				//	ActionsData[0]=0;
				//	ActionsData[1]=0;
				//}
				data.writeBytes(ActionsData);
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName} class="DefineButton2"
				id={id}
				TrackAsMenu={TrackAsMenu}
				CharacterEndFlag={CharacterEndFlag}
			/>;
			if(CharacterV.length){
				var listXML:XML=<CharacterList count={CharacterV.length}/>
				for each(var Character:BUTTONRECORD in CharacterV){
					listXML.appendChild(Character.toXML("Character",_toXMLOptions));
				}
				xml.appendChild(listXML);
			}
			if(ActionsV.length){
				listXML=<ActionsList count={ActionsV.length}/>
				for each(var Actions:BUTTONCONDACTION in ActionsV){
					listXML.appendChild(Actions.toXML("Actions",_toXMLOptions));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			id=int(xml.@id.toString());
			TrackAsMenu=int(xml.@TrackAsMenu.toString());
			if(xml.CharacterList.length()){
				var listXML:XML=xml.CharacterList[0];
				var CharacterXMLList:XMLList=listXML.Character;
				var i:int=-1;
				CharacterV=new Vector.<BUTTONRECORD>(CharacterXMLList.length());
				for each(var CharacterXML:XML in CharacterXMLList){
					i++;
					CharacterV[i]=new BUTTONRECORD();
					CharacterV[i].initByXML(CharacterXML,_initByXMLOptions);
				}
			}else{
				CharacterV=new Vector.<BUTTONRECORD>();
			}
			CharacterEndFlag=int(xml.@CharacterEndFlag.toString());
			if(xml.ActionsList.length()){
				listXML=xml.ActionsList[0];
				var ActionsXMLList:XMLList=listXML.Actions;
				i=-1;
				ActionsV=new Vector.<BUTTONCONDACTION>(ActionsXMLList.length());
				for each(var ActionsXML:XML in ActionsXMLList){
					i++;
					ActionsV[i]=new BUTTONCONDACTION();
					ActionsV[i].initByXML(ActionsXML,_initByXMLOptions);
				}
			}else{
				ActionsV=new Vector.<BUTTONCONDACTION>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
