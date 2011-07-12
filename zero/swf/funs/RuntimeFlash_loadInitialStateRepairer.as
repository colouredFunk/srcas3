/***
RuntimeFlash_loadInitialStateRepairer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 15:11:06
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.codes.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class RuntimeFlash_loadInitialStateRepairer{
		public static function repair(swf:SWF):Boolean{
			//TypeError: Error #1009: 无法访问空对象引用的属性或方法。
			//	at RuntimeFlash/loadInitialState()
			//	at RuntimeFlash/___RuntimeFlash_Application1_applicationComplete()
			//	at flash.events::EventDispatcher/dispatchEventFunction()
			//	at flash.events::EventDispatcher/dispatchEvent()
			//	at mx.core::UIComponent/dispatchEvent()
			//	at mx.managers::SystemManager/preloader_preloaderDoneHandler()
			//	at flash.events::EventDispatcher/dispatchEventFunction()
			//	at flash.events::EventDispatcher/dispatchEvent()
			//	at mx.preloaders::Preloader/displayClassCompleteHandler()
			//	at flash.events::EventDispatcher/dispatchEventFunction()
			//	at flash.events::EventDispatcher/dispatchEvent()
			//	at mx.preloaders::DownloadProgressBar/timerHandler()
			//	at mx.preloaders::DownloadProgressBar/initCompleteHandler()
			//	at flash.events::EventDispatcher/dispatchEventFunction()
			//	at flash.events::EventDispatcher/dispatchEvent()
			//	at mx.preloaders::Preloader/dispatchAppEndEvent()
			//	at mx.preloaders::Preloader/appCreationCompleteHandler()
			//	at flash.events::EventDispatcher/dispatchEventFunction()
			
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
						if(clazz.getClassName()=="RuntimeFlash"){
							for each(var trait:ABCTrait in clazz.itraitV){
								if(
									trait.name.name=="loadInitialState"
									&&
									trait.method
									&&
									trait.method.codes
								){
									var i:int=-1;
									for each(var code:* in trait.method.codes.codeArr){
										i++;
										if(
											code is Code
											&&
											code.op==AVM2Ops.getproperty
											&&
											code.value
											&&
											code.value.name=="loader"
										){
											var code2:*=trait.method.codes.codeArr[i+1] as Code;
											if(
												code2 is Code
												&&
												code2.op==AVM2Ops.getproperty
												&&
												code.value
												&&
												code2.value.name=="loaderInfo"
											){
												trace("修复 RuntimeFlash loadInitialState");
												code2.value=new PackageNamespaceQNames().gen("contentLoaderInfo");
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
			
			return false;
		}
	}
}
		