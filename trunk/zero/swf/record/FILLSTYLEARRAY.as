/***
FILLSTYLEARRAY 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月8日 16:58:59 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A fill style array itself has three fields. The first field is an 8-bit integer count which indicates
//how many fill styles are in the array. This count works similar to the tag's length field in that if
//it is all 1s, you have to look at the next 16 bits to get the actual length. Here is the file
//description:
//FILLSTYLEARRAY
//Field 					Type 							Comment
//FillStyleCount 			UI8 							Count of fill styles
//FillStyleCountExtended 	If FillStyleCount = 0xFF UI16 	Extended count of fill styles.
//															Supported only for Shape2 and Shape3.
//FillStyles 				FILLSTYLE[FillStyleCount] 		Array of fill styles
package zero.swf.record{
	import zero.swf.record.FILLSTYLE;
	import flash.utils.ByteArray;
	public class FILLSTYLEARRAY extends Record{
		public var FillStylesV:Vector.<FILLSTYLE>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			FillStylesV=new Vector.<FILLSTYLE>();
			//#offsetpp
			//#offsetpp
			
			var FillStyleCount:int=data[offset++];
			if(FillStyleCount==0xff){
				FillStyleCount=data[offset++]|(data[offset++]<<8);
			}
			for(var i:int=0;i<FillStyleCount;i++){
				//#offsetpp
			
				FillStylesV[i]=new FILLSTYLE();
				offset=FillStylesV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var FillStyleCount:int=FillStylesV.length;
			//#offsetpp
			var offset:int=0;
			if(FillStyleCount<0xff){
				data[offset++]=FillStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=FillStyleCount;
				data[offset++]=FillStyleCount>>8;
			}
			//#offsetpp
			
			data.position=offset;
			for each(var FillStyles:FILLSTYLE in FillStylesV){
				data.writeBytes(FillStyles.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<FILLSTYLEARRAY>
				<list vNames="FillStylesV" count={FillStylesV.length}/>
			</FILLSTYLEARRAY>;
			var listXML:XML=xml.list[0];
			for each(var FillStyles:FILLSTYLE in FillStylesV){
				var itemXML:XML=<FillStyles/>;
				itemXML.appendChild(FillStyles.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var FillStylesXMLList:XMLList=listXML.FillStyles;
			FillStylesV=new Vector.<FILLSTYLE>();
			var i:int=-1;
			for each(var FillStylesXML:XML in FillStylesXMLList){
				i++;
				FillStylesV[i]=new FILLSTYLE();
				FillStylesV[i].initByXML(FillStylesXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
