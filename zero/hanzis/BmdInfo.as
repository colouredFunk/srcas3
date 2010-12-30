/***
BmdInfo 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年10月15日 14:20:17
历次修改:未有修改
用法举例:配合 bmdInfo.dat 使用
*/

//wubiBmdInfoData{
//Field 				Type 			Comment
//text 					UTF[2]			汉字
//hasIdentifier			UB[1]
//Reserved				UB[5]			Must be 0
//xyCount				UB[2]			0~3, +1 后表示码数
//xyArr					xy[xyCount]
//bmdWid				U8
//bmdHei				U8
//bmdData				byte[]

//xy{
//	Field 				Type 			Comment
//	hasNext				UB[1]			If 1, has next xy
//	x					UB[7]			x
//	Reserved 			UB[1] 			Must be 0
//	y					UB[7]			y
//}
//}

package zero.hanzis{
	import flash.display.*;
	import flash.utils.*;
	import flash.geom.*;
	public class BmdInfo{
		//public static const distance:int=1500;//1446
		public static const wid0:int=110;
		public static const hei0:int=110;
		
		private static var textMark:Object;
		private static var data:ByteArray;
		
		[Bindable]
		[Embed(source="datas/bmdInfoTextMark.dat",mimeType="application/octet-stream")]
		private static var TextMarkDataClass:Class ;
		[Bindable]
		[Embed(source="datas/bmdInfo.dat",mimeType="application/octet-stream")]
		private static var BmdInfoDataClass:Class;
		
		public static function init():void{
			textMark=ByteArray(new TextMarkDataClass()).readObject();
			data=ByteArray(new BmdInfoDataClass());
		}
		
		public static function getBmdInfo(text:String):BmdInfo{
			if(textMark[text]>=0){
				var bmdInfo:BmdInfo=new BmdInfo();
				bmdInfo.init(data,textMark[text]);
				return bmdInfo;
			}
			return null;
		}
		
		//
		public var text:String;
		public var hasIdentifier:int;
		public var xyV:Vector.<Vector.<Vector.<int>>>;
		public var bmd:BitmapData;
		private function init(data:ByteArray,offset:int):void{
			text=String.fromCharCode(data[offset++]|(data[offset++]<<8));
			var byte:int=data[offset++];
			hasIdentifier=byte>>>7;
			var xyCount:int=(byte&3)+1;//3==00000011
			xyV=new Vector.<Vector.<Vector.<int>>>();
			var i:int;
			var subXyV:Vector.<Vector.<int>>;
			for(i=0;i<xyCount;i++){
				subXyV=xyV[i]=new Vector.<Vector.<int>>();
				var j:int=0;
				do{
					var xValue:int=data[offset++];
					subXyV[j++]=Vector.<int>([xValue&0x7f,data[offset++]]);
				}while(xValue>>>7);
				xyV[i]=subXyV;
			}
			var bmdWid:int=data[offset++];
			var bmdHei:int=data[offset++];
			var subBmd:BitmapData=new BitmapData(bmdWid,bmdHei,false,0xffffff);
			var step:int=1;
			for(var y:int=0;y<bmdHei;y++){
				for(var x:int=0;x<bmdWid;x++){
					if(step==1){
						byte=data[offset++];
						step=1<<8;
					}
					if(byte&(step>>>=1)){
						subBmd.setPixel(x,y,0x000000);
					}
				}
			}
			bmd=new BitmapData(wid0*4,hei0,false,0xffffff);
			var dx0:int=(wid0-bmdWid)/2;
			var dy:int=(hei0-bmdHei)/2;
			i=0;
			for each(subXyV in xyV){
				var dx:int=dx0+i*wid0;
				bmd.copyPixels(subBmd,subBmd.rect,new Point(dx,dy));
				for each(var subSubXyV:Vector.<int> in subXyV){
					bmd.floodFill(dx+subSubXyV[0],dy+subSubXyV[1],0x000000);
					//bmd.setPixel(dx+subSubXyV[0],dy+subSubXyV[1],0xff0000);
				}
				i++;
			}
			subBmd.dispose();
		}
		public function clear():void{
			xyV=null;
			bmd.dispose();
			bmd=null;
		}
		public static function checkBmds():void{
			for(var text:String in textMark){
				var bmd:BitmapData=getBmdInfo(text).bmd;
				if(bmd.getPixel(0,0)!=0xffffff){
					trace("出错: text="+text);
				}
				bmd.dispose();
			}
			//
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