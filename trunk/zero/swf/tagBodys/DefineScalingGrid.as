/***
DefineScalingGrid
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineScalingGrid
//The DefineScalingGrid tag introduces the concept of 9-slice scaling, which allows
//component-style scaling to be applied to a sprite or button character.
//When the DefineScalingGrid tag associates a character with a 9-slice grid, Flash Player
//conceptually divides the sprite or button into nine sections with a grid-like overlay. When the
//character is scaled, each of the nine areas is scaled independently. To maintain the visual
//integrity of the character, corners are not scaled, while the remaining areas of the image are
//scaled larger or smaller, as needed.
//DefineScalingGrid
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 78
//CharacterId 		UI16 			ID of sprite or button character upon which the scaling grid will be applied.
//Splitter 			RECT 			Center region of 9-slice grid
package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import flash.utils.ByteArray;
	public class DefineScalingGrid{//implements I_zero_swf_CheckCodesRight{
		public var CharacterId:int;						//UI16
		public var Splitter:RECT;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			CharacterId=data[offset]|(data[offset+1]<<8);
			offset+=2;
			Splitter=new RECT();
			return Splitter.initByData(data,offset,endOffset,_initByDataOptions);
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data.position=2;
			data.writeBytes(Splitter.toData(_toDataOptions));
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineScalingGrid"
				CharacterId={CharacterId}
			/>;
			xml.appendChild(Splitter.toXML("Splitter",_toXMLOptions));
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			CharacterId=int(xml.@CharacterId.toString());
			Splitter=new RECT();
			Splitter.initByXML(xml.Splitter[0],_initByXMLOptions);
		}
		}//end of CONFIG::USE_XML
	}
}
