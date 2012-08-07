/***
SWF
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月30日 21:43:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.getfonts.swf{
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import zero.codec.LZMAUncompressSWF;
	import zero.output;
	import zero.outputError;
	
	public class SWF{
		public var type:String;
		public var Version:int;
		public var FileLength:int;
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var FrameRate:Number;
		public var FrameCount:int;//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
		public var tagV:Vector.<Tag>;
		//
		
		public function SWF(
			_type:String=null,
			_Version:int=0,
			_width:Number=-1,
			_height:Number=-1,
			_FrameRate:Number=0,
			_tagV:Vector.<Tag>=null
		){
			type=_type||"CWS";
			Version=_Version>0?_Version:int(Capabilities.version.match(/\d+/)[0]);//例如 WIN 10,0,22,91 抽出 10;
			
			x=0;
			y=0;
			width=_width>-1?_width:800;
			height=_height>-1?_height:600;
			
			FrameRate=_FrameRate>0?_FrameRate:30;
			if(_tagV){
				tagV=_tagV;
				FrameCount=Tags.getRealFrameCount(tagV);
			}else{
				tagV=new Vector.<Tag>();
				tagV[0]=new Tag(TagTypes.ShowFrame);
				tagV[1]=new Tag(TagTypes.End);
				FrameCount=1;
			}
		}
		
		public function swfData2Data(swfData:ByteArray):ByteArray{
			if(swfData.length>8){
			}else{
				throw new Error("不是有效的SWF文件："+swfData);
			}
			swfData.position=0;
			type=swfData.readUTFBytes(3);//压缩和非压缩标记
			
			var data:ByteArray;
			
			switch(type){
				case "CWS":
					data=new ByteArray();
					data.writeBytes(swfData,8);
					try{
						data.uncompress();
					}catch(e:Error){
						throw new Error("CWS 解压缩数据时出错");
					}
				break;
				case "ZWS"://20120517
					try{
						import flash.utils.*;
						var t:int=getTimer();
						data=LZMAUncompressSWF(swfData);
						output("LZMAUncompressSWF 耗时："+(getTimer()-t)+" 毫秒；swfData.length="+swfData.length,"brown");
					}catch(e:Error){
						throw new Error("ZWS 解压缩数据时出错");
					}
				break;
				case "FWS":
					data=new ByteArray();
					data.writeBytes(swfData,8);
				break;
				default:
					//throw new Error("不是有效的SWF文件");
					var outputData:ByteArray=new ByteArray();
					var outputLen:int=100;
					outputData.writeBytes(swfData,0,Math.min(outputLen,swfData.length));
					throw new Error(
						"不是有效的SWF文件："+outputData+(
							outputLen<swfData.length
							?
							"..."
							:
							""
						)
					);
				break;
			}
			
			Version=swfData[3];//播放器版本
			
			FileLength=data.length+8;//SWF文件长度
			if(FileLength==(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))){
			}else{
				output(
					"文件长度不符 FileLength="+FileLength+
					"，ErrorFileLength="+(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))
					,"brown");
			}
			
			return data;
		}
		public function data2SWFData(data:ByteArray,_toDataOptions:Object):ByteArray{
			FileLength=data.length+8;
			
			if(type=="ZWS"){
				type="CWS";
				outputError("暂不支持 ZWS 压缩，type 自动改为 CWS");
			}
			
			var newData:ByteArray;
			switch(type){
				case "CWS":
				case "ZWS"://20120517
					if(type=="CWS"){
						newData=new ByteArray();
						newData.writeBytes(data);
						newData.compress();
					}else{
						throw new Error("暂不支持");
					}
					if(_toDataOptions&&_toDataOptions.ifCWSRemoveLastByte){//20120221
						newData.length--;
					}
				break;
				default:
					newData=data;
				break;
			}
			
			var swfData:ByteArray=new ByteArray();
			swfData.writeUTFBytes(type);
			swfData[3]=Version;
			swfData[4]=FileLength;
			swfData[5]=FileLength>>8;
			swfData[6]=FileLength>>16;
			swfData[7]=FileLength>>24;
			swfData.position=8;
			swfData.writeBytes(newData);
			
			return swfData;
		}
		
		public function initInfoByData(data:ByteArray):int{
			var bGroupValue:int=(data[0]<<24)|(data[1]<<16)|(data[2]<<8)|data[3];
			var offset:int=4;
			var Nbits:int=bGroupValue>>>27;							//11111000 00000000 00000000 00000000
			var bGroupBitsOffset:int=5;
			
			if(Nbits){
				var bGroupRshiftBitsOffset:int=32-Nbits;
				var bGroupNegMask:int=1<<(Nbits-1);
				var bGroupNeg:int=0xffffffff<<Nbits;
				
				var Xmin:int=(bGroupValue<<5)>>>bGroupRshiftBitsOffset;
				if(Xmin&bGroupNegMask){Xmin|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=Nbits;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
				var Xmax:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				if(Xmax&bGroupNegMask){Xmax|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=Nbits;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
				var Ymin:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				if(Ymin&bGroupNegMask){Ymin|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=Nbits;
				
				//从 data 读取足够多的位数以备下面使用:
				if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(data[offset++]<<8)|data[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|data[offset++];}
				
				var Ymax:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
				if(Ymax&bGroupNegMask){Ymax|=bGroupNeg;}//最高位为1,表示负数
				bGroupBitsOffset+=Nbits;
			}
			
			offset=offset-int(4-bGroupBitsOffset/8);
			
			x=Xmin/20;
			y=Ymin/20;
			width=(Xmax-Xmin)/20;
			height=(Ymax-Ymin)/20;
			
			FrameRate=data[offset++]/256+data[offset++];//帧频是一个Number, 在SWF里以 FIXED8(16-bit 8.8 fixed-point number, 16位8.8定点数) 的结构保存
			FrameCount=data[offset++]|(data[offset++]<<8);//仅用于参考
			
			return offset;
		}
		
		public function initBySWFData_start(swfData:ByteArray,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):Object/*zero_swf_InitByDataOptions*/{
			//~~~~~
			var data:ByteArray=swfData2Data(swfData);
			var offset:int=initInfoByData(data);
			
			//tagV
			tagV=new Vector.<Tag>();
			Tags.getTagsByData(tagV,data,offset,data.length);
			
			//#####
			FrameCount=Tags.getRealFrameCount(tagV,FrameCount);
			
			///
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object/*zero_swf_InitByDataOptions*/();
			}
			_initByDataOptions.swf_Version=Version;
			
			return _initByDataOptions;
		}
		public function initBySWFData(swfData:ByteArray,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):void{
			_initByDataOptions=initBySWFData_start(swfData,_initByDataOptions);
			
			//@@@@@
			var tagId:int=0;
			while(tagId<tagV.length){
				tagId=Tags.initByData_step(
					tagV,
					tagId,
					tagV.length,
					10000,
					_initByDataOptions
				);
			}
			
			//$$$$$
		}
		
		public function infoToData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			
			var Xmin:int=x*20;
			var Ymin:int=y*20;
			var Xmax:int=(x+width)*20;
			var Ymax:int=(y+height)*20;
			var bGroupValue:int=0;
			var offset:int=0;
			
			//计算所需最小位数:
			var bGroupMixNum:int=((Xmin<0?-Xmin:Xmin)<<1)|((Xmax<0?-Xmax:Xmax)<<1)|((Ymin<0?-Ymin:Ymin)<<1)|((Ymax<0?-Ymax:Ymax)<<1);
			if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){var Nbits:int=32;}else{Nbits=31;}}else{if(bGroupMixNum>>>29){Nbits=30;}else{Nbits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){Nbits=28;}else{Nbits=27;}}else{if(bGroupMixNum>>>25){Nbits=26;}else{Nbits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){Nbits=24;}else{Nbits=23;}}else{if(bGroupMixNum>>>21){Nbits=22;}else{Nbits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){Nbits=20;}else{Nbits=19;}}else{if(bGroupMixNum>>>17){Nbits=18;}else{Nbits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){Nbits=16;}else{Nbits=15;}}else{if(bGroupMixNum>>>13){Nbits=14;}else{Nbits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){Nbits=12;}else{Nbits=11;}}else{if(bGroupMixNum>>>9){Nbits=10;}else{Nbits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){Nbits=8;}else{Nbits=7;}}else{if(bGroupMixNum>>>5){Nbits=6;}else{Nbits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){Nbits=4;}else{Nbits=3;}}else{if(bGroupMixNum>>>1){Nbits=2;}else{Nbits=bGroupMixNum;}}}}}
			
			bGroupValue|=Nbits<<27;							//11111000 00000000 00000000 00000000
			var bGroupBitsOffset:int=5;
			
			var bGroupRshiftBitsOffset:int=32-Nbits;
			bGroupValue|=(Xmin<<bGroupRshiftBitsOffset)>>>5;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Xmax<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Ymin<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Ymax<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			
			data[offset++]=FrameRate*256;
			data[offset++]=FrameRate;
			if(_toDataOptions&&_toDataOptions.FrameCount>0){//20111205
				FrameCount=_toDataOptions.FrameCount;
			}else{
				FrameCount=Tags.getRealFrameCount(tagV);
			}
			//trace("FrameCount="+FrameCount);
			data[offset++]=FrameCount;
			data[offset++]=FrameCount>>8;
			
			return data;
		}
		
		public function toSWFData_start(_toDataOptions:Object/*zero_swf_ToDataOptions*/):Object/*zero_swf_ToDataOptions*/{
			//#####
			if(_toDataOptions&&_toDataOptions.FrameCount>0){//20111205
				FrameCount=_toDataOptions.FrameCount;
			}else{
				FrameCount=Tags.getRealFrameCount(tagV);
			}
			//trace("FrameCount="+FrameCount);
			
			///
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object/*zero_swf_ToDataOptions*/();
			}
			_toDataOptions.swf_Version=Version;
			
			return _toDataOptions;
		}
		public function toSWFData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			_toDataOptions=toSWFData_start(_toDataOptions);
			
			//临时变量
			var tagsData:ByteArray=new ByteArray();
			
			//@@@@@
			var tagId:int=0;
			while(tagId<tagV.length){
				tagId=Tags.toData_step(
					tagV,
					tagsData,
					tagId,
					tagV.length,
					10000,
					_toDataOptions
				);
			}
			
			return toSWFData_end(tagsData,_toDataOptions);
		}
		public function toSWFData_end(tagsData:ByteArray,_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			//~~~~~
			var data:ByteArray=infoToData(_toDataOptions);
			
			//$$$$$
			data.position=data.length;
			data.writeBytes(tagsData);
			if(_toDataOptions&&_toDataOptions.junkTailSize>0){//20120221
				//在 swf 后面添加若干随机字节，让搜索 40 00 00 00 的出错
				var i:int=_toDataOptions.junkTailSize;
				while(--i>=0){
					data[data.length]=int(Math.random()*0x100);
				}
			}
			return data2SWFData(data,_toDataOptions);
		}
	}
}
		