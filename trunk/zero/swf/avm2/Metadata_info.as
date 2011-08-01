/***
Metadata_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//metadata_info
//{
//	u30 name
//	u30 item_count
//	item_info items[item_count]
//}

//The name field is an index into the string array of the constant pool; it provides a name for the metadata
//entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
//item_count denotes the number of items that follow in the items array.
//name 是在 constant_pool.string_v 中的id
package zero.swf.avm2{
	import zero.swf.avm2.Item_info;
	import flash.utils.ByteArray;
	public class Metadata_info{//implements I_zero_swf_CheckCodesRight{
		public var name:int;							//u30
		public var item_infoV:Vector.<Item_info>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			//name
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var item_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{item_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{item_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{item_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{item_count=data[offset++];}
			//item_count
			item_infoV=new Vector.<Item_info>();
			for(var i:int=0;i<item_count;i++){
			
				item_infoV[i]=new Item_info();
				offset=item_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			//name
			var item_count:int=item_infoV.length;
			
			if(item_count>>>7){if(item_count>>>14){if(item_count>>>21){if(item_count>>>28){data[offset++]=(item_count&0x7f)|0x80;data[offset++]=((item_count>>>7)&0x7f)|0x80;data[offset++]=((item_count>>>14)&0x7f)|0x80;data[offset++]=((item_count>>>21)&0x7f)|0x80;data[offset++]=item_count>>>28;}else{data[offset++]=(item_count&0x7f)|0x80;data[offset++]=((item_count>>>7)&0x7f)|0x80;data[offset++]=((item_count>>>14)&0x7f)|0x80;data[offset++]=item_count>>>21;}}else{data[offset++]=(item_count&0x7f)|0x80;data[offset++]=((item_count>>>7)&0x7f)|0x80;data[offset++]=item_count>>>14;}}else{data[offset++]=(item_count&0x7f)|0x80;data[offset++]=item_count>>>7;}}else{data[offset++]=item_count;}
			//item_count
			
			data.position=offset;
			for each(var item_info:Item_info in item_infoV){
				data.writeBytes(item_info.toData(_toDataOptions));
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.avm2.Metadata_info"
				name={name}
			/>;
			if(item_infoV.length){
				var item_infoListXML:XML=<item_infoList count={item_infoV.length}/>
				for each(var item_info:Item_info in item_infoV){
					item_infoListXML.appendChild(item_info.toXML("item_info",_toXMLOptions));
				}
				xml.appendChild(item_infoListXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			name=int(xml.@name.toString());
			var i:int=-1;
			item_infoV=new Vector.<Item_info>();
			for each(var item_infoXML:XML in xml.item_infoList.item_info){
				i++;
				item_infoV[i]=new Item_info();
				item_infoV[i].initByXML(item_infoXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}
