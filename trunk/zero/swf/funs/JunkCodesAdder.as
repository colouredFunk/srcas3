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
		private static const options:Array=[
			[
				"index u30",
				[
					[108,0],
					[108,1],
					[101,1],
					[90,0],
					[88,1]
				]
			],[
				"branch",
				[
					[26,1],
					[26,2],
					[25,1],
					[25,2],
					[24,1],
					[24,2],
					[23,1],
					[23,2],
					[22,1],
					[22,2],
					[21,1],
					[21,2],
					[20,1],
					[20,2],
					[19,1],
					[19,2],
					[18,1],
					[18,2],
					[17,1],
					[17,2],
					[16,1],
					[16,2],
					[15,1],
					[15,2],
					[14,1],
					[14,2],
					[13,1],
					[13,2],
					[12,1],
					[12,2]
				]
			],[
				"args u30",
				[
					[86,1],
					[85,1],
					[83,1],
					[73,1],
					[66,1],
					[65,1]
				]
			],[
				"index u30 args u30",
				[
					[68,1,0],
					[67,1,0],
					[79,0,1],
					[79,1,1],
					[78,0,1],
					[78,1,1],
					[76,0,1],
					[76,1,1],
					[74,0,1],
					[74,1,1],
					[70,0,1],
					[70,1,1],
					[69,0,1],
					[69,1,1],
					[68,0,1],
					[68,1,1],
					[67,0,1],
					[67,1,1]
				]
			]
		];
		public static function addJunkCodes(swf:SWF2):void{
			DoABCWithoutFlagsAndName.setDecodeABC(AdvanceABC);
			
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagType.DoABC:
					case TagType.DoABCWithoutFlagsAndName:
						var advanceABC:AdvanceABC=(tag.getBody() as DoABCWithoutFlagsAndName).abc as AdvanceABC
						for each(var clazz:AdvanceClass in advanceABC.clazzV){
							addJunkCodesToCodeV(clazz.iinit);
							addJunkCodesToTraitss(clazz.itraits_infoV);
							addJunkCodesToCodeV(clazz.cinit);
							addJunkCodesToTraitss(clazz.ctraits_infoV);
						}
						for each(var script_info:AdvanceScript_info in advanceABC.script_infoV){
							addJunkCodesToCodeV(script_info.init);
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
						addJunkCodesToCodeV(traits_info.methodi);
					break;
					case TraitTypes.Function:
						addJunkCodesToCodeV(traits_info.functioni);
					break;
					case TraitTypes.Clazz:
					break;
				}
			}
		}
		private static function addJunkCodesToCodeV(method:AdvanceMethod):void{
			if(method.codes){
				
			}else{
				return;
			}
			
			var codeArr:Array=method.codes.codeArr;
			
			var L:int=codeArr.length;
			if(L<4){
				return;
			}
			
			var i:int=L-1;//不能 jump 到句子后面，否则播放器报错：VerifyError: Error #1020: 代码不能超出方法结尾。
			
			var idArr:Array=getIdArr(20,i);
			
			//trace("codes.codeArr.length="+codes.codeArr.length);
			
			while(--i>0){
				if(idArr[i]){
					if(codeArr[i]===Op.label){
						continue;
					}
					var j:int=i;
					
					var jumpCode:Code;
					
					switch(1){
						case 0:
							//codes.codeArr.splice(j++,0,Op.getlocal0);
							codeArr.splice(j++,0,Op.pushtrue);
							jumpCode=new Code(Op.iftrue);
							codeArr.splice(j++,0,jumpCode);
							
							/*
							codeArr.splice(j++,0,[
								Op.pushtrue,
								Op.throw_
							]);
							//*/
							
							/*
							var jumpBackLabel:LabelMark=new LabelMark();
							codeArr.splice(j++,0,jumpBackLabel);
							codeArr.splice(j++,0,Op.label);
							codeArr.splice(j++,0,new Code(Op.jump,jumpBackLabel));
							//*/
							
							///*
							codeArr.splice(j++,0,[
								Op.newclass,0
							]);
							//*/
							
							jumpCode.value=new LabelMark();
							codeArr.splice(j++,0,jumpCode.value);
						break;
						case 1:
							jumpCode=new Code(Op.jump);
							codeArr.splice(j++,0,jumpCode);
							var ran:int=(Math.random()*3)+1;
							while(--ran>=0){
								var option:Array=options[int(Math.random()*options.length)];
								switch(option[0]){
									case "index u30":
									case "args u30":
										option=option[1];
										option=option[int(Math.random()*option.length)];
										
										/*
										directCode=new DirectCode(option[0]);
										codes.codeArr.splice(j++,0,directCode);
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
										*/
										
										codeArr.splice(
											j++,
											0,
											[option[0],int(0x80*Math.random())]
										);
									break;
									case "branch":
										option=option[1];
										option=option[int(Math.random()*option.length)];
										
										/*
										directCode=new DirectCode(option[0]);
										codes.codeArr.splice(j++,0,directCode);
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
										*/
										
										codeArr.splice(
											j++,
											0,
											[option[0],int(0x80*Math.random()),int(0x100*Math.random()),int(0x100*Math.random())]
										);
									break;
									case "index u30 args u30":
										option=option[1];
										option=option[int(Math.random()*option.length)];
										
										/*
										directCode=new DirectCode(option[0]);
										codes.codeArr.splice(j++,0,directCode);
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
										*/
										
										codeArr.splice(
											j++,
											0,
											[option[0],int(0x80*Math.random()),int(0x80*Math.random())]
										);
									break;
									case "op":
										option=option[1];
										
										/*
										directCode=new DirectCode(option[int(Math.random()*option.length)]);
										codes.codeArr.splice(j++,0,directCode);
										*/
										
										codeArr.splice(
											j++,
											0,
											option[int(Math.random()*option.length)]
										);
										
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
									break;
									//*/
								}
							}
							
							jumpCode.value=new LabelMark();
							codeArr.splice(j++,0,jumpCode.value);
						break;
					}
				}
			}
			
			//trace("codes.codeArr.length="+codes.codeArr.length+"---------");
			
			method.max_stack++;
			
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