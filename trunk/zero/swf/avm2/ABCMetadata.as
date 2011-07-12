/***
ABCMetadata
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 17:49:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//metadata_info
//{
//	u30 name
//	u30 item_count
//	item_info items[item_count]
//}
package zero.swf.avm2{
	import zero.ComplexString;
	import zero.GroupString;
	import flash.utils.Dictionary;
	public class ABCMetadata{
		public var name:String;
		public var itemV:Vector.<ABCItem>;
		//
		public function initByInfo(
			metadata_info:Metadata_info,
			stringV:Vector.<String>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			var i:int;
			
			//The name field is an index into the string array of the constant pool; it provides a name for the metadata
			//entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
			//name 是在 constant_pool.string_v 中的id
			if(metadata_info.name>0){
				name=stringV[metadata_info.name];
			}else{
				throw new Error("metadata_info.name="+metadata_info.name);
			}
			
			//item_count denotes the number of items that follow in the items array.
			i=-1;
			itemV=new Vector.<ABCItem>();
			for each(var item_info:Item_info in metadata_info.item_infoV){
				i++;
				itemV[i]=new ABCItem();
				itemV[i].initByInfo(
					item_info,
					stringV,
					_initByDataOptions
				);
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The name field is an index into the string array of the constant pool; it provides a name for the metadata
			//entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
			//name 是在 constant_pool.string_v 中的id
			productMark.productString(name);
			
			//item_count denotes the number of items that follow in the items array.
			for each(var item:ABCItem in itemV){
				item.getInfo_product(productMark);
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Metadata_info{
			var i:int;
			var metadata_info:Metadata_info=new Metadata_info();
			
			//The name field is an index into the string array of the constant pool; it provides a name for the metadata
			//entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
			//name 是在 constant_pool.string_v 中的id
			if(name is String){
				metadata_info.name=productMark.getStringId(name);
			}else{
				throw new Error("name="+name);
			}
			
			//item_count denotes the number of items that follow in the items array.
			i=-1;
			metadata_info.item_infoV=new Vector.<Item_info>();
			for each(var item:ABCItem in itemV){
				i++;
				metadata_info.item_infoV[i]=item.getInfo(productMark,_toDataOptions);
			}
			
			return metadata_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=markStrs.xmlDict[this];
			if(xml){
				xml=xml.copy();//保证下面的 setName 不互相影响就行
				xml.setName(xmlName);
			}else{
				var markStr:String=toMarkStrAndMark(markStrs);
				if(_toXMLOptions&&_toXMLOptions.AVM2UseMarkStr){
					xml=<{xmlName} markStr={markStr}/>;
				}else{
					xml=<{xmlName}/>;
					
					if(name is String){
						xml.@name=name;
					}else{
						throw new Error("name="+name);
					}
					
					if(itemV.length){
						var itemListXML:XML=<itemList count={itemV.length}/>
						for each(var item:ABCItem in itemV){
							itemListXML.appendChild(item.toXMLAndMark(markStrs,"item",_toXMLOptions));
						}
						xml.appendChild(itemListXML);
					}
					
					var execResult:Array=/^[\s\S]*\((\d+)\)$/.exec(markStr);
					if(execResult){
						var copyId:int=int(execResult[1]);
						if(copyId>1){
							xml.@copyId=copyId;
						}
					}
				}
				markStrs.xmlDict[this]=xml;
			}
			return xml;
		}
		public function toMarkStrAndMark(markStrs:MarkStrs):String{
			
			//获取 metadata 的最简 markStr(自动计算 copyId)
			
			var markStr:String=markStrs.markStrDict[this];
			if(markStr is String){
				return markStr;
			}
			
			//计算 markStr
			markStr="";
			for each(var item:ABCItem in itemV){
				markStr+=",["+ComplexString.ext.escape(item.key)+","+ComplexString.ext.escape(item.value)+"]";
			}
			markStr="["+markStr.substr(1)+"]";
			
			if(name is String){
				markStr=ComplexString.ext.escape(name)+markStr;
			}else{
				throw new Error("name="+name);
			}
			
			//计算 copyId
			if(markStrs.metadataMark["~"+markStr]){
				var copyId:int=1;
				while(markStrs.metadataMark["~"+markStr+"("+(++copyId)+")"]){};
				markStr+="("+copyId+")";
			}
			//
			
			markStrs.metadataMark["~"+markStr]=this;
			markStrs.markStrDict[this]=markStr;
			
			return markStr;
		}
		public static function xml2metadata(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):ABCMetadata{
			return markStr2metadata(markStrs,xml2markStr(xml));
		}
		public static function xml2markStr(xml:XML):String{
			var i:int;
			
			//获取 metadata 的 xml 的最简 markStr
			
			if(/^<\w+ markStr=".*?"\/>$/.test(xml.toXMLString())){
				return normalizeMarkStr(xml.@markStr.toString());
			}
			
			i=-1;
			var markStr:String="";
			for each(var itemXML:XML in xml.itemList.item){
				i++;
				markStr+=",["+ComplexString.ext.escape(itemXML.@key.toString())+","+ComplexString.ext.escape(itemXML.@value.toString())+"]";
			}
			markStr="["+markStr.substr(1)+"]";
			
			var nameXML:XML=xml.@name[0];
			if(nameXML){
				markStr=ComplexString.ext.escape(nameXML.toString())+markStr;
			}else{
				throw new Error("nameXML="+nameXML);
			}
			
			var copyId:int=int(xml.@copyId.toString());
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		public static function markStr2metadata(markStrs:MarkStrs,markStr0:String):ABCMetadata{
			var i:int;
			
			var metadata:ABCMetadata=markStrs.metadataMark["~"+markStr0];
			if(metadata){
			}else{
				var markStr:String=normalizeMarkStr(markStr0);
				metadata=markStrs.metadataMark["~"+markStr];
				if(metadata){
				}else{
					metadata=new ABCMetadata();
					
					var execResult:Array=/^([\s\S]*?)\[([\s\S]*)\](?:\((\d+)\))?$/.exec(GroupString.escape(markStr));
					
					metadata.name=ComplexString.ext.unescape(execResult[1]);
					
					i=-1;
					metadata.itemV=new Vector.<ABCItem>();
					if(execResult[2]){
						for each(var itemEscapeMarkStr:String in GroupString.separate(execResult[2])){
							i++;
							var arr:Array=/^\[([\s\S]*),([\s\S]*)\]$/.exec(itemEscapeMarkStr);
							metadata.itemV[i]=new ABCItem();
							metadata.itemV[i].key=ComplexString.ext.unescape(arr[1]);
							metadata.itemV[i].value=ComplexString.ext.unescape(arr[2]);
						}
					}
					
					markStrs.markStrDict[metadata]=markStr;
					markStrs.metadataMark["~"+markStr]=metadata;
				}
				markStrs.metadataMark["~"+markStr0]=metadata;
			}
			return metadata;
		}
		public static function normalizeMarkStr(markStr:String):String{
			
			//获取最简 markStr
			
			var execResult:Array=/^([\s\S]*?)\[([\s\S]*)\](?:\((\d+)\))?$/.exec(GroupString.escape(markStr));
			
			markStr=GroupString.unescape(execResult[1])+"["+GroupString.unescape(execResult[2])+"]";
			
			var copyId:int=int(execResult[3]);
			if(copyId>1){
				markStr+="("+copyId+")";
			}
			
			return markStr;
		}
		}//end of CONFIG::USE_XML
	}
}	