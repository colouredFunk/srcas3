/***
DefineButtonCxform
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:47（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//DefineButtonCxform
//DefineButtonCxform defines the color transform for each shape and text character in a
//button. This is not used for DefineButton2, which includes its own CXFORM.
//The minimum file format version is SWF 2.
//
//DefineButtonCxform
//Field 					Type 			Comment
//Header 					RECORDHEADER 	Tag type = 23
//ButtonId 					UI16 			Button ID for this information
//ButtonColorTransforms 	CXFORM[n] 		Character color transform 依次每个ButtonRecord的CXFORM(文档里是错的)
package zero.swf.tagBodys{
	import zero.swf.records.CXFORM;
	import flash.utils.ByteArray;
	public class DefineButtonCxform{//implements I_zero_swf_CheckCodesRight{
		public var ButtonId:int;						//UI16
		public var ButtonColorTransformV:Vector.<CXFORM>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			ButtonId=data[offset]|(data[offset+1]<<8);
			offset+=2;
			var i:int=-1;
			ButtonColorTransformV=new Vector.<CXFORM>();
			while(offset<endOffset){
				i++;
			
				ButtonColorTransformV[i]=new CXFORM();
				offset=ButtonColorTransformV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=ButtonId;
			data[1]=ButtonId>>8;
			data.position=2;
			for each(var ButtonColorTransform:CXFORM in ButtonColorTransformV){
				data.writeBytes(ButtonColorTransform.toData(_toDataOptions));
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="DefineButtonCxform"
				ButtonId={ButtonId}
			/>;
			if(ButtonColorTransformV.length){
				var listXML:XML=<ButtonColorTransformList count={ButtonColorTransformV.length}/>
				for each(var ButtonColorTransform:CXFORM in ButtonColorTransformV){
					listXML.appendChild(ButtonColorTransform.toXML("ButtonColorTransform",_toXMLOptions));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			ButtonId=int(xml.@ButtonId.toString());
			if(xml.ButtonColorTransformList.length()){
				var listXML:XML=xml.ButtonColorTransformList[0];
				var ButtonColorTransformXMLList:XMLList=listXML.ButtonColorTransform;
				var i:int=-1;
				ButtonColorTransformV=new Vector.<CXFORM>(ButtonColorTransformXMLList.length());
				for each(var ButtonColorTransformXML:XML in ButtonColorTransformXMLList){
					i++;
					ButtonColorTransformV[i]=new CXFORM();
					ButtonColorTransformV[i].initByXML(ButtonColorTransformXML,_initByXMLOptions);
				}
			}else{
				ButtonColorTransformV=new Vector.<CXFORM>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
