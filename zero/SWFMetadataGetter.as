/***
SWFMetadataGetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月5日 09:37:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	public class SWFMetadataGetter{
		//获取 swf 的 Metadata tag 的数据，然后可以用来获取修改日期等。
		public static const playerVersion:int=int(Capabilities.version.match(/\d+,/)[0].replace(",",""));//例如 WIN 10,0,22,91 抽出 10;
		
		public static var type:String;
		public static var Version:int=playerVersion;
		public static var FileLength:int;
		
		public static var x:Number;
		public static var y:Number;
		public static var width:Number;
		public static var height:Number;
		
		public static var FrameRate:Number;
		public static var FrameCount:int;
		
		public static var metadataXML:XML;
		
		public static function init(swfData:ByteArray):void{
			//输入一个有效的SWF文件数据，返回SWF文件第8字节后面的数据(如果是压缩影片则解压)
			if(swfData.length>8){
				swfData.position=0;
				type=swfData.readUTFBytes(3);//压缩和非压缩标记
				
				var data:ByteArray=new ByteArray();
				data.writeBytes(swfData,8);
				
				switch(type){
					case "CWS":
						try{
							data.uncompress();
						}catch(e:Error){
							trace("CWS 解压缩数据时出错");
						}
					break;
					case "FWS":
					break;
					default:
						trace("不是有效的SWF文件");
					break;
				}
				
				Version=swfData[3];//播放器版本
				
				FileLength=data.length+8;//SWF文件长度
				if(FileLength!=(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))){
					trace(
						"文件长度不符 FileLength="+FileLength+
						",ErrorFileLength="+(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))
					);
				}
				
				var offset:int=0;
				//获取SWF的宽高帧频
				var bGroupValue:int=(data[offset++]<<24)|(data[offset++]<<16)|(data[offset++]<<8)|data[offset++];
				var Nbits:int=bGroupValue>>>27;							//11111000 00000000 00000000 00000000
				if(Nbits){
					var bGroupBitsOffset:int=5;
					
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
				
				offset-=int(4-bGroupBitsOffset/8);
				
				x=Xmin/20;
				y=Ymin/20;
				width=(Xmax-Xmin)/20;
				height=(Ymax-Ymin)/20;
				
				FrameRate=data[offset++]/256+data[offset++];//帧频是一个Number, 在SWF里以 FIXED8(16-bit 8.8 fixed-point number, 16位8.8定点数) 的结构保存
				
				FrameCount=data[offset++]|(data[offset++]<<8);//帧数是一个int, 在SWF里以 UI16(Unsigned 16-bit integer value, 16位无符号整数) 的结构保存
				
				while(offset<data.length){
					var temp:int=data[offset++];
					var tag_type:int=(temp>>>6)|(data[offset++]<<2);
					var tag_bodyLength:int=temp&0x3f;
					if(tag_bodyLength==0x3f){//长tag
						tag_bodyLength=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
						//test_isShort=false;
					}//else{
					//	test_isShort=true;
					//}
					if(tag_type==77){//Metadata
						try{
							data.position=offset;
							metadataXML=new XML(data.readUTFBytes(tag_bodyLength));
						}catch(e:Error){
							trace("XML格式不正确, e="+e);
							metadataXML=null;
						}
						var metadataName:String=null;
						try{
							metadataName=metadataXML.name().toString();
						}catch(e:Error){
						}
						if(metadataName){
						}else{
							trace("XML格式不正确");
							metadataXML=null;
						}
						return;
					}
					offset+=tag_bodyLength;
				}
				/*
				if(offset===data.length){
				}else{
					trace("最后一个 tag, tag_type="+tag_type);
					trace("offset="+offset+",data.length="+data.length+",offset!=data.length");
				}
				*/
			}else{
				trace("不是有效的SWF文件");
			}
		}
		public static function getModifyDate(swfData:ByteArray=null):String{
			if(swfData){
				init(swfData);
			}
			if(metadataXML){
				try{
					//trace(metadata.toXMLString());
					var rdf:Namespace=metadataXML.namespace("rdf");
					var DescriptionXML:XML=metadataXML.rdf::Description[0];
					if(DescriptionXML){
						//trace(DescriptionXML.toXMLString());
						var xmp:Namespace=DescriptionXML.namespace("xmp");
						//trace("xmp="+xmp);
						var ModifyDateXML:XML=DescriptionXML.xmp::ModifyDate[0];
						if(ModifyDateXML){
							//trace(ModifyDateXML.toXMLString());
							return ModifyDateXML.toString();
						}
					}
				}catch(e:Error){
					trace("getModifyDate() 时发生错误,e="+e);
				}
			}
			
			trace(metadataXML.toXMLString());
			
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