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
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var ns_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ns_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ns_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ns_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ns_count=data[offset++];}
			//ns_count
			nsV=new Vector.<int>();
			for(var i:int=0;i<ns_count;i++){
			
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{nsV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{nsV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{nsV[i]=data[offset++];}
				//nsV[i]
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var ns_count:int=nsV.length;
			var offset:int=0;
			if(ns_count>>>7){if(ns_count>>>14){if(ns_count>>>21){if(ns_count>>>28){data[offset++]=(ns_count&0x7f)|0x80;data[offset++]=((ns_count>>>7)&0x7f)|0x80;data[offset++]=((ns_count>>>14)&0x7f)|0x80;data[offset++]=((ns_count>>>21)&0x7f)|0x80;data[offset++]=ns_count>>>28;}else{data[offset++]=(ns_count&0x7f)|0x80;data[offset++]=((ns_count>>>7)&0x7f)|0x80;data[offset++]=((ns_count>>>14)&0x7f)|0x80;data[offset++]=ns_count>>>21;}}else{data[offset++]=(ns_count&0x7f)|0x80;data[offset++]=((ns_count>>>7)&0x7f)|0x80;data[offset++]=ns_count>>>14;}}else{data[offset++]=(ns_count&0x7f)|0x80;data[offset++]=ns_count>>>7;}}else{data[offset++]=ns_count;}
			//ns_count
			
			for each(var ns:int in nsV){
			
				if(ns>>>7){if(ns>>>14){if(ns>>>21){if(ns>>>28){data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=((ns>>>21)&0x7f)|0x80;data[offset++]=ns>>>28;}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=((ns>>>14)&0x7f)|0x80;data[offset++]=ns>>>21;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=((ns>>>7)&0x7f)|0x80;data[offset++]=ns>>>14;}}else{data[offset++]=(ns&0x7f)|0x80;data[offset++]=ns>>>7;}}else{data[offset++]=ns;}
				//ns
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.avm2.Ns_set_info"/>;
			if(nsV.length){
				var nsListXML:XML=<nsList count={nsV.length}/>
				for each(var ns:int in nsV){
					nsListXML.appendChild(<ns value={ns}/>);
				}
				xml.appendChild(nsListXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var i:int=-1;
			nsV=new Vector.<int>();
			for each(var nsXML:XML in xml.nsList.ns){
				i++;
				nsV[i]=int(nsXML.@value.toString());
			}
		}
		}//end of CONFIG::USE_XML
	}
}
