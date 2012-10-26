/***
Pixelate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月26日 10:16:01
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	/**
	 * 
	 * 像素化（马赛克）
	 * 
	 */	
	public class Pixelate extends BaseShader{
		
		private static const code:PixelateCode=new PixelateCode();
		
		/**
		 * 
		 * @param _dimension 格子大小（1~100），默认2
		 * 
		 */		
		public function Pixelate(_dimension:int=2){
			super(code);
			dimension=_dimension;
			//outputParamInfos();
		}
		
		/**
		 * 
		 * 格子大小（1~100），默认2
		 * 
		 */		
		public function get dimension():int{
			return (data.dimension as ShaderParameter).value[0];
		}
		public function set dimension(_dimension:int):void{
			(data.dimension as ShaderParameter).value=[_dimension];
		}
	}
}