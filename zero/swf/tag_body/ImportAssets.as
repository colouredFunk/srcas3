/***
ImportAssets 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月17日 10:48:15 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.tag_body{
	import flash.utils.ByteArray;
	public class ImportAssets extends TagBody{
		public var URL:String;							//STRING
		public var TagV:Vector.<int>;
		public var NameV:Vector.<String>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			URL=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			//#offsetpp
			
			var Count:int=data[offset++]|(data[offset++]<<8);
			TagV=new Vector.<int>(Count);
			NameV=new Vector.<String>(Count);
			for(var i:int=0;i<Count;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				//#offsetpp
			
				get_str_size=0;
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
			data.writeUTFBytes(URL+"\x00");
			var offset:int=data.length;
			var Count:int=TagV.length;
			data[offset]=Count;
			data[offset+1]=Count>>8;
			//#offsetpp
			offset+=2;
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
			var xml:XML=<ImportAssets
				URL={URL}
			>
				<list vNames="TagV,NameV" count={TagV.length}/>
			</ImportAssets>;
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
			URL=xml.@URL.toString();
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
