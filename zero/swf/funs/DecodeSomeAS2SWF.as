/***
DecodeSomeAS2SWF 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月27日 17:47:49
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	
	public class DecodeSomeAS2SWF{
		public static function decode(swfData:ByteArray):ByteArray{
			var swf:SWF2=new SWF2();
			swf.initBySWFData(swfData);
			var newOffset:int;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoAction:
						var doAction:DoAction=tag.getBody() as DoAction;
						var actionData:ByteArray=doAction.Actions.toData();
						var newActionData:ByteArray=new ByteArray();
						var endOffset:int=actionData.length;
						var offset:int=0;
						var test_depth:int=0;
						while(offset<endOffset){
							var op:int=actionData[offset++];
							trace("op="+op.toString(16));
							if(op){
								
								if(++test_depth>=6){
									newActionData.position=newActionData.length;
									newActionData.writeBytes(actionData,offset);
									break;
								}
								
								newOffset=getOffset(actionData,offset-1);
								if(newOffset>=0){
									offset=newOffset;
									continue;
								}
								if(op<0x80){
									newActionData[newActionData.length]=op;
								}else{
									var Length:int=actionData[offset++]|(actionData[offset++]<<8);
									newActionData[newActionData.length]=op;
									newActionData[newActionData.length]=Length;
									newActionData[newActionData.length]=Length>>8;
									newActionData.position=newActionData.length;
									newActionData.writeBytes(actionData,offset,Length);
									offset+=Length;
								}
							}else{
								break;
							}
						}
						
						doAction.Actions.initByData(newActionData,0,newActionData.length);
					break;
				}
			}
			return swf.toSWFData();
		}
		private static function getOffset(actionData:ByteArray,offset:int):int{
			var op:int=actionData[offset++];
			var jumpOffset:int;
			if(op<0x80){
				if(op==0x34){
					if(
						actionData[offset]==0x50//_increment
					){
						offset+=1;
					}//else{
					//}
				}
			}else{
				var Length:int=actionData[offset++]|(actionData[offset++]<<8);
				if(op==0x96){
					if(
						Length==3
						&&
						actionData[offset+3]==0x32//_charToAscii
					){
						offset+=4;
					}else if(
						Length==2
						&&
						actionData[offset]==0x05
						&&
						actionData[offset+1]==0x00//_push false
						&&
						actionData[offset+2]==0x12//_not
					){
						offset+=3;
					}else if(
						Length==5
						&&
						actionData[offset+5]==0x4c//_dup
						&&
						actionData[offset+6]==0x61//_bitwiseOr
					){
						offset+=7;
					}else{
						return -1;
					}
				}
			}
			
			if(
				actionData[offset++]==0x9d
				&&
				actionData[offset++]==0x02
				&&
				actionData[offset++]==0x00
			){
				jumpOffset=actionData[offset++]|(actionData[offset++]<<8);
				if(jumpOffset&0x8000){
					jumpOffset|=0xffff0000;
				}
				trace("jumpOffset="+jumpOffset);
				return offset+jumpOffset;
			}
			
			return -1;
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