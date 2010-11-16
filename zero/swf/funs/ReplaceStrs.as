/***
ReplaceStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月6日 22:17:10
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	
	import flash.utils.ByteArray;
	
	import zero.swf.SWF2;
	import zero.swf.Tag;
	import zero.swf.TagType;
	import zero.swf.tagBodys.DoABC;
	import zero.swf.tagBodys.DoABCWithoutFlagsAndName;
	import zero.swf.tagBodys.SymbolClass;
	import zero.swf.avm2.ABCFileWithSimpleConstant_pool;
	
	public class ReplaceStrs{
		public static function replace(
			swfData:ByteArray,
			str0Arr:Array,
			strtArr:Array//,
			//symbolClassNameIdArr:Array=null
		):ByteArray{
			//把 DoABC 或 DoABCWithoutFlagsAndName 的 abcData 里的 stringV 里的特定的字符串替换成特定的字符串
			DoABCWithoutFlagsAndName.setDecodeABC(ABCFileWithSimpleConstant_pool);
			
			var swf:SWF2=new SWF2();
			swf.initBySWFData(swfData);
			
			DoABC;
			DoABCWithoutFlagsAndName;
			
			var str0:String;
			var i:int;
			
			var mark:Object=new Object();
			i=-1;
			for each(str0 in str0Arr){
				i++;
				mark["~"+str0]=strtArr[i];
			}
			
			/*
			var symbolClassNameMark:Object;
			if(symbolClassNameIdArr){
				symbolClassNameMark=new Object();
				for each(var symbolClassNameId:int in symbolClassNameIdArr){
					symbolClassNameMark["~"+str0Arr[symbolClassNameId]]=strtArr[symbolClassNameId];
				}
			}else{
				symbolClassNameMark=null;
			}
			*/
			
			var strt:String;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var abcData:ABCFileWithSimpleConstant_pool=tag.getBody().abc;
						i=abcData.stringV.length;
						while(--i>0){
							strt=mark["~"+abcData.stringV[i]];
							if(strt is String){
								//trace("strt=\""+strt+"\",strt.length="+strt.length);
								abcData.stringV[i]=strt;
							}
						}
					break;
					case TagType.SymbolClass:
						/*
						if(symbolClassNameMark){
							var NameV:Vector.<String>=(tag.getBody() as SymbolClass).NameV;
							i=NameV.length;
							while(--i>=0){
								strt=symbolClassNameMark["~"+NameV[i]];
								if(strt){
									NameV[i]=strt;
								}
							}
						}
						*/
						var NameV:Vector.<String>=(tag.getBody() as SymbolClass).NameV;
						i=NameV.length;
						while(--i>=0){
							strt=mark["~"+NameV[i]];
							if(strt is String){
								NameV[i]=strt;
							}
						}
					break;
				}
			}
			
			DoABCWithoutFlagsAndName.setDecodeABC(null);
			
			return swf.toSWFData();
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