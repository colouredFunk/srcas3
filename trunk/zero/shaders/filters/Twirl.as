/***
Twirl
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月30日 17:02:53
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
	 * 捻
	 * 
	 */	
	public class Twirl extends BaseShader{
		
		private static const code:TwirlCode=new TwirlCode();
		
		/**
		 * 
		 * @param _radius 半径（0.1~2048），默认10
		 * @param _center 中心点（(0,0)~(2048,2048)），默认(256,256)
		 * @param _twirlAngle 旋转角度（0~360），默认90
		 * @param _gaussOrSinc 是否波浪，默认false
		 * 
		 */		
		public function Twirl(_radius:Number=10,_center:Point=null,_twirlAngle:Number=90,_gaussOrSinc:Boolean=false){
			super(code);
			radius=_radius;
			_center&&(center=_center);
			twirlAngle=_twirlAngle;
			gaussOrSinc=_gaussOrSinc;
		}
		
		/**
		 * 
		 * 半径（0.1~2048），默认10
		 * 
		 */		
		public function get radius():Number{
			return (data.radius as ShaderParameter).value[0];
		}
		public function set radius(_radius:Number):void{
			(data.radius as ShaderParameter).value=[_radius];
		}
		
		/**
		 * 
		 * 中心点（(0,0)~(2048,2048)），默认(256,256)
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
		 * 旋转角度（0~360），默认90
		 * 
		 */		
		public function get twirlAngle():Number{
			return (data.twirlAngle as ShaderParameter).value[0];
		}
		public function set twirlAngle(_twirlAngle:Number):void{
			(data.twirlAngle as ShaderParameter).value=[_twirlAngle];
		}
		
		/**
		 * 
		 * 是否波浪，默认false
		 * 
		 */		
		public function get gaussOrSinc():Boolean{
			return (data.gaussOrSinc as ShaderParameter).value[0]?true:false;
		}
		public function set gaussOrSinc(_gaussOrSinc:Boolean):void{
			(data.gaussOrSinc as ShaderParameter).value=[_gaussOrSinc?1:0];
		}
	}
}