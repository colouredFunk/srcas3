/***
GetFWAd_ID 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月28日 19:51:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	import zero.swf.avm1.Op;
	import zero.swf.avm2.*;
	import zero.swf.avm2.advances.*;
	import zero.swf.vmarks.*;
	
	public class GetFWAd_ID{
		
		private static var FWAd_ID:String;
		
		public static function getFWAd_ID(gameSWF:SWF2):String{
			//自动搜索 FWAd_ID
			if(gameSWF.isAS3){
				FWAd_ID=null;
				Za7Za8.forEachTraits(
					gameSWF,
					null,
					null,
					_getFWAd_ID
				);
				if(FWAd_ID){
					return FWAd_ID;
				}
			}else{
				FWAd_ID=getFWAd_ID_from_doAction(gameSWF);
				if(FWAd_ID){
					return FWAd_ID;
				}
			}
			return null;
		}
		private static function _getFWAd_ID(
			clazz:AdvanceClass,
			traits_infoV:Vector.<AdvanceTraits_info>,
			id:int,
			traitsName:String
		):void{
			if(FWAd_ID){
				return;
			}
			var traits_info:AdvanceTraits_info=traits_infoV[id];
			if(traits_info.name.name=="FWAd_ID"){
				switch(traits_info.kind_trait_type){
					case TraitTypes.Slot:
					case TraitTypes.Const:
						if(traits_info.vkind==ConstantKind.Utf8){
							FWAd_ID=traits_info.vindex;
							trace(clazz.name.name+".FWAd_ID="+FWAd_ID);
						}
					break;
					case TraitTypes.Method:
					case TraitTypes.Getter:
					case TraitTypes.Setter:
					case TraitTypes.Function:
					case TraitTypes.Clazz:
						//
					break;
				}
			}
		}
		
		public static function getFWAd_ID_from_doAction(gameSWF:SWF2):String{
			var constantStrV:Vector.<String>;
			for each(var tag:Tag in gameSWF.tagV){
				if(tag.type==TagType.DoAction){
					constantStrV=null;
					var doActionData:ByteArray=tag.getBodyData();
					var offset:int=tag.bodyOffset;
					var endOffset:int=offset+tag.bodyLength;
					var strSize:int;
					var i:int;
					while(offset<endOffset){
						var op:int=doActionData[offset++];
						if(op<0x80){
						}else{
							var Length:int=doActionData[offset++]|(doActionData[offset++]<<8);
							var lastOffset:int=offset+Length;
							if(op==0x88){//constantPool
								constantStrV=new Vector.<String>();
								var total:int=doActionData[offset++]|(doActionData[offset++]<<8);
								for(i=0;i<total;i++){
									strSize=0;
									doActionData.position=offset;
									while(doActionData[offset++]){
										strSize++;
									}
									if(strSize){
										constantStrV[i]=doActionData.readUTFBytes(strSize);
									}else{
										constantStrV[i]="";
									}
								}
							}else if(op==0x96){//push
								//Field 			Type 					Comment
								//_push 		ACTIONRECORDHEADER 		ActionCode = 0x96
								//Type 				UI8 					0 = string literal
								//											1 = floating-point literal
								//											5 and later:
								//											2 = null
								//											3 = undefined
								//											4 = register
								//											5 = Boolean
								//											6 = double
								//											7 = integer
								//											8 = constant 8
								//											9 = constant 16
								//String 			If Type = 0, STRING 	Null-terminated character string
								//Float 			If Type = 1, FLOAT 		32-bit IEEE single-precision little-endian floating-point value
								//RegisterNumber 	If Type = 4, UI8 		Register number
								//Boolean 			If Type = 5, UI8 		Boolean value
								//Double 			If Type = 6, DOUBLE 	64-bit IEEE double-precision littleendian double value
								//Integer 			If Type = 7, UI32 		32-bit little-endian integer
								//Constant8 		If Type = 8, UI8 		Constant pool index (for indexes < 256) (see _constants)
								//Constant16 		If Type = 9, UI16 		Constant pool index (for indexes >= 256) (see _constants)
								var pushArr:Array=new Array();
								i=0;
								while(offset<lastOffset){
									switch(doActionData[offset++]){
										case 0://STRING
											strSize=0;
											doActionData.position=offset;
											while(doActionData[offset++]){
												strSize++;
											}
											if(strSize){
												pushArr[i]=doActionData.readUTFBytes(strSize);
											}else{
												pushArr[i]="";
											}
											break;
										case 1://FLOAT
											offset+=4;
											break;
										case 4://UI8
											offset++;
											break;
										case 5://UI8
											offset++;
											break;
										case 6://DOUBLE
											offset+=8;
											break;
										case 7://UI32
											offset+=4;
											break;
										case 8://UI8
											pushArr[i]=constantStrV[doActionData[offset++]];
											break;
										case 9://UI16
											pushArr[i]=constantStrV[doActionData[offset++]|(doActionData[offset++]<<8)];
											break;
									}
									i++;
								}
								//trace("pushArr="+pushArr);
								if(pushArr[i-2]=="FWAd_ID"){
									if(
										doActionData[offset]==0x3c//varEquals
										||
										doActionData[offset]==0x1d//setVariable
									){
										if(pushArr[i-1]){
											return pushArr[i-1];
										}
									}
								}
							}
							offset=lastOffset;
						}
					}
				}
			}
			return null;
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