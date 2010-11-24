/***
Member 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月28日 09:12:23
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Member{
		//ABCFile
			//Constant_pool
		public static const INTEGER:String="integer";
		public static const UINTEGER:String="uinteger";
		public static const DOUBLE:String="double";
		public static const STRING:String="string";
		public static const NAMESPACE_INFO:String="namespace_info";
		public static const NS_SET_INFO:String="ns_set_info";
		public static const MULTINAME_INFO:String="multiname_info";
			//
		public static const METHOD:String="method";
		public static const METADATA_INFO:String="metadata_info";
		public static const CLAZZ:String="clazz";
		public static const SCRIPT_INFO:String="script_info";
		//
		
		public static const TRAITS_INFO:String="traits_info";
		public static const OPTION_DETIAL:String="option_detial";
		public static const ITEM_INFO:String="item_info";
		public static const EXCEPTION_INFO:String="exception_info";
		
		public static const DIRECT_INT:String="direct_int";
		
		////
		
		public static const typeV:Vector.<String>=Vector.<String>([
			INTEGER,
			UINTEGER,
			DOUBLE,
			STRING,
			NAMESPACE_INFO,
			NS_SET_INFO,
			MULTINAME_INFO,
			METHOD,
			METADATA_INFO,
			CLAZZ,
			SCRIPT_INFO,
			TRAITS_INFO,
			OPTION_DETIAL,
			ITEM_INFO,
			EXCEPTION_INFO
		]);
		
		////
		
		public static const CURR_CASE:String="curr_case";
		
		public static var directMark:Object;
		public static var idStartFrom1Mark:Object;
		public static var useMarkKeyMark:Object;
		public static var fromABCFileMark:Object=firstInit();
		private static function firstInit():Object{
			directMark=new Object();
			directMark[INTEGER]=true;
			directMark[UINTEGER]=true;
			directMark[DOUBLE]=true;
			directMark[STRING]=true;
			
			idStartFrom1Mark=new Object();
			
			idStartFrom1Mark[INTEGER]=true;
			idStartFrom1Mark[UINTEGER]=true;
			idStartFrom1Mark[DOUBLE]=true;
			idStartFrom1Mark[STRING]=true;
			idStartFrom1Mark[NAMESPACE_INFO]=true;
			idStartFrom1Mark[NS_SET_INFO]=true;
			idStartFrom1Mark[MULTINAME_INFO]=true;
			
			useMarkKeyMark=new Object();
			
			useMarkKeyMark[NAMESPACE_INFO]=true;
			useMarkKeyMark[NS_SET_INFO]=true;
			useMarkKeyMark[MULTINAME_INFO]=true;
			
			//
			var fromABCFileMark:Object=new Object();
			
			fromABCFileMark[INTEGER]=true;
			fromABCFileMark[UINTEGER]=true;
			fromABCFileMark[DOUBLE]=true;
			fromABCFileMark[STRING]=true;
			fromABCFileMark[NAMESPACE_INFO]=true;
			fromABCFileMark[NS_SET_INFO]=true;
			fromABCFileMark[MULTINAME_INFO]=true;
			
			fromABCFileMark[METHOD]=true;
			fromABCFileMark[METADATA_INFO]=true;
			fromABCFileMark[CLAZZ]=true;
			fromABCFileMark[SCRIPT_INFO]=true;
			
			return fromABCFileMark;
		}
		
		public var name:String;
		public var type:String;
		public var isList:Boolean;
		public var curr:String;
		
		public var kindClass:Class;
		public var kindVName:String;
		
		public var flagClass:Class;
		
		public var constKindName:String;
		
		public function Member(
			_name:String,
			_type:String=null,
			rest:Object=null
		){
			name=_name;
			type=_type||DIRECT_INT;
			
			if(rest){
				curr=rest.curr;
				
				if(rest.isList){
					isList=true;
				}else if(rest.kindClass){
					kindClass=rest.kindClass;
					kindVName=rest.kindVName||"kindV";
				}else if(rest.flagClass){
					flagClass=rest.flagClass;
				}else if(rest.constKindName){
					constKindName=rest.constKindName;
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