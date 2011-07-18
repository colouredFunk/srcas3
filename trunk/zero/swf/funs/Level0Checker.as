/***
Level0Checker
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 15:54:46
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.getTimer;
	
	import zero.swf.*;
	import zero.swf.codes.*;
	import zero.swf.avm1.ACTIONRECORDs;
	import zero.swf.avm1.*;
	import zero.swf.tagBodys.*;
	
	public class Level0Checker{
		public static function check(swf:SWF):Boolean{
			var t:int=getTimer();
			var checkResult:Boolean=checkTagV(swf.tagV);
			trace("检查是否带 _level0 耗时："+(getTimer()-t)+" 毫秒");
			return checkResult;
		}
		private static function checkTagV(tagV:Vector.<Tag>):Boolean{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.DoAction:
						if(
							checkActions(
								tag.getBody(DoAction,{ActionsClass:ACTIONRECORDs}).Actions
							)
						){
							return true;
						}
					break;
					case TagTypes.DoInitAction:
						if(
							checkActions(
								tag.getBody(DoInitAction,{ActionsClass:ACTIONRECORDs}).Actions
							)
						){
							return true;
						}
					break;
					case TagTypes.DefineSprite:
						if(
							checkTagV(
								tag.getBody(DefineSprite,null).tagV
							)
						){
							return true;
						}
					break;
				}
			}
			
			return false;
		}
		private static function checkActions(Actions:ACTIONRECORDs):Boolean{
			for each(var code:* in Actions.codeArr){
				if(
					code is Code
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
		