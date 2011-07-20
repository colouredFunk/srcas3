/***
MainTimeline_frame1_accessStageChecker
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 16:25:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.getTimer;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	import zero.swf.tagBodys.*;
	
	public class DocClass_frame1_accessStageChecker{
		//TypeError: Error #1009: 无法访问空对象引用的属性或方法。
		//at Tetrabreak_fla::MainTimeline/frame1()
		public static function check(swf:SWF):Boolean{
			var t:int=getTimer();
			
			var docClassName:String=getDocClassName(swf);
			
			if(docClassName){
				var ABCData:ABCClasses;
				for each(var tag:Tag in swf.tagV){
					switch(tag.type){
						case TagTypes.DoABC:
							ABCData=tag.getBody(DoABC,{ABCDataClass:ABCClasses}).ABCData;
						break;
						case TagTypes.DoABCWithoutFlagsAndName:
							ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCClasses}).ABCData;
						break;
						default:
							ABCData=null;
						break;
					}
					if(ABCData){
						for each(var clazz:ABCClass in ABCData.classV){
							if(clazz.getClassName()==docClassName){
								var i:int=clazz.itraitV.length;
								while(--i>=0){
									var trait:ABCTrait=clazz.itraitV[i];
									if(
										trait.name.name=="frame1"
										&&
										trait.method
										&&
										trait.method.codes
									){
										for each(var code:* in trait.method.codes.codeArr){
											if(
												code is Code
												&&
												code.op==AVM2Ops.getlex
											){
												var multiname:ABCMultiname=code.value;
												if(multiname&&multiname.name=="stage"){
													trace("xxx::XXX/frame1() 访问 stage 的");
													trace("检查是否 frame1() 访问 stage 耗时："+(getTimer()-t)+" 毫秒");
													return true;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			
			trace("检查是否 frame1() 访问 stage 耗时："+(getTimer()-t)+" 毫秒");
			return false;
		}
	}
}
		