/***
StackValue
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月8日 22:14:16
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2.runners{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class StackValue{
		
		public static var local0:StackValue=new StackValue("local0");
		public static var any:StackValue=new StackValue("any");
		
		public var name:String;
		public function StackValue(_name:String){
			name=_name;
		}
		public function toString():String{
			return "-"+name+"-";
		}
	}
}