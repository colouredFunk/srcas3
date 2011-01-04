/***
ReplaceDoActionConstant 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月16日 22:26:38
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import zero.swf.*;
	import flash.utils.ByteArray;
	
	public class ReplaceDoActionConstant{
		public static function replace(doActionTag:Tag,str0Arr:Array,strtArr:Array):Boolean{
			var str:String,i:int;
			var strMark:Object=new Object();
			i=0;
			for each(str in str0Arr){
				strMark["~"+str]=strtArr[i++];
			}
			var doActionData:ByteArray=doActionTag.getBodyData();
			//trace(BytesAndStr16.bytes2str16(doActionData,tag.bodyOffset,tag.bodyLength));
			var offset:int=doActionTag.bodyOffset;
			if(doActionData[offset++]==0x88){//constantPool
				var newDoActionData:ByteArray=new ByteArray();
				newDoActionData[0]=0x88;
				var constantPoolSize:int=doActionData[offset++]|(doActionData[offset++]<<8);
				//trace("constantPoolSize="+constantPoolSize);
				//newDoActionData[1]=0x00;
				//newDoActionData[2]=0x00;
				i=doActionData[offset++]|(doActionData[offset++]<<8);
				newDoActionData[3]=i
				newDoActionData[4]=i>>8;
				while(i>0){
					i--;
					var strSize:int=0;
					doActionData.position=offset;
					while(doActionData[offset++]){
						strSize++;
					}
					if(strSize){
						str=doActionData.readUTFBytes(strSize);
						if(strMark["~"+str] is String){
							str=strMark["~"+str];
						}
						newDoActionData.position=newDoActionData.length;
						newDoActionData.writeUTFBytes(str);
					}
					newDoActionData[newDoActionData.length]=0x00;//字符串结束
				}
				constantPoolSize=newDoActionData.length-3;
				newDoActionData[1]=constantPoolSize;
				newDoActionData[2]=constantPoolSize>>8;
				newDoActionData.position=newDoActionData.length;
				newDoActionData.writeBytes(doActionData,offset,doActionTag.bodyOffset+doActionTag.bodyLength-offset);
				doActionTag.setBodyData(newDoActionData);
				return true;
			}
			return false;
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