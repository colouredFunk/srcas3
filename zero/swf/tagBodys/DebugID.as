/***
DebugID 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 15:32:52 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//swf_tag 63为DebugID 其中记录debug的id号
//格式为 UUID (UI8[16])
package zero.swf.tagBodys{
	import zero.BytesAndStr16;
	import flash.utils.ByteArray;
	public class DebugID{
		public var id:String;							//DebugID
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=
				BytesAndStr16._16V[data[offset]]+
				BytesAndStr16._16V[data[offset+1]]+
				BytesAndStr16._16V[data[offset+2]]+
				BytesAndStr16._16V[data[offset+3]]+
				"-"+
				BytesAndStr16._16V[data[offset+4]]+
				BytesAndStr16._16V[data[offset+5]]+
				"-"+
				BytesAndStr16._16V[data[offset+6]]+
				BytesAndStr16._16V[data[offset+7]]+
				"-"+
				BytesAndStr16._16V[data[offset+8]]+
				BytesAndStr16._16V[data[offset+9]]+
				"-"+
				BytesAndStr16._16V[data[offset+10]]+
				BytesAndStr16._16V[data[offset+11]]+
				BytesAndStr16._16V[data[offset+12]]+
				BytesAndStr16._16V[data[offset+13]]+
				BytesAndStr16._16V[data[offset+14]]+
				BytesAndStr16._16V[data[offset+15]];
			return offset+16;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var idStr:String=id.replace(/-/g,"");
			data.writeUnsignedInt(uint("0x"+idStr.substr(0,8)));
			data.writeUnsignedInt(uint("0x"+idStr.substr(8,8)));
			data.writeUnsignedInt(uint("0x"+idStr.substr(16,8)));
			data.writeUnsignedInt(uint("0x"+idStr.substr(24,8)));
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return <{xmlName} class="DebugID"
				id={id}
			/>;
		}
		public function initByXML(xml:XML):void{
			id=xml.@id.toString();
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
