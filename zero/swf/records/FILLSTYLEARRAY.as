/***
FILLSTYLEARRAY 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:08:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
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
package zero.swf.records{
	import zero.swf.records.FILLSTYLE;
	import flash.utils.ByteArray;
	public class FILLSTYLEARRAY{
		public var FillStylesV:Vector.<FILLSTYLE>;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			
			var FillStyleCount:int=data[offset++];
			if(FillStyleCount==0xff){
				FillStyleCount=data[offset++]|(data[offset++]<<8);
			}
			FillStylesV=new Vector.<FILLSTYLE>(FillStyleCount);
			for(var i:int=0;i<FillStyleCount;i++){
			
				FillStylesV[i]=new FILLSTYLE();
				offset=FillStylesV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var FillStyleCount:int=FillStylesV.length;
			var offset:int=0;
			if(FillStyleCount<0xff){
				data[offset++]=FillStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=FillStyleCount;
				data[offset++]=FillStyleCount>>8;
			}
			
			data.position=offset;
			for each(var FillStyles:FILLSTYLE in FillStylesV){
				data.writeBytes(FillStyles.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<FILLSTYLEARRAY>
				<FillStylesList/>
			</FILLSTYLEARRAY>;
			if(FillStylesV.length){
				var listXML:XML=xml.FillStylesList[0];
				listXML.@count=FillStylesV.length;
				for each(var FillStyles:FILLSTYLE in FillStylesV){
					var itemXML:XML=<FillStyles/>;
					itemXML.appendChild(FillStyles.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.FillStylesList;
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			if(xml.FillStylesList.length()){
				var listXML:XML=xml.FillStylesList[0];
				var FillStylesXMLList:XMLList=listXML.FillStyles;
				var i:int=-1;
				FillStylesV=new Vector.<FILLSTYLE>(FillStylesXMLList.length());
				for each(var FillStylesXML:XML in FillStylesXMLList){
					i++;
					FillStylesV[i]=new FILLSTYLE();
					FillStylesV[i].initByXML(FillStylesXML.children()[0]);
				}
			}else{
				FillStylesV=new Vector.<FILLSTYLE>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
