/***
Item_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:25:31 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The item_info entry consists of item_count elements that are interpreted as key/value pairs of indices into the
//string table of the constant pool. If the value of key is zero, this is a keyless entry and only carries a value.

//item_info
//{
//	u30 key
//	u30 value
//}
package zero.swf.avm2{
	import flash.utils.ByteArray;
	public class Item_info extends AVM2Obj{
		public var key:int;								//u30
		public var value:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){key=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{key=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{key=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{key=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{key=data[offset++];}
			//key
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{value=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{value=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{value=data[offset++];}
			//value
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(key>>>7){if(key>>>14){if(key>>>21){if(key>>>28){data[offset++]=(key&0x7f)|0x80;data[offset++]=((key>>>7)&0x7f)|0x80;data[offset++]=((key>>>14)&0x7f)|0x80;data[offset++]=((key>>>21)&0x7f)|0x80;data[offset++]=key>>>28;}else{data[offset++]=(key&0x7f)|0x80;data[offset++]=((key>>>7)&0x7f)|0x80;data[offset++]=((key>>>14)&0x7f)|0x80;data[offset++]=key>>>21;}}else{data[offset++]=(key&0x7f)|0x80;data[offset++]=((key>>>7)&0x7f)|0x80;data[offset++]=key>>>14;}}else{data[offset++]=(key&0x7f)|0x80;data[offset++]=key>>>7;}}else{data[offset++]=key;}
			//key
			
			if(value>>>7){if(value>>>14){if(value>>>21){if(value>>>28){data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=((value>>>14)&0x7f)|0x80;data[offset++]=((value>>>21)&0x7f)|0x80;data[offset++]=value>>>28;}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=((value>>>14)&0x7f)|0x80;data[offset++]=value>>>21;}}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=((value>>>7)&0x7f)|0x80;data[offset++]=value>>>14;}}else{data[offset++]=(value&0x7f)|0x80;data[offset++]=value>>>7;}}else{data[offset++]=value;}
			//value
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String=null):XML{//暂时带默认 null 值{
			return <Item_info
				key={key}
				value={value}
			/>;
		}
		override public function initByXML(xml:XML):void{
			key=int(xml.@key.toString());
			value=int(xml.@value.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
