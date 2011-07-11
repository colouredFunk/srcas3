/***
AdjustDistances 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年3月3日 09:39:51
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.motions{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	public class AdjustDistances{
		private var dspObjArr:Array;
		private var left:Number;
		private var right:Number;
		
		public var u:Number=0.2;
		
		public function AdjustDistances(..._dspObjArr){
			if(
				_dspObjArr[0] is Array
				&&
				_dspObjArr.length==1
			){
				_dspObjArr=_dspObjArr[0];
			}
			
			dspObjArr=_dspObjArr;
			
			var u_rect:Rectangle=new Rectangle(0,0,0,0);
			var rect:Rectangle;
			for each(var dspObj:DisplayObject in dspObjArr){
				rect=getB(dspObj);
				u_rect=u_rect.union(rect);
			}
			
			left=u_rect.left;
			right=u_rect.right;
		}
		public function step():void{
			var widSum:Number=0;
			var dspObj:DisplayObject;
			var rect:Rectangle;
			for each(dspObj in dspObjArr){
				rect=getB(dspObj);
				widSum+=rect.width;
			}
			var d:Number=((right-left)-widSum)/(dspObjArr.length-1);
			var x:Number=left;
			for each(dspObj in dspObjArr){
				rect=getB(dspObj);
				//dspObj.x+=x-rect.x;//立刻
				dspObj.x+=(x-rect.x)*u;//缓动
				x+=rect.width+d;
			}
			
			//最右边的有些振动，调一下：
			dspObj=dspObjArr[dspObjArr.length-1];
			rect=getB(dspObj);
			dspObj.x+=right-rect.right;
		}
		private function getB(dspObj:DisplayObject):Rectangle{
			if(dspObj.hasOwnProperty("adjust_b_area")){
				return dspObj["adjust_b_area"].getBounds(dspObj.parent);
			}
			return dspObj.getBounds(dspObj.parent);
		}
	}
}

