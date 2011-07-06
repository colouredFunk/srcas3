/***
CLIPACTIONs
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:17（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//Clip actions are valid for placing sprite characters only. Clip actions define event handlers for a sprite character.
//CLIPACTIONS
//Field 				Type 							Comment
//Reserved 				UI16 							Must be 0
//AllEventFlags			CLIPEVENTFLAGS 					All events used in these clip actions
//ClipActionRecords 	CLIPACTIONRECORD[one or more]	Individual event handlers
//ClipActionEndFlag 	If SWF version <= 5, UI16		Must be 0
//						If SWF version >= 6, UI32		
package zero.swf.records.clips{
	import zero.swf.records.clips.CLIPEVENTFLAGS;
	import zero.swf.records.clips.CLIPACTIONRECORD;
	import zero.Outputer;
	import flash.utils.ByteArray;
	public class CLIPACTIONs{//implements I_zero_swf_CheckCodesRight{
		public var AllEventFlags:CLIPEVENTFLAGS;
		public var ClipActionRecordV:Vector.<CLIPACTIONRECORD>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			if(_initByDataOptions&&_initByDataOptions.swf_Version>0){
			}else{
				throw new Error("需要提供 swf_Version 信息");
			}
			//Reserved=data[offset]|(data[offset+1]<<8);
			offset+=2;
			AllEventFlags=new CLIPEVENTFLAGS();
			offset=AllEventFlags.initByData(data,offset,endOffset,_initByDataOptions);
			var i:int=-1;
			ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			while(offset<endOffset-6){
				i++;
				/*
				if(_initByDataOptions.swf_Version<6){
					if(data[offset]||data[offset+1]){
					}else{
						Outputer.output("i="+i+"，可能是扰码: CLIPEVENTFLAGS 所有属性为0","brown");
						offset+=2;
						i--;
						continue;
					}
				}else{
					if(data[offset]||data[offset+1]||data[offset+2]||data[offset+3]){
					}else{
						Outputer.output("i="+i+"，可能是扰码: CLIPEVENTFLAGS 所有属性为0","brown");
						offset+=4;
						i--;
						continue;
					}
				}
				*/
				ClipActionRecordV[i]=new CLIPACTIONRECORD();
				offset=ClipActionRecordV[i].initByData(data,offset,endOffset,_initByDataOptions);
			}
			if(_initByDataOptions.swf_Version<6){
				return offset+2;
			}
			return offset+4;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			if(_toDataOptions&&_toDataOptions.swf_Version>0){
			}else{
				throw new Error("需要提供 swf_Version 信息");
			}
			data[0]=0x00;
			data[1]=0x00;
			data.position=2;
			data.writeBytes(AllEventFlags.toData(_toDataOptions));
			for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
				data.writeBytes(ClipActionRecord.toData(_toDataOptions));
			}
			var offset:int=data.length;
			data[offset++]=0x00;
			data[offset++]=0x00;
			if(_toDataOptions.swf_Version<6){
			}else{
				data[offset++]=0x00;
				data[offset++]=0x00;
			}
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.records.clips.CLIPACTIONs"/>;
			xml.appendChild(AllEventFlags.toXML("AllEventFlags",_toXMLOptions));
			if(ClipActionRecordV.length){
				var ClipActionRecordListXML:XML=<ClipActionRecordList count={ClipActionRecordV.length}/>
				for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
					ClipActionRecordListXML.appendChild(ClipActionRecord.toXML("ClipActionRecord",_toXMLOptions));
				}
				xml.appendChild(ClipActionRecordListXML);
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			AllEventFlags=new CLIPEVENTFLAGS();
			AllEventFlags.initByXML(xml.AllEventFlags[0],_initByXMLOptions);
			var i:int=-1;
			ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			for each(var ClipActionRecordXML:XML in xml.ClipActionRecordList.ClipActionRecord){
				i++;
				ClipActionRecordV[i]=new CLIPACTIONRECORD();
				ClipActionRecordV[i].initByXML(ClipActionRecordXML,_initByXMLOptions);
			}
		}
		}//end of CONFIG::USE_XML
	}
}
