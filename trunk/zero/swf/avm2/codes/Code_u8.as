/***
Code_u8 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 09:06:04 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import zero.swf.avm2.AVM2Op;
	import flash.utils.ByteArray;
	public class Code_u8 extends Code{
		public var op:int;								//u8
		public var u8:int;								//u8
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			op=data[offset];
			u8=data[offset+1];
			return offset+2;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=op;
			data[1]=u8;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			return <{xmlName} class="Code_u8"
				op={AVM2Op.opNameV[op]}
				u8={u8}
			/>;
		}
		override public function initByXML(xml:XML):void{
			op=AVM2Op[xml.@op.toString()];
			u8=int(xml.@u8.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
