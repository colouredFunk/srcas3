/***
DisorderIds
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月26日 21:40:49
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.records.buttons.BUTTONRECORD;
	import zero.swf.tagBodys.*;
	
	public class DisorderIds{
		public static function disorder(swf:SWF):void{
			var i:int;
			
			var defTagV:Vector.<Tag>=new Vector.<Tag>();
			var ignoredIdMark:Array=new Array();
			var objIdNameArr:Array=new Array();
			markTags(swf.tagV,defTagV,ignoredIdMark,objIdNameArr);
			
			var markArr:Array=new Array();
			var ranIdArr:Array=new Array();
			var ranId:int=0;
			var subArr:Array;
			var defId:int;
			var defTag:Tag;
			
			for each(defTag in defTagV){
				defId=defTag.UI16Id;
				if(defId>0){
				}else{
					throw new Error("defId="+defId);
				}
				if(ignoredIdMark[defId]){
					throw new Error("ignoredIdMark[defId]="+ignoredIdMark[defId]);
				}
				if(markArr[defId]){
					throw new Error("重复的 defId："+defId);
				}
				markArr[defId]=true;
				do{
					ranId++;//ranId 从 1 开始
				}while(ignoredIdMark[ranId]);
				ranIdArr.push(ranId);
			}
			
			ZeroCommon.disorder(ranIdArr);
			
			i=-1;
			
			var ranIdMark:Array=new Array();
			for each(defTag in defTagV){
				i++;
				ranIdMark[defTag.UI16Id]=ranIdArr[i];
				defTag.UI16Id=ranIdArr[i];
			}
			
			for each(subArr in objIdNameArr){
				var obj:*=subArr[0];
				var idName:*=subArr[1];
				defId=obj[idName];
				if(defId>0){
				}else{
					throw new Error("obj.constructor="+obj.constructor+"，idName="+idName+"，obj[idName]="+obj[idName]);
				}
				if(ignoredIdMark[defId]){
					continue;
				}
				ranId=ranIdMark[defId];
				if(ranId>0){
				}else{
					throw new Error("obj.constructor="+obj.constructor+"，idName="+idName+"defId="+defId+"，ranIdMark[defId]="+ranIdMark[defId]);
				}
				obj[idName]=ranId;
			}
		}
		private static function markTags(
			tagV:Vector.<Tag>,
			defTagV:Vector.<Tag>,
			ignoredIdMark:Array,
			objIdNameArr:Array
		):void{
			var i:int,Tag_:int;
			for each(var tag:Tag in tagV){
				if(DefineObjs[TagTypes.typeNameV[tag.type]]){
					switch(tag.type){
						case TagTypes.DefineShape:
						//case TagTypes.DefineText:
						case TagTypes.DefineShape2:
						case TagTypes.DefineShape3:
						//case TagTypes.DefineText2:
						//case TagTypes.DefineEditText:
						case TagTypes.DefineMorphShape:
						case TagTypes.DefineShape4:
						case TagTypes.DefineMorphShape2:
						case TagTypes.DefineBinaryData:
							//trace("tag.type="+TagTypes.typeNameV[tag.type]+"，tag.UI16Id="+tag.UI16Id);
							defTagV.push(tag);
						break;
						case TagTypes.DefineButton2:
							defTagV.push(tag);
							var defineButton2:DefineButton2=tag.getBody(DefineButton2,null);
							for each(var Character:BUTTONRECORD in defineButton2.CharacterV){
								objIdNameArr.push([Character,"CharacterID"]);
							}
						break;
						case TagTypes.DefineSprite:
							defTagV.push(tag);
							markTags(tag.getBody(DefineSprite,null).tagV,defTagV,ignoredIdMark,objIdNameArr);
						break;
						default:
							ignoredIdMark[tag.UI16Id]=true;
						break;
					}
				}else{
					switch(tag.type){
						case TagTypes.PlaceObject:
							var placeObject:PlaceObject=tag.getBody(PlaceObject,null);
							if(placeObject.CharacterId>0){
								objIdNameArr.push([placeObject,"CharacterId"]);
							}
						break;
						case TagTypes.RemoveObject:
							var removeObject:RemoveObject=tag.getBody(RemoveObject,null);
							if(removeObject.CharacterId>0){
								objIdNameArr.push([removeObject,"CharacterId"]);
							}
						break;
						//case TagTypes.StartSound:
						//break;
						case TagTypes.PlaceObject2:
							var placeObject2:PlaceObject2=tag.getBody(PlaceObject2,null);
							if(placeObject2.CharacterId>0){
								objIdNameArr.push([placeObject2,"CharacterId"]);
							}
						break;
						//case TagTypes.RemoveObject2:
						//break;
						case TagTypes.PlaceObject3:
							var placeObject3:PlaceObject3=tag.getBody(PlaceObject3,null);
							if(placeObject3.CharacterId>0){
								objIdNameArr.push([placeObject3,"CharacterId"]);
							}
						break;
							
						case TagTypes.DefineButtonSound:
							objIdNameArr.push([tag,"UI16Id"]);
						break;
						case TagTypes.DoInitAction:
							var doInitAction:DoInitAction=tag.getBody(DoInitAction,null);
							objIdNameArr.push([doInitAction,"SpriteID"]);
						break;
						//case TagTypes.VideoFrame:
						//break;
						case TagTypes.CSMTextSettings:
							objIdNameArr.push([tag,"UI16Id"]);
						break;
						case TagTypes.DefineScalingGrid:
							objIdNameArr.push([tag,"UI16Id"]);
						break;
							
						case TagTypes.ExportAssets:
							var exportAssets:ExportAssets=tag.getBody(ExportAssets,null);
							i=-1;
							for each(Tag_ in exportAssets.TagV){
								i++;
								if(Tag_>0){
									objIdNameArr.push([exportAssets.TagV,i]);
								}else{
									throw new Error("Tag_="+Tag_);
								}
							}
						break;
						case TagTypes.ImportAssets:
							var importAssets:ImportAssets=tag.getBody(ImportAssets,null);
							i=-1;
							for each(Tag_ in importAssets.TagV){
								i++;
								if(Tag_>0){
									objIdNameArr.push([importAssets.TagV,i]);
								}else{
									throw new Error("Tag_="+Tag_);
								}
							}
						break;
						case TagTypes.ImportAssets2:
							var importAssets2:ImportAssets2=tag.getBody(ImportAssets2,null);
							i=-1;
							for each(Tag_ in importAssets2.TagV){
								i++;
								if(Tag_>0){
									objIdNameArr.push([importAssets2.TagV,i]);
								}else{
									throw new Error("Tag_="+Tag_);
								}
							}
						break;
						case TagTypes.SymbolClass:
							var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
							i=-1;
							for each(Tag_ in symbolClass.TagV){
								i++;
								if(Tag_>0){
									objIdNameArr.push([symbolClass.TagV,i]);
								}//else{
									//throw new Error("Tag_="+Tag_);
								//}
							}
						break;
					}
				}
			}
		}
	}
}
		