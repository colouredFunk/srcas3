/***
cutBmdBy3Point
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
	
	public function cutBmdBy3Point(bmd:BitmapData,p0:*,p1:*,p2:*):BitmapData{
		var dx1:Number=p1.x-p0.x;
		var dy1:Number=p1.y-p0.y;
		var dx2:Number=p2.x-p0.x;
		var dy2:Number=p2.y-p0.y;
		var wid:Number=Math.sqrt(dx1*dx1+dy1*dy1);
		var hei:Number=Math.sqrt(dx2*dx2+dy2*dy2);
		var m:Matrix=new Matrix(
			dx1/wid,dx2/hei,
			dy1/wid,dy2/hei,
			-p0.x,-p0.y
		);
		
		var newBmd:BitmapData=new BitmapData(wid,hei,bmd.transparent,0xffff0000);
		newBmd.draw(new Bitmap(bmd),m);
		
		return newBmd;
	}
}
		