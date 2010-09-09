/***
BGetterAndSetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年3月19日 09:41:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.gettersetter{
	import flash.utils.*;
	public class BGetterAndSetter{不推荐使用
		//UB,SB,FB专用
		private static var data:ByteArray;
		public static var offset:int;
		private static var bitOffset:int;
		private static var currValue:int;
		public static function startGet(_data:ByteArray,_offset:int):void{
			data=_data;
			offset=_offset;
			bitOffset=0;
			currValue=
				(data[offset++]<<24)|
				(data[offset++]<<16)|
				(data[offset++]<<8)|
				data[offset++];
		}
		public static function getUB(Nbits:int):int{
			if(Nbits>0){
				var b:int=(currValue&((0xffffffff<<(32-Nbits))>>>bitOffset))>>>(32-(bitOffset+=Nbits));
				while(bitOffset>=8){
					bitOffset-=8;
					currValue=(currValue<<8)|data[offset++];
				}
				return b;
			}
			return 0;
		}
		public static function getSB(Nbits:int):int{
			var b:int=getUB(Nbits);
			if(b>>>(Nbits-1)){//最高位为1,表示负数
				b|=(0xffffffff<<Nbits);//用1补足32位
			}
			return b;
		}
		public static function getFB(Nbits:int):int{
			var b:int=getUB(Nbits);
			if(b>>>(Nbits-1)){//最高位为1,表示负数
				b|=(0xffffffff<<Nbits);//用1补足32位
			}
			return b;
		}
		public static function endGet():void{
			data=null;
			offset-=(bitOffset?3:4);
		}
		/////////////////////////////////////////////////////////////////////////////////////////
		
		public static function startSet(_data:ByteArray,_offset:int):void{
			data=_data;
			offset=_offset;
			bitOffset=32;
			currValue=0;
		}
		public static function getNbitsByUBs(...bs):int{
			var Nbits:int=0;
			for each(var b:int in bs){
				//计算所需最小位数
				if(b>>>Nbits){
					while(b>>>(++Nbits)){};
				}
			}
			return Nbits;
		}
		public static function getNbitsBySBs(...bs):int{
			var Nbits:int=0;
			for each(var b:int in bs){
				//计算所需最小位数
				if(b<0){
					b=-b;
				}
				b<<=1;//这样下面就会多算一位
				if(b>>>Nbits){
					while(b>>>(++Nbits)){};
				}
			}
			return Nbits;
		}
		public static function getNbitsByFBs(...bs):int{
			var Nbits:int=0;
			for each(var b:int in bs){
				//计算所需最小位数
				if(b<0){
					b=-b;
				}
				b<<=1;//这样下面就会多算一位
				if(b>>>Nbits){
					while(b>>>(++Nbits)){};
				}
			}
			return Nbits;
		}
		public static function setUB(b:int,Nbits:int):void{
			if(Nbits>0){
				var mask:int=0xffffffff>>>(32-Nbits);
				bitOffset-=Nbits;
				currValue|=((b&mask)<<bitOffset);//对正负数都正确
				while(bitOffset<24){
					bitOffset+=8;
					data[offset++]=currValue>>24;
					currValue<<=8;
				}
			}
		}
		public static function setSB(b:int,Nbits:int):void{
			if(Nbits>0){
				var mask:int=0xffffffff>>>(32-Nbits);
				bitOffset-=Nbits;
				currValue|=((b&mask)<<bitOffset);//对正负数都正确
				while(bitOffset<24){
					bitOffset+=8;
					data[offset++]=currValue>>24;
					currValue<<=8;
				}
			}
		}
		public static function setFB(b:int,Nbits:int):void{
			if(Nbits>0){
				var mask:int=0xffffffff>>>(32-Nbits);
				bitOffset-=Nbits;
				currValue|=((b&mask)<<bitOffset);//对正负数都正确
				while(bitOffset<24){
					bitOffset+=8;
					data[offset++]=currValue>>24;
					currValue<<=8;
				}
			}
		}
		public static function endSet():void{
			while(bitOffset<32){
				bitOffset+=8;
				data[offset++]=currValue>>24;
			}
			data=null;
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