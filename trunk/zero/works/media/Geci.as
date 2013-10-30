/***
Geci
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月25日 15:46:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.media{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Geci extends Sprite{
		
		public var txt:Sprite;
		public var maskShape:Sprite;
		
		public function Geci(){
			txt.cacheAsBitmap=true;
			maskShape.cacheAsBitmap=true;
			txt.mask=maskShape;
		}
		
		public function init(geciXML:XML):void{
			txt["txt"].autoSize=TextFieldAutoSize.LEFT;
			txt["txt"].htmlText=geciXML.children().toXMLString().replace(/\r\n/g,"\n");
			update(0);
		}
		public function clear():void{
			txt["txt"].text="";
		}
		
		public function update(progress:Number):void{
			var b:Rectangle=maskShape.getBounds(this);
			txt.y=b.x+b.height/2-progress*txt.height;
		}
		
	}
}