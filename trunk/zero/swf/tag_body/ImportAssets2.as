/***
ImportAssets2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月31日 14:09:47 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.tag_body{
	import flash.utils.ByteArray;
	public class ImportAssets2 extends TagBody{
		public var URL:String;					//STRING
		public var ReservedUI16:int;			//UI16
		public var Count:int;					//UI16
		public var TagV:Vector.<int>;			
		public var NameV:Vector.<String>;		
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):void{
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			URL=data.readUTFBytes(get_str_size);
			offset+=get_str_size;
			ReservedUI16=data[offset]|(data[offset+1]<<8);
			Count=data[offset+2]|(data[offset+3]<<8);
			TagV=new Vector.<int>();
			NameV=new Vector.<String>();
			offset+=4;
			//#offsetpp
			for(var i:int=0;i<Count;i++){
				TagV[i]=data[offset++]|(data[offset++]<<8);
				get_str_size=0;
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
			data.position=0;
			data.writeUTFBytes(URL);
			var offset:int=data.length;
			data[offset]=0;//字符串结束
			data[offset+1]=ReservedUI16;
			data[offset+2]=ReservedUI16>>8;
			data[offset+3]=Count;
			data[offset+4]=Count>>8;
			offset+=5;
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
			var xml:XML=<ImportAssets2
				URL={URL}
				ReservedUI16={ReservedUI16}
				Count={Count}
			>
				<list vNames="TagV,NameV" count={Count}/>
			</ImportAssets2>;
			var listXML:XML=xml.list[0];
			for(var i:int=0;i<Count;i++){
				listXML.appendChild(<Tag value={TagV[i]}/>);
				listXML.appendChild(<Name value={NameV[i]}/>);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			URL=xml.@URL.toString();
			ReservedUI16=int(xml.@ReservedUI16.toString());
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
