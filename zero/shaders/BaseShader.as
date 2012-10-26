/***
BaseShader
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年10月26日 10:36:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.shaders{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	import flash.geom.*;
	import flash.system.*;
	
	public class BaseShader extends Shader{
		public function BaseShader(code:ByteArray){
			super(code);
		}
		public function outputParamInfos():void{
			for(var paramName:String in data){
				trace(paramName+"="+data[paramName]);
				for(var attName:String in data[paramName]){
					trace(" "+attName+"="+data[paramName][attName]);
				}
			}
		}
	}
}