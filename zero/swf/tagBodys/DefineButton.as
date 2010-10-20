/***
DefineButton 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月17日 10:44:07 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
//Actions 			ACTIONRECORD[zero or more]	Actions to perform
//ActionEndFlag 	UI8 						Must be 0
package zero.swf.tagBodys{
	import zero.swf.records.BUTTONRECORD_within_DefineButton;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineButton extends TagBody{
		public var id:int;								//UI16
		public var CharacterV:Vector.<BUTTONRECORD_within_DefineButton>;
		public var CharacterEndFlag:int;				//UI8
		public var restData:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			//#offsetpp
			offset+=2;
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>();
			while(data[offset]){
				i++;
				//#offsetpp
			
				CharacterV[i]=new BUTTONRECORD_within_DefineButton();
				offset=CharacterV[i].initByData(data,offset,endOffset);
			}
			CharacterEndFlag=data[offset++];
			//#offsetpp
			
			restData=new BytesData();
			return restData.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			//#offsetpp
			data.position=2;
			for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
				data.writeBytes(Character.toData());
			}
			var offset:int=data.length;
			data[offset++]=CharacterEndFlag;
			data.position=offset;
			data.writeBytes(restData.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineButton
				id={id}
				CharacterEndFlag={CharacterEndFlag}
			>
				<list vNames="CharacterV" count={CharacterV.length}/>
				<restData/>
			</DefineButton>;
			var listXML:XML=xml.list[0];
			for each(var Character:BUTTONRECORD_within_DefineButton in CharacterV){
				var itemXML:XML=<Character/>;
				itemXML.appendChild(Character.toXML());
				listXML.appendChild(itemXML);
			}
			xml.restData.appendChild(restData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			var listXML:XML=xml.list[0];
			var CharacterXMLList:XMLList=listXML.Character;
			var i:int=-1;
			CharacterV=new Vector.<BUTTONRECORD_within_DefineButton>(CharacterXMLList.length());
			for each(var CharacterXML:XML in CharacterXMLList){
				i++;
				CharacterV[i]=new BUTTONRECORD_within_DefineButton();
				CharacterV[i].initByXML(CharacterXML.children()[0]);
			}
			CharacterEndFlag=int(xml.@CharacterEndFlag.toString());
			restData=new BytesData();
			restData.initByXML(xml.restData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
