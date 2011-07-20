/***
YouyouwinAdIdGetter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月12日 20:17:18
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.ByteArray;
	
	import zero.swf.*;
	import zero.swf.avm1.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	import zero.swf.tagBodys.*;
	
	public class YouyouwinAdIdGetter{
		public static function getYouyouwinAdIdAS3(swf:SWF):String{
			var youyouwinShellClassName:String=getYouyouwinShellClassName(swf);
			if(youyouwinShellClassName){
				if(youyouwinShellClassName=="SWFShellAdderOnline"){
					return getSWFShellAdderOnlineAdId(swf);
				}
				if(youyouwinShellClassName.indexOf("@youyouwin")==0){
					return getSWFShellAdderOnline3AdId(swf);
				}
			}
			return null;
		}
		private static function getSWFShellAdderOnlineAdId(swf:SWF):String{
			var firstDefineBinaryDataData:ByteArray=getFirstDefineBinaryDataData(swf);
			swf=new SWF();
			swf.initBySWFData(firstDefineBinaryDataData,null);
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
						if(clazz.getClassName()=="FWAd"){
							for each(var trait:ABCTrait in clazz.itraitV){
								if(
									trait.name.name=="init"
									&&
									trait.method
									&&
									trait.method.codes
								){
									for each(var code:* in trait.method.codes.codeArr){
										if(
											code is Code
											&&
											code.op==AVM2Ops.pushstring
											&&
											code.value=="id"
										){
											code=trait.method.codes.codeArr[trait.method.codes.codeArr.indexOf(code)+1];
											if(
												code is Code
												&&
												code.op==AVM2Ops.pushstring
												&&
												code.value
											){
												return code.value;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return null;
		}
		private static function getSWFShellAdderOnline3AdId(swf:SWF):String{
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
						if(clazz.name.name.indexOf("@youyouwin")==0){
							for each(var trait:ABCTrait in clazz.itraitV){
								if(
									trait.name.name=="enterFrame"
									&&
									trait.method
									&&
									trait.method.codes
								){
									for each(var code:* in trait.method.codes.codeArr){
										if(
											code is Code
											&&
											code.op==AVM2Ops.pushstring
											&&
											code.value=="id"
										){
											code=trait.method.codes.codeArr[trait.method.codes.codeArr.indexOf(code)+1];
											if(
												code is Code
												&&
												code.op==AVM2Ops.pushstring
												&&
												code.value
											){
												return code.value;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return null;
		}
		public static function getYouyouwinAdIdAS2(swf:SWF,removeCode:Boolean):String{
			//尝试检查第一个 DefineSprite
			var tag:Tag;
			for each(tag in swf.tagV){
				if(tag.type==TagTypes.DefineSprite){
					var defineSprite:DefineSprite=tag.getBody(DefineSprite,null);
					if(
						defineSprite.tagV.length==3
						&&
						defineSprite.tagV[0].type==TagTypes.DoAction
						&&
						defineSprite.tagV[1].type==TagTypes.ShowFrame
						&&
						defineSprite.tagV[2].type==TagTypes.End
					){
						var actionRecord:ACTIONRECORDs=defineSprite.tagV[0].getBody(DoAction,{ActionsClass:ACTIONRECORDs}).Actions;
						for each(var code:* in actionRecord.codeArr){
							if(
								code is Code
								&&
								code.op==AVM1Ops.push
								&&
								code.value.length>=4
								&&
								code.value[0]=="id"
								&&
								code.value[2]=="adType"
								&&
								code.value[3]=="loading"
								
							){
								if(removeCode){
									//自动去掉
									swf.tagV.splice(swf.tagV.indexOf(tag),1);
									getYouyouwinAdIdAS2(swf,true);
								}
								return code.value[1];
							}
						}
					}
					break;
				}
			}
			return null;
		}
		private static function getFirstDefineBinaryDataData(swf:SWF):ByteArray{
			for each(var tag:Tag in swf.tagV){
				if(tag.type==TagTypes.DefineBinaryData){
					return tag.getBody(DefineBinaryData,null).Data.toData(null);
				}
			}
			return null;
		}
	}
}
		