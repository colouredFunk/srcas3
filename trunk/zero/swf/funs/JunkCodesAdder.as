/***
CodesAddJunks 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月23日 18:31:18
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import zero.BytesAndStr16;
	import zero.swf.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.tagBodys.*;
	import zero.swf.vmarks.*;

	public class JunkCodesAdder extends JunksAdder{
		private static const options:Array=BytesAndStr16.str162bytes("09 09 01 09 05 01 06 13 69 6e 64 65 78 20 75 33 30 09 0b 01 09 05 01 04 6c 04 00 09 05 01 04 6c 04 01 09 05 01 04 65 04 01 09 05 01 04 5a 04 00 09 05 01 04 58 04 01 09 05 01 06 0d 62 72 61 6e 63 68 09 3d 01 09 05 01 04 1a 04 01 09 05 01 04 1a 04 02 09 05 01 04 19 04 01 09 05 01 04 19 04 02 09 05 01 04 18 04 01 09 05 01 04 18 04 02 09 05 01 04 17 04 01 09 05 01 04 17 04 02 09 05 01 04 16 04 01 09 05 01 04 16 04 02 09 05 01 04 15 04 01 09 05 01 04 15 04 02 09 05 01 04 14 04 01 09 05 01 04 14 04 02 09 05 01 04 13 04 01 09 05 01 04 13 04 02 09 05 01 04 12 04 01 09 05 01 04 12 04 02 09 05 01 04 11 04 01 09 05 01 04 11 04 02 09 05 01 04 10 04 01 09 05 01 04 10 04 02 09 05 01 04 0f 04 01 09 05 01 04 0f 04 02 09 05 01 04 0e 04 01 09 05 01 04 0e 04 02 09 05 01 04 0d 04 01 09 05 01 04 0d 04 02 09 05 01 04 0c 04 01 09 05 01 04 0c 04 02 09 05 01 06 11 61 72 67 73 20 75 33 30 09 0d 01 09 05 01 04 56 04 01 09 05 01 04 55 04 01 09 05 01 04 53 04 01 09 05 01 04 49 04 01 09 05 01 04 42 04 01 09 05 01 04 41 04 01 09 05 01 06 25 69 6e 64 65 78 20 75 33 30 20 61 72 67 73 20 75 33 30 09 25 01 09 07 01 04 44 04 01 04 00 09 07 01 04 43 04 01 04 00 09 07 01 04 4f 04 00 04 01 09 07 01 04 4f 04 01 04 01 09 07 01 04 4e 04 00 04 01 09 07 01 04 4e 04 01 04 01 09 07 01 04 4c 04 00 04 01 09 07 01 04 4c 04 01 04 01 09 07 01 04 4a 04 00 04 01 09 07 01 04 4a 04 01 04 01 09 07 01 04 46 04 00 04 01 09 07 01 04 46 04 01 04 01 09 07 01 04 45 04 00 04 01 09 07 01 04 45 04 01 04 01 09 07 01 04 44 04 00 04 01 09 07 01 04 44 04 01 04 01 09 07 01 04 43 04 00 04 01 09 07 01 04 43 04 01 04 01").readObject();
		
		public static function addJunkCodes(swf:SWF2):void{
			trace("options="+options);
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							addJunkCodesToCodeV(clazz.iinit.codes);
							addJunkCodesToTraitss(clazz.itraits_infoV);
							addJunkCodesToCodeV(clazz.cinit.codes);
							addJunkCodesToTraitss(clazz.ctraits_infoV);
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							addJunkCodesToCodeV(script_info.init.codes);
							addJunkCodesToTraitss(script_info.traits_infoV);
						}
					break;
				}
			}
		}
		private static function addJunkCodesToTraitss(traits_infoV:Vector.<AdvanceTraits_info>):void{
			for each(var traits_info:AdvanceTraits_info in traits_infoV){
				//trace(TraitTypes.typeV[traits_info.kind_trait_type]);
				switch(traits_info.kind_trait_type){
					case TraitTypes.Slot:
					case TraitTypes.Const:
					break;
					case TraitTypes.Method:
					case TraitTypes.Getter:
					case TraitTypes.Setter:
						addJunkCodesToCodeV(traits_info.methodi.codes);
					break;
					case TraitTypes.Function:
						addJunkCodesToCodeV(traits_info.functioni.codes);
					break;
					case TraitTypes.Clazz:
					break;
				}
			}
		}
		private static function addJunkCodesToCodeV(codes:AdvanceCodes):void{
			if(codes){
			}else{
				return;
			}
			
			var codeV:Vector.<BaseCode>=codes.codeV;
			
			var i:int;
			var L:int=codeV.length;
			if(L<4){
				return;
			}
			
			i=L-1;//不能 jump 到句子后面，否则播放器报错：VerifyError: Error #1020: 代码不能超出方法结尾。
			
			var idArr:Array=getIdArr(5,i);
			while(--i>=0){
				if(idArr[i]){
					var j:int=i;
					var jump:AdvanceCode=new AdvanceCode(Op.jump);
					codeV.splice(j++,0,jump);
					
					var directCode:DirectCode;
					var option:Array=options[int(Math.random()*options.length)];
					switch(option[0]){
						case "index u30":
						case "args u30":
							option=option[1];
							option=option[int(Math.random()*option.length)];
							directCode=new DirectCode(option[0]);
							codeV.splice(j++,0,directCode);
							switch(option[1]){
								case 0:
									directCode.value=0;
								break;
								case 1:
									directCode.value=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
								break;
								case 2:
									directCode.value=0x3fffffff;
								break;
							}
						break;
						case "branch":
							option=option[1];
							option=option[int(Math.random()*option.length)];
							directCode=new DirectCode(option[0]);
							codeV.splice(j++,0,directCode);
							switch(option[1]){
								case 0:
									directCode.value=0;//仅乱码
								break;
								case 1:
									directCode.value=(int(Math.random()*0x7fffff)+1);//精灵挂掉
								break;
								case 2:
									directCode.value=-(int(Math.random()*0x800000)+1);//较大机率精灵挂掉
								break;
							}
						break;
						case "index u30 args u30":
							option=option[1];
							option=option[int(Math.random()*option.length)];
							directCode=new DirectCode(option[0]);
							codeV.splice(j++,0,directCode);
							directCode.value={};
							switch(option[1]){
								case 0:
									directCode.value.u30_1=0;
								break;
								case 1:
									directCode.value.u30_1=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
								break;
								case 2:
									directCode.value.u30_1=0x3fffffff;
								break;
							}
							switch(option[2]){
								case 0:
									directCode.value.u30_2=0;
								break;
								case 1:
									directCode.value.u30_2=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
								break;
								case 2:
									directCode.value.u30_2=0x3fffffff;
								break;
							}
						break;
						case "op":
							option=option[1];
							directCode=new DirectCode(option[int(Math.random()*option.length)]);
							codeV.splice(j++,0,directCode);
						break;
						/*
						case "special":
							option=option[1];
							var op:int=option[int(Math.random()*option.length)];
							switch(op){
								case Op.op_pushbyte:
									var code_byte:Code_Byte=new Code_Byte(int(Math.random()*0x100));
									code_byte.op=op;
									codeArr[codeArr.length]=code_byte;
								break;
								case Op.op_pushshort:
								case Op.op_debugline:
								case Op.op_bkptline:
									code_u30_direct=new Code_u30_Direct();
									code_u30_direct.op=op;
									//code_u30_direct.u30=0;
									//code_u30_direct.u30=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
									//code_u30_direct.u30=0x3fffffff;
									code_u30_direct.u30=int(Math.random()*0x10000);
									codeArr[codeArr.length]=code_u30_direct;
								break;
								case Op.op_lookupswitch:
									//没测试
								break;
								case Op.op_hasnext2:
									code_u30_u30_direct=new Code_u30_u30_Direct();
									code_u30_u30_direct.op=op;
									
									//code_u30_u30_direct.u30_1=0;
									//code_u30_u30_direct.u30_1=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
									//code_u30_u30_direct.u30_1=0x3fffffff;
									code_u30_u30_direct.u30_1=int(Math.random()*0x10000);
									
									//code_u30_u30_direct.u30_2=0;
									//code_u30_u30_direct.u30_2=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
									//code_u30_u30_direct.u30_2=0x3fffffff;
									code_u30_u30_direct.u30_2=int(Math.random()*0x10000);
									
									codeArr[codeArr.length]=code_u30_u30_direct;
								break;
								case Op.op_debug:
									var code_debug:Code_Debug=new Code_Debug();
									code_debug.op=op;
									code_debug.debug_type=int(Math.random()*0x100);
									//code_debug.string="";
									code_debug.reg=int(Math.random()*0x100);
									code_debug.extra=int(Math.random()*0x10000);
									codeArr[codeArr.length]=code_debug;
								break;
							}
							//*/
						break;
					}
					
					jump.value=new LabelMark();
					codeV.splice(j++,0,jump.value);
				}
			}
			
			DoABCWithoutFlagsAndName.setDecodeABC(null);
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