/***
PutInSceneObjs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月1日 21:06:31
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class PutInSceneObjs{
		private static var tagAndClassNameByDefIdArr:Array;
		private static var putInSceneSpriteArr:Array;
		public static var classNameByDefIdArr:Array;
		public static var classNameMark:Object;
		public static function init(swf:SWF2):void{
			var tag:Tag;
			var className:String;
			classNameByDefIdArr=new Array();
			for each(tag in swf.tagV){
				if(tag.type==TagType.SymbolClass){
					var symbolClass:SymbolClass=tag.getBody() as SymbolClass;
					var i:int=-1;
					for each(className in symbolClass.NameV){
						i++;
						//trace(symbolClass.TagV[i],className);
						classNameByDefIdArr[symbolClass.TagV[i]]=className;
					}
				}
			}
			tagAndClassNameByDefIdArr=new Array();
			for each(tag in swf.tagV){
				if(DefineObjs[TagType.typeNameArr[tag.type]]){
					var defId:int=tag.getDefId();
					if(classNameByDefIdArr[defId]){//这里假定了每个 defObj 在 swf.tagV 里只出现一次
						tagAndClassNameByDefIdArr[defId]=[tag,classNameByDefIdArr[defId]];
					}
				}
			}
			
			//trace("classNameByDefIdArr="+classNameByDefIdArr);
			
			putInSceneSpriteArr=new Array();
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.PlaceObject:
					case TagType.PlaceObject2:
					case TagType.PlaceObject3:
						getObjsPutInScene(tag.getBody());
					break;
				}
			}
			
			tagAndClassNameByDefIdArr=null;
			
			classNameMark=new Object();
			for each(className in putInSceneSpriteArr){
				if(className){
					classNameMark["~"+className]=true;
				}
			}
			if(classNameByDefIdArr[0]){
				classNameMark["~"+classNameByDefIdArr[0]]=true;//文档类
			}
			putInSceneSpriteArr=null;
		}
		
		private static function getObjsPutInScene(placeObject:*):void{
			if(tagAndClassNameByDefIdArr[placeObject.CharacterId]){
				var tag:Tag=tagAndClassNameByDefIdArr[placeObject.CharacterId][0];
				if(tag&&tag.type==TagType.DefineSprite){
					if(putInSceneSpriteArr[placeObject.CharacterId]){
						return;
					}
					//trace("placeObject.CharacterId="+placeObject.CharacterId);
					putInSceneSpriteArr[placeObject.CharacterId]=tagAndClassNameByDefIdArr[placeObject.CharacterId][1];
					for each(var subTag:Tag in (tag.getBody() as DefineSprite).dataAndTags.tagV){
						switch(subTag.type){
							case TagType.PlaceObject:
							case TagType.PlaceObject2:
							case TagType.PlaceObject3:
								getObjsPutInScene(subTag.getBody());
							break;
						}
					}
				}
			}
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/