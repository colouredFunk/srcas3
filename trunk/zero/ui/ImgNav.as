/***
ImgNav 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月19日 13:28:17
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	public class ImgNav extends Sprite{
		public var onUpdate:Function;
		private var wid0:int;
		private var hei0:int;
		private var cutMc:Sprite;
		private var freeTran:FreeTran;
		private var bmd:BitmapData;
		private var bmp:Bitmap;
		public function ImgNav(){
			bmp=new Bitmap();
			this.addChild(bmp);
			cutMc=new Sprite();
			cutMc.graphics.clear();
			cutMc.graphics.beginFill(0x000000,0.2);
			cutMc.graphics.drawRect(0,0,100,100);
			cutMc.graphics.endFill();
			this.addChild(cutMc);
			freeTran=new FreeTran();
			freeTran.lockScale=true;
			freeTran.rotateEnabled=false;
			freeTran.scaleSideEnabled=false;
			freeTran.moveBounds=this.getBounds(this);
			freeTran.maxWid=wid0=this.width;
			freeTran.maxHei=hei0=this.height;
			freeTran.minWid=wid0/10;
			freeTran.minHei=hei0/10;
			freeTran.onTran=update;
			this.addChild(freeTran);
		}
		public function setBmd(_bmd:BitmapData):void{
			bmp.bitmapData=bmd=_bmd;
			bmp.transform.matrix=new Matrix();
			if(bmd.width<wid0&&bmd.height<hei0){
				bmp.scaleX=bmp.scaleY=1;
			}else{
				if(bmd.width/bmd.height<wid0/hei0){
					bmp.height=hei0;
					bmp.scaleX=bmp.scaleY;
				}else{
					bmp.width=wid0;
					bmp.scaleY=bmp.scaleX;
				}
			}
			bmp.x=(wid0-bmp.width)/2;
			bmp.y=(hei0-bmp.height)/2;
			
			/*
			cutMc.width=wid0/2;
			cutMc.height=hei0/2;
			cutMc.x=(wid0-cutMc.width)/2;
			cutMc.y=(hei0-cutMc.height)/2;
			*/
			
			cutMc.width=wid0;
			cutMc.height=hei0;
			cutMc.x=0;
			cutMc.y=0;
			
			freeTran.setPic(cutMc);
			
			update();
		}
		private function update(pic:Sprite=null,matrix:Matrix=null):void{
			if(onUpdate==null){
			}else{
				var m:Matrix=cutMc.transform.matrix;
				var mT:Matrix=bmp.transform.matrix;
				mT.invert();
				m.concat(mT);
				var p1:Point=m.transformPoint(new Point(0,0));
				var p2:Point=m.transformPoint(new Point(100,100));
				
				onUpdate(new Rectangle(p1.x,p1.y,p2.x-p1.x,p2.y-p1.y));
			}
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