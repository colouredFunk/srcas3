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
		public var FillStyleV:Vector.<FILLSTYLE>;
		public var LineStyleV:Vector.<BaseLineStyle>;
		public var NumFillBits:int;
		public var NumLineBits:int;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			
			var FillStyleCount:int=data[offset++];
			if(FillStyleCount==0xff){
				FillStyleCount=data[offset++]|(data[offset++]<<8);
			}
			FillStyleV=new Vector.<FILLSTYLE>(FillStyleCount);
			for(var i:int=0;i<FillStyleCount;i++){
			
				FillStyleV[i]=new FILLSTYLE();
				offset=FillStyleV[i].initByData(data,offset,endOffset);
			}
			
			
			var LineStyleCount:int=data[offset++];
			if(LineStyleCount==0xff){
				LineStyleCount=data[offset++]|(data[offset++]<<8);
			}
			LineStyleV=new Vector.<BaseLineStyle>(LineStyleCount);
			for(i=0;i<LineStyleCount;i++){
			
				LineStyleV[i]=new SHAPEWITHSTYLE.currLineStyleClass();
				offset=LineStyleV[i].initByData(data,offset,endOffset);
			}
			var flags:int=data[offset++];
			NumFillBits=(flags<<24)>>>28;				//11110000
			NumLineBits=flags&0x0f;						//00001111
			return offset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var FillStyleCount:int=FillStyleV.length;
			var offset:int=0;
			if(FillStyleCount<0xff){
				data[offset++]=FillStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=FillStyleCount;
				data[offset++]=FillStyleCount>>8;
			}
			
			data.position=offset;
			for each(var FillStyle:FILLSTYLE in FillStyleV){
				data.writeBytes(FillStyle.toData());
			}
			offset=data.length;
			var LineStyleCount:int=LineStyleV.length;
			
			if(LineStyleCount<0xff){
				data[offset++]=LineStyleCount;
			}else{
				data[offset++]=0xff;
				data[offset++]=LineStyleCount;
				data[offset++]=LineStyleCount>>8;
			}
			
			data.position=offset;
			for each(var LineStyle:BaseLineStyle in LineStyleV){
				data.writeBytes(LineStyle.toData());
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
			if(FillStyleV.length){
				var listXML:XML=<FillStyleList count={FillStyleV.length}/>
				for each(var FillStyle:FILLSTYLE in FillStyleV){
					listXML.appendChild(FillStyle.toXML("FillStyle"));
				}
				xml.appendChild(listXML);
			}
			if(LineStyleV.length){
				listXML=<LineStyleList count={LineStyleV.length}/>
				for each(var LineStyle:BaseLineStyle in LineStyleV){
					listXML.appendChild(LineStyle.toXML("LineStyle"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		public function initByXML(xml:XML):void{
			if(xml.FillStyleList.length()){
				var listXML:XML=xml.FillStyleList[0];
				var FillStyleXMLList:XMLList=listXML.FillStyle;
				var i:int=-1;
				FillStyleV=new Vector.<FILLSTYLE>(FillStyleXMLList.length());
				for each(var FillStyleXML:XML in FillStyleXMLList){
					i++;
					FillStyleV[i]=new FILLSTYLE();
					FillStyleV[i].initByXML(FillStyleXML);
				}
			}else{
				FillStyleV=new Vector.<FILLSTYLE>();
			}
			if(xml.LineStyleList.length()){
				listXML=xml.LineStyleList[0];
				var LineStyleXMLList:XMLList=listXML.LineStyle;
				i=-1;
				LineStyleV=new Vector.<BaseLineStyle>(LineStyleXMLList.length());
				for each(var LineStyleXML:XML in LineStyleXMLList){
					i++;
					LineStyleV[i]=new SHAPEWITHSTYLE.currLineStyleClass();
					LineStyleV[i].initByXML(LineStyleXML);
				}
			}else{
				LineStyleV=new Vector.<BaseLineStyle>();
			}
			NumFillBits=int(xml.@NumFillBits.toString());
			NumLineBits=int(xml.@NumLineBits.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
