/***
SWFInfoGetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月22日 18:53:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import zero.gettersetter.BGetterAndSetter;
	public class DataAndBaseInfo{
		public var wid:int;
		public var hei:int;
		public var FrameRate:Number;
		public var offset:int;
		//public static var FrameCount:int;
		public function DataAndBaseInfo(){
			//wid=1;
			//hei=1;
			FrameRate=1;
		}
		
		public function initByData(data:ByteArray):void{
			//获取SWF的宽高帧频帧数
			
			//舞台宽高在SWF里是以一个RECT(见 SWF File Format Specification Version 10 第20页 Rectangle record)的结构保存
			BGetterAndSetter.startGet(data,0);
			var rect_Nbits:int=BGetterAndSetter.getUB(5);
			BGetterAndSetter.getSB(rect_Nbits);//Xmin
			var Xmax:int=BGetterAndSetter.getSB(rect_Nbits);
			BGetterAndSetter.getSB(rect_Nbits);//Ymin
			var Ymax:int=BGetterAndSetter.getSB(rect_Nbits);
			BGetterAndSetter.endGet();
			
			wid=Xmax/20;//获取到的值是以堤为单位, 1堤等于20像素, 所以要除以20
			hei=Ymax/20;//获取到的值是以堤为单位, 1堤等于20像素, 所以要除以20
			
			offset=BGetterAndSetter.offset;
			FrameRate=data[offset++]/256+data[offset++];//帧频是一个Number, 在SWF里以 FIXED8(16-bit 8.8 fixed-point number, 16位8.8定点数) 的结构保存
		}
		public function getData(data:ByteArray):void{
			BGetterAndSetter.startSet(data,0);
			var Xmax:int=wid*20;
			var Ymax:int=hei*20;
			var rect_Nbits:int=BGetterAndSetter.getNbitsBySBs(Xmax,Ymax);
			BGetterAndSetter.setUB(rect_Nbits,5);
			BGetterAndSetter.setSB(0,rect_Nbits);
			BGetterAndSetter.setSB(Xmax,rect_Nbits);
			BGetterAndSetter.setSB(0,rect_Nbits);
			BGetterAndSetter.setSB(Ymax,rect_Nbits);
			
			BGetterAndSetter.endSet();
			
			offset=BGetterAndSetter.offset;
			data[offset++]=FrameRate*256;
			data[offset++]=FrameRate;
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