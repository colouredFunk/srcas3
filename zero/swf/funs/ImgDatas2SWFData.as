/***
ImgDatas2SWFData 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月16日 07:32:36
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class ImgDatas2SWFData{
		public static function imgDatas2SWFData(imgDataOrImgDataArr:*,classNameOrClassNameArr:*):ByteArray{
			var imgDataV:Vector.<ByteArray>;
			var classNameV:Vector.<String>;
			if(imgDataOrImgDataArr is ByteArray){
				imgDataV=new Vector.<ByteArray>();
				imgDataV[0]=imgDataOrImgDataArr;
			}else{
				imgDataV=Vector.<ByteArray>(imgDataOrImgDataArr);
			}
			if(classNameOrClassNameArr is String){
				classNameV=new Vector.<String>();
				classNameV[0]=classNameOrClassNameArr;
			}else{
				classNameV=Vector.<String>(classNameOrClassNameArr);
			}
			var swfData:ByteArray=new ByteArray();
			
			swfData[0]=0x46;
			swfData[1]=0x57;
			swfData[2]=0x53;
			
			swfData[3]=0x0a;
			
			swfData[4]=0x00;
			swfData[5]=0x00;
			swfData[6]=0x00;
			swfData[7]=0x00;
			
			swfData[8]=0x00;
			
			swfData[9]=0x00;
			swfData[10]=0x20;
			
			swfData[11]=0x01;
			swfData[12]=0x00;
			
			swfData[13]=0x44;
			swfData[14]=0x11;
			swfData[15]=0x08;
			swfData[16]=0x00;
			swfData[17]=0x00;
			swfData[18]=0x00;
			
			var offset:int,tagBodyLengthPos:int,tagBodyLength:int;
			var i:int=0;
			var currId:int=1;
			var className:String;
			
			for each(var imgData:ByteArray in imgDataV){
				offset=swfData.length;
				
				swfData[offset++]=0xbf;
				swfData[offset++]=0x14;
				
				tagBodyLengthPos=offset;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				
				swfData[offset++]=0x01;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x10;
				swfData[offset++]=0x00;
				swfData[offset++]=0x2e;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x06;
				swfData[offset++]=0x00;
				
				var classNameData:ByteArray=new ByteArray();
				className=classNameV[i];
				classNameData.writeUTFBytes(className);
				if(classNameData.length>0x7f){
					throw new Error("暂不支持长度超过 0x7f 的 className: "+className);
					return;
				}
				swfData[offset++]=classNameData.length;
				swfData.position=offset;
				swfData.writeBytes(classNameData);
				swfData.writeBytes(getBytesByNums(0x0d,0x66,0x6c,0x61,0x73,0x68,0x2e,0x64,0x69,0x73,0x70,0x6c,0x61,0x79,0x0a,0x42,0x69,0x74,0x6d,0x61,0x70,0x44,0x61,0x74,0x61,0x06,0x4f,0x62,0x6a,0x65,0x63,0x74,0x04,0x16,0x01,0x16,0x03,0x18,0x02,0x00,0x04,0x07,0x01,0x02,0x07,0x02,0x04,0x07,0x01,0x05,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x02,0x09,0x03,0x00,0x01,0x00,0x00,0x00,0x01,0x02,0x01,0x01,0x04,0x01,0x00,0x03,0x00,0x01,0x01,0x04,0x05,0x03,0xd0,0x30,0x47,0x00,0x00,0x01,0x03,0x01,0x05,0x06,0x09,0xd0,0x30,0xd0,0x24,0x00,0x2a,0x49,0x02,0x47,0x00,0x00,0x02,0x02,0x01,0x01,0x04,0x13,0xd0,0x30,0x65,0x00,0x60,0x03,0x30,0x60,0x02,0x30,0x60,0x02,0x58,0x00,0x1d,0x1d,0x68,0x01,0x47,0x00,0x00));
				
				offset=swfData.length;
				
				tagBodyLength=offset-tagBodyLengthPos-4;
				swfData[tagBodyLengthPos]=tagBodyLength;
				swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
				swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
				swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
					
				swfData[offset++]=0x7f;
				swfData[offset++]=0x05;
				
				tagBodyLengthPos=offset;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				swfData[offset++]=0x00;
				
				swfData[offset++]=currId;
				swfData[offset++]=currId>>8;
				
				swfData.position=offset;
				swfData.writeBytes(imgData);
				
				offset=swfData.length;
				
				tagBodyLength=offset-tagBodyLengthPos-4;
				swfData[tagBodyLengthPos]=tagBodyLength;
				swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
				swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
				swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
				
				i++;
				currId++;
			}
			
			offset=swfData.length;
			
			swfData[offset++]=0x3f;
			swfData[offset++]=0x13;
			
			tagBodyLengthPos=offset;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			
			swfData[offset++]=classNameV.length;
			swfData[offset++]=classNameV.length>>8;
			
			currId=1;
			for each(className in classNameV){
				swfData[offset++]=currId;
				swfData[offset++]=currId>>8;
				
				swfData.position=offset;
				swfData.writeUTFBytes(className+"\x00");
			}
			
			offset=swfData.length;
			
			tagBodyLength=offset-tagBodyLengthPos-4;
			swfData[tagBodyLengthPos]=tagBodyLength;
			swfData[tagBodyLengthPos+1]=tagBodyLength>>8;
			swfData[tagBodyLengthPos+2]=tagBodyLength>>16;
			swfData[tagBodyLengthPos+3]=tagBodyLength>>24;
			
			swfData[offset++]=0x40;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			swfData[offset++]=0x00;
			
			var swfDataSize:int=swfData.length;
			swfData[4]=swfDataSize;
			swfData[5]=swfDataSize>>8;
			swfData[6]=swfDataSize>>16;
			swfData[7]=swfDataSize>>24;
			
			return swfData;
		}
		
		
		private static function getBytesByNums(...nums):ByteArray{
			var bytes:ByteArray=new ByteArray();
			var i:int=0;
			for each(var num:int in nums){
				bytes[i++]=num;
			}
			return bytes;
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