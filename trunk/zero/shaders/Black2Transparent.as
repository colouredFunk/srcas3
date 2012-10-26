/***
Black2Transparent
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月26日 11:13:04
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
	 * 黑背景变透明
	 * 
	 */	
	public class Black2Transparent extends BaseShader{
		
		private static const code:Black2TransparentCode=new Black2TransparentCode();
		
		public function Black2Transparent(){
			super(code);
			outputParamInfos();
		}
	}
}