/***
MethodCodesInserter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月16日 20:09:35
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;
	
	public class MethodCodesInserter{
		public static function addCodeSegToSWF(swf:SWF2,codeSegMethod:AdvanceMethod):void{
			var codeV:Vector.<BaseCode>=normalizeCodeV(codeSegMethod.codes.codeV);
			
			var tag:Tag;
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							insertCodesInMethod(codeV,codeSegMethod.max_stack,clazz.cinit);
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							insertCodesInMethod(codeV,codeSegMethod.max_stack,script_info.init);
						}
					break;
				}
			}
		}
		public static function normalizeCodeV(codeV:Vector.<BaseCode>):Vector.<BaseCode>{
			codeV=codeV.slice();
			if(
				codeV.shift()["op"]==Op.getlocal0
				&&
				codeV.shift()["op"]==Op.pushscope
				&&
				codeV.pop()["op"]==Op.returnvoid
			){
			}else{
				throw new Error("codeV 不太正常");
			}
			return codeV;
		}
		public static function insertCodesInMethod(
			codeV:Vector.<BaseCode>,
			codes_max_stack:int,
			method:AdvanceMethod
		):void{
			var code0:AdvanceCode,code1:AdvanceCode;
			if(method.codes.codeV.length>1){
				code0=method.codes.codeV[0] as AdvanceCode;
				code1=method.codes.codeV[1] as AdvanceCode;
				if(
					code0.op==Op.getlocal0
					&&
					code1.op==Op.pushscope
				){
					method.codes.codeV.shift();
					method.codes.codeV.shift();
				}else{
					code0=null;
					code1=null;
					//throw new Error("method_codeV 不太正常, code0.op="+Op.opNameV[code0.op]+", code1.op="+Op.opNameV[code1.op]);
				}
			}
			
			if(method.max_stack<codes_max_stack){
				method.max_stack=codes_max_stack;
			}
			
			method.codes.codeV=codeV.concat(method.codes.codeV);
			
			if(code0&&code1){
				method.codes.codeV.unshift(code1);
				method.codes.codeV.unshift(code0);
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