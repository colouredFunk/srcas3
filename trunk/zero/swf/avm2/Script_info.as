/***
Script_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:25:32 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The script_info entry is used to define characteristics of an ActionScript 3.0 script.
//script_info
//{
//	u30 init
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The init field is an index into the method array of the abcFile. It identifies a function that is to be
//invoked prior to any other code in this script.
//它确定一个函数，要
//调用任何其他代码之前在此脚本

//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
//defined by the script.
package zero.swf.avm2{
	import zero.swf.avm2.Traits_info;
	import flash.utils.ByteArray;
	public class Script_info extends AVM2Obj{
		public var init:int;							//u30
		public var traits_infoV:Vector.<Traits_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{init=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{init=data[offset++];}
			//init
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var traits_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{traits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{traits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{traits_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{traits_info_count=data[offset++];}
			//traits_info_count
			traits_infoV=new Vector.<Traits_info>(traits_info_count);
			for(var i:int=0;i<traits_info_count;i++){
			
				traits_infoV[i]=new Traits_info();
				offset=traits_infoV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(init>>>7){if(init>>>14){if(init>>>21){if(init>>>28){data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=((init>>>14)&0x7f)|0x80;data[offset++]=((init>>>21)&0x7f)|0x80;data[offset++]=init>>>28;}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=((init>>>14)&0x7f)|0x80;data[offset++]=init>>>21;}}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=init>>>14;}}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=init>>>7;}}else{data[offset++]=init;}
			//init
			var traits_info_count:int=traits_infoV.length;
			
			if(traits_info_count>>>7){if(traits_info_count>>>14){if(traits_info_count>>>21){if(traits_info_count>>>28){data[offset++]=(traits_info_count&0x7f)|0x80;data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;data[offset++]=((traits_info_count>>>14)&0x7f)|0x80;data[offset++]=((traits_info_count>>>21)&0x7f)|0x80;data[offset++]=traits_info_count>>>28;}else{data[offset++]=(traits_info_count&0x7f)|0x80;data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;data[offset++]=((traits_info_count>>>14)&0x7f)|0x80;data[offset++]=traits_info_count>>>21;}}else{data[offset++]=(traits_info_count&0x7f)|0x80;data[offset++]=((traits_info_count>>>7)&0x7f)|0x80;data[offset++]=traits_info_count>>>14;}}else{data[offset++]=(traits_info_count&0x7f)|0x80;data[offset++]=traits_info_count>>>7;}}else{data[offset++]=traits_info_count;}
			//traits_info_count
			
			data.position=offset;
			for each(var traits_info:Traits_info in traits_infoV){
				data.writeBytes(traits_info.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Script_info
				init={init}
			>
				<traits_infoList/>
			</Script_info>;
			if(traits_infoV.length){
				var listXML:XML=xml.traits_infoList[0];
				listXML.@count=traits_infoV.length;
				for each(var traits_info:Traits_info in traits_infoV){
					var itemXML:XML=<traits_info/>;
					itemXML.appendChild(traits_info.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.traits_infoList;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			init=int(xml.@init.toString());
			if(xml.traits_infoList.length()){
				var listXML:XML=xml.traits_infoList[0];
				var traits_infoXMLList:XMLList=listXML.traits_info;
				var i:int=-1;
				traits_infoV=new Vector.<Traits_info>(traits_infoXMLList.length());
				for each(var traits_infoXML:XML in traits_infoXMLList){
					i++;
					traits_infoV[i]=new Traits_info();
					traits_infoV[i].initByXML(traits_infoXML.children()[0]);
				}
			}else{
				traits_infoV=new Vector.<Traits_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
