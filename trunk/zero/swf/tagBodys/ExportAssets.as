/***
ExportAssets 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月17日 10:48:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The ExportAssets tag makes portions of a SWF file available for import by other SWF files
//(see "ImportAssets" on page 56). For example, ten SWF files that are all part of the same
//website can share an embedded custom font if one file embeds the font and exports the font
//character. Each exported character is identified by a string. Any type of character can be
//exported.
//If the value of the character in ExportAssets was previously exported with a different identifier,
//Flash Player associates the tag with the latter identifier. That is, if Flash Player has already read
//a given value for Tag1 and the same Tag1 value is read later in the SWF file, the second Name1
//value is used.
//The minimum file format version is SWF 5.

//Field 		Type 			Comment
//Header 		RECORDHEADER 	Tag type = 56
//Count 		UI16 			Number of assets to export
//Tag1 			UI16 			First character ID to export
//Name1 		STRING 			Identifier for first exported character
//...
//TagN 			UI16 			Last character ID to export
//NameN 		STRING 			Identifier for last exported character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class ExportAssets extends TagBody{
		public var TagV:Vector.<int>;
		public var NameV:Vector.<String>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			var Count:int=data[offset++]|(data[offset++]<<8);
			TagV=new Vector.<int>(Count);
			NameV=new Vector.<String>(Count);
			for(var i:int=0;i<Count;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				//#offsetpp
			
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var Count:int=TagV.length;
			data[0]=Count;
			data[1]=Count>>8;
			//#offsetpp
			var offset:int=2;
			var i:int=-1;
			for each(var Tag:int in TagV){
				i++;
				data[offset++]=Tag;
				data[offset++]=Tag>>8;
				data.position=offset;
				data.writeUTFBytes(NameV[i]+"\x00");
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<ExportAssets>
				<list vNames="TagV,NameV" count={TagV.length}/>
			</ExportAssets>;
			var listXML:XML=xml.list[0];
			var i:int=-1;
			for each(var Tag:int in TagV){
				i++;
				listXML.appendChild(<Tag value={Tag}/>);
				listXML.appendChild(<Name value={NameV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var TagXMLList:XMLList=listXML.Tag;
			var NameXMLList:XMLList=listXML.Name;
			var i:int=-1;
			TagV=new Vector.<int>(TagXMLList.length());
			NameV=new Vector.<String>(NameXMLList.length());
			for each(var TagXML:XML in TagXMLList){
				i++;
				TagV[i]=int(TagXML.@value.toString());
				NameV[i]=NameXMLList[i].@value.toString();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
