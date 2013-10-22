/***
PointViewer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月09日 14:45:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class PointViewer extends Sprite{
		public function PointViewer(){
			this.graphics.clear();
			this.graphics.lineStyle(1,0xff0000);
			this.graphics.beginFill(0xff0000,0.3);
			this.graphics.drawCircle(0,0,6);
			this.graphics.endFill();
			this.graphics.moveTo(-8,0);
			this.graphics.lineTo(-2,0);
			this.graphics.moveTo(0,-8);
			this.graphics.lineTo(0,-2);
			this.graphics.moveTo(8,0);
			this.graphics.lineTo(2,0);
			this.graphics.moveTo(0,8);
			this.graphics.lineTo(0,2);
		}
	}
}