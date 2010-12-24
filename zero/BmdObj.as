/***
BmdObj 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月15日 19:34:09
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import mx.graphics.codec.JPEGEncoder;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	public class BmdObj{
		public static var BmdClassFront:String="Bmd";//默认 className 前缀
		public static var getBmdClass:Function;
		
		private static var classNameV:Vector.<String>;
		private static var imgDataV:Vector.<ByteArray>;
		private static var whArr:Array;
		private static var id:int;
		private static var intervalId:int=-1;
		private static var bmdObjV2DataStart:Function;
		private static var bmdObjV2DataProgress:Function;
		private static var bmdObjV2DataFinished:Function;
		public static function bmdObjV2Data(
			_bmdObjV2DataStart:Function,
			_bmdObjV2DataProgress:Function,
			_bmdObjV2DataFinished:Function
		):void{
			_bmdObjV2DataStart&&_bmdObjV2DataStart("当前图片: %1 / 总图片: %2",bmdObjV.length);
			bmdObjV2DataProgress=_bmdObjV2DataProgress;
			bmdObjV2DataFinished=_bmdObjV2DataFinished;
			classNameV=new Vector.<String>();
			imgDataV=new Vector.<ByteArray>();
			whArr=new Array();
			id=-1;
			clearInterval(intervalId);
			intervalId=setInterval(_bmdObjV2Data,30);
		}
		public static function stopBmdObjV2Data():void{
			clearInterval(intervalId);
		}
		private static function _bmdObjV2Data():void{
			if(++id>=bmdObjV.length){
				bmdObjV2DataProgress(bmdObjV.length,bmdObjV.length);
				clearInterval(intervalId);
				var whData:ByteArray=new ByteArray();
				whData.writeObject(whArr);
				whData.compress();
				bmdObjV2DataFinished(classNameV,imgDataV,whData);
				bmdObjV2DataProgress=null;
				bmdObjV2DataFinished=null;
				whArr=null;
				return;
			}
			var bmdObj:BmdObj= bmdObjV[id];
			
			var bmd:BitmapData;
			if(bmdObj.wid<bmdObj.bmd.width||bmdObj.hei<bmdObj.bmd.height){
				bmd=new BitmapData(bmdObj.wid,bmdObj.hei,true,0x00000000);
				var bmdSp:Sprite=new Sprite();
				var g:Graphics=bmdSp.graphics;
				g.clear();
				g.beginBitmapFill(bmdObj.bmd,new Matrix(bmdObj.wid/bmdObj.bmd.width,0,0,bmdObj.hei/bmdObj.bmd.height),true,true);
				g.drawRect(0,0,bmdObj.wid,bmdObj.hei);
				g.endFill();
				bmd.draw(bmdSp);
			}else{
				bmd=bmdObj.bmd;
			}
			
			//trace("bmdObj.imgData="+bmdObj.imgData);
			//var pngData:ByteArray=PNGEncoder.encode(bmd);
			var jpgData:ByteArray=new JPEGEncoder().encode(bmd);
			if(bmdObj.imgData){
				
				//trace("bmdObj.imgData.length="+bmdObj.imgData.length+",pngData.length="+pngData.length);
				//if(bmdObj.imgData.length<pngData.length){
				
				//trace("bmdObj.imgData.length="+bmdObj.imgData.length+",jpgData.length="+jpgData.length);
				if(bmdObj.imgData.length<jpgData.length){
					//trace("使用原图像数据");
					imgDataV[id]=bmdObj.imgData;
				}else{
					//trace("使用png数据");
					//imgDataV[id]=pngData;
					//trace("使用jpg数据");
					imgDataV[id]=jpgData;
				}
			}else{
				//trace("针对 .bmp 的 png数据");
				//imgDataV[id]=pngData;
				//trace("针对 .bmp 的 jpg数据");
				imgDataV[id]=jpgData;
			}
			
			bmdObjV2DataProgress(id,bmdObjV.length);
			
			classNameV[id]=BmdClassFront+id;
			
			whArr[id]=[bmdObj.w,bmdObj.h,bmdObj.wid,bmdObj.hei];
		}
		
		//
		public static function data2BmdObjV(whData:ByteArray):void{
			var i:int=-1;
			var BmdClass:Class;
			var BmdClassV:Vector.<Class>=new Vector.<Class>();
			while(true){
				try{
					BmdClassV[BmdClassV.length]=getBmdClass(BmdClassFront+(++i));
				}catch(e:Error){
					break;
				}
			}
			BmdClassVAndData2BmdObjV(BmdClassV,whData);
		}
		public static function BmdClassVAndData2BmdObjV(
			BmdClassV:Vector.<Class>,
			whData:ByteArray
		):void{
			reset();
			if(whData.length>0){
				whData.uncompress();
				var whArr:Array=whData.readObject();
				
				var i:int=0;
				for each(var BmdClass:Class in BmdClassV){
					var bmdObj:BmdObj=new BmdObj();
					bmdObj.bmd=new BmdClass();
					bmdObj.w=whArr[i][0];
					bmdObj.h=whArr[i][1];
					bmdObj.wid=whArr[i][2];
					bmdObj.hei=whArr[i][3];
					
					bmdObjV[bmdObjV.length]=bmdObj;
					i++;
				}
			}
		}
		
		public static function reset():void{
			clearInterval(intervalId);
			/*
			for each(var bmdObj:BmdObj in bmdObjV){
				bmdObj.bmd.dispose();
			}
			*/
			bmdObjV=new Vector.<BmdObj>();
			bmdObjV2DataProgress=null;
			bmdObjV2DataFinished=null;
			whArr=null;
			classNameV=null;
			imgDataV=null;
		}
		
		
		public static var bmdObjV:Vector.<BmdObj>=new Vector.<BmdObj>();
		
		public var imgData:ByteArray;
		public var w:int;//列数
		public var h:int;//行数
		public var wid:int;//宽
		public var hei:int;//高
		public var bmd:BitmapData;//图像数据
		
		//主要用于拼图
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