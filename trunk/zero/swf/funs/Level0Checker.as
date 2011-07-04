/***
Level0Checker
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 15:54:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.avm1.ACTIONRECORD;
	import zero.swf.avm1.*;
	import zero.swf.tagBodys.*;
	
	public class Level0Checker{
		public static function check(swf:SWF):Boolean{
			return checkTagV(swf.tagV);
		}
		private static function checkTagV(tagV:Vector.<Tag>):Boolean{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.DoAction:
						if(checkActions((tag.getBody({ActionsClass:ACTIONRECORD}) as DoAction).Actions)){
							return true;
						}
					break;
					case TagTypes.DoInitAction:
						if(checkActions((tag.getBody({ActionsClass:ACTIONRECORD}) as DoInitAction).Actions)){
							return true;
						}
					break;
					case TagTypes.DefineSprite:
						if(checkTagV((tag.getBody(null) as DefineSprite).tagV)){
							return true;
						}
					break;
				}
			}
			
			return false;
		}
		private static function checkActions(Actions:ACTIONRECORD):Boolean{
			for each(var code:* in Actions.codeArr){
				if(
					code is AVM1Code
					&&
					code.op==AVM1Ops.push
				){
					for each(var pushValue:String in code.value){
						if(pushValue=="_level0"){
							trace("带 _level0 的 swf");
							return true;
						}
					}
				}
			}
			return false;
		}
	}
}
		