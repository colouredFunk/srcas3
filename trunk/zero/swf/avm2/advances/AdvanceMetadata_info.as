/***
AdvanceMetadata_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月26日 22:42:40
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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

package zero.swf.avm2.advances{
	import zero.swf.avm2.Metadata_info;
	import zero.swf.avm2.Item_info;
	
	public class AdvanceMetadata_info extends Advance{
		
		private static const memberV:Vector.<Member>=Vector.<Member>([
			new Member("name",Member.STRING),
			new Member("item_info",Member.ITEM_INFO,{isList:true})
		]);
		
		private var infoId:int;	//从 swf 或 xml 直接读取过来的 id
		
		public var name:String;
		public var item_infoV:Vector.<AdvanceItem_info>;
		//
		public function AdvanceMetadata_info(){
		}
		
		public function initByInfo(_infoId:int,metadata_info:Metadata_info):void{
			infoId=_infoId;
			
			initByInfo_fun(metadata_info,memberV);
		}
		public function toInfoId():int{
			var metadata_info:Metadata_info=new Metadata_info();
			
			toInfo_fun(metadata_info,memberV);
			
			//--
			AdvanceABC.currInstance.abcFile.metadata_infoV.push(metadata_info);
			return AdvanceABC.currInstance.abcFile.metadata_infoV.length-1;
		}
		
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=toXML_fun(memberV,xmlName);
			
			xml.@infoId=infoId;
			return xml;
		}
		public function initByXML(xml:XML):void{
			infoId=int(xml.@infoId.toString());
			
			initByXML_fun(xml,memberV);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}