/***
CLIPACTIONS 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月3日 13:23:54 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//Clip actions are valid for placing sprite characters only. Clip actions define event handlers for a sprite character.
//CLIPACTIONS
//Field 				Type 							Comment
//Reserved 				UI16 							Must be 0
//AllEventFlags			CLIPEVENTFLAGS 					All events used in these clip actions
//ClipActionRecords 	CLIPACTIONRECORD[one or more]	Individual event handlers
//ClipActionEndFlag 	If SWF version <= 5, UI16		Must be 0
//						If SWF version >= 6, UI32		
package zero.swf.records{
	import zero.swf.records.CLIPEVENTFLAGS;
	import zero.swf.records.CLIPACTIONRECORD;
	import flash.utils.ByteArray;
	import zero.swf.CurrSWFVersion;
	import zero.Outputer;
	public class CLIPACTIONS{
		public var AllEventFlags:CLIPEVENTFLAGS;
		public var ClipActionRecordV:Vector.<CLIPACTIONRECORD>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//Reserved=data[offset]|(data[offset+1]<<8);
			offset+=2;
			AllEventFlags=new CLIPEVENTFLAGS();
			offset=AllEventFlags.initByData(data,offset,endOffset);
			
			var i:int=-1;
			ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			while(offset<endOffset-6){
				if(CurrSWFVersion.Version<6){
					if(data[offset]||data[offset+1]){
					}else{
						Outputer.output("可能是扰码: CLIPEVENTFLAGS 所有属性为0","brown");
						offset+=2;
						continue;
					}
				}else{
					if(data[offset]||data[offset+1]||data[offset+2]||data[offset+3]){
					}else{
						Outputer.output("可能是扰码: CLIPEVENTFLAGS 所有属性为0","brown");
						offset+=4;
						continue;
					}
				}
				i++;
				ClipActionRecordV[i]=new CLIPACTIONRECORD();
				offset=ClipActionRecordV[i].initByData(data,offset,endOffset);
			}
			
			if(CurrSWFVersion.Version<6){
				return offset+2;
			}
			return offset+4;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=0x00;
			data[1]=0x00;
			data.position=2;
			data.writeBytes(AllEventFlags.toData());
			for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
				data.writeBytes(ClipActionRecord.toData());
			}
			var offset:int=data.length;
			data[offset++]=0x00;
			data[offset++]=0x00;
			if(CurrSWFVersion.Version<6){
				return data;
			}
			data[offset++]=0x00;
			data[offset++]=0x00;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="CLIPACTIONS"/>;
			xml.appendChild(AllEventFlags.toXML("AllEventFlags"));
			if(ClipActionRecordV.length){
				var listXML:XML=<ClipActionRecordList count={ClipActionRecordV.length}/>
				for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
					listXML.appendChild(ClipActionRecord.toXML("ClipActionRecord"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			AllEventFlags=new CLIPEVENTFLAGS();
			AllEventFlags.initByXML(xml.AllEventFlags[0]);
			if(xml.ClipActionRecordList.length()){
				var listXML:XML=xml.ClipActionRecordList[0];
				var ClipActionRecordXMLList:XMLList=listXML.ClipActionRecord;
				var i:int=-1;
				ClipActionRecordV=new Vector.<CLIPACTIONRECORD>(ClipActionRecordXMLList.length());
				for each(var ClipActionRecordXML:XML in ClipActionRecordXMLList){
					i++;
					ClipActionRecordV[i]=new CLIPACTIONRECORD();
					ClipActionRecordV[i].initByXML(ClipActionRecordXML);
				}
			}else{
				ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
