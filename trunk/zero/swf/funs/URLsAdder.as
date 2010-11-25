/***
URLsAdder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月16日 19:38:19
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class URLsAdder extends MethodCodesInserter{
		public static function addURLsToSWF(
			swf:SWF2,
			checkURLMethod1:AdvanceMethod,
			checkURLMethod2:AdvanceMethod,
			urlsXML:XML
		):void{
			不用了直接汇编
			//trace(urlsXML.toXMLString());
			var codeV1:Vector.<BaseCode>=normalizeCodeV(checkURLMethod1.codes.codeV);
			var codeV2:Vector.<BaseCode>=normalizeCodeV(checkURLMethod2.codes.codeV);
			
			var tag:Tag;
			
			var codeV:Vector.<BaseCode>=new Vector.<BaseCode>();
			var max_stack:int=Math.max(checkURLMethod1.max_stack,checkURLMethod2.max_stack);
			for each(var urlXML:XML in urlsXML.url){
				//trace(urlXML.@url.toString());
				if(urlXML.@strictMatch.toString()=="true"){
					insert(codeV,codeV1,urlXML.@url.toString());
				}else{
					insert(codeV,codeV2,urlXML.@url.toString());
				}
			}
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							insertCodesInMethod(codeV,max_stack,clazz.cinit);
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							insertCodesInMethod(codeV,max_stack,script_info.init);
						}
					break;
				}
			}
		}
		private static function insert(
			codeV:Vector.<BaseCode>,
			checkURLMethodCodeV:Vector.<BaseCode>,
			url:String
		):void{
			var lastLabelMarkV:Vector.<LabelMark>=new Vector.<LabelMark>();
			if(codeV.length){
				while(true){
					code=codeV.pop();
					if(code is LabelMark){
						lastLabelMarkV.push(code);
					}else{
						break;
					}
				}
			}else{
				lastLabelMarkV=null;
			}
			
			//简单的 codeV.clone()，不支持 lookupswitch
			var L:int=checkURLMethodCodeV.length;
			var labelMarkDict:Dictionary=new Dictionary();
			var code:BaseCode,advanceCode:AdvanceCode,labelMark:LabelMark;
			for(var i:int=0;i<L;i++){
				code=checkURLMethodCodeV[i];
				if(code is AdvanceCode){
					advanceCode=new AdvanceCode(code["op"]);
					advanceCode.value=code["value"];
					if(advanceCode.op==Op.pushstring&&advanceCode.value=="${url}"){
						advanceCode.value=url;
					}
					codeV.push(advanceCode);
				}else{
					labelMark=new LabelMark();
					labelMarkDict[code]=labelMark;
					codeV.push(labelMark);
				}
			}
			for each(code in codeV){
				if(code is AdvanceCode){
					advanceCode=code as AdvanceCode;
					if(labelMarkDict[advanceCode.value]){
						advanceCode.value=labelMarkDict[advanceCode.value];
					}
				}
			}
			for each(labelMark in lastLabelMarkV){
				codeV.push(labelMark);
			}
			//
			
			/*
			for each(code in codeV){
				if(code is AdvanceCode){
					trace(Op.opNameV[code["op"]],code["value"]);
				}else{
					trace(code);
				}
			}
			trace("codeV.length="+codeV.length);
			//*/
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