/***
DefineShape4 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月9日 22:32:46 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tag_body{
	import zero.swf.record.RECT;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class DefineShape4 extends TagBody{
		public var id:int;								//UI16
		public var ShapeBounds:RECT;
		public var EdgeBounds:RECT;
		public var restDatas:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			//#offsetpp
			offset+=2;
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset);
			//#offsetpp
			
			EdgeBounds=new RECT();
			offset=EdgeBounds.initByData(data,offset,endOffset);
			//#offsetpp
			
			restDatas=new BytesData();
			return restDatas.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData());
			data.writeBytes(EdgeBounds.toData());
			data.writeBytes(restDatas.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineShape4
				id={id}
			>
				<ShapeBounds/>
				<EdgeBounds/>
				<restDatas/>
			</DefineShape4>;
			xml.ShapeBounds.appendChild(ShapeBounds.toXML());
			xml.EdgeBounds.appendChild(EdgeBounds.toXML());
			xml.restDatas.appendChild(restDatas.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			ShapeBounds=new RECT();
			ShapeBounds.initByXML(xml.ShapeBounds.children()[0]);
			EdgeBounds=new RECT();
			EdgeBounds.initByXML(xml.EdgeBounds.children()[0]);
			restDatas=new BytesData();
			restDatas.initByXML(xml.restDatas.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
