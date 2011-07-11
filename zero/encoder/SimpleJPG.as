/***
SimpleJPG 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月13日 13:56:27
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

//JPEG文件由八个部分组成，每个部分的标记字节为两个，首字节固定为：0xFF，当然，准许在其前面再填充多个0xFF，以最后一个为准。下面为各部分的名称和第二个标记字节的数值，用ultraedit的16进制搜索功能可找到各部分的起始位置，在嵌入式系统中可用类似的数值匹配法定位。
//一、图像开始SOI(Start of Image)标记，数值0xD8
//二、APP0标记(Marker)，数值0xE0
//1、APP0长度(length)
//2、标识符(identifier)
//3、版本号(version)
//4、X和Y的密度单位(units=0：无单位；units=1：点数/英寸；units=2：点数/厘米)
//5、X方向像素密度(X density)
//6、Y方向像素密度(Y density)
//7、缩略图水平像素数目(thumbnail horizontal pixels)
//8、缩略图垂直像素数目(thumbnail vertical pixels)
//9、缩略图RGB位图(thumbnail RGB bitmap)，由前面的数值决定，取值3n，n为缩略图总像素
//三、APPn标记(Markers)，其中n=1～15，数值对应0xE1～0xEF　　　 
//1、APPn长度(length)
//2、应用细节信息(application specific information)
//四、一个或者多个量化表DQT(difine quantization table)，数值0xDB
//1、量化表长度(quantization table length)
//2、量化表数目(quantization table number)
//3、量化表(quantization table)
//五、帧图像开始SOF0(Start of Frame)，数值0xC0
//1、帧开始长度(start of frame length)
//2、精度(precision)，每个颜色分量每个像素的位数(bits per pixel per color component)
//3、图像高度(image height)
//4、图像宽度(image width)
//5、颜色分量数(number of color components)
//6、对每个颜色分量(for each component)
//包括：ID、垂直方向的样本因子(vertical sample factor)、水平方向的样本因子(horizontal sample factor) 、量化表号(quantization table#)
//六、一个或者多个霍夫曼表DHT(Difine Huffman Table)，数值0xC4
//1、霍夫曼表的长度(Huffman table length)
//2、类型、AC或者DC(Type, AC or DC)
//3、索引(Index)
//4、位表(bits table)
//5、值表(value table)
//七、扫描开始SOS(Start of Scan)，数值0xDA
//1、扫描开始长度(start of scan length)
//2、颜色分量数(number of color components)
//3、每个颜色分量
//包括：ID、交流系数表号(AC table #)、直流系数表号(DC table #)
//4、压缩图像数据(compressed image data)
//八、图像结束EOI(End of Image)，数值0xD9

package zero.encoder{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class SimpleJPG{
		private static const SOI:int=0xD8;
		private static const APPO:int=0xE0;
		//private static const APPn:0xE1～0xEF
		private static const DQT:int=0xDB;
		private static const SOF0:int=0xC0;
		private static const DHT:int=0xC4;
		private static const SOS:int=0xDA;
		private static const EOI:int=0xD9;
		
		public static function getSOF0EndOffset(jpgData:ByteArray):int{//主要是为了插入 JPEGTables
			var endOffset:int=jpgData.length;
			var offset:int=0;
			while(offset<endOffset){
				while(jpgData[++offset]==0xff){}
				var Maker:int=jpgData[offset++];
				switch(Maker){
					case SOI:
					break;
					case EOI:
						break;
					break;
					default:
						offset+=(jpgData[offset]<<8)|jpgData[offset+1];
						if(Maker==SOF0){
							return offset;
						}
					break;
				}
			}
			return -1;
		}
		/*
		public static function decode(jpgData:ByteArray):Vector.<Vector.<int>>{
			var decodeResult:Vector.<Vector.<int>>=new Vector.<Vector.<int>>();
			var endOffset:int=jpgData.length;
			var offset:int=0;
			while(offset<endOffset){
				while(jpgData[++offset]==0xff){}
				trace("offset="+offset);
				var subDecodeResult:Vector.<int>=new Vector.<int>();
				var Maker:int=jpgData[offset++];
				subDecodeResult[0]=Maker;
				switch(Maker){
					case SOI:
					break;
					case EOI:
					break;
					default:
						var length:int=(jpgData[offset]<<8)|jpgData[offset+1];
						subDecodeResult[1]=offset;
						subDecodeResult[2]=length;
						offset+=length;
					break;
				}
				decodeResult[decodeResult.length]=subDecodeResult;
				
				if(Maker==EOI){
					break;
				}
			}
			if(offset==endOffset){
				
			}else{
				trace("offset="+offset,"endOffset="+endOffset);
				trace("jpg可能包含不合法数据");
			}
			return decodeResult;
		}
		*/
	}
}

