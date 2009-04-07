/***
BMPEncoder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建时间:2009年2月7日 16:25:01
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚;最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
package com.zero.images{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class BMPEncoder{
		public static function encode(bmd:BitmapData,biBitCount:int=24,isRev:Boolean=false):ByteArray{
			if(biBitCount!=24){
				trace("暂不支持24位以外的encode ^_^");
				return null;
			}
			var bmdData:ByteArray=new ByteArray();
			/*
			BMP文件头
			typedef struct tagBITMAPFILEHEADER {
				WORD	bfType;			// 位图文件的类型，必须为BM
				DWORD	bfSize;			// 位图文件的大小，以字节为单位
				WORD	bfReserved1;	// 位图文件保留字，必须为0
				WORD	bfReserved2;	// 位图文件保留字，必须为0
				DWORD	bfOffBits;		// 位图数据的起始位置，以相对于位图文件头的偏移量表示，以字节为单位
			} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
			
			|.BM.|....大小...|..0..|..0..|
			42 4d b6 70 06 00 00 00 00 00
			*/
			
			bmdData[0]=0x42;
			bmdData[1]=0x4d;//"BM"
			
			//bfSize
			bmdData[2]=0;
			bmdData[3]=0;
			bmdData[4]=0;
			bmdData[5]=0;
			
			bmdData[6]=0;
			bmdData[7]=0;
			bmdData[8]=0;
			bmdData[9]=0;//00 00 00 00
			
			bmdData[10]=54;
			bmdData[11]=0;
			bmdData[12]=0;
			bmdData[13]=0;
			
			
			/*
			位图信息头
			typedef struct tagBITMAPINFOHEADER{
				DWORD	biSize; //本结构所占用字节数
				LONG	biWidth; //位图的宽度
				LONG	biHeight; //位图的高度
				WORD	biPlanes; //永远为1 ,由于没有用过所以 没做研究 附msdn解释 Specifies the number of planes for the target device. This value must be set to 1. 
				WORD	biBitCount;//位图的位数  分为1 4 8 16 24 32 本文没对1 4 进行研究
				DWORD	biCompression; //本意为压缩类型，但是却另外有作用，稍候解释
				DWORD	biSizeImage; //表示位图数据区域的大小以字节为单位
				LONG	biXPelsPerMeter;//位图水平分辨率，每米像素数
				LONG	biYPelsPerMeter;//位图垂直分辨率，每米像素数
				DWORD	biClrUsed;//ColorsUsed 位图实际使用的颜色表中的颜色数
				DWORD	biClrImportant;//ColorsImportant 位图显示过程中重要的颜色数
			} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
			*/
			
			bmdData[14]=40;
			bmdData[15]=0;
			bmdData[16]=0;
			bmdData[17]=0;
			
			var biWidth:uint=bmd.width;
			bmdData[18]=biWidth&0xff;
			bmdData[19]=(biWidth&0xff00)>>8;
			bmdData[20]=(biWidth&0xff0000)>>16;//因为BitmapData最大只能到2880,所以这个其实总是0
			bmdData[21]=(biWidth&0xff000000)>>24;//因为BitmapData最大只能到2880,所以这个其实总是0
			
			var biHeight:int=bmd.height;
			var uBiHeight:uint=isRev?-biHeight:biHeight;
			bmdData[22]=uBiHeight&0xff;
			bmdData[23]=(uBiHeight&0xff00)>>8;
			bmdData[24]=(uBiHeight&0xff0000)>>16;
			bmdData[25]=(uBiHeight&0xff000000)>>24;
			
			bmdData[26]=1;
			bmdData[27]=0;
			
			bmdData[28]=24;
			bmdData[29]=0;
			
			bmdData[30]=0;
			bmdData[31]=0;
			bmdData[32]=0;
			bmdData[33]=0;
			
			//biSizeImage
			bmdData[34]=0;
			bmdData[35]=0;
			bmdData[36]=0;
			bmdData[37]=0;
			
			
			bmdData[38]=0;
			bmdData[39]=0;
			bmdData[40]=0;
			bmdData[41]=0;
			
			bmdData[42]=0;
			bmdData[43]=0;
			bmdData[44]=0;
			bmdData[45]=0;
			
			bmdData[46]=0;
			bmdData[47]=0;
			bmdData[48]=0;
			bmdData[49]=0;//biClrUsed
			
			bmdData[50]=0;
			bmdData[51]=0;
			bmdData[52]=0;
			bmdData[53]=0;//biClrImportant
			
			//设置像素值
			var pos:int=54;
			var restArr:Array;//在设置像素时保持在行末是4个字节的整数倍
			var colorArr:Array;
			var i:int,x:int,y:int,num:int;
			var color:uint;
			var biCompression:int;
			
			restArr=getRestArr(pos);
			switch(biBitCount){
				case 24:
				if(isRev){
					for(y=0;y<biHeight;y++){
						for(x=0;x<biWidth;x++){
							color=bmd.getPixel(x,y);
							//trace("color="+color.toString(16));
							bmdData[pos++]=color&0xff;
							bmdData[pos++]=(color&0xff00)>>8;
							bmdData[pos++]=(color&0xff0000)>>16;
						}
						pos+=restArr[pos%4];
					}
				}else{
					for(y=biHeight-1;y>=0;y--){
						for(x=0;x<biWidth;x++){
							color=bmd.getPixel(x,y);
							//trace("color="+color.toString(16));
							bmdData[pos++]=color&0xff;
							bmdData[pos++]=(color&0xff00)>>8;
							bmdData[pos++]=(color&0xff0000)>>16;
						}
						pos+=restArr[pos%4];
					}
				}
			}
			
			var bfSize:int=bmdData.length;
			bmdData[2]=bfSize&0xff;
			bmdData[3]=(bfSize&0xff00)>>8;
			bmdData[4]=(bfSize&0xff0000)>>16;
			bmdData[5]=(bfSize&0xff000000)>>24;
			return bmdData;
		}
		public static function decode(bmdData:ByteArray):BitmapData{
			if(!(bmdData[0]==0x42&&bmdData[1]==0x4d)){
				//0x42,0x4d----66,77----BM
				trace("不是有效的位图文件");
				return null;
			}
			var bfOffBits:int=bmdData[10]|(bmdData[11]<<8)|(bmdData[12]<<16)|(bmdData[13]<<24);
			trace("bfOffBits="+bfOffBits);
			var biWidth:int=bmdData[18]|(bmdData[19]<<8)|(bmdData[20]<<16)|(bmdData[21]<<24);
			trace("biWidth="+biWidth);
			var biHeight:int=bmdData[22]|(bmdData[23]<<8)|(bmdData[24]<<16)|(bmdData[25]<<24);
			trace("biHeight="+biHeight);
			var biBitCount:int=bmdData[28]|(bmdData[29]<<8);
			trace("biBitCount="+biBitCount);
			var biCompression:int=bmdData[30]|(bmdData[31]<<8)|(bmdData[32]<<16)|(bmdData[33]<<24);
			trace("biCompression="+biCompression);
			
			/*
			BMP文件头
			typedef struct tagBITMAPFILEHEADER {
				WORD	bfType;			// 位图文件的类型，必须为BM
				DWORD	bfSize;			// 位图文件的大小，以字节为单位
				WORD	bfReserved1;	// 位图文件保留字，必须为0
				WORD	bfReserved2;	// 位图文件保留字，必须为0
				DWORD	bfOffBits;		// 位图数据的起始位置，以相对于位图文件头的偏移量表示，以字节为单位
			} BITMAPFILEHEADER, *PBITMAPFILEHEADER;
			
			|.BM.|....大小...|..0..|..0..|
			42 4d b6 70 06 00 00 00 00 00
			*/
			
			/*trace(String.fromCharCode(bmdData[0])+String.fromCharCode(bmdData[1]));//BM
			var bfSize:int=bmdData[2]|(bmdData[3]<<8)|(bmdData[4]<<16)|(bmdData[5]<<24);
			trace("bfSize="+bfSize);
			trace(bmdData[6],bmdData[7],bmdData[8],bmdData[9]);//0 0 0 0*/
			
			/*
			位图信息头
			typedef struct tagBITMAPINFOHEADER{
				DWORD	biSize; //本结构所占用字节数
				LONG	biWidth; //位图的宽度
				LONG	biHeight; //位图的高度
				WORD	biPlanes; //永远为1 ,由于没有用过所以 没做研究 附msdn解释 Specifies the number of planes for the target device. This value must be set to 1. 
				WORD	biBitCount;//位图的位数  分为1 4 8 16 24 32 本文没对1 4 进行研究
				DWORD	biCompression; //本意为压缩类型，但是却另外有作用，稍候解释
				DWORD	biSizeImage; //表示位图数据区域的大小以字节为单位
				LONG	biXPelsPerMeter;//位图水平分辨率，每米像素数
				LONG	biYPelsPerMeter;//位图垂直分辨率，每米像素数
				DWORD	biClrUsed;//ColorsUsed 位图实际使用的颜色表中的颜色数
				DWORD	biClrImportant;//ColorsImportant 位图显示过程中重要的颜色数
			} BITMAPINFOHEADER, *PBITMAPINFOHEADER;
			*/
			
			/*var biSize:int=bmdData[14]|(bmdData[15]<<8)|(bmdData[16]<<16)|(bmdData[17]<<24);
			trace("biSize="+biSize);
			trace("biPlanes="+(bmdData[26]|(bmdData[27]<<8)));
			var biSizeImage:int=bmdData[34]|(bmdData[35]<<8)|(bmdData[36]<<16)|(bmdData[37]<<24);
			trace("biSizeImage="+biSizeImage);
			var biXPelsPerMeter:int=bmdData[38]|(bmdData[39]<<8)|(bmdData[40]<<16)|(bmdData[41]<<24);
			trace("biXPelsPerMeter="+biXPelsPerMeter);
			var biYPelsPerMeter:int=bmdData[42]|(bmdData[43]<<8)|(bmdData[44]<<16)|(bmdData[45]<<24);
			trace("biYPelsPerMeter="+biYPelsPerMeter);
			var biClrUsed:int=bmdData[46]|(bmdData[47]<<8)|(bmdData[48]<<16)|(bmdData[49]<<24);
			trace("biClrUsed="+biClrUsed);
			var biClrImportant:int=bmdData[50]|(bmdData[51]<<8)|(bmdData[52]<<16)|(bmdData[53]<<24);
			trace("biClrImportant="+biClrImportant);*/
			
			/*
			颜色表
			typedef struct tagRGBQUAD {
				BYTE	rgbBlue;// 蓝色的亮度(值范围为0-255)
				BYTE	rgbGreen; // 绿色的亮度(值范围为0-255)
				BYTE	rgbRed; // 红色的亮度(值范围为0-255)
				BYTE	rgbReserved;// 保留，必须为0
			} RGBQUAD;
			颜色表中RGBQUAD结构数据的个数有biBitCount来确定:
			当biBitCount=1,4,8时，分别有2,16,256个表项;
			*/
			
			var pos:int=54;
			var restArr:Array;//在读取像素时保持在行末是4个字节的整数倍
			var bmd:BitmapData=new BitmapData(biWidth,biHeight>0?biHeight:-biHeight,false,0x000000);
			var colorArr:Array;
			var i:int,x:int,y:int,num:int;
			var color:uint;
			var isRev:Boolean=biHeight<0;//是否翻转
			if(isRev){
				biHeight=-biHeight;
			}
			switch(biBitCount){
				case 32:
					//得到像素值
					pos=bfOffBits;
					restArr=getRestArr(pos);
					if(biCompression){
						if(isRev){
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									pos++
									bmd.setPixel(x,y,bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16));
								}
								pos+=restArr[pos%4];
							}
						}else{
							for(y=biHeight-1;y>=0;y--){
								for(x=0;x<biWidth;x++){
									pos++
									bmd.setPixel(x,y,bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16));
								}
								pos+=restArr[pos%4];
							}
						}
					}else{
						if(isRev){
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									bmd.setPixel(x,y,bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16));
									pos++
								}
								pos+=restArr[pos%4];
							}
						}else{
							for(y=biHeight-1;y>=0;y--){
								for(x=0;x<biWidth;x++){
									bmd.setPixel(x,y,bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16));
									pos++
								}
								pos+=restArr[pos%4];
							}
						}
					}
				break;
				case 24:
					//得到像素值
					pos=bfOffBits;
					restArr=getRestArr(pos);
					if(isRev){
						for(y=0;y<biHeight;y++){
							for(x=0;x<biWidth;x++){
								bmd.setPixel(x,y,bmdData[pos++]|((bmdData[pos++])<<8)|((bmdData[pos++])<<16));
							}
							pos+=restArr[pos%4];
						}
					}else{
						for(y=biHeight-1;y>=0;y--){
							for(x=0;x<biWidth;x++){
								bmd.setPixel(x,y,bmdData[pos++]|((bmdData[pos++])<<8)|((bmdData[pos++])<<16));
							}
							pos+=restArr[pos%4];
						}
					}
				break;
				case 16:
					var mask1:int,mask2:int,mask3:int;
					var rOffset:int,gOffset:int,bOffset:int;
					if(biCompression){
						//在位图数据区域前存在一个RGB掩码的描述 是3个DWORD值
						mask1=bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16)|(bmdData[pos++]<<24);
						mask2=bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16)|(bmdData[pos++]<<24);
						mask3=bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16)|(bmdData[pos++]<<24);
						
						switch(mask1){
							case 0xf800:
								//565
								rOffset=5;
								gOffset=6;
								bOffset=5;
							break;
							case 0xf00:
								//444
								rOffset=4;
								gOffset=4;
								bOffset=4;
							break;
							default:
								//555
								rOffset=5;
								gOffset=5;
								bOffset=5;
							break;
						}
					}else{
						//16_x1r5g5b5,16_x1r5g5b5_rev,貌似就是没有压缩的555格式...
						rOffset=5;
						gOffset=5;
						bOffset=5;
						mask1=0x7c00;
						mask2=0x3e0;
						mask3=0x1f;
					}
					
					trace(mask1.toString(16),mask1.toString(2));
					trace(mask2.toString(16),mask2.toString(2));
					trace(mask3.toString(16),mask3.toString(2));
					
					var rMult:Number=0xff/((1<<rOffset)-1)/(1<<(gOffset+bOffset));
					var gMult:Number=0xff/((1<<gOffset)-1)/(1<<bOffset);
					var bMult:Number=0xff/((1<<bOffset)-1);
					
					//得到像素值
					pos=bfOffBits;
					restArr=getRestArr(pos);
					var colorData:int;
					if(isRev){
						for(y=0;y<biHeight;y++){
							for(x=0;x<biWidth;x++){
								colorData=bmdData[pos++]|(bmdData[pos++]<<8);
								bmd.setPixel(x,y,
									(Math.round((colorData&mask1)*rMult)<<16)|
									(Math.round((colorData&mask2)*gMult)<<8)|
									Math.round((colorData&mask3)*bMult)
								);
							}
							pos+=restArr[pos%4];
						}
					}else{
						for(y=biHeight-1;y>=0;y--){
							for(x=0;x<biWidth;x++){
								colorData=bmdData[pos++]|(bmdData[pos++]<<8);
								bmd.setPixel(x,y,
									(Math.round((colorData&mask1)*rMult)<<16)|
									(Math.round((colorData&mask2)*gMult)<<8)|
									Math.round((colorData&mask3)*bMult)
								);
							}
							pos+=restArr[pos%4];
						}
					}
				break;
				case 8:
					//得到调色板
					colorArr=new Array(256);
					for(i=0;i<256;i++){
						color=bmdData[pos]|(bmdData[pos+1]<<8)|(bmdData[pos+2]<<16);
						colorArr[i]=color;
						pos+=4;
					}
					
					//得到像素值
					pos=bfOffBits;
					restArr=getRestArr(pos);
					if(biCompression){
						trace("暂不支持8位压缩位图的解码 ^_^");
/*
http://www.vckbase.com/article/bitmap/3.htm
关于位图行程编码格式压缩
作者:TingYa 

---Window中的位图支持行程编码压缩方式，通常位图的象素使用4比特或者8比特来表示，即BITMAPINFOHEADER结构中的biCompression的BI_RLE8和BI_RLE4
1．8位位图的压缩
---在这种情况下BITMAPINFOHEADER结构中的biCompression设置为BI_RLE8,.使用256色位图行程编码格式将位图进行压缩。这种压缩方式包括绝对方式和编码方式。 

编码方式
---在此方式下每两个字节组成一个信息单元。第一个字节给出其后面相连的象素的个数。第二个字节给出这些象素使用的颜色索引表中的索引。例如：信息单元03 04，03表示其后的象素个数是3个，04表示这些象素使用的是颜色索引表中的第五项的值。压缩数据展开后就是04 04 04 .同理04 05 可以展开为05 05 05 05. 信息单元的第一个字节也可以是00，这种情况下信息单元并不表示数据单元，而是表示一些特殊的含义。这些含义通常由信息单元的第二个字节的值来描述。这些值在0x00到0x02之间。
具体含义如下： 
第二个字节的值 
00 线结束 
01 位图结束 
02 象素位置增量。表示紧跟在这个字节后面的信息单元里的两个字节中所包含的无符号值指定了下个象素相对于当前象素的水平和垂直偏移量。例如：00 02 06 08表示的含义是下一个象素的位值是从当前位置向右移动5个象素，向下移动8个象素。（不是字节） 

绝对方式 

---绝对方式的标志是第一个字节是0，第二个字节是0x03到0xff之间的值。第二个 字节的值表示跟随其后面的象素的字节数目。每个字节都包含一个象素的颜色索引。 每个行程编码都必须补齐到字的边界。 

2． 4位位图压缩
---这是BITMAPINFOHEADER的biCompression设置为BI_RLE4，使用16位行程编码格式进行位图压缩。压缩方式也包括编码方式和绝对方式。 
编码方式： 
---4位压缩的编码方式跟8位的编码的压缩方式没有什么区别。每个信息单元也是由 两个字节表示，第一个字节表示其后面所跟随的象素的个数。第二个字节表示象素在 颜色索引表中的索引。这个字节又分为上下两个部分。第一个象素用上半部分指定的 颜色表中的颜色画出。第二个象素用下半部分的颜色画出。第三个象素用下一个字节 的上半部分画出。依次类推。 其余的跟8位位图压缩差不多。
*/
					}else{
						if(isRev){
							for(y=0;y<biHeight;y++){
								for(x=0;x<biWidth;x++){
									bmd.setPixel(x,y,colorArr[bmdData[pos++]]);
								}
								pos+=restArr[pos%4];
							}
						}else{
							for(y=biHeight-1;y>=0;y--){
								for(x=0;x<biWidth;x++){
									bmd.setPixel(x,y,colorArr[bmdData[pos++]]);
								}
								pos+=restArr[pos%4];
							}
						}
					}
				break;
				case 4:
					trace("暂不支持对4位位图的解码");
				break;
				case 1:
					//得到调色板
					colorArr=new Array(2);
					for(i=0;i<2;i++){
						color=bmdData[pos++]|(bmdData[pos++]<<8)|(bmdData[pos++]<<16);
						trace("color=0x"+color.toString(16));
						colorArr[i]=color;
						pos++;
					}
					//得到像素值
					pos=bfOffBits;
					restArr=getRestArr(pos);
					if(isRev){
						x=0;
						y=0;
						loop1_1:while(true){
							num=bmdData[pos++];
							i=8;
							while(--i>=0){
								bmd.setPixel(x,y,colorArr[((num>>i)&1)]);
								if(++x>=biWidth){
									if(++y>=biHeight){
										break loop1_1;
									}
									x=0;
									pos+=restArr[pos%4];
									break;
								}
							}
						}
					}else{
						x=0;
						y=biHeight-1;
						loop1_2:while(true){
							num=bmdData[pos++];
							i=8;
							while(--i>=0){
								bmd.setPixel(x,y,colorArr[((num>>i)&1)]);
								if(++x>=biWidth){
									if(--y<0){
										break loop1_2;
									}
									x=0;
									pos+=restArr[pos%4];
									break;
								}
							}
						}
					}
				break;
				default:
				return null;
			}
			return bmd;
		}
		private static function getRestArr(pos:int):Array{
			switch(pos%4){
				case 0:
					return [0,3,2,1];
				case 1:
					return [1,0,3,2];
				case 2:
					return [2,1,0,3];
				case 3:
					return [3,2,1,0];
			}
			return null;
		}
	}
}