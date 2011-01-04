/***
ImportAssets2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 16:45:36 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The ImportAssets2 tag replaces the ImportAssets tag for SWF 8 and later. ImportAssets2
//currently mirrors the ImportAssets tag's functionality.
//The ImportAssets2 tag imports characters from another SWF file. The importing SWF file
//references the exporting SWF file by the URL where it can be found. Imported assets are
//added to the dictionary just like characters defined within a SWF file.
//The URL of the exporting SWF file can be absolute or relative. If it is relative, it is resolved
//relative to the location of the importing SWF file.
//The ImportAssets2 tag must be earlier in the frame than any later tags that rely on the
//imported assets.
//The minimum file format version is SWF 8.

//ImportAssets2
//Field 			Type 			Comment
//Header 			RECORDHEADER 	Tag type = 71
//URL 				STRING 			URL where the source SWF file can be found
//Reserved 			UI8 			Must be 1
//Reserved 			UI8 			Must be 0
//Count 			UI16 			Number of assets to import
//Tag1 				UI16 			Character ID to use for first imported character in importing SWF file (need not match character ID in exporting SWF file)
//Name1 			STRING 			Identifier for first imported character (must match an identifier in exporting SWF file)
//...
//TagN 				UI16 			Character ID to use for last imported character in importing SWF file
//NameN 			STRING 			Identifier for last imported character
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	public class ImportAssets2{
		public var URL:String;							//STRING
		public var ReservedUI16:int;					//UI16
		public var TagV:Vector.<int>;
		public var NameV:Vector.<String>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			URL=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			ReservedUI16=data[offset++]|(data[offset++]<<8);
			
			var Count:int=data[offset++]|(data[offset++]<<8);
			TagV=new Vector.<int>(Count);
			NameV=new Vector.<String>(Count);
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
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data.writeUTFBytes(URL+"\x00");
			var offset:int=data.length;
			data[offset]=ReservedUI16;
			data[offset+1]=ReservedUI16>>8;
			var Count:int=TagV.length;
			data[offset+2]=Count;
			data[offset+3]=Count>>8;
			offset+=4;
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
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="ImportAssets2"
				URL={URL}
				ReservedUI16={ReservedUI16}
			/>;
			if(TagV.length){
				var listXML:XML=<TagAndNameList count={TagV.length}/>
				var i:int=-1;
				for each(var Tag:int in TagV){
					i++;
					listXML.appendChild(<Tag value={Tag}/>);
					listXML.appendChild(<Name value={NameV[i]}/>);
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			URL=xml.@URL.toString();
			ReservedUI16=int(xml.@ReservedUI16.toString());
			if(xml.TagAndNameList.length()){
				var listXML:XML=xml.TagAndNameList[0];
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
			}else{
				TagV=new Vector.<int>();
				NameV=new Vector.<String>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
