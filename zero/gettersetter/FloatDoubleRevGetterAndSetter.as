/***
FloatDoubleRevGetterAndSetter 版本:v1.0
简要说明:用于 Matrix Rectangle 之类的按位读取的数据
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年7月5日 10:08:47
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.gettersetter{
	import flash.utils.*;
	public class FloatDoubleRevGetterAndSetter{
		private static var numData:ByteArray=new ByteArray();
		public static function getFloatRev(data:ByteArray,offset:int):Number{
			//或参考 Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN
			numData[3]=data[offset++];
			numData[2]=data[offset++];
			numData[1]=data[offset++];
			numData[0]=data[offset++];
			
			numData.position=0;
			return numData.readFloat();
		}
		public static function setFloatRev(value:Number,data:ByteArray,offset:int):void{
			//或参考 Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN
			numData.position=0;
			numData.writeFloat(value);
			
			data[offset++]=numData[3];
			data[offset++]=numData[2];
			data[offset++]=numData[1];
			data[offset++]=numData[0];
		}
		
		public static function getDoubleRev(data:ByteArray,offset:int):Number{
			//或参考 Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN
			numData[3]=data[offset++];
			numData[2]=data[offset++];
			numData[1]=data[offset++];
			numData[0]=data[offset++];
			numData[7]=data[offset++];
			numData[6]=data[offset++];
			numData[5]=data[offset++];
			numData[4]=data[offset++];
			
			numData.position=0;
			return numData.readDouble();
		}
		public static function setDoubleRev(value:Number,data:ByteArray,offset:int):void{
			//或参考 Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN
			numData.position=0;
			numData.writeDouble(value);
			
			data[offset++]=numData[3];
			data[offset++]=numData[2];
			data[offset++]=numData[1];
			data[offset++]=numData[0];
			data[offset++]=numData[7];
			data[offset++]=numData[6];
			data[offset++]=numData[5];
			data[offset++]=numData[4];
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