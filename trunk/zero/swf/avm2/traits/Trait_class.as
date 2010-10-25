/***
Trait_class 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:22:57 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//trait_class
//{
//	u30 slot_id
//	u30 classi
//}

//The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. A
//value of 0 requests the AVM2 to assign a position.

//The classi field is an index that points into the class array of the abcFile entry.
package zero.swf.avm2.traits{
	import flash.utils.ByteArray;
	public class Trait_class extends Trait{
		public var slot_id:int;							//u30
		public var classi:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{slot_id=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{slot_id=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{slot_id=data[offset++];}
			//slot_id
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{classi=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{classi=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{classi=data[offset++];}
			//classi
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(slot_id>>>7){if(slot_id>>>14){if(slot_id>>>21){if(slot_id>>>28){data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=((slot_id>>>21)&0x7f)|0x80;data[offset++]=slot_id>>>28;}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=((slot_id>>>14)&0x7f)|0x80;data[offset++]=slot_id>>>21;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=((slot_id>>>7)&0x7f)|0x80;data[offset++]=slot_id>>>14;}}else{data[offset++]=(slot_id&0x7f)|0x80;data[offset++]=slot_id>>>7;}}else{data[offset++]=slot_id;}
			//slot_id
			
			if(classi>>>7){if(classi>>>14){if(classi>>>21){if(classi>>>28){data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=((classi>>>14)&0x7f)|0x80;data[offset++]=((classi>>>21)&0x7f)|0x80;data[offset++]=classi>>>28;}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=((classi>>>14)&0x7f)|0x80;data[offset++]=classi>>>21;}}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=((classi>>>7)&0x7f)|0x80;data[offset++]=classi>>>14;}}else{data[offset++]=(classi&0x7f)|0x80;data[offset++]=classi>>>7;}}else{data[offset++]=classi;}
			//classi
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <Trait_class
				slot_id={slot_id}
				classi={classi}
			/>;
		}
		override public function initByXML(xml:XML):void{
			slot_id=int(xml.@slot_id.toString());
			classi=int(xml.@classi.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
