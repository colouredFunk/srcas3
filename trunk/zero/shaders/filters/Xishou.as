/***
Xishou
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月01日 13:29:21
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders.filters{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.BaseShader;
	
	/**
	 * 
	 * 吸收
	 * 
	 */	
	public class Xishou extends BaseShader{
		
		private static const code:XishouCode=new XishouCode();
		
		/**
		 * 
		 * @param _center 中心点（(0,0)~(2048,2048)），默认(0,0)
		 * @param _strength 强度（1~2048），默认1000
		 * 
		 */		
		public function Xishou(_center:Point=null,_strength:Number=1000){
			super(code);
			_center&&(center=_center);
		}
		
		/**
		 * 
		 * 中心点（(0,0)~(2048,2048)），默认(0,0)
		 * 
		 */		
		public function get center():Point{
			var value:Array=(data.center as ShaderParameter).value;
			return new Point(value[0],value[1]);
		}
		public function set center(_center:Point):void{
			(data.center as ShaderParameter).value=[_center.x,_center.y];
		}
		
		/**
		 * 
		 * 强度（1~2048），默认1000
		 * 
		 */		
		public function get strength():int{
			return (data.strength as ShaderParameter).value[0];
		}
		public function set strength(_strength:int):void{
			(data.strength as ShaderParameter).value=[_strength];
		}
	}
}