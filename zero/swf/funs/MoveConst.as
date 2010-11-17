/***
MoveConst 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月17日 13:39:55
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
	
	public class MoveConst{
		ZЁЯ¤ 15:54:32
		在忙？
		
		梦旅人 15:55:13
		还好，怎么
		
		ZЁЯ¤ 15:55:28
		
		
		ZЁЯ¤ 15:55:34
		上回说那东西
		
		ZЁЯ¤ 15:55:49
		把常量分离到外面初始化
		
		梦旅人 15:56:01
		噢。可以了是吧
		
		ZЁЯ¤ 15:56:12
		嗯，不太可以
		
		梦旅人 15:56:20
		什么问题呢
		
		ZЁЯ¤ 15:56:32
		
		
		ZЁЯ¤ 15:56:55
		右边是分离后在外面初始化的
		
		ZЁЯ¤ 15:57:25
		涉及到一个先后的问题。。
		
		ZЁЯ¤ 15:57:44
		
		
		ZЁЯ¤ 15:57:56
		这句比初始化的要快，所以就变成 ssss0 了
		
		梦旅人 15:58:05
		噢
		
		ZЁЯ¤ 15:58:21
		可能得想点别的
		
		梦旅人 15:58:21
		那专门加一个函数来初始化？
		
		ZЁЯ¤ 15:58:39
		嗯，这是考虑的一个方法
		
		ZЁЯ¤ 15:59:37
		把常量分离到外面初始化不是不行，只是得限制很多东西，一不小心，就写错了
		
		梦旅人 16:00:27
		只要保证要分离的变量不是一开始就使用的，只要不出现这种就行  
		可以给一个专门的函数
		
		梦旅人 16:00:48
		所以要分离的变量就不要有关联 
		
		梦旅人 16:01:19
		反正这个也是我们自己用，自己注意就行了
		
		ZЁЯ¤ 16:01:35
		对，而且不能别的类引用，例如 Main.b，如果被外面一个类引用，但那个类如果比Main先初始化，就完了
		
		梦旅人 16:01:50
		噢
		
		ZЁЯ¤ 16:01:55
		所以，非常的严格。。
		
		ZЁЯ¤ 16:02:01
		private static const b:int=12345;
		
		ZЁЯ¤ 16:02:13
		只能是 private
		
		梦旅人 16:02:12
		恩，那就明确规则就行
		
		ZЁЯ¤ 16:02:19
		限制太多~
			
			梦旅人 16:02:23
			需要分离的变量都不要有关联
			
			梦旅人 16:02:38
			只选一些特殊变量来分离就行
			
			ZЁЯ¤ 16:03:02
		嗯。。
		
		梦旅人 16:03:07
		只能是 private？
		
		梦旅人 16:03:27
		上面的不是public的吗
		
		ZЁЯ¤ 16:03:41
		public 就有可能被别的类引用了
		
		梦旅人 16:03:45
		哦。这样
		
		ZЁЯ¤ 16:03:51
		嗯，现有两个想法
		
		ZЁЯ¤ 16:04:10
		一个就是定成private等一个很严格的规则
		
		ZЁЯ¤ 16:04:24
		一个就是，每次加密，手动挑几个来分离
		
		ZЁЯ¤ 16:04:45
		反正都不太爽就是
		
		ZЁЯ¤ 16:05:15
		还是弄个函数吧
		
		梦旅人 16:05:40
		恩。好的。需要后面在初始化的变量就写到函数里面
		public static function getMoveConstsAndRemove(swf:SWF2):Vector.<Array>{
			var arrV:Vector.<Array>=new Vector.<Array>();
			var multiname_name_infoDict:Dictionary=new Dictionary();
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc;
						for each(var clazz:AdvanceClass in advanceABC.classV){
							getConstFromTraits(clazz.ctraits_infoV,arrV,multiname_name_infoDict);
							var codeV:Vector.<BaseCode>=clazz.cinit.codes.codeV;
							var i:int=codeV.length;
							while(--i>=0){
								var advanceCode:AdvanceCode=codeV[i] as AdvanceCode;
								if(
									advanceCode
									&&
									advanceCode.op==Op.findproperty
									&&
									multiname_name_infoDict[advanceCode.value]
								){
									var initpropertyCode:AdvanceCode=codeV[i+2] as AdvanceCode;
									if(
										initpropertyCode
										&&
										initpropertyCode.op==Op.initproperty
										&&
										initpropertyCode.value===advanceCode.value
									){
										codeV.splice(i,3);
									}
								}
							}
						}
					break;
				}
			}
			return arrV;
		}
		private static function getConstFromTraits(
			traits_infoV:Vector.<AdvanceTraits_info>,
			arrV:Vector.<Array>,
			multiname_name_infoDict:Dictionary
		):void{
			for each(var traits_info:AdvanceTraits_info in traits_infoV){
				switch(traits_info.kind_trait_type){
					case TraitTypes.Slot:
					case TraitTypes.Const:
						switch(traits_info.vkind){
							case ConstantKind.Int:
							case ConstantKind.UInt:
							case ConstantKind.Double:
							case ConstantKind.Utf8:
							case ConstantKind.Namespace:
							case ConstantKind.PackageNamespace:
							case ConstantKind.PackageInternalNs:
							case ConstantKind.ProtectedNamespace:
							case ConstantKind.ExplicitNamespace:
							case ConstantKind.StaticProtectedNs:
							case ConstantKind.PrivateNs:
								arrV.push([
									traits_info.name,
									traits_info.vkind,
									traits_info.vindex
								]);
								traits_info.vkind=ConstantKind.Undefined;
								traits_info.vindex=ConstantKind.Undefined;
								traits_info.kind_trait_type=TraitTypes.Slot;
								//trace(traits_info.toXML("traits_info").toXMLString());
								multiname_name_infoDict[traits_info.name]=true;
							break;
							case ConstantKind.True:
							case ConstantKind.False:
							case ConstantKind.Null:
								arrV.push([
									traits_info.name,
									traits_info.vkind
								]);
								traits_info.vkind=ConstantKind.Undefined;
								traits_info.vindex=ConstantKind.Undefined;
								traits_info.kind_trait_type=TraitTypes.Slot;
								//trace(traits_info.toXML("traits_info").toXMLString());
								multiname_name_infoDict[traits_info.name]=true;
							break;
							case ConstantKind.Undefined:
							break;
							default:
							break;
						}
					break;
					case TraitTypes.Method:
					case TraitTypes.Getter:
					case TraitTypes.Setter:
					break;
					case TraitTypes.Function:
					break;
					case TraitTypes.Clazz:
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