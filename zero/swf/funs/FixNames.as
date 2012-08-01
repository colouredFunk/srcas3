/***
FixNames
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年9月9日 13:37:14
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	public class FixNames{
		
		private static const wordReg:RegExp=/^[A-Za-z_\$\u4e00-\u9fa5][\w\$\.\:\u4e00-\u9fa5]*$/;
		private static const keyArr:Array=["break","case","continue","default","do","else","for","each","in","if","return","super","switch","throw","try","catch","finally","while","with","dynamic","final","internal","native","override","private","protected","public","static","class","const","extends","function","get","implements","interface","namespace","package","set","var","default","import","include","use","this","is","as"];
		
		private static var nameHeads:Object;
		
		private static var mark:Object;
		private static var keyMark:Object;
		private static var fixId:int;
		
		public static function fix(swf:SWFExtend,_nameHeads:Object):void{
			if(swf.isAS3){
				
				if(_nameHeads){
					nameHeads=_nameHeads;
				}else{
					nameHeads=new Object();
					nameHeads["class"]="对象";
					nameHeads["interface"]="接口";
					nameHeads["namespace"]="命名空间";
					nameHeads["property"]="属性";
					nameHeads["constant"]="常量";
					nameHeads["method"]="方法";
					nameHeads["getter"]="getter方法";
					nameHeads["setter"]="setter方法";
					nameHeads["function"]="函数";
					nameHeads["unknown"]="不详";
				}
			
				var i:int;
				
				fixId=-1;
				mark=new Object();
				keyMark=new Object();
				for each(var key:String in keyArr){
					keyMark["~"+key]=true;
				}
				
				for each(var ABCData:ABCFile in getABCFiles(swf)){
					for each(var instance_info:Instance_info in ABCData.instance_infoV){
						fixString(ABCData,ABCData.multiname_infoV[instance_info.name].u30_2,nameHeads["class"]);
						fixTraits_infoV(ABCData,instance_info.itraits_infoV);
						for each(var intrf:int in instance_info.intrfV){
							fixMultiname_info(ABCData,ABCData.multiname_infoV[intrf],nameHeads["interface"]);
						}
					}
					for each(var class_info:Class_info in ABCData.class_infoV){
						fixTraits_infoV(ABCData,class_info.ctraits_infoV);
					}
					for each(var script_info:Script_info in ABCData.script_infoV){
						fixTraits_infoV(ABCData,script_info.traits_infoV);
					}
					for each(var namespace_info:Namespace_info in ABCData.namespace_infoV){
						if(namespace_info){
							fixString(ABCData,namespace_info.name,nameHeads["namespace"]);
						}
					}
					for each(var multiname_info:Multiname_info in ABCData.multiname_infoV){
						if(multiname_info){
							fixMultiname_info(ABCData,multiname_info,nameHeads["unknown"]);
						}
					}
				}
				
				fixTagV(swf.tagV);
				
			}else{
				throw new Error("swf.isAS3="+swf.isAS3);
			}
		}
		private static function fixTagV(tagV:Vector.<Tag>):void{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.DefineSprite:
						fixTagV(tag.getBody(DefineSprite,null).tagV);
					break;
					case TagTypes.PlaceObject2:
						var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
						if(placeObject2.Name){
							if(mark["~"+placeObject2.Name]){
								placeObject2.Name=mark["~"+placeObject2.Name];
							}
						}
					break;
					case TagTypes.PlaceObject3:
						var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
						if(placeObject3.Name){
							if(mark["~"+placeObject3.Name]){
								placeObject3.Name=mark["~"+placeObject3.Name];
							}
						}
					break;
					case TagTypes.SymbolClass:
						var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
						var i:int=NameV.length;
						while(--i>=0){
							var NameArr:Array=NameV[i].split(/\:+|\./);
							var j:int=NameArr.length;
							while(--j>=0){
								if(mark["~"+NameArr[j]]){
									NameArr[j]=mark["~"+NameArr[j]];
								}
							}
							NameV[i]=NameArr.join(".");
						}
					break;
				}
			}
		}
		private static function fixTraits_infoV(ABCData:ABCFile,traits_infoV:Vector.<Traits_info>):void{
			for each(var traits_info:Traits_info in traits_infoV){
				switch(traits_info.kind_trait_type){
					case TraitTypeAndAttributes.Slot:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["property"]);
					break;
					case TraitTypeAndAttributes.Const:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["constant"]);
					break;
					case TraitTypeAndAttributes.Method:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["method"]);
					break;
					case TraitTypeAndAttributes.Getter:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["getter"]);
					break;
					case TraitTypeAndAttributes.Setter:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["setter"]);
					break;
					case TraitTypeAndAttributes.Function_:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["function"]);
					break;
					case TraitTypeAndAttributes.Class_:
						fixMultiname_info(ABCData,ABCData.multiname_infoV[traits_info.name],nameHeads["class"]);
					break;
				}
			}
		}
		private static function fixMultiname_info(ABCData:ABCFile,multiname_info:Multiname_info,nameHead:String):void{
			//if(multiname_info){
				switch(multiname_info.kind){
					
					case MultinameKinds.QName:
					case MultinameKinds.QNameA:
						fixString(ABCData,multiname_info.u30_2,nameHead);
					break;
					
					case MultinameKinds.Multiname:
					case MultinameKinds.MultinameA:
						
					case MultinameKinds.RTQName:
					case MultinameKinds.RTQNameA:
						fixString(ABCData,multiname_info.u30_1,nameHead);
					break;
				}
			//}
		}
		private static function fixString(ABCData:ABCFile,stringId:int,nameHead:String):void{
			var string:String=ABCData.stringV[stringId];
			if(string){
				if(wordReg.test(string)&&!keyMark["~"+string]){
				}else if(string.indexOf("http://")==0){
				}else if(string==","||string==";"){//heliwars1.swf
				}else{
					
					//if(/^[^\w \[\]\!\+\-\=\?"'`\$\%<>\^@\&#][\s\S]*$/.test(string)){
					//	if(/^[,;][,;\d\!\+\-"'`\$\%@\&#][\s\S]*$/.test(string)){
					//	}else{
					//		trace("string='"+string+"'");
					//		return;
					//	}
					//}
					//if(string==","||string==";"){
					//	if(mark["~"+string]){
					//	}else{
					//		fixId++;
					//		mark["~"+string]=string;
					//	}
					//	trace("string='"+string+"'");
					//	return;
					//}
					//trace("string='"+string+"'");
					
					var wordArr:Array=string.split(/\:+|\./);
					var j:int=wordArr.length;
					while(--j>=0){
						if(mark["~"+wordArr[j]]){
						}else{
							mark["~"+wordArr[j]]=nameHead+(++fixId);
							mark["~"+mark["~"+wordArr[j]]]=mark["~"+wordArr[j]];
						}
						wordArr[j]=mark["~"+wordArr[j]];
					}
					ABCData.stringV[stringId]=wordArr.join(".");
				}
			}
		}
	}
}