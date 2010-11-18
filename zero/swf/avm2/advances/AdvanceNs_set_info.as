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
package zero.swf.avm2.advances{
	import zero.swf.avm2.Ns_set_info;
	import zero.swf.avm2.advances.AdvanceABC;

	public class AdvanceNs_set_info extends Advance{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("ns",Member.NAMESPACE_INFO,{isList:true})
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var nsV:Vector.<AdvanceNamespace_info>;
		//
		public function AdvanceNs_set_info(){
		}
		
		public function initByInfo(advanceABC:AdvanceABC,_infoId:int,ns_set_info:Ns_set_info):void{
			infoId=_infoId;
			
			initByInfo_fun(advanceABC,ns_set_info,memberV);
		}
		public function toInfoId(advanceABC:AdvanceABC):int{
			var ns_set_info:Ns_set_info=new Ns_set_info();
			
			toInfo_fun(advanceABC,ns_set_info,memberV);
			
			//--
			advanceABC.abcFile.ns_set_infoV.push(ns_set_info);
			return advanceABC.abcFile.ns_set_infoV.length-1;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=toXML_fun(memberV,xmlName);
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(marks:Object,xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(marks,xml,memberV);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}