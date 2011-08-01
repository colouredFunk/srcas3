/***
PutInSceneTagAndClassNames 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月1日 21:06:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	
	public class PutInSceneTagAndClassNames{
		public static function getPutInSceneTagAndClassNameArr(swf:SWF):Array{
			var classNameArr:Array=new Array();//以 defId 为索引的 className 们
			var defTagArr:Array=new Array();//以 defId 为索引且在 classNameArr 中有记录的 tag 们
			var putInSceneTagAndClassNameArr:Array=new Array();
			getClassNameArr(swf.tagV,classNameArr);
			getDefTagArr(swf.tagV,classNameArr,defTagArr);
			getPutInSceneTagArr(
				swf.tagV,
				classNameArr,
				defTagArr,
				putInSceneTagAndClassNameArr
			);
			if(classNameArr[0]){
				putInSceneTagAndClassNameArr[0]=[null,classNameArr[0].replace(/\:\:/g,".")];//文档类
			}
			
			return putInSceneTagAndClassNameArr;
		}
		private static function getClassNameArr(tagV:Vector.<Tag>,classNameArr:Array):void{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.SymbolClass:
						var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
						var i:int=-1;
						for each(var className:String in symbolClass.NameV){
							i++;
							classNameArr[symbolClass.TagV[i]]=className.replace(/\:\:/g,".");
						}
					break;
					case TagTypes.DefineSprite:
						getClassNameArr(tag.getBody(DefineSprite,null).tagV,classNameArr);
					break;
				}
			}
		}
		private static function getDefTagArr(tagV:Vector.<Tag>,classNameArr:Array,defTagArr:Array):void{
			for each(var tag:Tag in tagV){
				if(DefineObjs[TagTypes.typeNameV[tag.type]]){
					var defId:int=tag.UI16Id;
					if(classNameArr[defId]){
						defTagArr[defId]=tag;
					}
				}
				if(tag.type==TagTypes.DefineSprite){
					getDefTagArr(tag.getBody(DefineSprite,null).tagV,classNameArr,defTagArr);
				}
			}
		}
		private static function getPutInSceneTagArr(
			tagV:Vector.<Tag>,
			classNameArr:Array,
			defTagArr:Array,
			putInSceneTagAndClassNameArr:Array
		):void{
			var CharacterId:int;
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.PlaceObject:
						CharacterId=tag.getBody(PlaceObject,null).CharacterId;
						if(defTagArr[CharacterId]){
							putInSceneTagAndClassNameArr[CharacterId]=[tag,classNameArr[CharacterId]];
						}
					break;
					case TagTypes.PlaceObject2:
						CharacterId=tag.getBody(PlaceObject2,null).CharacterId;
						if(defTagArr[CharacterId]){
							putInSceneTagAndClassNameArr[CharacterId]=[tag,classNameArr[CharacterId]];
						}
					break;
					case TagTypes.PlaceObject3:
						CharacterId=tag.getBody(PlaceObject3,null).CharacterId;
						if(defTagArr[CharacterId]){
							putInSceneTagAndClassNameArr[CharacterId]=[tag,classNameArr[CharacterId]];
						}
					break;
					case TagTypes.DefineSprite:
						getPutInSceneTagArr(
							tag.getBody(DefineSprite,null).tagV,
							classNameArr,
							defTagArr,
							putInSceneTagAndClassNameArr
						);
					break;
				}
			}
		}
	}
}

