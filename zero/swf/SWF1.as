/***
SWF1 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年8月11日 10:30:53
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.utils.ByteArray;
	
	import zero.swf.records.RECT;
	
	public class SWF1 extends SWF0{
		public static const baseInfoNameV:Vector.<String>=SWF0.baseInfoNameV.concat(Vector.<String>([
			"x","y","width","height","FrameRate"
		]));
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var FrameRate:Number;
		
		public function SWF1(
			_type:String="CWS",
			_Version:int=0,
			_width:Number=800,
			_height:Number=600,
			_FrameRate:Number=30
		){
			super(_type,_Version);
			
			x=0;
			y=0;
			width=_width;
			height=_height;
			
			FrameRate=_FrameRate;
		}
		
		//
		override public function initBySWFData(swfData:ByteArray):void{
			initByData(swfData2Data(swfData));
		}
		
		public function initBaseInfoByData(_data:ByteArray):ByteArray{
			//获取SWF的宽高帧频
			var FrameSize:RECT=new RECT();
			var offset:int=FrameSize.initByData(_data,0,_data.length);
			x=FrameSize.Xmin/20;
			y=FrameSize.Ymin/20;
			width=(FrameSize.Xmax-FrameSize.Xmin)/20;
			height=(FrameSize.Ymax-FrameSize.Ymin)/20;
			
			//trace(FrameSize.toXML("FrameSize").toXMLString());
			
			FrameRate=_data[offset++]/256+_data[offset++];//帧频是一个Number, 在SWF里以 FIXED8(16-bit 8.8 fixed-point number, 16位8.8定点数) 的结构保存
			var data:ByteArray=new ByteArray();
			data.writeBytes(_data,offset);
			return data;
			
		}
		public function initByData(_data:ByteArray):void{
			data=initBaseInfoByData(_data);
		}
		
		public function baseInfo2Data():ByteArray{
			var FrameSize:RECT=new RECT();
			FrameSize.Xmin=x*20;
			FrameSize.Ymin=y*20;
			FrameSize.Xmax=(x+width)*20;
			FrameSize.Ymax=(y+height)*20;
			//trace(FrameSize.toXML("FrameSize").toXMLString());
			var data:ByteArray=FrameSize.toData();
			data[data.length]=FrameRate*256;
			data[data.length]=FrameRate;
			return data;
		}
		public function toData():ByteArray{
			var newData:ByteArray=baseInfo2Data();
			newData.position=newData.length;
			newData.writeBytes(data);
			return newData;
		}
		
		override public function toSWFData():ByteArray{
			return data2SWFData(toData());
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