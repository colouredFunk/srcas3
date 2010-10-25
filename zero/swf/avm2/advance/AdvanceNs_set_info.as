/***
AdvanceNs_set_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 09:47:24 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
package zero.swf.avm2.advance{
	import flash.utils.ByteArray;
	import zero.swf.avm2.Ns_set_info;
	public class AdvanceNs_set_info extends Advance{
		public var nsV:Vector.<AdvanceNamespace_info>;
		//
		public function initByInfo(info:Ns_set_info):void{
			var count:int=info.nsV.length;
			nsV=new Vector.<AdvanceNamespace_info>(count);
			for(var i:int=0;i<count;i++){
				if(info.nsV[i]<1){
					nsV[i]=null;
				}else if(info.nsV[i]<currAdvanceABCFile.namespace_infoV.length){
					nsV[i]=currAdvanceABCFile.namespace_infoV[info.nsV[i]];
				}else{
					throw new Error("info.nsV[i]="+info.nsV[i]+" 超出范围,currAdvanceABCFile. namespace_infoV.length="+currAdvanceABCFile.namespace_infoV.length);
				}
			}
		}
		public function toInfo():Ns_set_info{
			var info:Ns_set_info=new Ns_set_info();
			var count:int=nsV.length;
			info.nsV=new Vector.<int>(count);
			var i:int=-1;
			for each(var ns:AdvanceNamespace_info in nsV){
				i++;
				info.nsV[i]=ns.infoId;
			}
			return info;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<AdvanceNs_set_info>
				<nsList/>
			</AdvanceNs_set_info>;
			if(nsV.length){
				var listXML:XML=xml.nsList[0];
				listXML.@count=nsV.length;
				for each(var ns:AdvanceNamespace_info in nsV){
					listXML.appendChild(<ns value={"指向 AdvanceNamespace_info"}/>);
				}
			}else{
				delete xml.nsList;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			if(xml.nsList.length()){
				var listXML:XML=xml.nsList[0];
				var nsXMLList:XMLList=listXML.ns;
				var i:int=-1;
				nsV=new Vector.<AdvanceNamespace_info>(nsXMLList.length());
				for each(var nsXML:XML in nsXMLList){
					i++;
					nsV[i]=nsXML.@value.toString();
				}
			}else{
				nsV=new Vector.<AdvanceNamespace_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
