/***
ExportAssets 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 11:21:11 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.tag_body{

	import flash.utils.ByteArray;

	import zero.BytesAndStr16;
	import zero.swf.BytesData;

	public class ExportAssets extends TagBody{
		public var Count:int;					//UI16
		public var TagV:Vector.<int>;			
		public var NameV:Vector.<String>;		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			Count=data[offset]|(data[offset+1]<<8);
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			offset+=2;
			//#offsetpp
			for(var i:int=0;i<Count;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			Count=TagV.length;
			data[0]=Count;
			data[1]=Count>>8;
			var offset:int=2;
			//#offsetpp
			for(var i:int=0;i<Count;i++){
				data[offset++]=TagV[i];
				data[offset++]=TagV[i]>>8;
				data.position=offset;
				data.writeUTFBytes(NameV[i]);
				offset=data.length;
				data[offset++]=0;//字符串结束
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			Count=TagV.length;
			var xml:XML=<ExportAssets
				Count={Count}
			>
				<list vNames="TagV,NameV" count={Count}/>
			</ExportAssets>;
			var listXML:XML=xml.list[0];
			for(var i:int=0;i<Count;i++){
				listXML.appendChild(<Tag value={TagV[i]}/>);
				listXML.appendChild(<Name value={NameV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			Count=int(xml.@Count.toString());
			var listXML:XML=xml.list[0];
			var TagXMLList:XMLList=listXML.Tag;
			TagV=new Vector.<int>();
			var NameXMLList:XMLList=listXML.Name;
			NameV=new Vector.<String>();
			Count=TagXMLList.length();
			for(var i:int=0;i<Count;i++){
				TagV[i]=int(TagXMLList[i].@value.toString());
				NameV[i]=NameXMLList[i].@value.toString();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
