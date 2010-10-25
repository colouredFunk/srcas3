/***
AdvanceMethod 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月23日 16:16:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advance{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.vmarks.MethodFlags;
	import zero.swf.avm2.ABCFile;
	import zero.swf.avm2.Method_body_info;
	import zero.swf.avm2.Method_info;
	import zero.swf.avm2.Option_detail;
	
	public class AdvanceMethod extends Advance{
		public var return_type:AdvanceMultiname_info;			//0 -> *
		public var param_typeV:Vector.<AdvanceMultiname_info>;	//0 -> *
		public var name:String;								//0 -> null
		public var flags:int;
		public var option_detailV:Vector.<AdvanceOption_detail>;
		public var param_nameV:Vector.<String>;
		
		public var max_stack:int;
		public var local_count:int;
		public var init_scope_depth:int;
		public var max_scope_depth:int;
		//public var codes:Codes;
		public var exception_infoV:Vector.<AdvanceException_info>;
		public var traits_infoV:Vector.<AdvanceTraits_info>;
		
		public function AdvanceMethod(){
		}
		public function initByInfo(
			method_info:Method_info,
			method_body_info:Method_body_info
		):void{
			var i:int;
			
			getAdvance(method_info,"return_type",AdvanceMultiname_info);
			
			getAdvancesByIds(method_info,"param_type",AdvanceMultiname_info,Vector.<AdvanceMultiname_info>);
			
			getString(method_info,"name");
			
			flags=method_info.flags;
			
			getAdvancesByInfos(method_info,"option_detail",AdvanceOption_detail,Vector.<AdvanceOption_detail>);
			
			/*
			if(method_info.param_nameV&&method_info.param_nameV.length){
				param_nameV=new Vector.<String>();
				i=-1;
				for each(var param_name:int in method_info.param_nameV){
					i++;
					param_nameV[i]=abcFile.stringV[param_name];
				}
			}
			*/
		}
		
		public function toXML():XML{
			var xml:XML=<AdvanceMethod
				name=""
				flags={(
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_ARGUMENTS]+
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_ACTIVATION]+
					"|"+MethodFlags.flagV[flags&MethodFlags.NEED_REST]+
					"|"+MethodFlags.flagV[flags&MethodFlags.HAS_OPTIONAL]+
					"|"+MethodFlags.flagV[flags&MethodFlags.SET_DXNS]+
					"|"+MethodFlags.flagV[flags&MethodFlags.HAS_PARAM_NAMES]
				).replace(/\|null/g,"").substr(1)}
			>
				<return_type/>
				<param_typeList/>
				<option_detailList/>
				<param_nameList/>
			</AdvanceMethod>;
			
			if(return_type){
				xml.return_type[0].appendChild(return_type.toXML());
			}else{
				xml.return_type[0].@value="*";
			}
			
			if(param_typeV&&param_typeV.length){
				var listXML:XML=xml.param_typeList[0];
				listXML.@count=param_typeV.length;
				for each(var param_type:AdvanceMultiname_info in param_typeV){
					var itemXML:XML=<param_type/>;
					if(param_type){
						itemXML.appendChild(param_type.toXML());
					}else{
						itemXML.@value="*";
					}
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.param_typeList;
			}
			
			if(name){
				xml.@name=name;
			}else{
				delete xml.@name;
			}
			
			if(option_detailV&&option_detailV.length){
				listXML=xml.option_detailList[0];
				listXML.@count=option_detailV.length;
				for each(var option_detail:AdvanceOption_detail in option_detailV){
					itemXML=<option_detail/>;
					itemXML.appendChild(option_detail.toXML());
					listXML.appendChild(itemXML);
				}
			}else{
				delete xml.option_detailList;
			}
			if(param_nameV&&param_nameV.length){
				listXML=xml.param_nameList[0];
				listXML.@count=param_nameV.length;
				for each(var param_name:String in param_nameV){
					listXML.appendChild(<param_name value={param_name}/>);
				}
			}else{
				delete xml.param_nameList;
			}
			
			return xml;
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