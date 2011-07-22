/***
AddJunkCodes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年7月23日 18:31:18
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.Dictionary;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	import zero.swf.tagBodys.*;

	public class AddJunkCodes{
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
		private static const ifCodeArr:Array=[AVM2Ops.ifnlt,AVM2Ops.ifnle,AVM2Ops.ifngt,AVM2Ops.ifnge,AVM2Ops.ifeq,AVM2Ops.ifne,AVM2Ops.iflt,AVM2Ops.ifle,AVM2Ops.ifgt,AVM2Ops.ifge,AVM2Ops.ifstricteq,AVM2Ops.ifstrictne];
		
		private var dict:Dictionary;
		public function AddJunkCodes(){
			dict=new Dictionary();
		}
		public function add(swf:SWF):void{
			var ABCData:ABCClasses;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(DoABC,{ABCDataClass:ABCClasses}).ABCData;
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCClasses}).ABCData;
					break;
					default:
						ABCData=null;
					break;
				}
				if(ABCData){
					for each(var clazz:ABCClass in ABCData.classV){
						addJunkCodesToCodeV(clazz.iinit);
						addJunkCodesToTraits(clazz.itraitV);
						addJunkCodesToCodeV(clazz.cinit);
						addJunkCodesToTraits(clazz.ctraitV);
					}
					for each(var script:ABCScript in ABCData.scriptV){
						addJunkCodesToCodeV(script.init);
						addJunkCodesToTraits(script.traitV);
					}
				}
			}
		}
		private function addJunkCodesToTraits(traitV:Vector.<ABCTrait>):void{
			for each(var trait:ABCTrait in traitV){
				//trace(TraitTypes.typeV[traits_info.kind_trait_type]);
				switch(trait.kind_trait_type){
					case TraitTypeAndAttributes.Slot:
					case TraitTypeAndAttributes.Const:
					break;
					case TraitTypeAndAttributes.Method:
					case TraitTypeAndAttributes.Getter:
					case TraitTypeAndAttributes.Setter:
						addJunkCodesToCodeV(trait.method);
					break;
					case TraitTypeAndAttributes.Function_:
						addJunkCodesToCodeV(trait.function_);
					break;
					case TraitTypeAndAttributes.Class_:
					break;
				}
			}
		}
		
		private function addJunkCodesToCodeV(method:ABCMethod):void{
			if(method.codes){
				
			}else{
				return;
			}
			
			var codeArr:Array=method.codes.codeArr;
			
			var L:int=codeArr.length;
			if(L<7){
				return;
			}
			
			if(dict[method.codes]){
				trace("重复添加垃圾代码");
				return;
			}
			dict[method.codes]=true;
			
			var i:int=L-1;//不能 jump 到句子后面，否则播放器报错：VerifyError: Error #1020: 代码不能超出方法结尾。
			
			var idMarkV:Vector.<Boolean>=ZeroCommon.getIdMarkV(5,i);
			
			//trace("codes.codeArr.length="+codes.codeArr.length);
			
			var ran:int;
			
			while(--i>0){
				if(idMarkV[i]){
					if(codeArr[i]===AVM2Ops.label){
						continue;
					}
					var j:int=i;
					
					var jumpCode:Code;
					
					switch(int(Math.random()*4)){
						case 0:
						case 1:
						case 2:
							//pushtrue
							codeArr.splice(j++,0,getPushTrue());
							
							//执行一个操作，但维持为true
							switch(int(Math.random()*4)){
								case 0:
								break;
								case 1:
									//typeof(任何值)==一个有效的字符串
									codeArr.splice(j++,0,AVM2Ops.typeof_);
								break;
								case 2:
									codeArr.splice(j++,0,AVM2Ops.convert_b);
								break;
								case 3:
									codeArr.splice(j++,0,AVM2Ops.coerce_b);
								break;
							}
							
							//iftrue
							switch(int(Math.random()*2)){
								case 0:
									jumpCode=new Code(AVM2Ops.iftrue);
								break;
								case 1:
									codeArr.splice(j++,0,AVM2Ops.not);
									jumpCode=new Code(AVM2Ops.iffalse);
								break;
								
							}
							codeArr.splice(j++,0,jumpCode);
							
							//扰码
							ran=(Math.random()*3)+1;
							while(--ran>=0){
								switch(int(Math.random()*3)){
								//switch(2){
									case 0:
										codeArr.splice(j++,0,getPushTrue());
										codeArr.splice(j++,0,getPop());
									break;
									case 1:
										codeArr.splice(
											j++,
											0,
											getLookUpSwitch()
										);
									break;
									case 2:
										var junkLabelMark:LabelMark=new LabelMark(0);
										//codeArr.splice(j++,0,junkLabelMark);
										//codeArr.splice(j++,0,AVM2Ops.label);
										var junkJumpCode:Code;
										if(Math.random()<0.1){
											junkJumpCode=new Code(AVM2Ops.jump,junkLabelMark);
											codeArr.splice(j++,0,junkJumpCode);
										}else{
											codeArr.splice(j++,0,getPushTrue());
											codeArr.splice(j++,0,getPushTrue());
											junkJumpCode=new Code(
												ifCodeArr[int(Math.random()*ifCodeArr.length)],
												junkLabelMark
											);
											codeArr.splice(j++,0,junkJumpCode);
										}
										codeArr.splice(j++,0,junkLabelMark);
									break;
								}
							}
							
							jumpCode.value=new LabelMark(0);
							codeArr.splice(j++,0,jumpCode.value);

						break;
						case 3:
							jumpCode=new Code(AVM2Ops.jump);
							codeArr.splice(j++,0,jumpCode);
							ran=(Math.random()*3)+1;
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
											case AVM2Ops.op_pushbyte:
												var code_byte:Code_Byte=new Code_Byte(int(Math.random()*0x100)-0x80);
												code_byte.op=op;
												codeArr[codeArr.length]=code_byte;
											break;
											case AVM2Ops.op_pushshort:
											case AVM2Ops.op_debugline:
											case AVM2Ops.op_bkptline:
												code_u30_direct=new Code_u30_Direct();
												code_u30_direct.op=op;
												//code_u30_direct.u30=0;
												//code_u30_direct.u30=int(Math.random()*0xffff)+1;//uint(Math.random()*0x40000000);最大可以到 (0x3f ff ff ff)
												//code_u30_direct.u30=0x3fffffff;
												code_u30_direct.u30=int(Math.random()*0x10000);
												codeArr[codeArr.length]=code_u30_direct;
											break;
											case AVM2Ops.op_lookupswitch:
												//没测试
											break;
											case AVM2Ops.op_hasnext2:
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
											case AVM2Ops.op_debug:
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
							
							jumpCode.value=new LabelMark(0);
							codeArr.splice(j++,0,jumpCode.value);
						break;
					}
				}
			}
			
			//trace("codes.codeArr.length="+codes.codeArr.length+"---------");
			
			method.max_stack+=4;
		}
		private function getPushTrue():*{
			var num1:int,num2:int;
			switch(int(Math.random()*11)){
				case 0:
					return AVM2Ops.pushtrue;
				break;
				case 1:
					return [AVM2Ops.pushfalse,AVM2Ops.not];
				break;
				case 2:
					return AVM2Ops.getlocal0;
				break;
				case 3:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*0x100)-0x80;if(num1^num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.bitxor];
				break;
				case 4:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*0x100)-0x80;if(num1&num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.bitand];
				break;
				case 5:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*0x100)-0x80;if(num1|num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.bitor];
				break;
				case 6:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*0x100)-0x80;if(num1+num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.add_i];
				break;
				case 7:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*0x100)-0x80;if(num1-num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.subtract_i];
				break;
				case 8:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*4);if(num1<<num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.lshift];
				break;
				case 9:
					while(true){num1=int(Math.random()*0x100)-0x80;num2=int(Math.random()*4);if(num1>>num2){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.pushbyte,num2,AVM2Ops.rshift];
				break;
				case 10:
					while(true){num1=int(Math.random()*0x100)-0x80;if(~num1){break;}}
					return [AVM2Ops.pushbyte,num1,AVM2Ops.bitnot];
				break;
			}
			return null;
		}
		private function getPop():*{
			switch(int(Math.random()*5)){
				case 0:
					return AVM2Ops.pop;
				break;
				case 1:
					return AVM2Ops.throw_;
				break;
				case 2:
					return [AVM2Ops.iftrue,0x00,0x00,0x00];
				break;
				case 3:
					return [AVM2Ops.iffalse,0x00,0x00,0x00];
				break;
				case 4:
					return AVM2Ops.returnvalue;
				break;
			}
			return null;
		}
		private function getLookUpSwitch():Array{
			var arr:Array=[
				AVM2Ops.pushbyte,int(Math.random()*0x100)-0x80,
				AVM2Ops.lookupswitch
			]
			var case_count:int=int(Math.random()*2)+1;
			var offset:int=1+3+1+3*(case_count+1);
			arr.push(offset,0x00,0x00);
			arr.push(case_count);
			while(--case_count>=0){
				arr.push(offset,0x00,0x00);
			}
			arr.push(offset,0x00,0x00);
			return arr;
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