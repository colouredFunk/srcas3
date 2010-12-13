/***
EncryptAS2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月21日 09:52:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm1{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.DataAndTags;
	import zero.swf.SWFLevel0;
	import zero.swf.Tag;
	import zero.swf.TagType;
	import zero.swf.tagBodys.DefineButton2;
	import zero.swf.tagBodys.DoAction;
	import zero.swf.tagBodys.DoInitAction;
	import zero.swf.tagBodys.PlaceObject2;
	import zero.swf.tagBodys.PlaceObject3;
	
	public class EncryptAS2{
		public static var totalActionRecord:int;
		public static function encrypt(swfData:ByteArray,encryptFun:Function=null):ByteArray{
			totalActionRecord=1;
			
			DataAndTags.activateTagBodyClasses([
				DefineButton,
				DefineButton2,
				DoAction,
				DoInitAction,
				PlaceObject2,
				PlaceObject3
			]);
			
			var swf:SWFLevel0=new SWFLevel0();
			ACTIONRECORD.reset();
			swf.initBySWFData(swfData);
			var actionRecordV:Vector.<ACTIONRECORD>=ACTIONRECORD.actionRecordV;
			if(encryptFun==null){
				encryptFun=encrypt1;
				//encryptFun=TrueStrCode.addCheckTrueStrCodes;
			}
			for each(var actionRecord:ACTIONRECORD in actionRecordV){
				if(actionRecord.dataLength){
					encryptFun(actionRecord);
				}
			}
			ACTIONRECORD.clear();
			
			totalActionRecord=actionRecordV.length;
			
			return swf.toSWFData();
		}
		private static function getJunkCodes():ByteArray{
			var junkCodes:ByteArray=new ByteArray();
			var i:int=int(Math.random()*3)+1;
			while(i--){
				junkCodes[i]=int(Math.random()*0x100);
			}
			return junkCodes;
		}
		public static function encrypt0(actionRecord:ACTIONRECORD):void{
			//var junkCodes:ByteArray=getJunkCodes();//效果不太好
			var junkCodes:ByteArray=new ByteArray();
			junkCodes[0]=0x90;
			
			var offset1:int=actionRecord.dataLength+junkCodes.length+1;//原字节码长度 + 扰码长度 + 1
			var offset2:int=-(actionRecord.dataLength+6);//-(原字节码长度 + 6)
			//下面是 99 02 00 offset1 扰码 原字节码 end 99 02 00 offset2 end:
			
			var encryptTagData:ByteArray=new ByteArray();
			
			encryptTagData[0]=0x99;
			encryptTagData[1]=0x02;
			encryptTagData[2]=0x00;
			encryptTagData[3]=offset1;
			encryptTagData[4]=offset1>>8;
			
			encryptTagData.position=encryptTagData.length;
			encryptTagData.writeBytes(junkCodes);//扰码
			
			encryptTagData.writeBytes(actionRecord.ownData,actionRecord.dataOffset,actionRecord.dataLength);//原字节码
			
			encryptTagData[encryptTagData.length]=0x00;//end一下，否则出问题。。
			
			encryptTagData[encryptTagData.length]=0x99;
			encryptTagData[encryptTagData.length]=0x02;
			encryptTagData[encryptTagData.length]=0x00;
			encryptTagData[encryptTagData.length]=offset2;
			encryptTagData[encryptTagData.length]=offset2>>8;
			
			//encryptTagData[encryptTagData.length]=0x00;//end
			actionRecord.initByData(encryptTagData,0,encryptTagData.length);
			
			//trace(BytesAndStr16.bytes2str16(encryptTagData,0,encryptTagData.length));
		}
		
		public static function encrypt1(actionRecord:ACTIONRECORD):void{
			var junkCodes:ByteArray=getJunkCodes();
			
			var encryptTagData:ByteArray=new ByteArray();
			
			var i:int;
			switch(1){
				/*
				case 0:
					encryptTagData[0]=0x96;
					encryptTagData[1]=0x02;
					encryptTagData[2]=0x00;
					encryptTagData[3]=0x05;
					encryptTagData[4]=0x01;
					//_push true
					//asv直接跳过
				break;
				//*/
				/*
				case 0:
					encryptTagData[0]=0x96;
					encryptTagData[1]=0x02;
					encryptTagData[2]=0x00;
					encryptTagData[3]=0x05;
					encryptTagData[4]=0x00;
					
					encryptTagData[5]=0x96;
					encryptTagData[6]=0x02;
					encryptTagData[7]=0x00;
					encryptTagData[8]=0x05;
					encryptTagData[9]=0x01;
					
					encryptTagData[10]=0x11;
					//_push false(或其它为假的值)
					//_push true(或其它为真的值)
					//_or
					//貌似意义不大
				break;
				//*/
				case 1:
					var trueStrCode:int=TrueStrCode.getTrueStrCode();
					
					encryptTagData[0]=0x96;
					if(trueStrCode>0xff){
						encryptTagData[1]=0x03;
						encryptTagData[4]=trueStrCode>>8;
						encryptTagData[5]=trueStrCode;
					}else{
						encryptTagData[1]=0x02;
						encryptTagData[4]=trueStrCode;
					}
					encryptTagData[2]=0x00;
					encryptTagData[3]=0x00;
					//_push (非空字符串)
					//配合有效的扰码能使asv挂掉
				break;
			}
			
			var offset:int=junkCodes.length;
			
			encryptTagData[encryptTagData.length]=0x9d;
			encryptTagData[encryptTagData.length]=0x02;
			encryptTagData[encryptTagData.length]=0x00;
			encryptTagData[encryptTagData.length]=offset;
			encryptTagData[encryptTagData.length]=offset>>8;
			//9d 02 00 offset 
			//_if true jump offset
			
			encryptTagData.position=encryptTagData.length;
			encryptTagData.writeBytes(junkCodes);//扰码
			
			encryptTagData.writeBytes(actionRecord.ownData,actionRecord.dataOffset,actionRecord.dataLength);//原字节码
			
			encryptTagData[encryptTagData.length]=0x00;//end一下，否则出问题。。
			
			//encryptTagData[encryptTagData.length]=0x99;
			//encryptTagData[encryptTagData.length]=0x02;
			//encryptTagData[encryptTagData.length]=0x00;
			//encryptTagData[encryptTagData.length]=0xfb;
			//encryptTagData[encryptTagData.length]=0xff;
			
			//encryptTagData[encryptTagData.length]=0x00;//end
			actionRecord.initByData(encryptTagData,0,encryptTagData.length);
			
			//trace(BytesAndStr16.bytes2str16(encryptTagData,0,encryptTagData.length));
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