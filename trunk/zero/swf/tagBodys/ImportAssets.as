/***
ImportAssets 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:45:36 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The ImportAssets tag imports characters from another SWF file. The importing SWF file
//references the exporting SWF file by the URL where it can be found. Imported assets are
//added to the dictionary just like characters defined within a SWF file.
//The URL of the exporting SWF file can be absolute or relative. If it is relative, it will be
//resolved relative to the location of the importing SWF file.
//The ImportAssets tag must be earlier in the frame than any later tags that rely on the
//imported assets.
//The ImportAssets tag was deprecated in SWF 8; Flash Player 8 or later ignores this tag. In
//SWF 8 or later, use the ImportAssets2 tag instead.
//The minimum file format version is SWF 5, and the maximum file format version is SWF 7.

//ImportAssets
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 57
//URL 				STRING 			URL where the source SWF file can be found
//Count 			UI16 			Number of assets to import
//Tag1 				UI16 			Character ID to use for first imported character in importing SWF file (need not match character ID in exporting SWF file)
//Name1 			STRING 			Identifier for first imported character (must match an identifier in exporting SWF file)
//...
//TagN 				UI16 			Character ID to use for last imported character in importing SWF file
//NameN 			STRING 			Identifier for last imported character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class ImportAssets{//implements I_zero_swf_CheckCodesRight{
		public var URL:String;							//STRING
		public var TagV:Vector.<int>;
		public var NameV:Vector.<String>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			URL=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			
			var Count:int=data[offset++]|(data[offset++]<<8);
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			for(var i:int=0;i<Count;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				get_str_size=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				NameV[i]=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeUTFBytes(URL+"\x00");
			var offset:int=data.length;
			var Count:int=TagV.length;
			data[offset++]=Count;
			data[offset++]=Count>>8;
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
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.ImportAssets"
				URL={URL}
			/>;
			if(TagV.length){
				var TagAndNameListXML:XML=<TagAndNameList count={TagV.length}/>
				var i:int=-1;
				for each(var Tag:int in TagV){
					i++;
					TagAndNameListXML.appendChild(<Tag value={Tag}/>);
					TagAndNameListXML.appendChild(<Name value={NameV[i]}/>);
				}
				xml.appendChild(TagAndNameListXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			URL=xml.@URL.toString();
			var NameXMLList:XMLList=xml.TagAndNameList.Name;
			var i:int=-1;
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			for each(var TagXML:XML in xml.TagAndNameList.Tag){
				i++;
				TagV[i]=int(TagXML.@value.toString());
				NameV[i]=NameXMLList[i].@value.toString();
			}
		}
		}//end of CONFIG::USE_XML
	}
}
