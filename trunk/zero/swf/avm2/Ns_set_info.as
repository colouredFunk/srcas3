/***
Ns_set_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//An ns_set_info entry defines a set of namespaces, allowing the set to be used as a unit in the definition of multinames.

//			ns_set_info
//			{
//				u30 count
//				u30 ns[count]
//			}

//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
//the namespace array of the constant pool.
//ns是在 constant_pool.namespace_info_v 中的id
//No entry in the ns array may be zero.
package zero.swf.avm2{
	import flash.utils.ByteArray;
	public class Ns_set_info{//implements I_zero_swf_CheckCodesRight{
		public var nsV:Vector.<int>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			//#offsetpp
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var integer_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integer_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integer_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integer_count=data[offset++];}
			//integer_count
			nsV=new Vector.<int>(integer_count);
			for(var i:int=0;i<integer_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{nsV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{nsV[i]=data[offset++];}
				//nsV[i]
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var integer_count:int=nsV.length;
			var offset:int=0;
			if(integer_count>>>7){if(integer_count>>>14){if(integer_count>>>21){if(integer_count>>>28){data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=((integer_count>>>21)&0x7f)|0x80;data[offset++]=integer_count>>>28;}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=((integer_count>>>14)&0x7f)|0x80;data[offset++]=integer_count>>>21;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=((integer_count>>>7)&0x7f)|0x80;data[offset++]=integer_count>>>14;}}else{data[offset++]=(integer_count&0x7f)|0x80;data[offset++]=integer_count>>>7;}}else{data[offset++]=integer_count;}
			//integer_count
			
			for each(var ns:int in nsV){
			
				if(ns>>>7){if(ns>>>14){if(ns>>>21){if(ns>>>28){data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=((ns>>>21)&0x7f)|0x80;data[offset++]=ns>>>28;}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=ns>>>21;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=ns>>>14;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=ns>>>7;}}else{data[offset++]=ns;}
				//ns
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="Ns_set_info"/>;
			if(nsV.length){
				var listXML:XML=<nsList count={nsV.length}/>
				for each(var ns:int in nsV){
					listXML.appendChild(<ns value={ns}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			if(xml.nsList.length()){
				var listXML:XML=xml.nsList[0];
				var nsXMLList:XMLList=listXML.ns;
				var i:int=-1;
				nsV=new Vector.<int>(nsXMLList.length());
				for each(var nsXML:XML in nsXMLList){
					i++;
					nsV[i]=int(nsXML.@value.toString());
				}
			}else{
				nsV=new Vector.<int>();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
