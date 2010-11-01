/***
FillAndLineStyles 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月1日 20:28:49 
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

//A line style array is exactly the same as a fill style array except it stores line styles. Here is the
//file description:
//LINESTYLEARRAY
//Field 					Type 											Comment
//LineStyleCount 			UI8 											Count of line styles
//LineStyleCountExtended 	If LineStyleCount = 0xFF UI16 					Extended count of line styles
//LineStyles 				If Shape1, Shape2, or Shape3, LINESTYLE[count]	Array of line styles
//							If Shape4, LINESTYLE2[count] 					
package zero.swf.records{
	import zero.swf.records.FILLSTYLE;
	import zero.swf.records.lineStyles.BaseLineStyle;
	import flash.utils.ByteArray;
	public class FillAndLineStyles{
		public var FillStylesV:Vector.<FILLSTYLE>;
		public var LineStylesV:Vector.<BaseLineStyle>;
		public var NumFillBits:int;
		public var NumLineBits:int;
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
			
			
			var LineStyleCount:int=data[offset++];
			if(LineStyleCount==0xff){
				LineStyleCount=data[offset++]|(data[offset++]<<8);
			}
			LineStylesV=new Vector.<BaseLineStyle>(LineStyleCount);
			for(i=0;i<LineStyleCount;i++){
			
				LineStylesV[i]=new SHAPEWITHSTYLE.currLineStyleClass();
				offset=LineStylesV[i].initByData(data,offset,endOffset);
			}
			var flags:int=data[offset++];
			NumFillBits=(flags<<24)>>>28;				//11110000
			NumLineBits=flags&0x0f;						//00001111
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
			offset=data.length;
			var LineStyleCount:int=LineStylesV.length;
			
			if(LineStyleCount<0xff){
				data[offset++]=LineStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=LineStyleCount;
				data[offset++]=LineStyleCount>>8;
			}
			
			data.position=offset;
			for each(var LineStyles:BaseLineStyle in LineStylesV){
				data.writeBytes(LineStyles.toData());
			}
			offset=data.length;
			var flags:int=0;
			flags|=NumFillBits<<4;						//11110000
			flags|=NumLineBits;							//00001111
			data[offset++]=flags;
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="FillAndLineStyles"
				NumFillBits={NumFillBits}
				NumLineBits={NumLineBits}
			/>;
			if(FillStylesV.length){
				var listXML:XML=<FillStylesList count={FillStylesV.length}/>
				for each(var FillStyles:FILLSTYLE in FillStylesV){
					listXML.appendChild(FillStyles.toXML("FillStyles"));
				}
				xml.appendChild(listXML);
			}
			if(LineStylesV.length){
				listXML=<LineStylesList count={LineStylesV.length}/>
				for each(var LineStyles:BaseLineStyle in LineStylesV){
					listXML.appendChild(LineStyles.toXML("LineStyles"));
				}
				xml.appendChild(listXML);
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
					FillStylesV[i].initByXML(FillStylesXML);
				}
			}else{
				FillStylesV=new Vector.<FILLSTYLE>();
			}
			if(xml.LineStylesList.length()){
				listXML=xml.LineStylesList[0];
				var LineStylesXMLList:XMLList=listXML.LineStyles;
				i=-1;
				LineStylesV=new Vector.<BaseLineStyle>(LineStylesXMLList.length());
				for each(var LineStylesXML:XML in LineStylesXMLList){
					i++;
					LineStylesV[i]=new SHAPEWITHSTYLE.currLineStyleClass();
					LineStylesV[i].initByXML(LineStylesXML);
				}
			}else{
				LineStylesV=new Vector.<BaseLineStyle>();
			}
			NumFillBits=int(xml.@NumFillBits.toString());
			NumLineBits=int(xml.@NumLineBits.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
