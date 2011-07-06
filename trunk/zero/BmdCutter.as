/***
BmdCutter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月29日 11:18:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class BmdCutter{
		public static function clipCut(bmpClip:DisplayObject,cutClip:DisplayObject):BitmapData{
			if(bmpClip.stage){
			}else{
				throw new Error("bmpClip 需要在显示列表里");
			}
			if(cutClip.stage){
			}else{
				throw new Error("cutClip 需要在显示列表里");
			}
			
			var b:Rectangle=cutClip.getBounds(cutClip);
			
			var p0:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x,b.y)));
			var p1:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x+b.width,b.y)));
			var p2:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x,b.y+b.height)));
			
			var cutBmd:BitmapData=new BitmapData(Point.distance(p0,p1),Point.distance(p0,p2),true,0x66ff0000);
			cutBmd.draw(bmpClip,getM(p0.x,p0.y,p1.x,p1.y,p2.x,p2.y));
			return cutBmd;
		}
		/*
		public static function bmdCut(bmd:BitmapData,cutClip:DisplayObject):BitmapData{
			var b:Rectangle=cutClip.getBounds(cutClip);
			
			var p0:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x,b.y)));
			var p1:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x+b.width,b.y)));
			var p2:Point=bmpClip.globalToLocal(cutClip.localToGlobal(new Point(b.x,b.y+b.height)));
			
			var cutBmd:BitmapData=new BitmapData(Point.distance(p0,p1),Point.distance(p0,p2),true,0x66ff0000);
			cutBmd.draw(bmpClip,getM(p0.x,p0.y,p1.x,p1.y,p2.x,p2.y));
			return cutBmd;
		}
		*/
		private static function getM(x0:Number,y0:Number,x1:Number,y1:Number,x2:Number,y2:Number):Matrix{
			var dx1:Number=x1-x0;
			var dy1:Number=y1-y0;
			var dx2:Number=x2-x0;
			var dy2:Number=y2-y0;
			var wid:Number=Math.sqrt(dx1*dx1+dy1*dy1);
			var hei:Number=Math.sqrt(dx2*dx2+dy2*dy2);
			
			var m:Matrix=new Matrix(
				1,0,
				0,1,
				-x0,-y0
			);
			m.concat(new Matrix(
				dx1/wid,dx2/hei,
				dy1/wid,dy2/hei,
				0,0
			));
			
			return m;
		}
		/*
		public static function cutBmd(bmd:BitmapData,clipsOrP012:*):BitmapData{
			if(clipOrP012 is DisplayObject){
				p0:*,p1:*,p2:*
			}
			var dx1:Number=p1.x-p0.x;
			var dy1:Number=p1.y-p0.y;
			var dx2:Number=p2.x-p0.x;
			var dy2:Number=p2.y-p0.y;
			var wid:Number=Math.sqrt(dx1*dx1+dy1*dy1);
			var hei:Number=Math.sqrt(dx2*dx2+dy2*dy2);
			
			var m:Matrix=new Matrix(
				1,0,
				0,1,
				-p0.x,-p0.y
			);
			m.concat(new Matrix(
				dx1/wid,dx2/hei,
				dy1/wid,dy2/hei,
				0,0
			));
			
			var newBmd:BitmapData=new BitmapData(wid,hei,bmd.transparent,0xffff0000);
			newBmd.draw(new Bitmap(bmd),m);
			
			return newBmd;
		}
		*/
	}
}
		