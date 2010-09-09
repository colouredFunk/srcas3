/***
DefineButtonCxform 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月9日 11:08:19 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
//ButtonColorTransforms 	CXFORM[n] 			Character color transform 依次每个ButtonRecord的CXFORM(文档里是错的)
package zero.swf.tag_body{
	import zero.swf.record.CXFORM;
	import flash.utils.ByteArray;
	public class DefineButtonCxform extends TagBody{
		public var ButtonId:int;				//UI16
		public var ButtonColorTransformV:Vector.<CXFORM>;		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ButtonId=data[offset]|(data[offset+1]<<8);
			ButtonColorTransformV=new Vector.<CXFORM>();
			offset+=2;
			//#offsetpp
			var i:int=-1;
			while(offset<endOffset){
				i++;
				//#offsetpp
				ButtonColorTransformV[i]=new CXFORM();
				offset=ButtonColorTransformV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=ButtonId;
			data[1]=ButtonId>>8;
			data.position=2;
			for each(var ButtonColorTransform:CXFORM in ButtonColorTransformV){
				data.writeBytes(ButtonColorTransform.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineButtonCxform
				ButtonId={ButtonId}
			>
				<list vNames="ButtonColorTransformV" count={ButtonColorTransformV.length}/>
			</DefineButtonCxform>;
			var listXML:XML=xml.list[0];
			for each(var ButtonColorTransform:CXFORM in ButtonColorTransformV){
				var itemXML:XML=<ButtonColorTransform/>;
				itemXML.appendChild(ButtonColorTransform.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			ButtonId=int(xml.@ButtonId.toString());
			var listXML:XML=xml.list[0];
			var ButtonColorTransformXMLList:XMLList=listXML.ButtonColorTransform;
			ButtonColorTransformV=new Vector.<CXFORM>();
			var i:int=-1;
			for each(var ButtonColorTransformXML:XML in ButtonColorTransformXMLList){
				i++;
				ButtonColorTransformV[i]=new CXFORM();
				ButtonColorTransformV[i].initByXML(ButtonColorTransformXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
