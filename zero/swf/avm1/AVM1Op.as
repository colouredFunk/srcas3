/***
AVM1Op 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 15:11:36 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm1{

	public class AVM1Op{
		public static const end:int=0;//0x00
		//0x01//nop
		//0x02
		//0x03
		public static const nextFrame:int=4;//0x04
		public static const prevFrame:int=5;//0x05
		public static const play:int=6;//0x06
		public static const stop:int=7;//0x07
		public static const toggleQuality:int=8;//0x08
		public static const stopSounds:int=9;//0x09
		public static const oldAdd:int=10;//0x0a
		public static const subtract:int=11;//0x0b
		public static const multiply:int=12;//0x0c
		public static const divide:int=13;//0x0d
		public static const oldEquals:int=14;//0x0e
		public static const oldLessThan:int=15;//0x0f
		public static const and:int=16;//0x10
		public static const or:int=17;//0x11
		public static const not:int=18;//0x12
		public static const stringEq:int=19;//0x13
		public static const stringLength:int=20;//0x14
		public static const substring:int=21;//0x15
		//0x16
		public static const pop:int=23;//0x17
		public static const int_:int=24;//0x18
		//0x19
		//0x1a
		//0x1b
		public static const getVariable:int=28;//0x1c
		public static const setVariable:int=29;//0x1d
		//0x1e
		//0x1f
		public static const setTargetExpr:int=32;//0x20
		public static const concat:int=33;//0x21
		public static const getProperty:int=34;//0x22
		public static const setProperty:int=35;//0x23
		public static const duplicateClip:int=36;//0x24
		public static const removeClip:int=37;//0x25
		public static const trace_:int=38;//0x26
		public static const startDrag:int=39;//0x27
		public static const stopDrag:int=40;//0x28
		public static const stringLess:int=41;//0x29
		public static const throw_:int=42;//0x2a
		public static const cast:int=43;//0x2b
		public static const implements_:int=44;//0x2c
		public static const FSCommand2:int=45;//0x2d
		//0x2e
		//0x2f
		public static const random:int=48;//0x30
		public static const mBStringLength:int=49;//0x31
		public static const ord:int=50;//0x32
		public static const chr:int=51;//0x33
		public static const getTimer:int=52;//0x34
		public static const mbSubstring:int=53;//0x35
		public static const mbOrd:int=54;//0x36
		public static const mbChr:int=55;//0x37
		//0x38
		//0x39
		public static const delete_:int=58;//0x3a
		public static const delete2:int=59;//0x3b
		public static const varEquals:int=60;//0x3c
		public static const callFunction:int=61;//0x3d
		public static const return_:int=62;//0x3e
		public static const modulo:int=63;//0x3f
		public static const new_:int=64;//0x40
		public static const var_:int=65;//0x41
		public static const initArray:int=66;//0x42
		public static const initObject:int=67;//0x43
		public static const typeof_:int=68;//0x44
		public static const targetPath:int=69;//0x45
		public static const enumerate:int=70;//0x46
		public static const add:int=71;//0x47
		public static const lessThan:int=72;//0x48
		public static const equals:int=73;//0x49
		public static const toNumber:int=74;//0x4a
		public static const toString_:int=75;//0x4b
		public static const dup:int=76;//0x4c
		public static const swap:int=77;//0x4d
		public static const getMember:int=78;//0x4e
		public static const setMember:int=79;//0x4f
		public static const increment:int=80;//0x50
		public static const decrement:int=81;//0x51
		public static const callMethod:int=82;//0x52
		public static const newMethod:int=83;//0x53
		public static const instanceOf:int=84;//0x54
		public static const enumerateValue:int=85;//0x55
		//0x56
		//0x57
		//0x58
		//0x59
		//0x5a
		//0x5b
		//0x5c
		//0x5d
		//0x5e
		//0x5f
		public static const bitwiseAnd:int=96;//0x60
		public static const bitwiseOr:int=97;//0x61
		public static const bitwiseXor:int=98;//0x62
		public static const shiftLeft:int=99;//0x63
		public static const shiftRight:int=100;//0x64
		public static const shiftRight2:int=101;//0x65
		public static const strictEquals:int=102;//0x66
		public static const greaterThan:int=103;//0x67
		public static const stringGreater:int=104;//0x68
		public static const extends_:int=105;//0x69
		//0x6a
		//0x6b
		//0x6c
		//0x6d
		//0x6e
		//0x6f
		//0x70
		//0x71
		//0x72
		//0x73
		//0x74
		//0x75
		//0x76
		//0x77
		//0x78
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		//0x80
		public static const gotoFrame:int=129;//0x81
		//0x82
		public static const getURL:int=131;//0x83
		//0x84
		//0x85
		//0x86
		public static const setRegister:int=135;//0x87
		public static const constants:int=136;//0x88
		//0x89
		public static const ifFrameLoaded:int=138;//0x8a
		public static const setTarget:int=139;//0x8b
		public static const gotoLabel:int=140;//0x8c
		public static const ifFrameLoadedExpr:int=141;//0x8d
		public static const function2:int=142;//0x8e
		public static const try_:int=143;//0x8f
		//0x90
		//0x91
		//0x92
		//0x93
		public static const with_:int=148;//0x94
		//0x95
		public static const push:int=150;//0x96
		//0x97
		//0x98
		public static const branch:int=153;//0x99
		public static const getURL2:int=154;//0x9a
		public static const function_:int=155;//0x9b
		//0x9c
		public static const branchIfTrue:int=157;//0x9d
		public static const callFrame:int=158;//0x9e
		public static const gotoFrame2:int=159;//0x9f
		//0xa0
		//0xa1
		//0xa2
		//0xa3
		//0xa4
		//0xa5
		//0xa6
		//0xa7
		//0xa8
		//0xa9
		//0xaa
		//0xab
		//0xac
		//0xad
		//0xae
		//0xaf
		//0xb0
		//0xb1
		//0xb2
		//0xb3
		//0xb4
		//0xb5
		//0xb6
		//0xb7
		//0xb8
		//0xb9
		//0xba
		//0xbb
		//0xbc
		//0xbd
		//0xbe
		//0xbf
		//0xc0
		//0xc1
		//0xc2
		//0xc3
		//0xc4
		//0xc5
		//0xc6
		//0xc7
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		//0xd0
		//0xd1
		//0xd2
		//0xd3
		//0xd4
		//0xd5
		//0xd6
		//0xd7
		//0xd8
		//0xd9
		//0xda
		//0xdb
		//0xdc
		//0xdd
		//0xde
		//0xdf
		//0xe0
		//0xe1
		//0xe2
		//0xe3
		//0xe4
		//0xe5
		//0xe6
		//0xe7
		//0xe8
		//0xe9
		//0xea
		//0xeb
		//0xec
		//0xed
		//0xee
		//0xef
		//0xf0
		//0xf1
		//0xf2
		//0xf3
		//0xf4
		//0xf5
		//0xf6
		//0xf7
		//0xf8
		//0xf9
		//0xfa
		//0xfb
		//0xfc
		//0xfd
		//0xfe
		//0xff
		
		public static var ops:Object;
		public static const opNameV:Vector.<String>=get_opNameV();
		private static function get_opNameV():Vector.<String>{
			ops=new Object();
			var opNameV:Vector.<String>=new Vector.<String>(256);
			opNameV.fixed=true;
			opNameV[end]="end";
			ops["end"]=end;
			opNameV[nextFrame]="nextFrame";
			ops["nextFrame"]=nextFrame;
			opNameV[prevFrame]="prevFrame";
			ops["prevFrame"]=prevFrame;
			opNameV[play]="play";
			ops["play"]=play;
			opNameV[stop]="stop";
			ops["stop"]=stop;
			opNameV[toggleQuality]="toggleQuality";
			ops["toggleQuality"]=toggleQuality;
			opNameV[stopSounds]="stopSounds";
			ops["stopSounds"]=stopSounds;
			opNameV[oldAdd]="oldAdd";
			ops["oldAdd"]=oldAdd;
			opNameV[subtract]="subtract";
			ops["subtract"]=subtract;
			opNameV[multiply]="multiply";
			ops["multiply"]=multiply;
			opNameV[divide]="divide";
			ops["divide"]=divide;
			opNameV[oldEquals]="oldEquals";
			ops["oldEquals"]=oldEquals;
			opNameV[oldLessThan]="oldLessThan";
			ops["oldLessThan"]=oldLessThan;
			opNameV[and]="and";
			ops["and"]=and;
			opNameV[or]="or";
			ops["or"]=or;
			opNameV[not]="not";
			ops["not"]=not;
			opNameV[stringEq]="stringEq";
			ops["stringEq"]=stringEq;
			opNameV[stringLength]="stringLength";
			ops["stringLength"]=stringLength;
			opNameV[substring]="substring";
			ops["substring"]=substring;
			opNameV[pop]="pop";
			ops["pop"]=pop;
			opNameV[int_]="int_";
			ops["int_"]=int_;
			opNameV[getVariable]="getVariable";
			ops["getVariable"]=getVariable;
			opNameV[setVariable]="setVariable";
			ops["setVariable"]=setVariable;
			opNameV[setTargetExpr]="setTargetExpr";
			ops["setTargetExpr"]=setTargetExpr;
			opNameV[concat]="concat";
			ops["concat"]=concat;
			opNameV[getProperty]="getProperty";
			ops["getProperty"]=getProperty;
			opNameV[setProperty]="setProperty";
			ops["setProperty"]=setProperty;
			opNameV[duplicateClip]="duplicateClip";
			ops["duplicateClip"]=duplicateClip;
			opNameV[removeClip]="removeClip";
			ops["removeClip"]=removeClip;
			opNameV[trace_]="trace_";
			ops["trace_"]=trace_;
			opNameV[startDrag]="startDrag";
			ops["startDrag"]=startDrag;
			opNameV[stopDrag]="stopDrag";
			ops["stopDrag"]=stopDrag;
			opNameV[stringLess]="stringLess";
			ops["stringLess"]=stringLess;
			opNameV[throw_]="throw_";
			ops["throw_"]=throw_;
			opNameV[cast]="cast";
			ops["cast"]=cast;
			opNameV[implements_]="implements_";
			ops["implements_"]=implements_;
			opNameV[FSCommand2]="FSCommand2";
			ops["FSCommand2"]=FSCommand2;
			opNameV[random]="random";
			ops["random"]=random;
			opNameV[mBStringLength]="mBStringLength";
			ops["mBStringLength"]=mBStringLength;
			opNameV[ord]="ord";
			ops["ord"]=ord;
			opNameV[chr]="chr";
			ops["chr"]=chr;
			opNameV[getTimer]="getTimer";
			ops["getTimer"]=getTimer;
			opNameV[mbSubstring]="mbSubstring";
			ops["mbSubstring"]=mbSubstring;
			opNameV[mbOrd]="mbOrd";
			ops["mbOrd"]=mbOrd;
			opNameV[mbChr]="mbChr";
			ops["mbChr"]=mbChr;
			opNameV[delete_]="delete_";
			ops["delete_"]=delete_;
			opNameV[delete2]="delete2";
			ops["delete2"]=delete2;
			opNameV[varEquals]="varEquals";
			ops["varEquals"]=varEquals;
			opNameV[callFunction]="callFunction";
			ops["callFunction"]=callFunction;
			opNameV[return_]="return_";
			ops["return_"]=return_;
			opNameV[modulo]="modulo";
			ops["modulo"]=modulo;
			opNameV[new_]="new_";
			ops["new_"]=new_;
			opNameV[var_]="var_";
			ops["var_"]=var_;
			opNameV[initArray]="initArray";
			ops["initArray"]=initArray;
			opNameV[initObject]="initObject";
			ops["initObject"]=initObject;
			opNameV[typeof_]="typeof_";
			ops["typeof_"]=typeof_;
			opNameV[targetPath]="targetPath";
			ops["targetPath"]=targetPath;
			opNameV[enumerate]="enumerate";
			ops["enumerate"]=enumerate;
			opNameV[add]="add";
			ops["add"]=add;
			opNameV[lessThan]="lessThan";
			ops["lessThan"]=lessThan;
			opNameV[equals]="equals";
			ops["equals"]=equals;
			opNameV[toNumber]="toNumber";
			ops["toNumber"]=toNumber;
			opNameV[toString_]="toString_";
			ops["toString_"]=toString_;
			opNameV[dup]="dup";
			ops["dup"]=dup;
			opNameV[swap]="swap";
			ops["swap"]=swap;
			opNameV[getMember]="getMember";
			ops["getMember"]=getMember;
			opNameV[setMember]="setMember";
			ops["setMember"]=setMember;
			opNameV[increment]="increment";
			ops["increment"]=increment;
			opNameV[decrement]="decrement";
			ops["decrement"]=decrement;
			opNameV[callMethod]="callMethod";
			ops["callMethod"]=callMethod;
			opNameV[newMethod]="newMethod";
			ops["newMethod"]=newMethod;
			opNameV[instanceOf]="instanceOf";
			ops["instanceOf"]=instanceOf;
			opNameV[enumerateValue]="enumerateValue";
			ops["enumerateValue"]=enumerateValue;
			opNameV[bitwiseAnd]="bitwiseAnd";
			ops["bitwiseAnd"]=bitwiseAnd;
			opNameV[bitwiseOr]="bitwiseOr";
			ops["bitwiseOr"]=bitwiseOr;
			opNameV[bitwiseXor]="bitwiseXor";
			ops["bitwiseXor"]=bitwiseXor;
			opNameV[shiftLeft]="shiftLeft";
			ops["shiftLeft"]=shiftLeft;
			opNameV[shiftRight]="shiftRight";
			ops["shiftRight"]=shiftRight;
			opNameV[shiftRight2]="shiftRight2";
			ops["shiftRight2"]=shiftRight2;
			opNameV[strictEquals]="strictEquals";
			ops["strictEquals"]=strictEquals;
			opNameV[greaterThan]="greaterThan";
			ops["greaterThan"]=greaterThan;
			opNameV[stringGreater]="stringGreater";
			ops["stringGreater"]=stringGreater;
			opNameV[extends_]="extends_";
			ops["extends_"]=extends_;
			opNameV[gotoFrame]="gotoFrame";
			ops["gotoFrame"]=gotoFrame;
			opNameV[getURL]="getURL";
			ops["getURL"]=getURL;
			opNameV[setRegister]="setRegister";
			ops["setRegister"]=setRegister;
			opNameV[constants]="constants";
			ops["constants"]=constants;
			opNameV[ifFrameLoaded]="ifFrameLoaded";
			ops["ifFrameLoaded"]=ifFrameLoaded;
			opNameV[setTarget]="setTarget";
			ops["setTarget"]=setTarget;
			opNameV[gotoLabel]="gotoLabel";
			ops["gotoLabel"]=gotoLabel;
			opNameV[ifFrameLoadedExpr]="ifFrameLoadedExpr";
			ops["ifFrameLoadedExpr"]=ifFrameLoadedExpr;
			opNameV[function2]="function2";
			ops["function2"]=function2;
			opNameV[try_]="try_";
			ops["try_"]=try_;
			opNameV[with_]="with_";
			ops["with_"]=with_;
			opNameV[push]="push";
			ops["push"]=push;
			opNameV[branch]="branch";
			ops["branch"]=branch;
			opNameV[getURL2]="getURL2";
			ops["getURL2"]=getURL2;
			opNameV[function_]="function_";
			ops["function_"]=function_;
			opNameV[branchIfTrue]="branchIfTrue";
			ops["branchIfTrue"]=branchIfTrue;
			opNameV[callFrame]="callFrame";
			ops["callFrame"]=callFrame;
			opNameV[gotoFrame2]="gotoFrame2";
			ops["gotoFrame2"]=gotoFrame2;
			return opNameV;
		}
		
		////
		//

	}
}