/***
PNGEncoder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月9日 16:03:15
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package zero.encoder{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class PNGEncoder{推荐使用 mx.graphics.codec.PNGEncoder;
		public static function encode(bmd:BitmapData,biBitCount:int=24,isRev:Boolean=false):ByteArray{
			var bmdData:ByteArray=new ByteArray();
			
			//参考文章:
			//http://www.cnblogs.com/cymheart/archive/2005/08/20/219212.html
			var chunkData:ByteArray;
			var crc32:uint,color:uint;
			var x:int,y:int,chunkLen:int,pos:int;
			
			//PNG文件头
			bmdData[0]=0x89;
			bmdData[1]=0x50;
			bmdData[2]=0x4e;
			bmdData[3]=0x47;// PNG
			
			bmdData[4]=0x0d;
			bmdData[5]=0x0a;
			bmdData[6]=0x1a;
			bmdData[7]=0x0a;//(不知道什么来的)
			
			
			//IHDR 头块:
			bmdData[8]=0x00;
			bmdData[9]=0x00;
			bmdData[10]=0x00;
			bmdData[11]=0x0d;//IHDR头块 数据部分 长为13
			
			bmdData[12]=0x49;
			bmdData[13]=0x48;
			bmdData[14]=0x44;
			bmdData[15]=0x52//IHDR
			
			var width:uint=bmd.width;
			bmdData[16]=width>>24;
			bmdData[17]=width>>16;
			bmdData[18]=width>>8;
			bmdData[19]=width;//图片宽
			
			var height:uint=bmd.height;
			bmdData[20]=height>>24;
			bmdData[21]=height>>16;
			bmdData[22]=height>>8;
			bmdData[23]=height;//图片高
			
			bmdData[24]=8;//图像深度：真彩色图像
			bmdData[25]=6;//颜色类型：带α通道数据的真彩色图像
			bmdData[26]=0;//压缩方法(LZ77派生算法)
			bmdData[27]=0;//滤波器方法
			bmdData[28]=0;//隔行扫描方法：非隔行扫描
			
			bmdData.position=12;
			chunkData=new ByteArray();
			bmdData.readBytes(chunkData,0,17);//17=13+4
			crc32=CRC32.getValue(chunkData);
			bmdData[29]=crc32>>24;
			bmdData[30]=crc32>>16;
			bmdData[31]=crc32>>8;
			bmdData[32]=crc32;//CRC校验
			
			
			//IDAT 图像数据块
			bmdData[33]=0;
			bmdData[34]=0;
			bmdData[35]=0;
			bmdData[36]=0;//IDAT图像数据块 数据部分 长度暂时未知
			
			bmdData[37]=0x49;
			bmdData[38]=0x44;
			bmdData[39]=0x41;
			bmdData[40]=0x54;//IDAT
			
			var bmdColorData:ByteArray=new ByteArray();
			var bmdColorDataPos:int=0;
			//写入图像数据:
			if(bmd.transparent){
				for(y=0;y<height;y++){
					bmdColorData[bmdColorDataPos++]=0;//每行前面有一个0
					for(x=0;x<width;x++){
						color=bmd.getPixel32(x,y);
						bmdColorData[bmdColorDataPos++]=color>>16;
						bmdColorData[bmdColorDataPos++]=color>>8;
						bmdColorData[bmdColorDataPos++]=color;
						bmdColorData[bmdColorDataPos++]=color>>24;
					}
				}
			}else{
				for(y=0;y<height;y++){
					bmdColorData[bmdColorDataPos++]=0;//每行前面有一个0
					for(x=0;x<width;x++){
						color=bmd.getPixel(x,y);
						bmdColorData[bmdColorDataPos++]=color>>16;
						bmdColorData[bmdColorDataPos++]=color>>8;
						bmdColorData[bmdColorDataPos++]=color;
						bmdColorData[bmdColorDataPos++]=0xff;
					}
				}
			}
			bmdColorData.compress();//ByteArray和PNG的压缩都是zlib压缩
			bmdData.position=41;
			bmdData.writeBytes(bmdColorData);
			
			chunkLen=bmdColorData.length;
			bmdData[33]=chunkLen>>24;
			bmdData[34]=chunkLen>>16;
			bmdData[35]=chunkLen>>8;
			bmdData[36]=chunkLen;//IDAT图像数据块 
			
			bmdData.position=37;
			chunkData=new ByteArray();
			bmdData.readBytes(chunkData,0,chunkLen+4);
			crc32=CRC32.getValue(chunkData);
			
			pos=37+chunkLen+4;
			bmdData[pos++]=crc32>>24;
			bmdData[pos++]=crc32>>16;
			bmdData[pos++]=crc32>>8;
			bmdData[pos++]=crc32;//CRC校验
			
			//IEND块 图像结束数据 
			bmdData[pos++]=0x00;
			bmdData[pos++]=0x00;
			bmdData[pos++]=0x00;
			bmdData[pos++]=0x00;//数据部分 长度为0
			
			bmdData[pos++]=0x49;
			bmdData[pos++]=0x45;
			bmdData[pos++]=0x4e;
			bmdData[pos++]=0x44;//IEND
			
			bmdData[pos++]=0xAE;
			bmdData[pos++]=0x42;
			bmdData[pos++]=0x60;
			bmdData[pos++]=0x82;//CRC校验
			
			
			return bmdData;
		}
		public static function decode(bmdData:ByteArray):BitmapData{
			//因为png可以直接加载,所以这个decode只是玩玩 ^_^
			if(!(bmdData[1]==0x50&&bmdData[2]==0x4e&&bmdData[3]==0x47)){
				//0x89,0x50,0x4e,0x47----137,80,78,71---- PNG
				trace("不是有效的PNG文件");
				return null;
			}
			
			trace(
				 	String.fromCharCode(bmdData[1])+
					String.fromCharCode(bmdData[2])+
					String.fromCharCode(bmdData[3])
			);//PNG
			
			var chunkData:ByteArray;
			var crc32:uint;
			
			//0d 0a 1a 0a 不知道什么来的
			
			/*
			00 00 00 0d 说明IHDR头块长为13
			49 48 44 52 IHDR标识
			
			域的名称				字节数			说明  
			Width				4 bytes			图像宽度，以像素为单位  
			Height				4 bytes			图像高度，以像素为单位  
			Bit depth			1 byte			图像深度： 
												索引彩色图像：1，2，4或8 
												灰度图像：1，2，4，8或16 
												真彩色图像：8或16  
			ColorType			1 byte			颜色类型：
												0：灰度图像, 1，2，4，8或16 
												2：真彩色图像，8或16 
												3：索引彩色图像，1，2，4或8 
												4：带α通道数据的灰度图像，8或16 
												6：带α通道数据的真彩色图像，8或16  
			Compression method	1 byte			压缩方法(LZ77派生算法)  
			Filter method		1 byte			滤波器方法  
			Interlace method	1 byte			隔行扫描方法：
												0：非隔行扫描 
												1： Adam7(由Adam M. Costello开发的7遍隔行扫描方法) */

			var chunkTypeCode:String;
			var chunkLen:int;
			chunkLen=(bmdData[8]<<24)|(bmdData[9]<<16)|(bmdData[10]<<8)|bmdData[11];//13
			chunkData=new ByteArray();
			bmdData.position=12;
			bmdData.readBytes(chunkData,0,17);//17=13+4
			crc32=CRC32.getValue(chunkData);
			chunkTypeCode=(
					String.fromCharCode(bmdData[12])+
					String.fromCharCode(bmdData[13])+
					String.fromCharCode(bmdData[14])+
					String.fromCharCode(bmdData[15])
			);
			trace("chunkTypeCode="+chunkTypeCode);//IHDR IHDR标识
			trace("chunkLen="+chunkLen);//13 说明IHDR头块长为13
			
			
			var width:int=(bmdData[16]<<24)|(bmdData[17]<<16)|(bmdData[18]<<8)|bmdData[19];
			var height:int=(bmdData[20]<<24)|(bmdData[21]<<16)|(bmdData[22]<<8)|bmdData[23];
			trace("width="+width,"height="+height);
			
			var bitDepth:int=bmdData[24];
			trace("bitDepth="+bitDepth);
			
			var colorType:int=bmdData[25];
			trace("colorType="+colorType);
			
			var compressionMethod:int=bmdData[26];
			trace("compressionMethod="+compressionMethod);
			
			var filterMethod:int=bmdData[27];
			trace("filterMethod="+filterMethod);
			
			var interlaceMethod:int=bmdData[28];
			trace("interlaceMethod="+interlaceMethod);
			
			trace("CRC校验:",uint((bmdData[29]<<24)|(bmdData[30]<<16)|(bmdData[31]<<8)|bmdData[32]).toString(16));
			trace("crc32="+crc32.toString(16));
			trace("----------\r\n");
			
			//
			var colorArr:Array;
			var pos:int=33;
			var i:int,L:int,x:int,y:int,color:int;
			var bmd:BitmapData=new BitmapData(width,height,true,0xff330000);
			while(true){
				chunkLen=(bmdData[pos++]<<24)|(bmdData[pos++]<<16)|(bmdData[pos++]<<8)|bmdData[pos++];
				chunkData=new ByteArray();
				bmdData.position=pos;
				bmdData.readBytes(chunkData,0,chunkLen+4);
				crc32=CRC32.getValue(chunkData);
				chunkTypeCode=(
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])
				);
				trace("chunkTypeCode="+chunkTypeCode);
				trace("chunkLen="+chunkLen);
				switch(chunkTypeCode){
					case "PLTE":
						//调色板数据块
						if(chunkLen%3==0){
							L=chunkLen/3;
							colorArr=new Array(L);
							for(i=0;i<L;i++){
								colorArr[i]=uint(0xff000000|(bmdData[pos++]<<16)|(bmdData[pos++]<<8)|bmdData[pos++]);
								//trace(colorArr[i].toString(16));
							}
						}else{
							trace("非法的调色板数据");
							return null;
						}
					break;
					case "IDAT":
						//图像数据块
						//无压缩的LZ77压缩块：
						//字节				意义 
						//0~2				压缩信息，固定为0x78, 0xda, 0x1 
						//3~6				压缩块的LEN和NLEN信息 
						//		压缩的数据 
						//最后4字节 			Adler32信息
						trace(
							 bmdData[pos].toString(16),
							 bmdData[pos+1].toString(16),
							 bmdData[pos+2].toString(16)
						);
						//trace(bmdData[pos]|(bmdData[pos+1]<<8));LEN
						//trace(bmdData[pos+2]|(bmdData[pos+3]<<8));//NLEN
						if(colorArr){
							pos+=7;
							for(y=0;y<height;y++){
								//trace(bmdData[pos]);//0
								pos++;
								for(x=0;x<width;x+=2){
									color=bmdData[pos++];
									bmd.setPixel(x,y,colorArr[(color&0xf0)>>4]);
									bmd.setPixel(x+1,y,colorArr[color&0x0f]);
								}
							}
							pos+=4;//Adler32信息
						}else{
							bmdData.position=pos;
							var bmdColorData:ByteArray=new ByteArray();
							bmdData.readBytes(bmdColorData,0,chunkLen);
							bmdColorData.uncompress();//解压时一般不会出错,但是生成的图像经常不正确 - -0;
							/*for(var j:int=0;j<bmdColorData.length;j++){
								trace(bmdColorData[j].toString(16));
							}*/
							var bmdColorDataPos:int=0;
							for(y=0;y<height;y++){
								bmdColorDataPos++;
								for(x=0;x<width;x++){
									bmd.setPixel32(x,y,
										(bmdColorData[bmdColorDataPos++]<<16)|
										(bmdColorData[bmdColorDataPos++]<<8)|
										bmdColorData[bmdColorDataPos++]|
										(bmdColorData[bmdColorDataPos++]<<24)
									);
								}
							}
							pos+=chunkLen;
						}
					break;
					default:
						pos+=chunkLen;
					break;
				}
				trace("CRC校验:",uint((bmdData[pos]<<24)|(bmdData[pos+1]<<16)|(bmdData[pos+2]<<8)|bmdData[pos+3]).toString(16));
				trace("crc32="+crc32.toString(16));
				trace("----------\r\n");
				pos+=4;//CRC校验的4个字节
				
				if(pos>=bmdData.length){
					//chunkTypeCode=="IEND";
					break;
				}
			}
			return bmd;
		}
		public static function simplify(bmdData:ByteArray):ByteArray{
			//把非关键数据去掉
			if(!(bmdData[1]==0x50&&bmdData[2]==0x4e&&bmdData[3]==0x47)){
				//0x89,0x50,0x4e,0x47----137,80,78,71---- PNG
				trace("不是有效的PNG文件");
				return null;
			}
			//var chunkData:ByteArray;
			//var crc32:uint;
			var chunkTypeCode:String;
			var chunkLen:int;
			var pos:int=8;
			var startPos:int;
			
			var simplifyData:ByteArray=new ByteArray();
			simplifyData.position=0;
			bmdData.position=0;
			
			simplifyData.writeBytes(bmdData,0,8);
			
			while(true){
				startPos=pos;
				chunkLen=(bmdData[pos++]<<24)|(bmdData[pos++]<<16)|(bmdData[pos++]<<8)|bmdData[pos++];
				//chunkData=new ByteArray();
				//bmdData.position=pos;
				//bmdData.readBytes(chunkData,0,chunkLen+4);
				//crc32=CRC32.getValue(chunkData);
				chunkTypeCode=(
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])+
						String.fromCharCode(bmdData[pos++])
				);
				trace("chunkTypeCode="+chunkTypeCode);
				trace("chunkLen="+chunkLen);
				switch(chunkTypeCode){
					case "IHDR":
					case "PLTE":
					case "IDAT":
					case "IEND":
						simplifyData.writeBytes(bmdData,startPos,chunkLen+12);
					break;
				}
				//trace("CRC校验:",uint((bmdData[pos]<<24)|(bmdData[pos+1]<<16)|(bmdData[pos+2]<<8)|bmdData[pos+3]).toString(16));
				//trace("crc32="+crc32.toString(16));
				//trace("----------\r\n");
				pos+=chunkLen+4;
				
				if(pos>=bmdData.length){
					//chunkTypeCode=="IEND";
					break;
				}
			}
			return simplifyData;
		}
	}
}

import flash.utils.ByteArray;
class CRC32{
/** *//** 
 * @name:CRC32(CRC32校验类)
 * @usage:根据java.util.zip中CRC32类写的AS3版CRC32校验类
 * @author:flashlizi
 * @update:2007/06/05
....
*/
//经本人修改成适合在这里用的样子 ^_^
		private static var crc32:uint;
		private static var CRCTable:Array=initCRCTable();
		public static function getValue(data:ByteArray):uint{
			crc32=0;
			var L:int=data.length;
			for(var i:int=0;i<L;i++){
				var crc:uint = ~crc32;
				crc = CRCTable[(crc ^ data[i]) & 0xFF] ^ (crc >>> 8);
				crc32 = ~crc;
			}
			return crc32 & 0xFFFFFFFF;
		}
		private static function initCRCTable():Array {
			var crcTable:Array=new Array(256);
			for (var i:int=0; i < 256; i++) {
				var crc:uint=i;
				for (var j:int=0; j < 8; j++) {
					crc=(crc & 1)?(crc >>> 1) ^ 0xEDB88320:(crc >>> 1);
				}
				crcTable[i]=crc;
			}
			return crcTable;
		}
}