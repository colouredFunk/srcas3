/***
DefineShape4 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月30日 17:34:52 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tag_body{

	import flash.utils.ByteArray;

	import zero.BytesAndStr16;
	import zero.swf.BytesData;

	public class DefineShape4 extends TagBody{
		public var id:int;						//UI16
		public var bytesData:BytesData;			
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			id=data[offset]|(data[offset+1]<<8);
			bytesData=new BytesData();
			bytesData.initByData(data,offset+2,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(bytesData.toData());
			//var offset:int=data.length;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineShape4
				id={id}
			>
				<bytesData/>
			</DefineShape4>;
			xml.bytesData.appendChild(bytesData.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			bytesData=new BytesData();
			bytesData.initByXML(xml.bytesData.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
