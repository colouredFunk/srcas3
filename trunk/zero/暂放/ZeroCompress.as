/***
ZeroCompress 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月29日 09:36:43
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ZeroCompress{
		public static function compressStr(str:String):ByteArray{貌似不太好做
			trace("压缩前: str.length="+str.length);
			
			var cArr:Array=str.split("");
			var cMark:Object=new Object();
			var cV:Vector.<String>=new Vector.<String>();
			var totalC:int=0;
			var c:String;
			for each(c in cArr){
				if(cMark[c]>=0){
				}else{
					cMark[c]=totalC;
					cV[totalC]=c;
					totalC++;
				}
			}
			var Nbits:int=getNbits(totalC);
			if(Nbits>=8){
				throw new Error("好像压缩没意义了?");
			}
			
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var bGroupValue:int=0;
			//#offsetpp
			var offset:int=0;
			var bGroupBitsOffset:int=0;
			var bGroupRshiftBitsOffset:int=32-Nbits;
			for each(c in cArr){
				bGroupValue|=(cMark[c]<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
				bGroupBitsOffset+=Nbits;
				
				//向 data 写入满8位(1字节)的数据:
				if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;data[offset++]=bGroupValue>>24;bGroupValue<<=8;}
				
			}
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;data[offset++]=bGroupValue;}else{data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;data[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){data[offset++]=bGroupValue>>24;data[offset++]=bGroupValue>>16;}else{data[offset++]=bGroupValue>>24;}
			
			data.compress();
			
			trace("压缩后: data.length="+data.length);
			trace("压缩率: "+data.length/str.length);
			return data;
		}
		
		private static function getNbits(num:int):int{
			if(num>>>16){
				if(num>>>24){
					if(num>>>28){
						if(num>>>30){
							if(num>>>31){
								return 32;
							}else{
								return 31;
							}
						}else{
							if(num>>>29){
								return 30;
							}else{
								return 29;
							}
						}
					}else{
						if(num>>>26){
							if(num>>>27){
								return 28;
							}else{
								return 27;
							}
						}else{
							if(num>>>25){
								return 26;
							}else{
								return 25;
							}
						}
					}
				}else{
					if(num>>>20){
						if(num>>>22){
							if(num>>>23){
								return 24;
							}else{
								return 23;
							}
						}else{
							if(num>>>21){
								return 22;
							}else{
								return 21;
							}
						}
					}else{
						if(num>>>18){
							if(num>>>19){
								return 20;
							}else{
								return 19;
							}
						}else{
							if(num>>>17){
								return 18;
							}else{
								return 17;
							}
						}
					}
				}
			}else{
				if(num>>>8){
					if(num>>>12){
						if(num>>>14){
							if(num>>>15){
								return 16;
							}else{
								return 15;
							}
						}else{
							if(num>>>13){
								return 14;
							}else{
								return 13;
							}
						}
					}else{
						if(num>>>10){
							if(num>>>11){
								return 12;
							}else{
								return 11;
							}
						}else{
							if(num>>>9){
								return 10;
							}else{
								return 9;
							}
						}
					}
				}else{
					if(num>>>4){
						if(num>>>6){
							if(num>>>7){
								return 8;
							}else{
								return 7;
							}
						}else{
							if(num>>>5){
								return 6;
							}else{
								return 5;
							}
						}
					}else{
						if(num>>>2){
							if(num>>>3){
								return 4;
							}else{
								return 3;
							}
						}else{
							if(num>>>1){
								return 2;
							}else{
								return num;
							}
						}
					}
				}
			}
			return -1;
		}
	}
}

