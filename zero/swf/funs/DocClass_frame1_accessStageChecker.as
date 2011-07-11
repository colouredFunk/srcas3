/***
MainTimeline_frame1_accessStageChecker
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 16:25:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class DocClass_frame1_accessStageChecker{
		//TypeError: Error #1009: 无法访问空对象引用的属性或方法。
		//at Tetrabreak_fla::MainTimeline/frame1()
		public static function check(swf:SWF):Boolean{
			var tag:Tag;
			
			var docClassName:String=null;
			
			loop:for each(tag in swf.tagV){
				if(tag.type==TagTypes.SymbolClass){
					var symbolClass:SymbolClass=tag.getBody({
						TagBodyClass:SymbolClass
					});
					var i:int=-1;
					for each(var className:String in symbolClass.NameV){
						i++;
						if(symbolClass.TagV[i]==0){
							docClassName=className.replace(/\:\:/g,".");
							break loop;
						}
					}
				}
			}
			
			var ABCData:ABCClasses;
			if(docClassName){
				for each(tag in swf.tagV){
					switch(tag.type){
						switch(tag.type){
							case TagTypes.DoABC:
								ABCData=tag.getBody({
									TagBodyClass:DoABC,
									ABCDataClass:ABCClasses
								}).ABCData;
							break;
							case TagTypes.DoABCWithoutFlagsAndName:
								ABCData=tag.getBody({
									TagBodyClass:DoABCWithoutFlagsAndName,
									ABCDataClass:ABCClasses
								}).ABCData;
							break;
							default:
								ABCData=null;
							break;
						}
						if(ABCData){
							for each(var clazz:ABCClass in ABCData.classV){
								if(clazz.getClassName()==docClassName){
									i=clazz.itraitV.length;
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
													code is AVM2Code
													&&
													code.op==AVM2Ops.getlex
												){
													var multiname:ABCMultiname=code.value;
													if(multiname&&multiname.name=="stage"){
														trace("xxx::MainTimeline/frame1() 访问 stage 的");
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
			}
			
			return false;
		}
	}
}
		