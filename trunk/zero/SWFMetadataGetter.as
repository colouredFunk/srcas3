/***
SWFMetadataGetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月5日 09:37:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.utils.ByteArray;
	
	import zero.codec.getSWFTagBodyData;

	public class SWFMetadataGetter{
		public static var metadataXML:XML;
		public static function init(swfData:ByteArray):void{
			var metadataData:ByteArray=getSWFTagBodyData(
				swfData,
				77//Metadata
			);
			try{
				metadataXML=new XML(metadataData.readUTFBytes(metadataData.length));
			}catch(e:Error){
				trace("XML格式不正确, e="+e);
				metadataXML=null;
			}
			var metadataName:String=null;
			try{
				metadataName=metadataXML.name().toString();
			}catch(e:Error){
			}
			if(metadataName){
			}else{
				trace("XML格式不正确");
				metadataXML=null;
			}
			return;
		}
		public static function getModifyDate(swfData:ByteArray=null):String{
			if(swfData){
				init(swfData);
			}
			if(metadataXML){
				try{
					//trace(metadata.toXMLString());
					var rdf:Namespace=metadataXML.namespace("rdf");
					var DescriptionXML:XML=metadataXML.rdf::Description[0];
					if(DescriptionXML){
						//trace(DescriptionXML.toXMLString());
						var xmp:Namespace=DescriptionXML.namespace("xmp");
						//trace("xmp="+xmp);
						var ModifyDateXML:XML=DescriptionXML.xmp::ModifyDate[0];
						if(ModifyDateXML){
							//trace(ModifyDateXML.toXMLString());
							return ModifyDateXML.toString();
						}
					}
				}catch(e:Error){
					//trace("getModifyDate() 时发生错误,e="+e);
				}
			}
			
			//if(metadataXML){
			//	trace(metadataXML.toXMLString());
			//}
			
			return null;
		}
	}
}

