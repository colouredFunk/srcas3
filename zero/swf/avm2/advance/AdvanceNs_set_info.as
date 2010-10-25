/***
AdvanceNs_set_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月25日 12:33:13 
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
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.advance.AdvanceABC;

	public class AdvanceNs_set_info extends Advance{
		public var realInfoId:int;	//toInfo 后重新计算的 id
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var nsV:Vector.<AdvanceNamespace_info>;
		//
		public function AdvanceNs_set_info(){
			trace("AdvanceNs_set_info test_total="+(++test_total));
		}
		public function initByInfo(_infoId:int,ns_set_info:Ns_set_info):void{
			infoId=_infoId;
			
			nsV=new Vector.<AdvanceNamespace_info>(ns_set_info.nsV.length);
			var i:int=-1;
			for each(var ns:int in ns_set_info.nsV){
				i++;
				nsV[i]=AdvanceABC.currInstance.getNamespace_infoById(ns);
			}
		}
		public function toInfo():Ns_set_info{
			var ns_set_info:Ns_set_info=new Ns_set_info();
			ns_set_info.nsV=new Vector.<int>(nsV.length);
			var i:int=-1;
			for each(var ns:AdvanceNamespace_info in nsV){
				i++;
				ns_set_info.nsV[i]=AdvanceABC.currInstance.getNamespace_infoId(ns);
			}
			return ns_set_info;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<AdvanceNs_set_info infoId={infoId}/>;
			
			var listXML:XML=<nsList/>;
			listXML.@count=nsV.length;
			for each(var ns:AdvanceNamespace_info in nsV){
				listXML.appendChild(ns.toXML());
			}
			xml.appendChild(listXML);
			
			return xml;
		}
		public function initByXML(xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			var listXML:XML=xml.nsList[0];
			var nsXMLList:XMLList=listXML.ns;
			var i:int=-1;
			nsV=new Vector.<AdvanceNamespace_info>(nsXMLList.length());
			for each(var nsXML:XML in nsXMLList){
				i++;
				nsV[i]=AdvanceABC.currInstance.getNamespace_infoByXML(nsXML);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
