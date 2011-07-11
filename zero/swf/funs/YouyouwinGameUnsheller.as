/***
YouyouwinGameUnsheller
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月28日 14:34:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class YouyouwinGameUnsheller{
		public static function unshell(swfData:ByteArray):ByteArray{
			//如果是加过壳的先解壳
			
			var swf:SWF=new SWF();
			swf.initBySWFData(swfData,null);
			
			if(checkHasSymbolClassName_SWFShellAdderOnline(swf)){
				var lastDefineBinaryDataData:ByteArray=getLastDefineBinaryDataData(swf);
				if(lastDefineBinaryDataData){
					return _unshell(lastDefineBinaryDataData);
				}
			}
			
			return swfData;
		}
		private static function _unshell(swfData:ByteArray):ByteArray{
			var i:int;
			
			var swf:SWF=new SWF();
			swf.initBySWFData(swfData,null);
			
			var putInSceneTagAndClassNameArr:Array=PutInSceneTagAndClassNames.getPutInSceneTagAndClassNameArr(swf);
			i=putInSceneTagAndClassNameArr.length;
			var classNameMark:Object=new Object();
			while(--i>=0){
				if(putInSceneTagAndClassNameArr[i]){
					//trace(putInSceneTagAndClassNameArr[i][1]);
					classNameMark["~"+putInSceneTagAndClassNameArr[i][1]]=true;
				}
			}
			
			var ABCData:ABCClasses;
			for each(var tag:Tag in swf.tagV){
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
						if(classNameMark["~"+clazz.getClassName()]){
							i=clazz.itraitV.length;
							while(--i>=0){
								var trait:ABCTrait=clazz.itraitV[i];
								if(
									trait.name.name=="stage"
									&&
									trait.method
									&&
									trait.method.codes
								){
									var code:AVM2Code=trait.method.codes.codeArr[2] as AVM2Code;
									if(code&&code.op==AVM2Ops.getlex){
										var multiname:ABCMultiname=code.value;
										if(multiname&&multiname.name=="SWFShellAdderOnline"){
											clazz.itraitV.splice(i,1);
											trace("清除强制添加的 stage");
											break;
										}
									}
								}
							}
						}
					}
				}
			}
			
			return swf.toSWFData(null);
		}
		private static function checkHasSymbolClassName_SWFShellAdderOnline(swf:SWF):Boolean{
			for each(var tag:Tag in swf.tagV){
				if(tag.type==TagTypes.SymbolClass){
					var symbolClass:SymbolClass=tag.getBody({
						TagBodyClass:SymbolClass
					});
					for each(var className:String in symbolClass.NameV){
						if(className=="SWFShellAdderOnline"){
							return true;
						}
					}
				}
			}
			return false;
		}
		private static function getLastDefineBinaryDataData(swf:SWF):ByteArray{
			var i:int=swf.tagV.length;
			while(--i>=0){
				var tag:Tag=swf.tagV[i];
				if(tag.type==TagTypes.DefineBinaryData){
					return tag.getBody({
						TagBodyClass:DefineBinaryData
					}).Data.toData(null);
				}
			}
			return null;
		}
	}
}
		