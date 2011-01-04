/***
RemoveObject2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:01:29 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//RemoveObject2
//The RemoveObject2 tag removes the character at the specified depth from the display list.
//The minimum file format version is SWF 3.

//RemoveObject2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 28
//Depth 			UI16 			Depth of character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class RemoveObject2{
		public var Depth:int;							//UI16
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			Depth=data[offset]|(data[offset+1]<<8);
			return offset+2;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=Depth;
			data[1]=Depth>>8;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return <{xmlName} class="RemoveObject2"
				Depth={Depth}
			/>;
		}
		public function initByXML(xml:XML):void{
			Depth=int(xml.@Depth.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
