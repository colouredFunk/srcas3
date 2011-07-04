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
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class PutInSceneTagAndClassNames{
		public static function getPutInSceneTagAndClassNameArr(swf:SWF):Array{
			
			//引用一下以便编译进来
			PlaceObject;
			PlaceObject2;
			PlaceObject3;
			//
			
			var classNameArr:Array=new Array();//以 defId 为索引的 className 们
			var defTagArr:Array=new Array();//以 defId 为索引且在 classNameArr 中有记录的 tag 们
			var putInSceneTagAndClassNameArr:Array=new Array();
			getClassNameArr(swf.tagV,classNameArr);
			getDefTagArr(swf.tagV,classNameArr,defTagArr);
			getPutInSceneTagArr(
				swf.tagV,
				classNameArr,
				defTagArr,
				putInSceneTagAndClassNameArr,
				swf.Version
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
						var symbolClass:SymbolClass=tag.getBody(null) as SymbolClass;
						var i:int=-1;
						for each(var className:String in symbolClass.NameV){
							i++;
							classNameArr[symbolClass.TagV[i]]=className.replace(/\:\:/g,".");
						}
					break;
					case TagTypes.DefineSprite:
						getClassNameArr((tag.getBody(null) as DefineSprite).tagV,classNameArr);
					break;
				}
			}
		}
		private static function getDefTagArr(tagV:Vector.<Tag>,classNameArr:Array,defTagArr:Array):void{
			for each(var tag:Tag in tagV){
				if(DefineObjs[TagTypes.typeNameV[tag.type]]){
					var defId:int=tag.getDefId();
					if(classNameArr[defId]){
						defTagArr[defId]=tag;
					}
				}
				if(tag.type==TagTypes.DefineSprite){
					getDefTagArr((tag.getBody(null) as DefineSprite).tagV,classNameArr,defTagArr);
				}
			}
		}
		private static function getPutInSceneTagArr(
			tagV:Vector.<Tag>,
			classNameArr:Array,
			defTagArr:Array,
			putInSceneTagAndClassNameArr:Array,
			swf_Version:int
		):void{
			for each(var tag:Tag in tagV){
				switch(tag.type){
					case TagTypes.PlaceObject:
					case TagTypes.PlaceObject2:
					case TagTypes.PlaceObject3:
						var CharacterId:int=tag.getBody({swf_Version:swf_Version})["CharacterId"];
						if(defTagArr[CharacterId]){
							putInSceneTagAndClassNameArr[CharacterId]=[tag,classNameArr[CharacterId]];
						}
					break;
					case TagTypes.DefineSprite:
						getPutInSceneTagArr(
							(tag.getBody(null) as DefineSprite).tagV,
							classNameArr,
							defTagArr,putInSceneTagAndClassNameArr,
							swf_Version
						);
					break;
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