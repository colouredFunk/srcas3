/***
CLIPACTIONS 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月12日 18:19:02 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.record{
	import zero.swf.record.CLIPEVENTFLAGS;
	import zero.swf.record.CLIPACTIONRECORD;
	import flash.utils.ByteArray;
	public class CLIPACTIONS extends Record{
		public var AllEventFlags:CLIPEVENTFLAGS;
		public var ClipActionRecordV:Vector.<CLIPACTIONRECORD>;
		public var ClipActionEndFlag1:int;				//UI16
		public var ClipActionEndFlag2:int;				//UI16
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			ClipActionEndFlag2=-1;
			//Reserved=data[offset]|(data[offset+1]<<8);
			//#offsetpp
			offset+=2;
			AllEventFlags=new CLIPEVENTFLAGS();
			offset=AllEventFlags.initByData(data,offset,endOffset);
			ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			//#offsetpp
			
			var i:int=-1;
			while(offset<endOffset-6){
				i++;
				//#offsetpp
			
				ClipActionRecordV[i]=new CLIPACTIONRECORD();
				offset=ClipActionRecordV[i].initByData(data,offset,endOffset);
			}
			ClipActionEndFlag1=data[offset++]|(data[offset++]<<8);
			//#offsetpp
			
			if(offset<endOffset){
				ClipActionEndFlag2=data[offset++]|(data[offset++]<<8);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=0x00;
			data[1]=0x00;
			data.position=2;
			data.writeBytes(AllEventFlags.toData());
			for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
				data.writeBytes(ClipActionRecord.toData());
			}
			var offset:int=data.length;
			data[offset]=ClipActionEndFlag1;
			data[offset+1]=ClipActionEndFlag1>>8;
			if(ClipActionEndFlag2>=0){
				data[offset+2]=ClipActionEndFlag2;
				data[offset+3]=ClipActionEndFlag2>>8;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<CLIPACTIONS
				ClipActionEndFlag1={ClipActionEndFlag1}
				ClipActionEndFlag2={ClipActionEndFlag2}
			>
				<AllEventFlags/>
				<list vNames="ClipActionRecordV" count={ClipActionRecordV.length}/>
			</CLIPACTIONS>;
			xml.AllEventFlags.appendChild(AllEventFlags.toXML());
			var listXML:XML=xml.list[0];
			for each(var ClipActionRecord:CLIPACTIONRECORD in ClipActionRecordV){
				var itemXML:XML=<ClipActionRecord/>;
				itemXML.appendChild(ClipActionRecord.toXML());
				listXML.appendChild(itemXML);
			}
			if(ClipActionEndFlag2>=0){
				
			}else{
				delete xml.@ClipActionEndFlag2;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			ClipActionEndFlag2=-1;
			AllEventFlags=new CLIPEVENTFLAGS();
			AllEventFlags.initByXML(xml.AllEventFlags.children()[0]);
			var listXML:XML=xml.list[0];
			var ClipActionRecordXMLList:XMLList=listXML.ClipActionRecord;
			ClipActionRecordV=new Vector.<CLIPACTIONRECORD>();
			var i:int=-1;
			for each(var ClipActionRecordXML:XML in ClipActionRecordXMLList){
				i++;
				ClipActionRecordV[i]=new CLIPACTIONRECORD();
				ClipActionRecordV[i].initByXML(ClipActionRecordXML.children()[0]);
			}
			ClipActionEndFlag1=int(xml.@ClipActionEndFlag1.toString());
			if(xml.@ClipActionEndFlag2){
				ClipActionEndFlag2=int(xml.@ClipActionEndFlag2.toString());
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
