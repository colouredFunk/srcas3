/***
Dibudaojiao
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月29日 15:37:26
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
	 * 底部倒角
	 * 
	 */	
	public class Dibudaojiao extends BaseShader{
		
		private static const code:DibudaojiaoCode=new DibudaojiaoCode();
		
		/**
		 * 
		 * @param _strength 强度（1~100），默认5
		 * 
		 */		
		public function Dibudaojiao(_strength:int=2){
			super(code);
			strength=_strength;
		}
		
		/**
		 * 
		 * 强度（1~100），默认5
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