/***
DefineButton
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
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
//Actions 			ACTIONRECORD[zero or more]	Actions to perform		//经测试发现就只有一个 ACTIONRECORD
//ActionEndFlag 	UI8 						Must be 0
package zero.swf.tagBodys{
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineButton{//implements I_zero_swf_CheckCodesRight{
		public var id:int;								//UI16
		public var restDatas:BytesData;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(restDatas.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineButton"
				id={id}
			/>;
			xml.appendChild(restDatas.toXML("restDatas",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			id=int(xml.@id.toString());
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
