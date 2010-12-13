/***
DefineButton 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 00:53:20 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The DefineButton tag defines a button character for later use by control tags such as
//PlaceObject.
//DefineButton includes an array of Button records that represent the four button shapes: an up
//character, a mouse-over character, a down character, and a hit-area character. It is not
//necessary to define all four states, but at least one button record must be present. For example,
//if the same button record defines both the up and over states, only three button records are
//required to describe the button.
//More than one button record per state is allowed. If two button records refer to the same state,
//both are displayed for that state.
//DefineButton also includes an array of ACTIONRECORDs, which are performed when the
//button is clicked and released (see "SWF 3 actions" on page 68).

//The minimum file format version is SWF 1.

//DefineButton
//Field 			Type 						Comment
//Header 			RECORDHEADER 				Tag type = 7
//ButtonId 			UI16 						ID for this character
//Characters 		BUTTONRECORD[one or more]	Characters that make up the button
//CharacterEndFlag 	UI8 						Must be 0
//Actions 			ACTIONRECORD[zero or more]	Actions to perform		//flash5 导出只有一个 ACTIONRECORD, flash8 导出是一个 BUTTONCONDACTION 的列表
//ActionEndFlag 	UI8 						Must be 0
package zero.swf.tagBodys{
	import zero.swf.records.BUTTONRECORD_within_DefineButton;
	import flash.utils.ByteArray;
	//import zero.swf.CurrSWFVersion;
	//import zero.swf.avm1.ACTIONRECORD;
	//import zero.swf.records.BUTTONCONDACTION;
	import zero.swf.BytesData;
	public class DefineButton{
		public var id:int;								//UI16
		public var CharacterV:Vector.<BUTTONRECORD_within_DefineButton>;
		public var CharacterEndFlag:int;				//UI8
		////
		//public var Actions:ACTIONRECORD;
		//public var ActionEndFlag:int;					//UI8
		//public var ActionsV:Vector.<BUTTONCONDACTION>;
		////
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>();
			while(data[offset]){
				i++;
			
				CharacterV[i]=new BUTTONRECORD_within_DefineButton();
				offset=CharacterV[i].initByData(data,offset,endOffset);
			}
			CharacterEndFlag=data[offset++];
			/*
			if(CurrSWFVersion.Version<6){
				Actions=new ACTIONRECORD();
				offset=Actions.initByData(data,offset,endOffset-1);
				ActionEndFlag=data[offset++];
			}else{
				i=-1;
				ActionsV=new Vector.<BUTTONCONDACTION>();
				while(offset<endOffset){
					i++;
				
					ActionsV[i]=new BUTTONCONDACTION();
					offset=ActionsV[i].initByData(data,offset,endOffset);
				}
			}
			return offset;
			*/
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
				data.writeBytes(Character.toData());
			}
			var offset:int=data.length;
			data[offset++]=CharacterEndFlag;
			data.position=offset;
			/*
			if(Actions){
				data.writeBytes(Actions.toData());
				data[data.length]=ActionEndFlag;
			}else{
				var restActionsNum:int=ActionsV.length;
				for each(var Actions:BUTTONCONDACTION in ActionsV){
					var ActionsData:ByteArray=Actions.toData();
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
			}
			*/
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineButton"
				id={id}
				CharacterEndFlag={CharacterEndFlag}
			/>;
			if(CharacterV.length){
				var listXML:XML=<CharacterList count={CharacterV.length}/>
				for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
					listXML.appendChild(Character.toXML("Character"));
				}
				xml.appendChild(listXML);
			}
			/*
			if(Actions){
				xml.appendChild(Actions.toXML("Actions"));
				xml.@ActionEndFlag=ActionEndFlag;
			}else{
				if(ActionsV.length){
					listXML=<ActionsList count={ActionsV.length}/>
					for each(var Actions:BUTTONCONDACTION in ActionsV){
						listXML.appendChild(Actions.toXML("Actions"));
					}
					xml.appendChild(listXML);
				}
			}
			*/
			xml.appendChild(restDatas.toXML("restDatas"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			if(xml.CharacterList.length()){
				var listXML:XML=xml.CharacterList[0];
				var CharacterXMLList:XMLList=listXML.Character;
				var i:int=-1;
				CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>(CharacterXMLList.length());
				for each(var CharacterXML:XML in CharacterXMLList){
					i++;
					CharacterV[i]=new BUTTONRECORD_within_DefineButton();
					CharacterV[i].initByXML(CharacterXML);
				}
			}else{
				CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>();
			}
			CharacterEndFlag=int(xml.@CharacterEndFlag.toString());
			/*
			if(xml.Actions.length()){
				Actions=new ACTIONRECORD();
				Actions.initByXML(xml.Actions[0]);
				ActionEndFlag=int(xml.@ActionEndFlag.toString());
			}else{
				if(xml.ActionsList.length()){
					listXML=xml.ActionsList[0];
					var ActionsXMLList:XMLList=listXML.Actions;
					i=-1;
					ActionsV=new Vector.<BUTTONCONDACTION>(ActionsXMLList.length());
					for each(var ActionsXML:XML in ActionsXMLList){
						i++;
						ActionsV[i]=new BUTTONCONDACTION();
						ActionsV[i].initByXML(ActionsXML);
					}
				}else{
					ActionsV=new Vector.<BUTTONCONDACTION>();
				}
			}
			*/
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
