/***
Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.advances.codes{
	import flash.utils.ByteArray;
	
	import zero.swf.avm2.advances.AdvanceMultiname_info;
	import zero.swf.avm2.advances.AdvanceABC;
	import zero.swf.avm2.advances.Member;
	

	public class Codes{
		public var codeV:Vector.<Code>;
		public function Codes(){
		}
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			trace("offset="+offset,"endOffset="+endOffset);
			codeV=new Vector.<Code>();
			
			var multiname_info:AdvanceMultiname_info;
			var multiname_info_index:int,args:int;
			
			var codeId:int=-1;
			while(offset<endOffset){
				codeId++;
				var code:Code;
				var op:int=data[offset++];
				var opName:String=Op.opNameV[op];
				trace("opName="+opName);
				if(opName){
					switch(Op.opTypeV[op]){
						case Op.type_simple:
							code=new Code();
						break;
						case Op.type_index_u30_multiname_info:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){multiname_info_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{multiname_info_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{multiname_info_index=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{multiname_info_index=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{multiname_info_index=data[offset++];}
							//multiname_info_index
							
							code=new Code_u30_Multiname();
							(code as Code_u30_Multiname).initByInfo(AdvanceABC.currInstance.getInfoByIdAndMemberType(multiname_info_index,Member.MULTINAME_INFO));
						break;
						case Op.type_index_u30_string:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_register:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_slot:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_int:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_uint:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_double:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_namespace_info:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_method:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_class:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_exception_info:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_scope:
							throw new Error("未处理");
						break;
						case Op.type_index_u30_finddef:
							throw new Error("未处理");
						break;
						case Op.type_index_args_u30_u30_multiname_info:
							throw new Error("未处理");
						break;
						case Op.type_index_args_u30_u30_method:
							throw new Error("未处理");
						break;
						case Op.type_args_u30:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){args=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{args=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{args=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{args=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{args=data[offset++];}
							//args
							
							//code=new Code_u30_Args();
							//offset=UGetterAndSetter.offset;
						break;
						case Op.type_branch_s24:
							throw new Error("未处理");
						break;
						case Op.type_value_byte_u8:
							throw new Error("未处理");
						break;
						case Op.type_value_int_u30:
							throw new Error("未处理");
						break;
						case Op.type_special:
							throw new Error("未处理");
						break;
						default:
							throw new Error("未知 op: "+op+", opName="+opName+", Op.opTypeV[op]="+Op.opTypeV[op]);
						break;
					}
				}else{
					throw new Error("未知 op: "+op+",opName="+opName);
				}
				code.op=op;
				codeV[codeId]=code;
			}
			return endOffset;
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			return data;
		}
		////
		CONFIG::toXMLAndInitByXML {
		public function toXML(xmlName:String):XML{
			return <{xmlName} class="Codes"/>;
		}
		public function initByXML(xml:XML):void{
		}
		}//end of CONFIG::toXMLAndInitByXML
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