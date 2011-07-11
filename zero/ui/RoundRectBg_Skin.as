/***
RoundRectBg_Skin 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年5月4日 20:58:05
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.ui{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.utils.*;
	
	import mx.core.IVisualElement;

	public class RoundRectBg_Skin extends RoundRectBg{
		public static var onInit:Function;
		
		private var wid0:Number;
		private var hei0:Number;
		//private var ellipseWidth0:Number;
		//private var ellipseHeight0:Number;
		
		public var rrbThing:*;
		public function RoundRectBg_Skin(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			rrbThing=this.parent;
			rrbThing.scale9Grid=null;
			
			var child:Shape=rrbThing.getChildAt(1) as Shape;
			var m:Matrix=rrbThing.transform.matrix;
			wid0=child.width*m.a;
			hei0=child.height*m.d;
			rrbThing.removeChild(child);
			rrbThing.transform.matrix=new Matrix();
			
			updateByValues({wid:wid0,hei:hei0});
			
			(onInit==null)||onInit(this);
		}
		public function update():void{
			var skin:*=this.parent.parent;
			//trace("skin="+skin);
			var element:*=this.parent.parent.parent;
			//trace("element="+element);
			if(element.width>0){
				var m:Matrix=skin.superMatrix;
				if(m.a>0&&m.d>0){
					
					this.scaleX=1/m.a;
					this.scaleY=1/m.d;
					//updateByValues({wid:wid0*m.a,hei:hei0*m.d,ellipseWidth:5/m.a,ellipseHeight:5/m.d});
					
					updateByValues({wid:wid0*m.a,hei:hei0*m.d});
				}
			}
		}
			
	}
}

