/***
Trait_method 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:22:57 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//trait_method
//{
//	u30 disp_id
//	u30 method
//}

//The disp_id field is a compiler assigned integer that is used by the AVM2 to optimize the resolution of
//virtual function calls. An overridden method must have the same disp_id as that of the method in the
//base class. A value of zero disables this optimization.

//The method field is an index that points into the method array of the abcFile entry.
package zero.swf.avm2.traits{
	import flash.utils.ByteArray;
	public class Trait_method extends Trait{
		public var disp_id:int;							//u30
		public var methodi:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{disp_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{disp_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{disp_id=data[offset++];}
			//disp_id
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{methodi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{methodi=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{methodi=data[offset++];}
			//methodi
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(disp_id>>>7){if(disp_id>>>14){if(disp_id>>>21){if(disp_id>>>28){data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=((disp_id>>>14)&0x7f)|0x80;data[offset++]=((disp_id>>>21)&0x7f)|0x80;data[offset++]=disp_id>>>28;}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=((disp_id>>>14)&0x7f)|0x80;data[offset++]=disp_id>>>21;}}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=((disp_id>>>7)&0x7f)|0x80;data[offset++]=disp_id>>>14;}}else{data[offset++]=(disp_id&0x7f)|0x80;data[offset++]=disp_id>>>7;}}else{data[offset++]=disp_id;}
			//disp_id
			
			if(methodi>>>7){if(methodi>>>14){if(methodi>>>21){if(methodi>>>28){data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=((methodi>>>14)&0x7f)|0x80;data[offset++]=((methodi>>>21)&0x7f)|0x80;data[offset++]=methodi>>>28;}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=((methodi>>>14)&0x7f)|0x80;data[offset++]=methodi>>>21;}}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=((methodi>>>7)&0x7f)|0x80;data[offset++]=methodi>>>14;}}else{data[offset++]=(methodi&0x7f)|0x80;data[offset++]=methodi>>>7;}}else{data[offset++]=methodi;}
			//methodi
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <Trait_method
				disp_id={disp_id}
				methodi={methodi}
			/>;
		}
		override public function initByXML(xml:XML):void{
			disp_id=int(xml.@disp_id.toString());
			methodi=int(xml.@methodi.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
