/***
FILTERLIST 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:08:28 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//FILTERLIST
//Field 				Type 									Comment
//NumberOfFilters 		UI8 									Number of Filters
//Filter 				FILTER[NumberOfFilters] 				List of filters

//FILTER
//Field 				Type 									Comment
//FilterID 				UI8 									0 = Has DropShadowFilter
//																1 = Has BlurFilter
//																2 = Has GlowFilter
//																3 = Has BevelFilter
//																4 = Has GradientGlowFilter
//																5 = Has ConvolutionFilter
//																6 = Has ColorMatrixFilter
//																7 = Has GradientBevelFilter
//DropShadowFilter 		If FilterID = 0, DROPSHADOWFILTER		Drop Shadow filter
//BlurFilter 			If FilterID = 1, BLURFILTER 			Blur filter
//GlowFilter 			If FilterID = 2, GLOWFILTER 			Glow filter
//BevelFilter 			If FilterID = 3, BEVELFILTER 			Bevel filter
//GradientGlowFilter 	If FilterID = 4, GRADIENTGLOWFILTER		Gradient Glow filter
//ConvolutionFilter 	If FilterID = 5, CONVOLUTIONFILTER		Convolution filter
//ColorMatrixFilter 	If FilterID = 6, COLORMATRIXFILTER		Color Matrix filter
//GradientBevelFilter 	If FilterID = 7, GRADIENTBEVELFILTER	Gradient Bevel filter
package zero.swf.records{
	import zero.swf.vmarks.FilterTypes;
	import zero.swf.records.filters.FILTER;
	import flash.utils.ByteArray;
	public class FILTERLIST extends Record{
		public var FilterV:Vector.<FILTER>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var NumberOfFilters:int=data[offset++];
			FilterV=new Vector.<FILTER>(NumberOfFilters);
			for(var i:int=0;i<NumberOfFilters;i++){
				var FilterID:int=data[offset++];
			
				FilterV[i]=new FilterTypes.classV[FilterID]();
				offset=FilterV[i].initByData(data,offset,endOffset);
				FilterV[i].FilterID=FilterID;
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var NumberOfFilters:int=FilterV.length;
			data[0]=NumberOfFilters;
			var offset:int=1;
			for each(var Filter:FILTER in FilterV){
				data[offset++]=Filter.FilterID;
				data.position=offset;
				data.writeBytes(Filter.toData());
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<FILTERLIST>
				<FilterList/>
			</FILTERLIST>;
			if(FilterV.length){
				var listXML:XML=xml.FilterList[0];
				listXML.@count=FilterV.length;
				for each(var Filter:FILTER in FilterV){
					var itemXML:XML=<Filter FilterID={FilterTypes.typeV[Filter.FilterID]}/>;
					itemXML.appendChild(Filter.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.FilterList;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			if(xml.FilterList.length()){
				var listXML:XML=xml.FilterList[0];
				var FilterXMLList:XMLList=listXML.Filter;
				var i:int=-1;
				FilterV=new Vector.<FILTER>(FilterXMLList.length());
				for each(var FilterXML:XML in FilterXMLList){
					i++;
					var FilterID:int=FilterTypes[FilterXML.@FilterID.toString()];
					FilterV[i]=new FilterTypes.classV[FilterID]();
					FilterV[i].initByXML(FilterXML.children()[0]);
					FilterV[i].FilterID=FilterID;
				}
			}else{
				FilterV=new Vector.<FILTER>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
