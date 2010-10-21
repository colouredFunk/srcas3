/***
RTQNameL 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:20:00 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//multiname_kind_RTQNameL
//{
//}

//This kind has no associated data.
//什么都没有...
package zero.swf.avm2.multinames{
	import flash.utils.ByteArray;
	public class RTQNameL extends Multiname_info{
		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <RTQNameL/>;
		}
		override public function initByXML(xml:XML):void{
			
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
