/***
getAvalibleDefineObjIdV 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年4月18日 17:42:12
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import zero.swf.*;
	public function getAvalibleDefineObjIdV(tagV:Vector.<Tag>):Vector.<int>{
		var avalibleDefineObjIdArr:Array=new Array();
		//avalibleDefineObjIdArr[0]=true;//有可能被文档类占用
		
		var id:int;
		
		for each(var tag:Tag in tagV){
			//if(tag is DefineSprite){//一般来说 DefineSprite 内不会有 DefineObj
			//}else{
			var typeName:String=TagTypes.typeNameV[tag.type];
			if(typeName){
				if(DefineObjs[typeName]){
					id=tag.getDefId();
					
					if(avalibleDefineObjIdArr[id]){
						throw new Error("发现重复的 id:"+id+"，typeName="+typeName);
					}
					avalibleDefineObjIdArr[id]=true;
				}
			}else{
				switch(tag.type){
					case 255:
						//常见的扰乱反编译器的 tag
					break;
					default:
						//主要是如果新版本的 flash 出新 tag 了知道一下
						throw new Error("未知 TagType: "+tag.type);
					break;
				}
			}
			//}
		}
		
		var avalibleDefineObjIdV:Vector.<int>=new Vector.<int>();
		for(id=1;id<=0x7fff;id++){//0 有可能被文档类占用,所以从1开始
			if(avalibleDefineObjIdArr[id]){
			}else{
				avalibleDefineObjIdV[avalibleDefineObjIdV.length]=id;
			}
		}
		//if(avalibleDefineObjIdV.length>10){
		//	trace("avalibleDefineObjIdV="+avalibleDefineObjIdV.slice(0,5)+"..."+avalibleDefineObjIdV.slice(avalibleDefineObjIdV.length-5,avalibleDefineObjIdV.length));
		//}else{
		//	trace("avalibleDefineObjIdV="+avalibleDefineObjIdV);
		//}
		return avalibleDefineObjIdV;
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