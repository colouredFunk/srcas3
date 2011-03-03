/***
FrameHeader 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月7日 11:02:15
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

/*
1．帧头HEADER 格式如下： 
typedef FrameHeader{
unsigned int sync:11;//同步信息
(这个地方有说12位的,对应下面就是1位的,貌似官网:http://www.datavoyage.com/mpgscript/mpeghdr.htm)
unsigned int version:2;//版本()
unsigned int layer:2;//层
unsigned int protection:1;// CRC校验
unsigned int bitrate:4;//位率
unsigned int frequency:2;//频率
unsigned int padding:1;//帧长调节
unsigned int private:1;//保留字
unsigned int mode:2;//声道模式
unsigned int mode extension:2;//扩充模式
unsigned int copyright:1;// 版权
unsigned int original:1;//原版标志
unsigned int emphasis:2;//强调模式
}HEADER, *LPHEADER; 

表1 MP3帧头宇节使用说明
名称 			长度(位) 		说明

同步信息			11				所有位均为1,第1字节恒为FF.
	
版本				2				00-MPEG 2.5
								01-未定义
								10-MPEG 2
								11-MPEG 1

层				2				00-未定义
								01-Layer 3
								10-Layer 2
								11-Layer 1

CRC校验			1				0-校验
								1-不校验
								
位率				4				取样率,单位是 kbps ,例如采用 MPEG-1 Layer 3, 64kbps 时,值为0101.
	
频率				2				采样频率,对于 MPEG-1:
								00-44.1kHz
								01-48kHz
								10-32kHz
								11-未定义
									
帧长调节			1				用来调整文件头长度
								0-无需调整
								1-调整
								具体调整计算方法见下文.
									
保留字			1				没有使用.
	
声道模式			2				表示声道
								00-立体声
								01-Joint Stereo
								10-双声道
								11-单声道
								
扩充模式			2				当声道模式为01时才使用.
	
版权				1				文件合法性
								0-不合法
								1-合法
								
原版标志			1				是否原版
								0-非原版
								1-原版
								
强调方式			2				用于声音经降噪压缩后再补偿的分类,很少用到,今后也可能不会用.
								00-未定义
								01-50/15ms
								10-保留
								11-CCITT J.17
*/

package zero.mp3s{
	import flash.utils.*;
	public class FrameHeader{
		private static const bitrateTable:Vector.<Vector.<int>>=Vector.<Vector.<int>>([
			Vector.<int>([0,32,40,48,56,64,80,96,112,128,160,192,224,256,320]),
			Vector.<int>([0,8,16,24,32,64,80,56,64,128,160,112,128,256,320])
		]);

		
		private static const frequencyTable:Vector.<Vector.<int>>=Vector.<Vector.<int>>([
			Vector.<int>([44100,48000,32000]),
			Vector.<int>([22050,24000,16000])/*,
			Vector.<int>([11025,12000,8000])*/
		]);
		
		private static const modeTable:Vector.<String>=Vector.<String>(["立体声","Joint Stereo","双声道","单声道"]);
		
		public var syn:int;
		public var version:Number;	//0 1 2 3	MPEG 2.5,未定义,MPEG 2,MPEG 1
		public var layer:int;		//0 1 2 3	未定义,Layer 3,Layer 2,Layer 1
		public var protection:int;
		
		public var bitrate:int;
		public var frequency:int;
		public var padding:int;
		//public var _private:int;
		
		public var mode:int;
		public var mode_extension:int;
		//public var copyright:int;
		//public var original:int;
		//public var emphasis:int;
		
		public function FrameHeader(){
		}
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			syn=data[offset++]<<3;
			var flag:int=data[offset++];
			syn|=(flag>>>5);
			if(syn!=0x7ff){
				throw new Error("不支持的 syn:"+syn);
			}
			
			switch((flag>>3)&3){
				case 0:
					version=2.5;
					throw new Error("不支持的 version:"+version);
				break;
				case 2:
					version=2;
				break;
				case 3:
					version=1;
				break;
				default:
					throw new Error("不支持的 versionId");
				break;
			}
			
			switch((flag>>1)&3){
				case 1:
					layer=3;
				break;
				case 2:
					layer=2;
					throw new Error("不支持的 layer:"+layer);
				break;
				case 3:
					layer=1;
					throw new Error("不支持的 layer:"+layer);
				break;
				default:
					throw new Error("不支持的 layerId");
				break;
			}
			//目前只支持 V1L3和V2L3
			
			trace("MPEG "+version,"Layer "+layer);
			
			protection=flag&1;
			
			trace("protection="+protection);
			
			flag=data[offset++];
			
			bitrate=bitrateTable[version-1][flag>>>4];
			if(bitrate>0){
				trace(bitrate+" Kbps");
			}else{
				throw new Error("不支持的 bitrate:"+bitrate);//0
			}
			
			frequency=frequencyTable[version-1][(flag>>2)&3];
			trace(frequency+" Hz");
			
			padding=(flag>>1)&1;
			trace("padding="+padding);
			
			//_private=flag&1;
			
			flag=data[offset++];
			
			mode=flag>>>6;
			trace(modeTable[mode]);
			
			if(mode==1){
				mode_extension=(flag>>4)&3;
				trace("mode_extension="+mode_extension);
			}
			
			//copyright=(flag>>3)&1;
			//original=(flag>>2)&1;
			//emphasis=flag&3;
			
			return offset;
		}
		public function toData():ByteArray{
			return null;
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/