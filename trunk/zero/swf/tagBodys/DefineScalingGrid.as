/***
DefineScalingGrid 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月12日 18:28:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
	import zero.swf.records.gardents.GRADIENT;
	import zero.swf.records.gardents.FOCALGRADIENT;
	import zero.swf.records.lineStyles.LINESTYLE;
	import zero.swf.records.RECT;
	import flash.utils.ByteArray;
	public class DefineScalingGrid{
		public var CharacterId:int;						//UI16
		public var Splitter:RECT;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			CharacterId=data[offset]|(data[offset+1]<<8);
			offset+=2;
			Splitter=new RECT();
			return Splitter.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=CharacterId;
			data[1]=CharacterId>>8;
			data.position=2;
			data.writeBytes(Splitter.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="DefineScalingGrid"
				CharacterId={CharacterId}
			/>;
			xml.appendChild(Splitter.toXML("Splitter"));
			return xml;
		}
		public function initByXML(xml:XML):void{
			CharacterId=int(xml.@CharacterId.toString());
			Splitter=new RECT();
			Splitter.initByXML(xml.Splitter[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
