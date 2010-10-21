/***
Op 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月28日 08:47:52
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2.codes{
	import flash.utils.ByteArray;

	public class Op{
		/*
		public static function getCodes():void{
			import _swf.Comm;
			var arr:Array=new Array();
			for each(var node:XML in op_xml.children()){
				arr[int(node.@Forms.toString())]=node.name();
			}
			for(var i:int=0;i<256;i++){
				var _16Str:String=(i<16?"0x0":"0x")+i.toString(16);
				if(arr[i]){
					trace("		public static const op_"+arr[i]+":int="+_16Str+";");
				}else{
					trace("		//"+_16Str);
				}
				arr[i]=arr[i]?("\t\""+arr[i]+"\""):"\t\"\"";
			}
			trace("		public static const op_v:Vector.<String>=Vector.<String>(["+arr+"]);");
		}
		*/
		
		//0x00//"arg"
		public static const op_bkpt:int=0x01;
		public static const op_nop:int=0x02;
		public static const op_throw:int=0x03;
		public static const op_getsuper:int=0x04;
		public static const op_setsuper:int=0x05;
		public static const op_dxns:int=0x06;
		public static const op_dxnslate:int=0x07;
		public static const op_kill:int=0x08;
		public static const op_label:int=0x09;
		//0x0a//"phi"
		//0x0b//"xarg"
		public static const op_ifnlt:int=0x0c;
		public static const op_ifnle:int=0x0d;
		public static const op_ifngt:int=0x0e;
		public static const op_ifnge:int=0x0f;
		public static const op_jump:int=0x10;
		public static const op_iftrue:int=0x11;
		public static const op_iffalse:int=0x12;
		public static const op_ifeq:int=0x13;
		public static const op_ifne:int=0x14;
		public static const op_iflt:int=0x15;
		public static const op_ifle:int=0x16;
		public static const op_ifgt:int=0x17;
		public static const op_ifge:int=0x18;
		public static const op_ifstricteq:int=0x19;
		public static const op_ifstrictne:int=0x1a;
		public static const op_lookupswitch:int=0x1b;
		public static const op_pushwith:int=0x1c;
		public static const op_popscope:int=0x1d;
		public static const op_nextname:int=0x1e;
		public static const op_hasnext:int=0x1f;
		public static const op_pushnull:int=0x20;
		public static const op_pushundefined:int=0x21;
		//public static const op_pushconstant:int=0x22;
		public static const op_nextvalue:int=0x23;
		public static const op_pushbyte:int=0x24;
		public static const op_pushshort:int=0x25;
		public static const op_pushtrue:int=0x26;
		public static const op_pushfalse:int=0x27;
		public static const op_pushnan:int=0x28;
		public static const op_pop:int=0x29;
		public static const op_dup:int=0x2a;
		public static const op_swap:int=0x2b;
		public static const op_pushstring:int=0x2c;
		public static const op_pushint:int=0x2d;
		public static const op_pushuint:int=0x2e;
		public static const op_pushdouble:int=0x2f;
		public static const op_pushscope:int=0x30;
		public static const op_pushnamespace:int=0x31;
		public static const op_hasnext2:int=0x32;
		//0x33//"hasnext2_i"
		//0x34//"hasnext2_o"
		public static const op_li8:int=0x35;
		public static const op_li16:int=0x36;
		public static const op_li32:int=0x37;
		public static const op_lf32:int=0x38;
		public static const op_lf64:int=0x39;
		public static const op_si8:int=0x3a;
		public static const op_si16:int=0x3b;
		public static const op_si32:int=0x3c;
		public static const op_sf32:int=0x3d;
		public static const op_sf64:int=0x3e;
		//0x3f
		public static const op_newfunction:int=0x40;
		public static const op_call:int=0x41;
		public static const op_construct:int=0x42;
		public static const op_callmethod:int=0x43;
		public static const op_callstatic:int=0x44;
		public static const op_callsuper:int=0x45;
		public static const op_callproperty:int=0x46;
		public static const op_returnvoid:int=0x47;
		public static const op_returnvalue:int=0x48;
		public static const op_constructsuper:int=0x49;
		public static const op_constructprop:int=0x4a;
		//public static const op_callsuperid:int=0x4b;
		public static const op_callproplex:int=0x4c;
		//public static const op_callinterface:int=0x4d;
		public static const op_callsupervoid:int=0x4e;
		public static const op_callpropvoid:int=0x4f;
		public static const op_sxi1:int=0x50;
		public static const op_sxi8:int=0x51;
		public static const op_sxi16:int=0x52;
		public static const op_applytype:int=0x53;
		//0x54
		public static const op_newobject:int=0x55;
		public static const op_newarray:int=0x56;
		public static const op_newactivation:int=0x57;
		public static const op_newclass:int=0x58;
		public static const op_getdescendants:int=0x59;
		public static const op_newcatch:int=0x5a;
		//0x5b
		//0x5c
		public static const op_findpropstrict:int=0x5d;
		public static const op_findproperty:int=0x5e;
		public static const op_finddef:int=0x5f;
		public static const op_getlex:int=0x60;
		public static const op_setproperty:int=0x61;
		public static const op_getlocal:int=0x62;
		public static const op_setlocal:int=0x63;
		public static const op_getglobalscope:int=0x64;
		public static const op_getscopeobject:int=0x65;
		public static const op_getproperty:int=0x66;
		//public static const op_getpropertylate:int=0x67;
		public static const op_initproperty:int=0x68;
		//public static const op_setpropertylate:int=0x69;
		public static const op_deleteproperty:int=0x6a;
		//public static const op_deletepropertylate:int=0x6b;
		public static const op_getslot:int=0x6c;
		public static const op_setslot:int=0x6d;
		public static const op_getglobalslot:int=0x6e;
		public static const op_setglobalslot:int=0x6f;
		public static const op_convert_s:int=0x70;
		public static const op_esc_xelem:int=0x71;
		public static const op_esc_xattr:int=0x72;
		public static const op_convert_i:int=0x73;
		public static const op_convert_u:int=0x74;
		public static const op_convert_d:int=0x75;
		public static const op_convert_b:int=0x76;
		public static const op_convert_o:int=0x77;
		public static const op_checkfilter:int=0x78;
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		public static const op_coerce:int=0x80;
		public static const op_coerce_b:int=0x81;
		public static const op_coerce_a:int=0x82;
		public static const op_coerce_i:int=0x83;
		public static const op_coerce_d:int=0x84;
		public static const op_coerce_s:int=0x85;
		public static const op_astype:int=0x86;
		public static const op_astypelate:int=0x87;
		public static const op_coerce_u:int=0x88;
		public static const op_coerce_o:int=0x89;
		//0x8a
		//0x8b
		//0x8c
		//0x8d
		//0x8e
		//0x8f
		public static const op_negate:int=0x90;
		public static const op_increment:int=0x91;
		public static const op_inclocal:int=0x92;
		public static const op_decrement:int=0x93;
		public static const op_declocal:int=0x94;
		public static const op_typeof:int=0x95;
		public static const op_not:int=0x96;
		public static const op_bitnot:int=0x97;
		//0x98
		//0x99
		//public static const op_concat:int=0x9a;
		//public static const op_add_d:int=0x9b;
		//0x9c
		//0x9d
		//0x9e
		//0x9f
		public static const op_add:int=0xa0;
		public static const op_subtract:int=0xa1;
		public static const op_multiply:int=0xa2;
		public static const op_divide:int=0xa3;
		public static const op_modulo:int=0xa4;
		public static const op_lshift:int=0xa5;
		public static const op_rshift:int=0xa6;
		public static const op_urshift:int=0xa7;
		public static const op_bitand:int=0xa8;
		public static const op_bitor:int=0xa9;
		public static const op_bitxor:int=0xaa;
		public static const op_equals:int=0xab;
		public static const op_strictequals:int=0xac;
		public static const op_lessthan:int=0xad;
		public static const op_lessequals:int=0xae;
		public static const op_greaterthan:int=0xaf;
		public static const op_greaterequals:int=0xb0;
		public static const op_instanceof:int=0xb1;
		public static const op_istype:int=0xb2;
		public static const op_istypelate:int=0xb3;
		public static const op_in:int=0xb4;
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
		public static const op_increment_i:int=0xc0;
		public static const op_decrement_i:int=0xc1;
		public static const op_inclocal_i:int=0xc2;
		public static const op_declocal_i:int=0xc3;
		public static const op_negate_i:int=0xc4;
		public static const op_add_i:int=0xc5;
		public static const op_subtract_i:int=0xc6;
		public static const op_multiply_i:int=0xc7;
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		public static const op_getlocal0:int=0xd0;
		public static const op_getlocal1:int=0xd1;
		public static const op_getlocal2:int=0xd2;
		public static const op_getlocal3:int=0xd3;
		public static const op_setlocal0:int=0xd4;
		public static const op_setlocal1:int=0xd5;
		public static const op_setlocal2:int=0xd6;
		public static const op_setlocal3:int=0xd7;
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
		//public static const op_abs_jump:int=0xee;
		public static const op_debug:int=0xef;
		public static const op_debugline:int=0xf0;
		public static const op_debugfile:int=0xf1;
		public static const op_bkptline:int=0xf2;
		public static const op_timestamp:int=0xf3;
		//0xf4
		//public static const op_verifypass:int=0xf5;
		//public static const op_alloc:int=0xf6;
		//public static const op_mark:int=0xf7;
		//public static const op_wb:int=0xf8;
		//public static const op_prologue:int=0xf9;
		//public static const op_sendenter:int=0xfa;
		//public static const op_doubletoatom:int=0xfb;
		//public static const op_sweep:int=0xfc;
		//public static const op_codegenop:int=0xfd;
		//public static const op_verifyop:int=0xfe;
		//public static const op_decode:int=0xff;
		public static const op_v:Vector.<String>=Vector.<String>([	"",	"bkpt",	"nop",	"throw",	"getsuper",	"setsuper",	"dxns",	"dxnslate",	"kill",	"label",	"",	"",	"ifnlt",	"ifnle",	"ifngt",	"ifnge",	"jump",	"iftrue",	"iffalse",	"ifeq",	"ifne",	"iflt",	"ifle",	"ifgt",	"ifge",	"ifstricteq",	"ifstrictne",	"lookupswitch",	"pushwith",	"popscope",	"nextname",	"hasnext",	"pushnull",	"pushundefined",	"",	"nextvalue",	"pushbyte",	"pushshort",	"pushtrue",	"pushfalse",	"pushnan",	"pop",	"dup",	"swap",	"pushstring",	"pushint",	"pushuint",	"pushdouble",	"pushscope",	"pushnamespace",	"hasnext2",	"",	"",	"li8","li16","li32","lf32","lf64","si8","si16","si32","sf32","sf64",	"",	"newfunction",	"call",	"construct",	"callmethod",	"callstatic",	"callsuper",	"callproperty",	"returnvoid",	"returnvalue",	"constructsuper",	"constructprop",	"",	"callproplex",	"",	"callsupervoid",	"callpropvoid",	"sxi1","sxi8","sxi16",	"applytype",	"",	"newobject",	"newarray",	"newactivation",	"newclass",	"getdescendants",	"newcatch",	"",	"",	"findpropstrict",	"findproperty",	"finddef",	"getlex",	"setproperty",	"getlocal",	"setlocal",	"getglobalscope",	"getscopeobject",	"getproperty",	"",	"initproperty",	"",	"deleteproperty",	"",	"getslot",	"setslot",	"getglobalslot",	"setglobalslot",	"convert_s",	"esc_xelem",	"esc_xattr",	"convert_i",	"convert_u",	"convert_d",	"convert_b",	"convert_o",	"checkfilter",	"",	"",	"",	"",	"",	"",	"",	"coerce",	"coerce_b",	"coerce_a",	"coerce_i",	"coerce_d",	"coerce_s",	"astype",	"astypelate",	"coerce_u",	"coerce_o",	"",	"",	"",	"",	"",	"",	"negate",	"increment",	"inclocal",	"decrement",	"declocal",	"typeof",	"not",	"bitnot",	"",	"",	"",	"",	"",	"",	"",	"",	"add",	"subtract",	"multiply",	"divide",	"modulo",	"lshift",	"rshift",	"urshift",	"bitand",	"bitor",	"bitxor",	"equals",	"strictequals",	"lessthan",	"lessequals",	"greaterthan",	"greaterequals",	"instanceof",	"istype",	"istypelate",	"in",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"increment_i",	"decrement_i",	"inclocal_i",	"declocal_i",	"negate_i",	"add_i",	"subtract_i",	"multiply_i",	"",	"",	"",	"",	"",	"",	"",	"",	"getlocal0",	"getlocal1",	"getlocal2",	"getlocal3",	"setlocal0",	"setlocal1",	"setlocal2",	"setlocal3",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"debug",	"debugline",	"debugfile",	"bkptline",	"timestamp",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	""]);
		
		/*
		private static const allCodes:Vector.<String>=Vector.<String>([
			'//00',
			'_as3_OP_0x00',
			'//01',
			'_as3_bkpt',
			'//02',
			'_as3_nop',
			'//03',
			'_as3_throw',
			'//04 01',
			'_as3_getsuper',
			'//05 01',
			'_as3_setsuper',
			'//06 00',
			'_as3_dxns',
			'//07',
			'_as3_dxnslate',
			'//08 00',
			'_as3_kill <0>',
			'//09',
			'_as3_label',
			'//0a',
			'_as3_OP_0x0A',
			'//0b',
			'_as3_OP_0x0B',
			'//0c 00 00 00',
			'_as3_ifnlt offset: 0',
			'//0d 00 00 00',
			'_as3_ifnle offset: 0',
			'//0e 00 00 00',
			'_as3_ifngt offset: 0',
			'//0f 00 00 00',
			'_as3_ifnge offset: 0',
			'//10 00 00 00',
			'_as3_jump offset: 0',
			'//11 00 00 00',
			'_as3_iftrue offset: 0',
			'//12 00 00 00',
			'_as3_iffalse offset: 0',
			'//13 00 00 00',
			'_as3_ifeq offset: 0',
			'//14 00 00 00',
			'_as3_ifne offset: 0',
			'//15 00 00 00',
			'_as3_iflt offset: 0',
			'//16 00 00 00',
			'_as3_ifle offset: 0',
			'//17 00 00 00',
			'_as3_ifgt offset: 0',
			'//18 00 00 00',
			'_as3_ifge offset: 0',
			'//19 00 00 00',
			'_as3_ifstricteq offset: 0',
			'//1a 00 00 00',
			'_as3_ifstrictne offset: 0',
			'//1b 00 00 00 00 00 00 00',
			'_as3_lookupswitch 0(0)[0]',
			'//1c',
			'_as3_pushwith',
			'//1d',
			'_as3_popscope',
			'//1e',
			'_as3_nextname',
			'//1f',
			'_as3_hasnext',
			'//20',
			'_as3_pushnull',
			'//21',
			'_as3_pushundefined',
			'//22 00',
			'_as3_OP_0x22 (op_pushconstant) //bad "不合法的 op: 0x22" //bad "不合法的 op: 0x00"',
			'//23',
			'_as3_nextvalue',
			'//24 00',
			'_as3_pushbyte 0',
			'//25 00',
			'_as3_pushshort 0',
			'//26',
			'_as3_pushtrue',
			'//27',
			'_as3_pushfalse',
			'//28',
			'_as3_pushnan',
			'//29',
			'_as3_pop',
			'//2a',
			'_as3_dup',
			'//2b',
			'_as3_swap',
			'//2c 00',
			'_as3_pushstring ""',
			'//2d 00',
			'_as3_pushint 0',
			'//2e 00',
			'_as3_pushuint 0',
			'//2f 00',
			'_as3_pushdouble 0',
			'//30',
			'_as3_pushscope',
			'//31 01',
			'_as3_pushnamespace',
			'//32 00 00',
			'_as3_hasnext2 0, 0',
			'//33',
			'_as3_OP_0x33',
			'//34',
			'_as3_OP_0x34',
			'//35',
			'_as3_OP_0x35',
			'//36',
			'_as3_OP_0x36',
			'//37',
			'_as3_OP_0x37',
			'//38',
			'_as3_OP_0x38',
			'//39',
			'_as3_OP_0x39',
			'//3a',
			'_as3_OP_0x3A',
			'//3b',
			'_as3_OP_0x3B',
			'//3c',
			'_as3_OP_0x3C',
			'//3d',
			'_as3_OP_0x3D',
			'//3e',
			'_as3_OP_0x3E',
			'//3f',
			'_as3_OP_0x3F',
			'//40 00',
			'_as3_newfunction',
			'//41 00',
			'_as3_call (param count:0)',
			'//42 00',
			'_as3_construct (param count:0)',
			'//43 00 00',
			'_as3_callmethod (param count:0)',
			'//44 00 00',
			'_as3_callstatic (param count:0)',
			'//45 01 00',
			'_as3_callsuper (param count:0)',
			'//46 01 00',
			'_as3_callproperty (param count:0)',
			'//47',
			'_as3_returnvoid',
			'//48',
			'_as3_returnvalue',
			'//49 01',
			'_as3_constructsuper (param count:0)',
			'//4a 01 00',
			'_as3_constructprop (param count:0)',
			'//4b',
			'_as3_callsuperid //bad "不合法的 op: 0x4b"',
			'//4c 01 00',
			'_as3_callproplex (param count:0)',
			'//4d',
			'_as3_callinterface //bad "不合法的 op: 0x4d"',
			'//4e 01 00',
			'_as3_callsupervoid (param count:0)',
			'//4f 01 00',
			'_as3_callpropvoid (param count:0)',
			'//50',
			'_as3_OP_0x50',
			'//51',
			'_as3_OP_0x51',
			'//52',
			'_as3_OP_0x52',
			'//53 00',
			'applytype (param count:0)',
			'//54',
			'_as3_OP_0x54',
			'//55 00',
			'_as3_newobject {object count:0}',
			'//56 00',
			'_as3_newarray [array size:0]',
			'//57',
			'_as3_newactivation',
			'//58 00',
			'_as3_newclass EncryptTest',
			'//59 01',
			'_as3_getdescendants',
			'//5a 00',
			'_as3_newcatch <0>',
			'//5b',
			'_as3_OP_0x5B',
			'//5c',
			'_as3_OP_0x5C',
			'//5d 01',
			'_as3_findpropstrict',
			'//5e 01',
			'_as3_findproperty',
			'//5f 00',
			'_as3_finddef //bad "Find a global definition. TODO: What exactly does this do ?"',
			'//60 01',
			'_as3_getlex',
			'//61 01',
			'_as3_setproperty',
			'//62 00',
			'_as3_getlocal <0>',
			'//63 00',
			'_as3_setlocal <0>',
			'//64',
			'_as3_getglobalscope',
			'//65 00',
			'_as3_getscopeobject 0',
			'//66 01',
			'_as3_getproperty',
			'//67',
			'_as3_OP_0x67',
			'//68 01',
			'_as3_initproperty',
			'//69',
			'_as3_OP_0x69',
			'//6a 01',
			'_as3_deleteproperty',
			'//6b',
			'_as3_OP_0x6B',
			'//6c 00',
			'_as3_getslot <0>',
			'//6d 00',
			'_as3_setslot <0>',
			'//6e 00',
			'_as3_getglobalslot <0>',
			'//6f 00',
			'_as3_setglobalslot <0>',
			'//70',
			'_as3_convert_s',
			'//71',
			'_as3_esc_xelem',
			'//72',
			'_as3_esc_xattr',
			'//73',
			'_as3_convert_i',
			'//74',
			'_as3_convert_u',
			'//75',
			'_as3_convert_d',
			'//76',
			'_as3_convert_b',
			'//77',
			'_as3_convert_o',
			'//78',
			'_as3_checkfilter',
			'//79',
			'_as3_OP_0x79',
			'//7a',
			'_as3_OP_0x7A',
			'//7b',
			'_as3_OP_0x7B',
			'//7c',
			'_as3_OP_0x7C',
			'//7d',
			'_as3_OP_0x7D',
			'//7e',
			'_as3_OP_0x7E',
			'//7f',
			'_as3_OP_0x7F',
			'//80 01',
			'_as3_coerce',
			'//81',
			'_as3_coerce_b',
			'//82',
			'_as3_coerce_a',
			'//83',
			'_as3_coerce_i',
			'//84',
			'_as3_coerce_d',
			'//85',
			'_as3_coerce_s',
			'//86 01',
			'_as3_astype',
			'//87',
			'_as3_astypelate',
			'//88',
			'_as3_coerce_u',
			'//89',
			'_as3_coerce_o',
			'//8a',
			'_as3_OP_0x8A',
			'//8b',
			'_as3_OP_0x8B',
			'//8c',
			'_as3_OP_0x8C',
			'//8d',
			'_as3_OP_0x8D',
			'//8e',
			'_as3_OP_0x8E',
			'//8f',
			'_as3_OP_0x8F',
			'//90',
			'_as3_negate',
			'//91',
			'_as3_increment',
			'//92 00',
			'_as3_inclocal <0>',
			'//93',
			'_as3_decrement',
			'//94 00',
			'_as3_declocal <0>',
			'//95',
			'_as3_typeof',
			'//96',
			'_as3_not',
			'//97',
			'_as3_bitnot',
			'//98',
			'_as3_OP_0x98',
			'//99',
			'_as3_OP_0x99',
			'//9a',
			'_as3_concat //bad "不合法的 op: 0x9a"',
			'//9b',
			'_as3_add_d //bad "不合法的 op: 0x9b"',
			'//9c',
			'_as3_OP_0x9C',
			'//9d',
			'_as3_OP_0x9D',
			'//9e',
			'_as3_OP_0x9E',
			'//9f',
			'_as3_OP_0x9F',
			'//a0',
			'_as3_add',
			'//a1',
			'_as3_subtract',
			'//a2',
			'_as3_multiply',
			'//a3',
			'_as3_divide',
			'//a4',
			'_as3_modulo',
			'//a5',
			'_as3_lshift',
			'//a6',
			'_as3_rshift',
			'//a7',
			'_as3_urshift',
			'//a8',
			'_as3_bitand',
			'//a9',
			'_as3_bitor',
			'//aa',
			'_as3_bitxor',
			'//ab',
			'_as3_equals',
			'//ac',
			'_as3_strictequals',
			'//ad',
			'_as3_lessthan',
			'//ae',
			'_as3_lessequals',
			'//af',
			'_as3_greaterthan',
			'//b0',
			'_as3_greaterequals',
			'//b1',
			'_as3_instanceof',
			'//b2 01',
			'_as3_istype',
			'//b3',
			'_as3_istypelate',
			'//b4',
			'_as3_in',
			'//b5',
			'_as3_OP_0xB5',
			'//b6',
			'_as3_OP_0xB6',
			'//b7',
			'_as3_OP_0xB7',
			'//b8',
			'_as3_OP_0xB8',
			'//b9',
			'_as3_OP_0xB9',
			'//ba',
			'_as3_OP_0xBA',
			'//bb',
			'_as3_OP_0xBB',
			'//bc',
			'_as3_OP_0xBC',
			'//bd',
			'_as3_OP_0xBD',
			'//be',
			'_as3_OP_0xBE',
			'//bf',
			'_as3_OP_0xBF',
			'//c0',
			'_as3_increment_i',
			'//c1',
			'_as3_decrement_i',
			'//c2 00',
			'_as3_inclocal_i <0>',
			'//c3 00',
			'_as3_declocal_i <0>',
			'//c4',
			'_as3_negate_i',
			'//c5',
			'_as3_add_i',
			'//c6',
			'_as3_subtract_i',
			'//c7',
			'_as3_multiply_i',
			'//c8',
			'_as3_OP_0xC8',
			'//c9',
			'_as3_OP_0xC9',
			'//ca',
			'_as3_OP_0xCA',
			'//cb',
			'_as3_OP_0xCB',
			'//cc',
			'_as3_OP_0xCC',
			'//cd',
			'_as3_OP_0xCD',
			'//ce',
			'_as3_OP_0xCE',
			'//cf',
			'_as3_OP_0xCF',
			'//d0',
			'_as3_getlocal <0>',
			'//d1',
			'_as3_getlocal <1>',
			'//d2',
			'_as3_getlocal <2>',
			'//d3',
			'_as3_getlocal <3>',
			'//d4',
			'_as3_setlocal <0>',
			'//d5',
			'_as3_setlocal <1>',
			'//d6',
			'_as3_setlocal <2>',
			'//d7',
			'_as3_setlocal <3>',
			'//d8',
			'_as3_OP_0xD8',
			'//d9',
			'_as3_OP_0xD9',
			'//da',
			'_as3_OP_0xDA',
			'//db',
			'_as3_OP_0xDB',
			'//dc',
			'_as3_OP_0xDC',
			'//dd',
			'_as3_OP_0xDD',
			'//de',
			'_as3_OP_0xDE',
			'//df',
			'_as3_OP_0xDF',
			'//e0',
			'_as3_OP_0xE0',
			'//e1',
			'_as3_OP_0xE1',
			'//e2',
			'_as3_OP_0xE2',
			'//e3',
			'_as3_OP_0xE3',
			'//e4',
			'_as3_OP_0xE4',
			'//e5',
			'_as3_OP_0xE5',
			'//e6',
			'_as3_OP_0xE6',
			'//e7',
			'_as3_OP_0xE7',
			'//e8',
			'_as3_OP_0xE8',
			'//e9',
			'_as3_OP_0xE9',
			'//ea',
			'_as3_OP_0xEA',
			'//eb',
			'_as3_OP_0xEB',
			'//ec',
			'_as3_OP_0xEC',
			'//ed',
			'_as3_OP_0xED',
			'//ee 00',
			'_as3_abs_jump offset: 0 //bad "不合法的 op: 0xee" //bad "不合法的 op: 0x00"',
			'//ef 00 00 00 00',
			'_as3_debug 0, 0, 0, 0',
			'//f0 00',
			'_as3_debugline line number: 0',
			'//f1 00',
			'_as3_debugfile ""',
			'//f2 00',
			'_as3_bkptline line number: 0',
			'//f3',
			'_as3_timestamp',
			'//f4',
			'_as3_OP_0xF4 //bad "不合法的 op: 0xf4"',
			'//f5',
			'_as3_verifypass //bad "不合法的 op: 0xf5"',
			'//f6',
			'_as3_alloc //bad "不合法的 op: 0xf6"',
			'//f7',
			'_as3_mark //bad "不合法的 op: 0xf7"',
			'//f8',
			'_as3_wb //bad "不合法的 op: 0xf8"',
			'//f9',
			'_as3_prologue //bad "不合法的 op: 0xf9"',
			'//fa',
			'_as3_sendenter //bad "不合法的 op: 0xfa"',
			'//fb',
			'_as3_doubletoatom //bad "不合法的 op: 0xfb"',
			'//fc',
			'_as3_sweep //bad "不合法的 op: 0xfc"',
			'//fd',
			'_as3_codegenop //bad "不合法的 op: 0xfd"',
			'//fe',
			'_as3_verifyop //bad "不合法的 op: 0xfe"',
			'//ff',
			'_as3_decode //bad "不合法的 op: 0xff"'
		]);
		public static function getAllCodes():Boolean{
			import zero.BytesAndStr16;
			var data:ByteArray=new ByteArray();
			for(var op:int=0;op<256;op++){
				data.writeBytes(
					BytesAndStr16.str162bytes(
						allCodes[op*2].replace("//","")
					)
				);
			}
			trace(BytesAndStr16.bytes2str16(data,0,data.length));
			return true;
		}
		private static var initAllCodes:Boolean=getAllCodes();
		//*/
		/*
		public static const op_xml:XML=
<op>
  <bkpt Forms="0x01" Stack="未知" Operation="未知" type="SIMPLE"/>
  <pushconstant Forms="0x22" Stack="未知" Operation="未知" type="SIMPLE"/>
  <callsuperid Forms="0x4b" Stack="未知" Operation="未知" type="SIMPLE"/>
  <callinterface Forms="0x4d" Stack="未知" Operation="未知" type="SIMPLE"/>
  <applytype Forms="0x53" Stack="未知" Operation="未知" type="ARGS"/>
  <finddef Forms="0x5f" Stack="未知" Operation="未知" type="INDEX"/>
  <getpropertylate Forms="0x67" Stack="未知" Operation="未知" type="SIMPLE"/>
  <setpropertylate Forms="0x69" Stack="未知" Operation="未知" type="SIMPLE"/>
  <deletepropertylate Forms="0x6b" Stack="未知" Operation="未知" type="SIMPLE"/>
  <coerce_b Forms="0x81" Stack="未知" Operation="未知" type="SIMPLE"/>
  <coerce_i Forms="0x83" Stack="未知" Operation="未知" type="SIMPLE"/>
  <coerce_d Forms="0x84" Stack="未知" Operation="未知" type="SIMPLE"/>
  <coerce_u Forms="0x88" Stack="未知" Operation="未知" type="SIMPLE"/>
  <coerce_o Forms="0x89" Stack="未知" Operation="未知" type="SIMPLE"/>
  <concat Forms="0x9a" Stack="未知" Operation="未知" type="SIMPLE"/>
  <add_d Forms="0x9b" Stack="未知" Operation="未知" type="SIMPLE"/>
  <bkptline Forms="0xf2" Stack="未知" Operation="未知" type="SIMPLE"/>
  <add Forms="0xa0" Stack="…, value1, value2 => …, value3" Operation="Add two values." type="SIMPLE"/>
  <add_i Forms="0xc5" Stack="…, value1, value2 => …, value3" Operation="Add two integer values." type="SIMPLE"/>
  <astype Forms="0x86" Stack="…, value => …, value" Operation="Return the same value, or null if not of the specified type." type="INDEX"/>
  <astypelate Forms="0x87" Stack="…, value, class => …, value" Operation="Return the same value, or null if not of the specified type." type="SIMPLE"/>
  <bitand Forms="0xa8" Stack="…, value1, value2 => …, value3" Operation="Bitwise and." type="SIMPLE"/>
  <bitnot Forms="0x97" Stack="…, value => …, ~value" Operation="Bitwise not." type="SIMPLE"/>
  <bitor Forms="0xa9" Stack="…, value1, value2 => …, value3" Operation="Bitwise or." type="SIMPLE"/>
  <bitxor Forms="0xaa" Stack="…, value1, value2 => …, value3" Operation="Bitwise exclusive or." type="SIMPLE"/>
  <call Forms="0x41" Stack="…, function, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a closure." type="ARGS"/>
  <callmethod Forms="0x43" Stack="…, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a method identified by index in the object’s method table." type="INDEX_ARGS"/>
  <callproperty Forms="0x46" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Call a property." type="INDEX_ARGS"/>
  <callproplex Forms="0x4c" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Call a property." type="INDEX_ARGS"/>
  <callpropvoid Forms="0x4f" Stack="…, obj, [ns], [name], arg1,...,argn => …" Operation="Call a property, discarding the return value." type="INDEX_ARGS"/>
  <callstatic Forms="0x44" Stack="…, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a method identified by index in the abcFile method table." type="INDEX_ARGS"/>
  <callsuper Forms="0x45" Stack="…, receiver, [ns], [name], arg1,...,argn => …, value" Operation="Call a method on a base class." type="INDEX_ARGS"/>
  <callsupervoid Forms="0x4e" Stack="…, receiver, [ns], [name], arg1, …, argn => …" Operation="Call a method on a base class, discarding the return value." type="INDEX_ARGS"/>
  <checkfilter Forms="0x78" Stack="…, value => …, value" Operation="Check to make sure an object can have a filter operation performed on it." type="SIMPLE"/>
  <coerce Forms="0x80" Stack="…, value => …, coercedvalue" Operation="Coerce a value to a specified type" type="INDEX"/>
  <coerce_a Forms="0x82" Stack="…, value => …, value" Operation="Coerce a value to the any type." type="SIMPLE"/>
  <coerce_s Forms="0x85" Stack="…, value => …, stringvalue" Operation="Coerce a value to a string." type="SIMPLE"/>
  <construct Forms="0x42" Stack="…, object, arg1, arg2, ..., argn => …, value" Operation="Construct an instance." type="ARGS"/>
  <constructprop Forms="0x4a" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Construct a property." type="INDEX_ARGS"/>
  <constructsuper Forms="0x49" Stack="…, object, arg1, arg2, ..., argn => …" Operation="Construct an instance of the base class." type="ARGS"/>
  <convert_b Forms="0x76" Stack="…, value => …, booleanvalue" Operation="Convert a value to a Boolean." type="SIMPLE"/>
  <convert_i Forms="0x73" Stack="…, value => …, intvalue" Operation="Convert a value to an integer." type="SIMPLE"/>
  <convert_d Forms="0x75" Stack="…, value => …, doublevalue" Operation="Convert a value to a double." type="SIMPLE"/>
  <convert_o Forms="0x77" Stack="…, value => …, value" Operation="Convert a value to an Object." type="SIMPLE"/>
  <convert_u Forms="0x74" Stack="…, value => …, uintvalue" Operation="Convert a value to an unsigned integer." type="SIMPLE"/>
  <convert_s Forms="0x70" Stack="…, value => …, stringvalue" Operation="Convert a value to a string." type="SIMPLE"/>
  <debug Forms="0xef" Format="debug debug_type index reg extra" Stack="… => …" Operation="Debugging info." type="DEBUG"/>
  <debugfile Forms="0xf1" Stack="… => …" Operation="Debugging line number info." type="INDEX"/>
  <debugline Forms="0xf0" Stack="… => …" Operation="Debugging line number info." type="VALUE_INT"/>
  <declocal Forms="0x94" Stack="… => …" Operation="Decrement a local register value." type="INDEX"/>
  <declocal_i Forms="0xc3" Stack="… => …" Operation="Decrement a local register value." type="INDEX"/>
  <decrement Forms="0x93" Stack="…, value => …, decrementedvalue" Operation="Decrement a value." type="SIMPLE"/>
  <decrement_i Forms="0xc1" Stack="…, value => …, dencrementedvalue" Operation="Decrement an integer value." type="SIMPLE"/>
  <deleteproperty Forms="0x6a" Stack="…, object, [ns], [name] => …, value" Operation="Delete a property." type="INDEX"/>
  <divide Forms="0xa3" Stack="…, value1, value2 => …, value3" Operation="Divide two values." type="SIMPLE"/>
  <dup Forms="0x2a" Stack="…, value => …, value, value" Operation="Duplicates the top value on the stack." type="SIMPLE"/>
  <dxns Forms="0x06" Stack="… => …" Operation="Sets the default XML namespace." type="INDEX"/>
  <dxnslate Forms="0x07" Stack="…, value => …" Operation="Sets the default XML namespace with a value determined at runtime." type="SIMPLE"/>
  <equals Forms="0xab" Stack="…, value1, value2 => …, result" Operation="Compare two values." type="SIMPLE"/>
  <esc_xattr Forms="0x72" Stack="…, value => …, stringvalue" Operation="Escape an xml attribute." type="SIMPLE"/>
  <esc_xelem Forms="0x71" Stack="…, value => …, stringvalue" Operation="Escape an xml element." type="SIMPLE"/>
  <findproperty Forms="0x5e" Stack="…, [ns], [name] => …, obj" Operation="Search the scope stack for a property." type="INDEX"/>
  <findpropstrict Forms="0x5d" Stack="…, [ns], [name] => …, obj" Operation="Find a property." type="INDEX"/>
  <getdescendants Forms="0x59" Stack="…, obj, [ns], [name] => …, value" Operation="Get descendants." type="INDEX"/>
  <getglobalscope Forms="0x64" Stack="… => …, obj" Operation="Gets the global scope." type="SIMPLE"/>
  <getglobalslot Forms="0x6e" Stack="… => …, value" Operation="Get the value of a slot on the global scope." type="INDEX"/>
  <getlex Forms="0x60" Stack="… => …, obj" Operation="Find and get a property." type="INDEX"/>
  <getlocal Forms="0x62" Stack="… => …, value" Operation="Get a local register." type="INDEX"/>
  <getlocal0 Forms="0xd0" Stack="… => …, value" Operation="Get a local register." type="SIMPLE"/>
  <getlocal1 Forms="0xd1" Stack="… => …, value" Operation="Get a local register." type="SIMPLE"/>
  <getlocal2 Forms="0xd2" Stack="… => …, value" Operation="Get a local register." type="SIMPLE"/>
  <getlocal3 Forms="0xd3" Stack="… => …, value" Operation="Get a local register." type="SIMPLE"/>
  <getproperty Forms="0x66" Stack="…, object, [ns], [name] => …, value" Operation="Get a property." type="INDEX"/>
  <getscopeobject Forms="0x65" Stack="… => …, scope" Operation="Get a scope object." type="INDEX"/>
  <getslot Forms="0x6c" Stack="…, obj => …, value" Operation="Get the value of a slot." type="INDEX"/>
  <getsuper Forms="0x04" Stack="…, obj, [ns], [name] => …, value" Operation="Gets a property from a base class." type="INDEX"/>
  <greaterequals Forms="0xb0" Stack="…, value1, value2 => …, result" Operation="Determine if one value is greater than or equal to another." type="SIMPLE"/>
  <greaterthan Forms="0xaf" Stack="…, value1, value2 => …, result" Operation="Determine if one value is greater than another." type="SIMPLE"/>
  <hasnext Forms="0x1f" Stack="…, obj, cur_index => …, next_index" Operation="Determine if the given object has any more properties." type="SIMPLE"/>
  <hasnext2 Forms="0x32" Format="hasnext2 object_reg index_reg" Stack="…, => …, value" Operation="Determine if the given object has any more properties." type="HAS_NEXT2"/>
  <ifeq Forms="0x13" Stack="…, value1, value2 => …" Operation="Branch if the first value is equal to the second value." type="BRANCH"/>
  <iffalse Forms="0x12" Stack="…, value => …" Operation="Branch if false." type="BRANCH"/>
  <ifge Forms="0x18" Stack="…, value1, value2 => …" Operation="Branch if the first value is greater than or equal to the second value." type="BRANCH"/>
  <ifgt Forms="0x17" Stack="…, value1, value2 => …" Operation="Branch if the first value is greater than the second value." type="BRANCH"/>
  <ifle Forms="0x16" Stack="…, value1, value2 => …" Operation="Branch if the first value is less than or equal to the second value." type="BRANCH"/>
  <iflt Forms="0x15" Stack="…, value1, value2 => …" Operation="Branch if the first value is less than the second value." type="BRANCH"/>
  <ifnge Forms="0x0f" Stack="…, value1, value2 => …" Operation="Branch if the first value is not greater than or equal to the second value." type="BRANCH"/>
  <ifngt Forms="0x0e" Stack="…, value1, value2 => …" Operation="Branch if the first value is not greater than the second value." type="BRANCH"/>
  <ifnle Forms="0x0d" Stack="…, value1, value2 => …" Operation="Branch if the first value is not less than or equal to the second value." type="BRANCH"/>
  <ifnlt Forms="0x0c" Stack="…, value1, value2 => …" Operation="Branch if the first value is not less than the second value." type="BRANCH"/>
  <ifne Forms="0x14" Stack="…, value1, value2 => …" Operation="Branch if the first value is not equal to the second value." type="BRANCH"/>
  <ifstricteq Forms="0x19" Stack="…, value1, value2 => …" Operation="Branch if the first value is equal to the second value." type="BRANCH"/>
  <ifstrictne Forms="0x1a" Stack="…, value1, value2 => …" Operation="Branch if the first value is not equal to the second value." type="BRANCH"/>
  <iftrue Forms="0x11" Stack="…, value => …" Operation="Branch if true." type="BRANCH"/>
  <in Forms="0xb4" Stack="…, name, obj => …, result" Operation="Determine whether an object has a named property." type="SIMPLE"/>
  <inclocal Forms="0x92" Stack="… => …" Operation="Increment a local register value." type="INDEX"/>
  <inclocal_i Forms="0xc2" Stack="… => …" Operation="Increment a local register value." type="INDEX"/>
  <increment Forms="0x91" Stack="…, value => …, incrementedvalue" Operation="Increment a value." type="SIMPLE"/>
  <increment_i Forms="0xc0" Stack="…, value => …, incrementedvalue" Operation="Increment an integer value." type="SIMPLE"/>
  <initproperty Forms="0x68" Stack="…, object, [ns], [name], value => …" Operation="Initialize a property." type="INDEX"/>
  <instanceof Forms="0xb1" Stack="…, value, type => …, result" Operation="Check the prototype chain of an object for the existence of a type." type="SIMPLE"/>
  <istype Forms="0xb2" Stack="…, value => …, result" Operation="Check whether an Object is of a certain type." type="INDEX"/>
  <istypelate Forms="0xb3" Stack="…, value, type => …, result" Operation="Check whether an Object is of a certain type." type="SIMPLE"/>
  <jump Forms="0x10" Stack="… => …" Operation="Unconditional branch." type="BRANCH"/>
  <kill Forms="0x08" Stack="… => …" Operation="Kills a local register." type="INDEX"/>
  <label Forms="0x09" Stack="… => …" Operation="Do nothing." type="SIMPLE" info="ignored by avm"/>
  <lessequals Forms="0xae" Stack="…, value1, value2 => …, result" Operation="Determine if one value is less than or equal to another." type="SIMPLE"/>
  <lessthan Forms="0xad" Stack="…, value1, value2 => …, result" Operation="Determine if one value is less than another." type="SIMPLE"/>
  <lookupswitch Forms="0x1b" Format="lookupswitch default_offset case_count case_offsets..." Stack="…, index => …" Operation="Jump to different locations based on an index." type="LOOKUP_SWITCH"/>
  <lshift Forms="0xa5" Stack="…, value1, value2 => …, value3" Operation="Bitwise left shift." type="SIMPLE"/>
  <modulo Forms="0xa4" Stack="…, value1, value2 => …, value3" Operation="Perform modulo division on two values." type="SIMPLE"/>
  <multiply Forms="0xa2" Stack="…, value1, value2 => …, value3" Operation="Multiply two values." type="SIMPLE"/>
  <multiply_i Forms="0xc7" Stack="…, value1, value2 => …, value3" Operation="Multiply two integer values." type="SIMPLE"/>
  <negate Forms="0x90" Stack="…, value => …, -value" Operation="Negate a value." type="SIMPLE"/>
  <negate_i Forms="0xc4" Stack="…, value => …, -value" Operation="Negate an integer value." type="SIMPLE"/>
  <newactivation Forms="0x57" Stack="… => …, newactivation" Operation="Create a new activation object." type="SIMPLE"/>
  <newarray Forms="0x56" Stack="…, value1, value2, ..., valueN => …, newarray" Operation="Create a new array." type="ARGS"/>
  <newcatch Forms="0x5a" Stack="… => …, catchscope" Operation="Create a new catch scope." type="INDEX"/>
  <newclass Forms="0x58" Stack="…, basetype => …, newclass" Operation="Create a new class." type="INDEX"/>
  <newfunction Forms="0x40" Stack="… => …, function_obj" Operation="Create a new function object." type="INDEX"/>
  <newobject Forms="0x55" Stack="…, name1, value1, name2, value2,...,nameN, valueN => …, newobj" Operation="Create a new object." type="ARGS"/>
  <nextname Forms="0x1e" Stack="…, obj, index => …, name" Operation="Get the name of the next property when iterating over an object." type="SIMPLE"/>
  <nextvalue Forms="0x23" Stack="…, obj, index => …, value" Operation="Get the name of the next property when iterating over an object." type="SIMPLE"/>
  <nop Forms="0x02" Stack="… => …" Operation="Do nothing." type="SIMPLE" info="ignored by avm"/>
  <not Forms="0x96" Stack="…, value => …, !value" Operation="Boolean negation." type="SIMPLE"/>
  <pop Forms="0x29" Stack="…, value => …" Operation="Pop the top value from the stack." type="SIMPLE"/>
  <popscope Forms="0x1d" Stack="… => …" Operation="Pop a scope off of the scope stack" type="SIMPLE"/>
  <pushbyte Forms="0x24" Stack="… => …, value" Operation="Push a byte value." type="VALUE_BYTE"/>
  <pushdouble Forms="0x2f" Stack="… => …, value" Operation="Push a double value onto the stack." type="INDEX"/>
  <pushfalse Forms="0x27" Stack="… => …, false" Operation="Push false." type="SIMPLE"/>
  <pushint Forms="0x2d" Stack="… => …, value" Operation="Push an int value onto the stack." type="INDEX"/>
  <pushnamespace Forms="0x31" Stack="… => …, namespace" Operation="Push a namespace." type="INDEX"/>
  <pushnan Forms="0x28" Stack="… => …, NaN" Operation="Push NaN." type="SIMPLE"/>
  <pushnull Forms="0x20" Stack="… => …, null" Operation="Push null." type="SIMPLE"/>
  <pushscope Forms="0x30" Stack="…, value => …" Operation="Push an object onto the scope stack." type="SIMPLE"/>
  <pushshort Forms="0x25" Stack="… => …, value" Operation="Push a short value." type="VALUE_INT"/>
  <pushstring Forms="0x2c" Stack="… => …, value" Operation="Push a string value onto the stack." type="INDEX"/>
  <pushtrue Forms="0x26" Stack="… => …, true" Operation="Push true." type="SIMPLE"/>
  <pushuint Forms="0x2e" Stack="… => …, value" Operation="Push an unsigned int value onto the stack." type="INDEX"/>
  <pushundefined Forms="0x21" Stack="… => …, undefined" Operation="Push undefined." type="SIMPLE"/>
  <pushwith Forms="0x1c" Stack="…, scope_obj => …" Operation="Push a with scope onto the scope stack" type="SIMPLE"/>
  <returnvalue Forms="0x48" Stack="…, return_value => …" Operation="Return a value from a method." type="SIMPLE"/>
  <returnvoid Forms="0x47" Stack="… => …" Operation="Return from a method." type="SIMPLE"/>
  <rshift Forms="0xa6" Stack="…, value1, value2 => …, value3" Operation="Signed bitwise right shift." type="SIMPLE"/>
  <setlocal Forms="0x63" Stack="…, value => …" Operation="Set a local register." type="INDEX"/>
  <setlocal0 Forms="0xd4" Stack="…, value => …" Operation="Set a local register." type="SIMPLE"/>
  <setlocal1 Forms="0xd5" Stack="…, value => …" Operation="Set a local register." type="SIMPLE"/>
  <setlocal2 Forms="0xd6" Stack="…, value => …" Operation="Set a local register." type="SIMPLE"/>
  <setlocal3 Forms="0xd7" Stack="…, value => …" Operation="Set a local register." type="SIMPLE"/>
  <setglobalslot Forms="0x6f" Stack="…, value => …" Operation="Set the value of a slot on the global scope." type="INDEX"/>
  <setproperty Forms="0x61" Stack="…, obj, [ns], [name], value => …" Operation="Set a property." type="INDEX"/>
  <setslot Forms="0x6d" Stack="…, obj, value => …" Operation="Set the value of a slot." type="INDEX"/>
  <setsuper Forms="0x05" Stack="…, obj, [ns], [name], value => …" Operation="Sets a property in a base class." type="INDEX"/>
  <strictequals Forms="0xac" Stack="…, value1, value2 => …, result" Operation="Compare two values strictly." type="SIMPLE"/>
  <subtract Forms="0xa1" Stack="…, value1, value2 => …, value3" Operation="subtract one value from another." type="SIMPLE"/>
  <subtract_i Forms="0xc6" Stack="…, value1, value2 => …, value3" Operation="Subtract an integer value from another integer value." type="SIMPLE"/>
  <swap Forms="0x2b" Stack="…, value1, value2 => …, value2, value1" Operation="Swap the top two operands on the stack" type="SIMPLE"/>
  <throw Forms="0x03" Stack="…, value => …" Operation="Throws an exception." type="SIMPLE"/>
  <typeof Forms="0x95" Stack="…, value => …, typename" Operation="Get the type name of a value." type="SIMPLE"/>
  <urshift Forms="0xa7" Stack="…, value1, value2 => …, value3" Operation="Unsigned bitwise right shift." type="SIMPLE"/>
  <timestamp Forms="0xf3" Stack="未知" Operation="未知" type="SIMPLE" info="ignored by avm"/>
  <verifypass Forms="0xf5" Stack="未知" Operation="未知" type="PROFILING" info="for VM profiling (abc verify overhead)"/>
  <alloc Forms="0xf6" Stack="未知" Operation="未知" type="PROFILING" info="for GC profiling"/>
  <mark Forms="0xf7" Stack="未知" Operation="未知" type="PROFILING" info="for GC profiling"/>
  <wb Forms="0xf8" Stack="未知" Operation="未知" type="PROFILING" info="for GC profiling"/>
  <prologue Forms="0xf9" Stack="未知" Operation="未知" type="PROFILING" info="for codegen profiling"/>
  <sendenter Forms="0xfa" Stack="未知" Operation="未知" type="PROFILING" info="ignored by AVM (profiling?)"/>
  <doubletoatom Forms="0xfb" Stack="未知" Operation="未知" type="PROFILING" info="for VM profiling (doubleToAtom method in avmcore)"/>
  <sweep Forms="0xfc" Stack="未知" Operation="未知" type="PROFILING" info="for GC profiling"/>
  <codegenop Forms="0xfd" Stack="未知" Operation="未知" type="PROFILING" info="for codegen profiling"/>
  <verifyop Forms="0xfe" Stack="未知" Operation="未知" type="PROFILING" info="for VM profiling (abc verify overhead)"/>
  <decode Forms="0xff" Stack="未知" Operation="未知" type="PROFILING" info="for VM profiling (abc parsing overhead)"/>
</op>
*/
		
/*
<op>
  <add Forms="0xa0" Format="add" Stack="…, value1, value2 => …, value3" Operation="Add two values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack and add them together as specified in ECMA-262 section
11.6 and as extended in ECMA-357 section 11.4. The algorithm is briefly described below.
1. If value1 and value2 are both Numbers, then set value3 to the result of adding the two
number values. See ECMA-262 section 11.6.3 for a description of adding number values.
2. If value1 or value2 is a String or a Date, convert both values to String using the ToString
algorithm described in ECMA-262 section 9.8. Concatenate the string value of value2 to the
string value of value1 and set value3 to the new concatenated String.
3. If value1 and value2 are both of type XML or XMLList, construct a new XMLList object,
then call [[Append]](value1), and then [[Append]](value2). Set value3 to the new XMLList.
See ECMA-357 section 9.2.1.6 for a description of the [[Append]] method.
4. If none of the above apply, convert value1 and value2 to primitives. This is done by calling
ToPrimitive with no hint. This results in value1_primitive and value2_primitive. If
value1_primitive or value2_primitive is a String then convert both to Strings using the
ToString algorithm (ECMA-262 section 9.8), concatenate the results, and set value3 to the
concatenated String. Otherwise convert both to Numbers using the ToNumber algorithm
(ECMA-262 section 9.3), add the results, and set value3 to the result of the addition.
Push value3 onto the stack.
]]></Description>
    <Notes><![CDATA[
For more information, see ECMA-262 section 11.6 (“Additive Operators”) and ECMA-357
section 11.4.
]]></Notes>
  </add>
  <add_i Forms="0xc5" Format="add_i" Stack="…, value1, value2 => …, value3" Operation="Add two integer values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack and convert them to int values using the ToInt32
algorithm (ECMA-262 section 9.5). Add the two int values and push the result onto the
stack
]]></Description>
  </add_i>
  <astype Forms="0x86" Format="astype index" Stack="…, value => …, value" Operation="Return the same value, or null if not of the specified type.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. The multiname at
index must not be a runtime multiname, and must be the name of a type.
Pop value off of the stack. If value is of the type specified by the multiname, push value back
onto the stack. If value is not of the type specified by the multiname, then push null onto
the stack.
]]></Description>
  </astype>
  <astypelate Forms="0x87" Format="astypelate" Stack="…, value, class => …, value" Operation="Return the same value, or null if not of the specified type.">
    <Description><![CDATA[
Pop class and value off of the stack. class should be an object of type Class. If value is of the
type specified by class, push value back onto the stack. If value is not of the type specified by
class, then push null onto the stack.
Runtime exceptions
A TypeError is thrown if class is not of type Class
]]></Description>
  </astypelate>
  <bitand Forms="0xa8" Format="bitand" Stack="…, value1, value2 => …, value3" Operation="Bitwise and.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Convert value1 and value2 to integers, as per ECMA-
262 section 11.10, and perform a bitwise and (&) on the two resulting integer values. Push
the result onto the stack.
]]></Description>
  </bitand>
  <bitnot Forms="0x97" Format="bitnot" Stack="…, value => …, ~value" Operation="Bitwise not.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to an integer, as per ECMA-262 section 11.4.8,
and then apply the bitwise complement operator (~) to the integer. Push the result onto the
stack
]]></Description>
  </bitnot>
  <bitor Forms="0xa9" Format="bitor" Stack="…, value1, value2 => …, value3" Operation="Bitwise or.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Convert value1 and value2 to integers, as per ECMA-
262 section 11.10, and perform a bitwise or (|) on the two resulting integer values. Push the
result onto the stack.
]]></Description>
  </bitor>
  <bitxor Forms="0xaa" Format="bitxor" Stack="…, value1, value2 => …, value3" Operation="Bitwise exclusive or.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Convert value1 and value2 to integers, as per ECMA-
262 section 11.10, and perform a bitwise exclusive or (^) on the two resulting integer values.
Push the result onto the stack
]]></Description>
  </bitxor>
  <call Forms="0x41" Format="call arg_count" Stack="…, function, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a closure.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack for the call. function
is the closure that is being called. receiver is the object to use for the “this” value. This will
invoke the [[Call]] property on function with the arguments receiver, arg1, ..., argn. The
result of invoking the [[Call]] property will be pushed onto the stack.
Runtime exceptions
A TypeError is thrown if function is not a Function.
]]></Description>
  </call>
  <callmethod Forms="0x43" Format="callmethod index arg_count" Stack="…, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a method identified by index in the object’s method table.">
    <Description><![CDATA[
index is a u30 that is the index of the method to invoke on receiver. arg_count is a u30 that is
the number of arguments present on the stack. receiver is the object to invoke the method
on.
The method at position index on the object receiver, is invoked with the arguments receiver,
arg1, ..., argn. The result of the method call is pushed onto the stack.
Runtime exceptions
A TypeError is thrown if receiver is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of arguments for the method
]]></Description>
  </callmethod>
  <callproperty Forms="0x46" Format="callproperty index arg_count" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Call a property.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
obj is the object to resolve and call the property on.
The property specified by the multiname at index is resolved on the object obj. The [[Call]]
property is invoked on the value of the resolved property with the arguments obj, arg1, ...,
argn. The result of the call is pushed onto the stack.
Runtime exceptions
A TypeError is thrown if obj is null or undefined or if the property specified by the
multiname is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of expected arguments for the method
]]></Description>
  </callproperty>
  <callproplex Forms="0x4c" Format="callproplex index arg_count" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Call a property.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
obj is the object to resolve and call the property on.
The property specified by the multiname at index is resolved on the object obj. The [[Call]]
property is invoked on the value of the resolved property with the arguments null, arg1, ...,
argn. The result of the call is pushed onto the stack.

Runtime exceptions
A TypeError is thrown if obj is null or undefined or if the property specified by the
multiname is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of expected arguments for the method
]]></Description>
  </callproplex>
  <callpropvoid Forms="0x4f" Format="callpropvoid index arg_count" Stack="…, obj, [ns], [name], arg1,...,argn => …" Operation="Call a property, discarding the return value.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
obj is the object to resolve and call the property on.
The property specified by the multiname at index is resolved on the object obj. The [[Call]]
property is invoked on the value of the resolved property with the arguments obj, arg1, ...,
argn. The result of the call is discarded.
Runtime exceptions
A TypeError is thrown if obj is null or undefined or if the property specified by the
multiname is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of expected arguments for the method.
]]></Description>
  </callpropvoid>
  <callstatic Forms="0x44" Format="callstatic index arg_count" Stack="…, receiver, arg1, arg2, ..., argn => …, value" Operation="Call a method identified by index in the abcFile method table.">
    <Description><![CDATA[
index is a u30 that is the index of the method_info of the method to invoke. arg_count is a
u30 that is the number of arguments present on the stack. receiver is the object to invoke the
method on.
The method at position index is invoked with the arguments receiver, arg1, ..., argn. The
receiver will be used as the “this” value for the method. The result of the method is pushed
onto the stack.
Runtime exceptions
A TypeError is thrown if receiver is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of arguments for the method
]]></Description>
  </callstatic>
  <callsuper Forms="0x45" Format="callsuper index arg_count" Stack="…, receiver, [ns], [name], arg1,...,argn => …, value" Operation="Call a method on a base class.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
receiver is the object to invoke the method on.
The base class of receiver is determined and the method indicated by the multiname is
resolved in the declared traits of the base class. The method is invoked with the arguments
receiver, arg1, ..., argn. The receiver will be used as the “this” value for the method. The result
of the method call is pushed onto the stack.
Runtime exceptions
A TypeError is thrown if receiver is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of arguments for the method
]]></Description>
  </callsuper>
  <callsupervoid Forms="0x4e" Format="callsupervoid index arg_count" Stack="…, receiver, [ns], [name], arg1, …, argn => …" Operation="Call a method on a base class, discarding the return value.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
receiver is the object to invoke the method on.
The base class of receiver is determined and the method indicated by the multiname is
resolved in the declared traits of the base class. The method is invoked with the arguments
receiver, arg1, ..., argn. The first argument will be used as the “this” value for the method.
The result of the method is discarded.

Runtime exceptions
A TypeError is thrown if receiver is null or undefined.
An ArgumentError is thrown if the number of arguments does not match the expected
number of arguments for the method
]]></Description>
  </callsupervoid>
  <checkfilter Forms="0x78" Format="checkfilter" Stack="…, value => …, value" Operation="Check to make sure an object can have a filter operation performed on it.">
    <Description><![CDATA[
This instruction checks that the top value of the stack can have a filter operation performed
on it. If value is of type XML or XMLList then nothing happens. If value is of any other type
a TypeError is thrown.
Runtime exceptions
A TypeError is thrown if value is not of type XML or XMLList
]]></Description>
  </checkfilter>
  <coerce Forms="0x80" Format="coerce index" Stack="…, value => …, coercedvalue" Operation="Coerce a value to a specified type">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. The multiname at
index must not be a runtime multiname.
The type specified by the multiname is resolved, and value is coerced to that type. The
resulting value is pushed onto the stack. If any of value’s base classes, or implemented

interfaces matches the type specified by the multiname, then the conversion succeeds and the
result is pushed onto the stack.
Runtime exceptions
A TypeError is thrown if value cannot be coerced to the specified type
]]></Description>
  </coerce>
  <coerce_a Forms="0x82" Format="coerce_a" Stack="…, value => …, value" Operation="Coerce a value to the any type.">
    <Description><![CDATA[
Indicates to the verifier that the value on the stack is of the any type (*). Does nothing to value
]]></Description>
  </coerce_a>
  <coerce_s Forms="0x85" Format="coerce_s" Stack="…, value => …, stringvalue" Operation="Coerce a value to a string.">
    <Description><![CDATA[
value is popped off of the stack and coerced to a String. If value is null or undefined, then
stringvalue is set to null. Otherwise stringvalue is set to the result of the ToString algorithm,
as specified in ECMA-262 section 9.8. stringvalue is pushed onto the stack.
]]></Description>
    <Notes><![CDATA[
This opcode is very similar to the convert_s opcode. The difference is that convert_s will
convert a null or undefined value to the string "null" or "undefined" whereas coerce_s
will convert those values to the null value.
			
]]></Notes>
  </coerce_s>
  <construct Forms="0x42" Format="construct arg_count" Stack="…, object, arg1, arg2, ..., argn => …, value" Operation="Construct an instance.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. object is the
function that is being constructed. This will invoke the [[Construct]] property on object with
the given arguments. The new instance generated by invoking [[Construct]] will be pushed
onto the stack.
Runtime exceptions
A TypeError is thrown if object does not implement the [[Construct]] property
]]></Description>
  </construct>
  <constructprop Forms="0x4a" Format="constructprop index arg_count" Stack="…, obj, [ns], [name], arg1,...,argn => …, value" Operation="Construct a property.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. The number of
arguments specified by arg_count are popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
obj is the object to resolve the multiname in.

The property specified by the multiname at index is resolved on the object obj. The
[[Construct]] property is invoked on the value of the resolved property with the arguments
obj, arg1, ..., argn. The new instance generated by invoking [[Construct]] will be pushed
onto the stack.
Runtime exceptions
A TypeError is thrown if obj is null or undefined.
A TypeError is thrown if the property specified by the multiname does not implement the
[[Construct]] property.
An ArgumentError is thrown if the number of arguments does not match the expected
number of expected arguments for the constructor
]]></Description>
  </constructprop>
  <constructsuper Forms="0x49" Format="constructsuper arg_count" Stack="…, object, arg1, arg2, ..., argn => …" Operation="Construct an instance of the base class.">
    <Description><![CDATA[
arg_count is a u30 that is the number of arguments present on the stack. This will invoke the
constructor on the base class of object with the given arguments.
Runtime exceptions
A TypeError is thrown if object is null or undefined
]]></Description>
  </constructsuper>
  <convert_b Forms="0x76" Format="convert_b" Stack="…, value => …, booleanvalue" Operation="Convert a value to a Boolean.">
    <Description><![CDATA[
value is popped off of the stack and converted to a Boolean. The result, booleanvalue, is
pushed onto the stack. This uses the ToBoolean algorithm, as described in ECMA-262
section 9.2, to perform the conversion
]]></Description>
  </convert_b>
  <convert_i Forms="0x73" Format="convert_i" Stack="…, value => …, intvalue" Operation="Convert a value to an integer.">
    <Description><![CDATA[
value is popped off of the stack and converted to an integer. The result, intvalue, is pushed
onto the stack. This uses the ToInt32 algorithm, as described in ECMA-262 section 9.5, to
perform the conversion
]]></Description>
  </convert_i>
  <convert_d Forms="0x75" Format="convert_d" Stack="…, value => …, doublevalue" Operation="Convert a value to a double.">
    <Description><![CDATA[
value is popped off of the stack and converted to a double. The result, doublevalue, is pushed
onto the stack. This uses the ToNumber algorithm, as described in ECMA-262 section 9.3,
to perform the conversion.
]]></Description>
  </convert_d>
  <convert_o Forms="0x77" Format="convert_o" Stack="…, value => …, value" Operation="Convert a value to an Object.">
    <Description><![CDATA[
If value is an Object then nothing happens. Otherwise an exception is thrown.
Runtime exceptions
A TypeError is thrown if value is null or undefined
]]></Description>
  </convert_o>
  <convert_u Forms="0x74" Format="convert_u" Stack="…, value => …, uintvalue" Operation="Convert a value to an unsigned integer.">
    <Description><![CDATA[
value is popped off of the stack and converted to an unsigned integer. The result, uintvalue,
is pushed onto the stack. This uses the ToUint32 algorithm, as described in ECMA-262
section 9.6
]]></Description>
  </convert_u>
  <convert_s Forms="0x70" Format="convert_s" Stack="…, value => …, stringvalue" Operation="Convert a value to a string.">
    <Description><![CDATA[
value is popped off of the stack and converted to a string. The result, stringvalue, is pushed
onto the stack. This uses the ToString algorithm, as described in ECMA-262 section 9.8
]]></Description>
    <Notes><![CDATA[
This is very similar to the coerce_s opcode. The difference is that coerce_s will not
convert a null or undefined value to the string "null" or "undefined" whereas
convert_s will
			
]]></Notes>
  </convert_s>
  <debug Forms="0xef" Format="debug debug_type index reg extra" Stack="… => …" Operation="Debugging info.">
    <Description><![CDATA[
debug_type is an unsigned byte. If the value of debug_type is DI_LOCAL (1), then this is
debugging information for a local register.
index is a u30 that must be an index into the string constant pool. The string at index is the
name to use for this register.
reg is an unsigned byte and is the index of the register that this is debugging information for.
extra is a u30 that is currently unused.

When debug_type has a value of 1, this tells the debugger the name to display for the register
specified by reg. If the debugger is not running, then this instruction does nothing
]]></Description>
  </debug>
  <debugfile Forms="0xf1" Format="debugfile index" Stack="… => …" Operation="Debugging line number info.">
    <Description><![CDATA[
index is a u30 that must be an index into the string constant pool
If the debugger is running, then this instruction sets the current file name in the debugger to
the string at position index of the string constant pool. This lets the debugger know which
instructions are associated with each source file. The debugger will treat all instructions as
occurring in the same file until a new debugfile opcode is encountered.
This instruction must occur before any debugline opcodes
]]></Description>
  </debugfile>
  <debugline Forms="0xf0" Format="debugline linenum" Stack="… => …" Operation="Debugging line number info.">
    <Description><![CDATA[
linenum is a u30 that indicates the current line number the debugger should be using for the
code currently executing.

If the debugger is running, then this instruction sets the current line number in the
debugger. This lets the debugger know which instructions are associated with each line in a
source file. The debugger will treat all instructions as occurring on the same line until a new
debugline opcode is encountered
]]></Description>
  </debugline>
  <declocal Forms="0x94" Format="declocal index" Stack="… => …" Operation="Decrement a local register value.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The value of the local register at index
is converted to a Number using the ToNumber algorithm (ECMA-262 section 9.3) and
then 1 is subtracted from the Number value. The local register at index is then set to the
result
]]></Description>
  </declocal>
  <declocal_i Forms="0xc3" Format="declocal_i index" Stack="… => …" Operation="Decrement a local register value.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The value of the local register at index
is converted to an int using the ToInt32 algorithm (ECMA-262 section 9.5) and then 1 is
subtracted the int value. The local register at index is then set to the result.
]]></Description>
  </declocal_i>
  <decrement Forms="0x93" Format="decrement" Stack="…, value => …, decrementedvalue" Operation="Decrement a value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to a Number using the ToNumber algorithm
(ECMA-262 section 9.3) and then subtract 1 from the Number value. Push the result onto
the stack
]]></Description>
  </decrement>
  <decrement_i Forms="0xc1" Format="decrement_i" Stack="…, value => …, dencrementedvalue" Operation="Decrement an integer value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to an int using the ToInt32 algorithm (ECMA-262
section 9.5) and then subtract 1 from the int value. Push the result onto the stack.
]]></Description>
  </decrement_i>
  <deleteproperty Forms="0x6a" Format="deleteproperty index" Stack="…, object, [ns], [name] => …, value" Operation="Delete a property.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
This will invoke the [[Delete]] method on object with the name specified by the multiname.
If object is not dynamic or the property is a fixed property then nothing happens, and false
is pushed onto the stack. If object is dynamic and the property is not a fixed property, it is
removed from object and true is pushed onto the stack.
Runtime exceptions
A ReferenceError is thrown if object is null or undefined
]]></Description>
  </deleteproperty>
  <divide Forms="0xa3" Format="divide" Stack="…, value1, value2 => …, value3" Operation="Divide two values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 and value2 to Number to create
value1_number and value2_number. Divide value1_number by value2_number and push the
result onto the stack.
]]></Description>
  </divide>
  <dup Forms="0x2a" Format="dup" Stack="…, value => …, value, value" Operation="Duplicates the top value on the stack.">
    <Description><![CDATA[
Duplicates the top value of the stack, and then pushes the duplicated value onto the stack
]]></Description>
  </dup>
  <dxns Forms="0x06" Format="dxns index" Stack="… => …" Operation="Sets the default XML namespace.">
    <Description><![CDATA[
index is a u30 that must be an index into the string constant pool. The string at index is used
as the uri for the default XML namespace for this method.
Runtime exceptions
A VerifyError is thrown if dxns is used in a method that does not have the SETS_DXNS flag
set.
]]></Description>
  </dxns>
  <dxnslate Forms="0x07" Format="dxns" Stack="…, value => …" Operation="Sets the default XML namespace with a value determined at runtime.">
    <Description><![CDATA[
The top value on the stack is popped, converted to a string, and that string is used as the uri
for the default XML namespace for this method.
Runtime exceptions
A VerifyError is thrown if dxnslate is used in a method that does not have the SETS_DXNS
flag set
]]></Description>
  </dxnslate>
  <equals Forms="0xab" Format="equals" Stack="…, value1, value2 => …, result" Operation="Compare two values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compare the two values using the abstract equality
comparison algorithm, as described in ECMA-262 section 11.9.3 and extended in ECMA-
347 section 11.5.1. Push the resulting Boolean value onto the stack.
]]></Description>
  </equals>
  <esc_xattr Forms="0x72" Format="esc_xattr" Stack="…, value => …, stringvalue" Operation="Escape an xml attribute.">
    <Description><![CDATA[
value is popped off of the stack and converted to a string. The result, stringvalue, is pushed
onto the stack. This uses the EscapeAttributeValue algorithm as described in the E4X
specification, ECMA-357 section 10.2.1.2, to perform the conversion
]]></Description>
  </esc_xattr>
  <esc_xelem Forms="0x71" Format="esc_xelem" Stack="…, value => …, stringvalue" Operation="Escape an xml element.">
    <Description><![CDATA[
value is popped off of the stack and converted to a string. The result, stringvalue, is pushed
onto the stack. This uses the ToXmlString algorithm as described in the E4X specification,
ECMA-357 section 10.2, to perform the conversion.
]]></Description>
  </esc_xelem>
  <findproperty Forms="0x5e" Format="findproperty index" Stack="…, [ns], [name] => …, obj" Operation="Search the scope stack for a property.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
This searches the scope stack, and then the saved scope in the current method closure, for a
property with the name specified by the multiname at index.
If any of the objects searched is a with scope, its declared and dynamic properties will be
searched for a match. Otherwise only the declared traits of a scope will be searched. The
global object will have its declared traits, dynamic properties, and prototype chain searched.
If the property is resolved then the object it was resolved in is pushed onto the stack. If the
property is unresolved in all objects on the scope stack then the global object is pushed onto
the stack.
]]></Description>
    <Notes><![CDATA[
Functions save the scope stack when they are created, and this saved scope stack is searched if
no match is found in the current scope stack.
Objects for the with statement are pushed onto the scope stack with the pushwith
instruction
			
]]></Notes>
  </findproperty>
  <findpropstrict Forms="0x5d" Format="findpropstrict index" Stack="…, [ns], [name] => …, obj" Operation="Find a property.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
This searches the scope stack, and then the saved scope in the method closure, for a property
with the name specified by the multiname at index.
If any of the objects searched is a with scope, its declared and dynamic properties will be
searched for a match. Otherwise only the declared traits of a scope will be searched. The
global object will have its declared traits, dynamic properties, and prototype chain searched.
If the property is resolved then the object it was resolved in is pushed onto the stack. If the
property is unresolved in all objects on the scope stack then an exception is thrown.
Runtime exceptions
A ReferenceError is thrown if the property is not resolved in any object on the scope stack.
]]></Description>
    <Notes><![CDATA[
Functions save the scope stack when they are created, and this saved scope stack is searched if
no match is found in the current scope stack.
Objects for the with statement are pushed onto the scope stack with the pushwith
instruction
			
]]></Notes>
  </findpropstrict>
  <getdescendants Forms="0x59" Format="getdescendants index" Stack="…, obj, [ns], [name] => …, value" Operation="Get descendants.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
obj is the object to find the descendants in. This will invoke the [[Descendants]] property on
obj with the multiname specified by index. For a description of the [[Descendants]] operator,
see the E4X spec (ECMA-357) sections 9.1.1.8 (for the XML type) and 9.2.1.8 (for the
XMLList type).
Runtime exceptions
A TypeError is thrown if obj is not of type XML or XMLList.
]]></Description>
  </getdescendants>
  <getglobalscope Forms="0x64" Format="getglobalscope" Stack="… => …, obj" Operation="Gets the global scope.">
    <Description><![CDATA[
Gets the global scope object from the scope stack, and pushes it onto the stack. The global
scope object is the object at the bottom of the scope stack
]]></Description>
  </getglobalscope>
  <getglobalslot Forms="0x6e" Format="getglobalslot slotindex" Stack="… => …, value" Operation="Get the value of a slot on the global scope.">
    <Description><![CDATA[
slotindex is a u30 that must be an index of a slot on the global scope. The slotindex must be
greater than 0 and less than or equal to the total number of slots the global scope has.
This will retrieve the value stored in the slot at slotindex of the global scope. This value is
pushed onto the stack.
]]></Description>
  </getglobalslot>
  <getlex Forms="0x60" Format="getlex index" Stack="… => …, obj" Operation="Find and get a property.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. The multiname at
index must not be a runtime multiname, so there are never any optional namespace or name
values on the stack.
This is the equivalent of doing a findpropstict followed by a getproperty. It will find the
object on the scope stack that contains the property, and then will get the value from that
object. See “Resolving multinames” on page 10.
Runtime exceptions
A ReferenceError is thrown if the property is unresolved in all of the objects on the scope
stack
]]></Description>
  </getlex>
  <getlocal Forms="0x62" Format="getlocal index" Stack="… => …, value" Operation="Get a local register.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The value of that register is pushed
onto the stack.
]]></Description>
  </getlocal>
  <getlocal_n Forms="0xd0 0xd1 0xd2 0xd3" Format="getlocal_n" Stack="… => …, value" Operation="Get a local register.">
    <Description><![CDATA[
<n> is the index of a local register. The value of that register is pushed onto the stack
]]></Description>
  </getlocal_n>
  <getproperty Forms="0x66" Format="getproperty index" Stack="…, object, [ns], [name] => …, value" Operation="Get a property.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
The property with the name specified by the multiname will be resolved in object, and the
value of that property will be pushed onto the stack. If the property is unresolved,
undefined is pushed onto the stack. See “Resolving multinames” on page 10.
]]></Description>
  </getproperty>
  <getscopeobject Forms="0x65" Format="getscopeobject index" Stack="… => …, scope" Operation="Get a scope object.">
    <Description><![CDATA[
index is an unsigned byte that specifies the index of the scope object to retrieve from the local
scope stack. index must be less than the current depth of the scope stack. The scope at that
index is retrieved and pushed onto the stack. The scope at the top of the stack is at index
scope_depth-1, and the scope at the bottom of the stack is index 0.
]]></Description>
    <Notes><![CDATA[
The indexing of elements on the local scope stack is the reverse of the indexing of elements
on the local operand stack
			
]]></Notes>
  </getscopeobject>
  <getslot Forms="0x6c" Format="getslot slotindex" Stack="…, obj => …, value" Operation="Get the value of a slot.">
    <Description><![CDATA[
slotindex is a u30 that must be an index of a slot on obj. slotindex must be less than the total
number of slots obj has.
This will retrieve the value stored in the slot at slotindex on obj. This value is pushed onto the
stack.
Runtime exceptions
A TypeError is thrown if obj is null or undefined.
]]></Description>
  </getslot>
  <getsuper Forms="0x04" Format="getsuper index" Stack="…, obj, [ns], [name] => …, value" Operation="Gets a property from a base class.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime
Once the multiname is constructed, the base class of obj is determined and the multiname is
resolved in the declared traits of the base class. The value of the resolved property is pushed
onto the stack. See “Resolving multinames” on page 10.
Runtime exceptions
A TypeError is thrown if obj is null or undefined.
A ReferenceError is thrown if the property is unresolved, or if the property is write-only
]]></Description>
  </getsuper>
  <greaterequals Forms="0xd0" Format="greaterequals" Stack="…, value1, value2 => …, result" Operation="Determine if one value is greater than or equal to another.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compute value1 < value2 using the Abstract
Relational Comparison Algorithm, as described in ECMA-262 section 11.8.5. If the result of
the comparison is false, push true onto the stack. Otherwise push false onto the stack.
]]></Description>
  </greaterequals>
  <greaterthan Forms="0xaf" Format="greaterthan" Stack="…, value1, value2 => …, result" Operation="Determine if one value is greater than another.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compute value2 < value1 using the Abstract
Relational Comparison Algorithm as described in ECMA-262 section 11.8.5. If the result of
the comparison is true, push true onto the stack. Otherwise push false onto the stack
]]></Description>
  </greaterthan>
  <hasnext Forms="0x1f" Format="hasnext" Stack="…, obj, cur_index => …, next_index" Operation="Determine if the given object has any more properties.">
    <Description><![CDATA[
cur_index and obj are popped off of the stack. cur_index must be of type int. Get the index of
the next property after the property at cur_index. If there are no more properties, then the
result is 0. The result is pushed onto the stack.
]]></Description>
  </hasnext>
  <hasnext2 Forms="0x32" Format="hasnext2 object_reg index_reg" Stack="…, => …, value" Operation="Determine if the given object has any more properties.">
    <Description><![CDATA[
object_reg and index_reg are uints that must be indexes to a local register. The value of the
register at position object_reg is the object that is being enumerated and is assigned to obj.
The value of the register at position index_reg must be of type int, and that value is assigned
to cur_index.
Get the index of the next property after the property located at index cur_index on object
obj. If there are no more properties on obj, then obj is set to the next object on the prototype
chain of obj, and cur_index is set to the first index of that object. If there are no more objects
on the prototype chain and there are no more properties on obj, then obj is set to null, and
cur_index is set to 0.
The register at position object_reg is set to the value of obj, and the register at position
index_reg is set to the value of cur_index.
If index is not 0, then push true. Otherwise push false.
]]></Description>
    <Notes><![CDATA[
hasnext2 works by reference. Each time it is executed it changes the values of local registers
rather than simply returning a new value. This is because the object being enumerated can
change when it is necessary to walk up the prototype chain to find more properties. This is
different from how hasnext works, though the two may seem similar due to the similar
names
			
]]></Notes>
  </hasnext2>
  <ifeq Forms="0x13" Format="ifeq offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is equal to value2.
Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
section 11.9.3 and ECMA-347 section 11.5.1. If the result of the comparison is true, jump
the number of bytes indicated by offset. Otherwise continue executing code from this point
]]></Description>
  </ifeq>
  <iffalse Forms="0x12" Format="iffalse offset" Stack="…, value => …" Operation="Branch if false.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump.
Pop value off the stack and convert it to a Boolean. If the converted value is false, jump the
number of bytes indicated by offset. Otherwise continue executing code from this point
]]></Description>
  </iffalse>
  <ifge Forms="0x18" Format="ifge offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is greater than or equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is greater than or equal to value2.
Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is false, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </ifge>
  <ifgt Forms="0x17" Format="ifgt offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is greater than the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is greater than or equal to value2.
Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </ifgt>
  <ifle Forms="0x16" Format="ifle offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is less than or equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is less than or equal to value2.
Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is false, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </ifle>
  <iflt Forms="0x15" Format="iflt offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is less than the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is less than value2.
Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </iflt>
  <ifnge Forms="0x0f" Format="ifnge offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not greater than or equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not greater than or equal to
value2.
Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is not false, jump the number of bytes
indicated by offset. Otherwise continue executing code from this point.
]]></Description>
    <Notes><![CDATA[
This appears to have the same effect as iflt, however, their handling of NaN is different. If
either of the compared values is NaN then the comparison value1 < value2 will return
undefined. In that case ifnge will branch (undefined is not false), but iflt will not
branch
			
]]></Notes>
  </ifnge>
  <ifngt Forms="0x0e" Format="ifngt offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not greater than the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not greater than or value2.
Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is not true, jump the number of bytes
indicated by offset. Otherwise continue executing code from this point.
]]></Description>
    <Notes><![CDATA[
This appears to have the same effect as ifle, however, their handling of NaN is different. If
either of the compared values is NaN then the comparison value2 < value1 will return

undefined. In that case ifngt will branch (undefined is not true), but ifle will not
branch
			
]]></Notes>
  </ifngt>
  <ifnle Forms="0x0d" Format="ifnle offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not less than or equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not less than or equal to
value2.
Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point.
]]></Description>
    <Notes><![CDATA[
This appears to have the same effect as ifgt, however, their handling of NaN is different. If
either of the compared values is NaN then the comparison value2 < value1 will return
undefined. In that case ifnle will branch (undefined is not false), but ifgt will not
branch
			
]]></Notes>
  </ifnle>
  <ifnlt Forms="0x0c" Format="ifnlt offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not less than the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not less than value2.

Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
section 11.8.5. If the result of the comparison is false, then jump the number of bytes
indicated by offset. Otherwise continue executing code from this point.
]]></Description>
    <Notes><![CDATA[
This appears to have the same effect as ifge, however, their handling of NaN is different. If
either of the compared values is NaN then the comparison value1 < value2 will return
undefined. In that case ifnlt will branch (undefined is not true), but ifge will not
branch
			
]]></Notes>
  </ifnlt>
  <ifne Forms="0x14" Format="ifne offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not equal to value2.
Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
section 11.9.3 and ECMA-347 Section 11.5.1. If the result of the comparison is false,
jump the number of bytes indicated by offset. Otherwise continue executing code from this
point
]]></Description>
  </ifne>
  <ifstricteq Forms="0x19" Format="ifstricteq offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is equal to value2.
Compute value1 === value2 using the strict equality comparison algorithm in ECMA-262
section 11.9.6. If the result of the comparison is true, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </ifstricteq>
  <ifstrictne Forms="0x1a" Format="ifstrictne offset" Stack="…, value1, value2 => …" Operation="Branch if the first value is not equal to the second value.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump if value1 is not equal to value2.
Compute value1 === value2 using the strict equality comparison algorithm in ECMA-262
section 11.9.6. If the result of the comparison is false, jump the number of bytes indicated
by offset. Otherwise continue executing code from this point
]]></Description>
  </ifstrictne>
  <iftrue Forms="0x11" Format="iftrue offset" Stack="…, value => …" Operation="Branch if true.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump.
Pop value off the stack and convert it to a Boolean. If the converted value is true, jump the
number of bytes indicated by offset. Otherwise continue executing code from this point.
]]></Description>
  </iftrue>
  <in Forms="0xb4" Format="in" Stack="…, name, obj => …, result" Operation="Determine whether an object has a named property.">
    <Description><![CDATA[
name is converted to a String, and is looked up in obj. If no property is found, then the
prototype chain is searched by calling [[HasProperty]] on the prototype of obj. If the
property is found result is true. Otherwise result is false. Push result onto the stack
]]></Description>
  </in>
  <inclocal Forms="0x92" Format="inclocal index" Stack="… => …" Operation="Increment a local register value.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The value of the local register at index
is converted to a Number using the ToNumber algorithm (ECMA-262 section 9.3) and
then 1 is added to the Number value. The local register at index is then set to the result
]]></Description>
  </inclocal>
  <inclocal_i Forms="0xc2" Format="inclocal_i index" Stack="… => …" Operation="Increment a local register value.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The value of the local register at index
is converted to an int using the ToInt32 algorithm (ECMA-262 section 9.5) and then 1 is
added to the int value. The local register at index is then set to the result
]]></Description>
  </inclocal_i>
  <increment Forms="0x91" Format="increment" Stack="…, value => …, incrementedvalue" Operation="Increment a value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to a Number using the ToNumber algorithm
(ECMA-262 section 9.3) and then add 1 to the Number value. Push the result onto the
stack
]]></Description>
  </increment>
  <increment_i Forms="0xc0" Format="increment_i" Stack="…, value => …, incrementedvalue" Operation="Increment an integer value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to an int using the ToInt32 algorithm (ECMA-262
section 9.5) and then add 1 to the int value. Push the result onto the stack
]]></Description>
  </increment_i>
  <initproperty Forms="0x68" Format="initproperty index" Stack="…, object, [ns], [name], value => …" Operation="Initialize a property.">
    <Description><![CDATA[
value is the value that the property will be set to. value is popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
The property with the name specified by the multiname will be resolved in object, and will be
set to value. This is used to initialize properties in the initializer method. When used in an
initializer method it is able to set the value of const properties.
Runtime exceptions
A TypeError is thrown if object is null or undefined.
A ReferenceError is thrown if the property is not found and object is not dynamic, or if the
instruction is used to set a const property outside an initializer method
]]></Description>
  </initproperty>
  <instanceof Forms="0xb1" Format="instanceof" Stack="…, value, type => …, result" Operation="Check the prototype chain of an object for the existence of a type.">
    <Description><![CDATA[
Pop value and type off of the stack. If value is null result is false. Walk up the prototype
chain of value looking for type. If type is present anywhere on the prototype, result is true. If
type is not found on the prototype chain, result is false. Push result onto the stack. See
ECMA-262 section 11.8.6 for a further description.
Runtime exceptions
A TypeError is thrown if type is not an Object
]]></Description>
  </instanceof>
  <istype Forms="0xb2" Format="istype index" Stack="…, value => …, result" Operation="Check whether an Object is of a certain type.">
    <Description><![CDATA[
index is a u30 that must be an index into the multiname constant pool. The multiname at
index must not be a runtime multiname.
Resolve the type specified by the multiname. Let indexType refer to that type. Compute the
type of value, and let valueType refer to that type. If valueType is the same as indexType, result
is true. If indexType is a base type of valueType, or an implemented interface of valueType,
then result is true. Otherwise result is set to false. Push result onto the stack
]]></Description>
  </istype>
  <istypelate Forms="0xb3" Format="istypelate" Stack="…, value, type => …, result" Operation="Check whether an Object is of a certain type.">
    <Description><![CDATA[
Compute the type of value, and let valueType refer to that type. If valueType is the same as
type, result is true. If type is a base type of valueType, or an implemented interface of
valueType, then result is true. Otherwise result is set to false. Push result onto the stack.
Runtime exceptions
A TypeError is thrown if type is not a Class
]]></Description>
  </istypelate>
  <jump Forms="0x10" Format="jump offset" Stack="… => …" Operation="Unconditional branch.">
    <Description><![CDATA[
offset is an s24 that is the number of bytes to jump. Jump the number of bytes indicated by
offset and resume execution there
]]></Description>
  </jump>
  <kill Forms="0x08" Format="kill index" Stack="… => …" Operation="Kills a local register.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The local register at index is killed. It
is killed by setting its value to undefined.

]]></Description>
    <Notes><![CDATA[
This is usually used so that different jumps to the same location will have the same types in
the local registers. The verifier ensures that all paths to a location have compatible values in
the local registers, if not a VerifyError occurs. This can be used to kill temporary values that
were stored in local registers before a jump so that no VerifyError occurs
			
]]></Notes>
  </kill>
  <label Forms="0x09" Format="label" Stack="… => …" Operation="Do nothing.">
    <Description><![CDATA[
Do nothing. Used to indicate that this location is the target of a branch.
]]></Description>
    <Notes><![CDATA[
This is usually used to indicate the target of a backwards branch. The label opcode will
prevent the verifier from thinking that the code after the label is unreachable
			
]]></Notes>
  </label>
  <lessequals Forms="0xae" Format="lessequals" Stack="…, value1, value2 => …, result" Operation="Determine if one value is less than or equal to another.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compute value2 < value1 using the Abstract
Relational Comparison Algorithm as described in ECMA-262 section 11.8.5. If the result of
the comparison is false, push true onto the stack. Otherwise push false onto the stack.
]]></Description>
  </lessequals>
  <lessthan Forms="0xad" Format="lessthan" Stack="…, value1, value2 => …, result" Operation="Determine if one value is less than another.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compute value1 < value2 using the Abstract
Relational Comparison Algorithm as described in ECMA-262 section 11.8.5. If the result of
the comparison is true, then push true onto the stack. Otherwise push false onto the
stack
]]></Description>
  </lessthan>
  <lookupswitch Forms="0x1b" Format="lookupswitch default_offset case_count case_offsets..." Stack="…, index => …" Operation="Jump to different locations based on an index.">
    <Description><![CDATA[
default_offset is an s24 that is the offset to jump, in bytes, for the default case. case_offsets are
each an s24 that is the offset to jump for a particular index. There are case_count+1 case
offsets. case_count is a u30.
index is popped off of the stack and must be of type int. If index is less than zero or greater
than case_count, the target is calculated by adding default_offset to the base location.
Otherwise the target is calculated by adding the case_offset at position index to the base
location. Execution continues from the target location.
The base location is the address of the lookupswitch instruction itself.

]]></Description>
    <Notes><![CDATA[
Other control flow instructions take the base location to be the address of the following
instruction
			
]]></Notes>
  </lookupswitch>
  <lshift Forms="0xa5" Format="lshift" Stack="…, value1, value2 => …, value3" Operation="Bitwise left shift.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack; convert value1 to an int to create value1_int ; and
convert value2 to a uint to create value2_uint. Left shift value1_int by the result of
value2_uint & 0x1F (leaving only the 5 least significant bits of value2_uint), and push the
result onto the stack. See ECMA-262 section 11.7.1
]]></Description>
  </lshift>
  <modulo Forms="0xa4" Format="modulo" Stack="…, value1, value2 => …, value3" Operation="Perform modulo division on two values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 and value2 to Number to create
value1_number and value2_number. Perform value1_number mod value2_number and push
the result onto the stack.
]]></Description>
  </modulo>
  <multiply Forms="0xa2" Format="multiply" Stack="…, value1, value2 => …, value3" Operation="Multiply two values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 and value2 to Number to create
value1_number and value2_number. Multiply value1_number by value2_number and push
the result onto the stack
]]></Description>
  </multiply>
  <multiply_i Forms="0xc7" Format="multiply_i" Stack="…, value1, value2 => …, value3" Operation="Multiply two integer values.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 and value2 to int to create value1_int
and value2_int. Multiply value1_int by value2_int and push the result onto the stack
]]></Description>
  </multiply_i>
  <negate Forms="0x90" Format="negate" Stack="…, value => …, -value" Operation="Negate a value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to a Number using the ToNumber algorithm
(ECMA-262 section 9.3) and then negate the Number value. Push the result onto the stack
]]></Description>
  </negate>
  <negate_i Forms="0xc4" Format="negate_i" Stack="…, value => …, -value" Operation="Negate an integer value.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to an int using the ToInt32 algorithm (ECMA-262
section 9.5) and then negate the int value. Push the result onto the stack
]]></Description>
  </negate_i>
  <newactivation Forms="0x57" Format="newactivation" Stack="… => …, newactivation" Operation="Create a new activation object.">
    <Description><![CDATA[
Creates a new activation object, newactivation, and pushes it onto the stack. Can only be
used in methods that have the NEED_ACTIVATION flag set in their MethodInfo entry.
]]></Description>
  </newactivation>
  <newarray Forms="0x56" Format="newobject arg_count" Stack="…, value1, value2, ..., valueN => …, newarray" Operation="Create a new array.">
    <Description><![CDATA[
arg_count is a u30 that is the number of entries that will be created in the new array. There
will be a total of arg_count values on the stack.
A new value of type Array is created and assigned to newarray. The values on the stack will
be assigned to the entries of the array, so newarray[0] = value1, newarray[1] = value2, ....,
newarray[N-1] = valueN. newarray is then pushed onto the stack
]]></Description>
  </newarray>
  <newcatch Forms="0x5a" Format="newcatch index" Stack="… => …, catchscope" Operation="Create a new catch scope.">
    <Description><![CDATA[
index is a u30 that must be an index of an exception_info structure for this method.
This instruction creates a new object to serve as the scope object for the catch block for the
exception referenced by index. This new scope is pushed onto the operand stack.
]]></Description>
  </newcatch>
  <newclass Forms="0x58" Format="newclass index" Stack="…, basetype => …, newclass" Operation="Create a new class.">
    <Description><![CDATA[
index is a u30 that is an index of the ClassInfo that is to be created. basetype must be the
base class of the class being created, or null if there is no base class.
The class that is represented by the ClassInfo at position index of the ClassInfo entries is
created with the given basetype as the base class. This will run the static initializer function
for the class. The new class object, newclass, will be pushed onto the stack.
When this instruction is executed, the scope stack must contain all the scopes of all base
classes, as the scope stack is saved by the created ClassClosure
]]></Description>
  </newclass>
  <newfunction Forms="0x40" Format="newfunction index" Stack="… => …, function_obj" Operation="Create a new function object.">
    <Description><![CDATA[
index is a u30 that must be an index of a method_info. A new function object is created
from that method_info and pushed onto the stack. For a description of creating a new
function object, see ECMA-262 section 13.2.
When creating the new function object the scope stack used is the current scope stack when
this instruction is executed, and the body is the method_body entry that references the
specified method_info entry.
]]></Description>
  </newfunction>
  <newobject Forms="0x55" Format="newobject arg_count" Stack="…, name1, value1, name2, value2,...,nameN, valueN => …, newobj" Operation="Create a new object.">
    <Description><![CDATA[
arg_count is a u30 that is the number of properties that will be created in newobj. There will
be a total of arg_count name values on the stack, which will be of type String (name1 to
nameN). There will be an equal number of values on the stack, which can be of any type,
and will be the initial values for the properties
A new value of type Object is created and assigned to newobj. The properties specified on the
stack will be dynamically added to newobj. The names of the properties will be name1,
name2,..., nameN and these properties will be set to the corresponding values (value1,
value2,..., valueN). newobj is then pushed onto the stack
]]></Description>
  </newobject>
  <nextname Forms="0x1e" Format="nextname" Stack="…, obj, index => …, name" Operation="Get the name of the next property when iterating over an object.">
    <Description><![CDATA[
index and obj are popped off of the stack. index must be a value of type int. Gets the name of
the property that is at position index + 1 on the object obj, and pushes it onto the stack.
]]></Description>
    <Notes><![CDATA[
index will usually be the result of executing hasnext on obj.
			
]]></Notes>
  </nextname>
  <nextvalue Forms="0x23" Format="nextvalue" Stack="…, obj, index => …, value" Operation="Get the name of the next property when iterating over an object.">
    <Description><![CDATA[
index and obj are popped off of the stack. index must be of type int. Get the value of the
property that is at position index + 1 on the object obj, and pushes it onto the stack.
]]></Description>
    <Notes><![CDATA[
Index will usually be the result of executing hasnext on obj
			
]]></Notes>
  </nextvalue>
  <nop Forms="0x02" Format="nop" Stack="… => …" Operation="Do nothing.">
    <Description><![CDATA[
Do nothing.
]]></Description>
  </nop>
  <not Forms="0x96" Format="not" Stack="…, value => …, !value" Operation="Boolean negation.">
    <Description><![CDATA[
Pop value off of the stack. Convert value to a Boolean using the ToBoolean algorithm
(ECMA-262 section 9.2) and then negate the Boolean value. Push the result onto the stack
]]></Description>
  </not>
  <pop Forms="0x29" Format="pop" Stack="…, value => …" Operation="Pop the top value from the stack.">
    <Description><![CDATA[
Pops the top value from the stack and discards it.
]]></Description>
  </pop>
  <popscope Forms="0x1d" Format="popscope" Stack="… => …" Operation="Pop a scope off of the scope stack">
    <Description><![CDATA[
Pop the top scope off of the scope stack and discards it
]]></Description>
  </popscope>
  <pushbyte Forms="0x24" Format="pushbyte byte_value" Stack="… => …, value" Operation="Push a byte value.">
    <Description><![CDATA[
byte_value is an unsigned byte. The byte_value is promoted to an int, and the result is pushed
onto the stack.
]]></Description>
  </pushbyte>
  <pushdouble Forms="0x2f" Format="pushdouble index" Stack="… => …, value" Operation="Push a double value onto the stack.">
    <Description><![CDATA[
index is a u30 that must be an index into the double constant pool. The double value at
index in the double constant pool is pushed onto the stack
]]></Description>
  </pushdouble>
  <pushfalse Forms="0x27" Format="pushfalse" Stack="… => …, false" Operation="Push false.">
    <Description><![CDATA[
Push the false value onto the stack.
]]></Description>
  </pushfalse>
  <pushint Forms="0x2d" Format="pushint index" Stack="… => …, value" Operation="Push an int value onto the stack.">
    <Description><![CDATA[
index is a u30 that must be an index into the integer constant pool. The int value at index in
the integer constant pool is pushed onto the stack
]]></Description>
  </pushint>
  <pushnamespace Forms="0x31" Format="pushnamespace index" Stack="… => …, namespace" Operation="Push a namespace.">
    <Description><![CDATA[
index is a u30 that must be an index into the namespace constant pool. The namespace value
at index in the namespace constant pool is pushed onto the stack
]]></Description>
  </pushnamespace>
  <pushnan Forms="0x28" Format="pushnan" Stack="… => …, NaN" Operation="Push NaN.">
    <Description><![CDATA[
Push the value NaN onto the stack
]]></Description>
  </pushnan>
  <pushnull Forms="0x20" Format="pushnull" Stack="… => …, null" Operation="Push null.">
    <Description><![CDATA[
Push the null value onto the stack
]]></Description>
  </pushnull>
  <pushscope Forms="0x30" Format="pushscope" Stack="…, value => …" Operation="Push an object onto the scope stack.">
    <Description><![CDATA[
Pop value off of the stack. Push value onto the scope stack.
Runtime exceptions
A TypeError is thrown if value is null or undefined.
]]></Description>
  </pushscope>
  <pushshort Forms="0x25" Format="pushshort value" Stack="… => …, value" Operation="Push a short value.">
    <Description><![CDATA[
value is a u30. The value is pushed onto the stack
]]></Description>
  </pushshort>
  <pushstring Forms="0x2c" Format="pushstring index" Stack="… => …, value" Operation="Push a string value onto the stack.">
    <Description><![CDATA[
index is a u30 that must be an index into the string constant pool. The string value at index
in the string constant pool is pushed onto the stack.
]]></Description>
  </pushstring>
  <pushtrue Forms="0x26" Format="pushtrue" Stack="… => …, true" Operation="Push true.">
    <Description><![CDATA[
Push the true value onto the stack
]]></Description>
  </pushtrue>
  <pushuint Forms="0x2e" Format="pushuint index" Stack="… => …, value" Operation="Push an unsigned int value onto the stack.">
    <Description><![CDATA[
index is a u30 that must be an index into the unsigned integer constant pool. The value at
index in the unsigned integer constant pool is pushed onto the stack.
]]></Description>
  </pushuint>
  <pushundefined Forms="0x21" Format="pushundefined" Stack="… => …, undefined" Operation="Push undefined.">
    <Description><![CDATA[
Push the undefined value onto the stack
]]></Description>
  </pushundefined>
  <pushwith Forms="0x1c" Format="pushwith" Stack="…, scope_obj => …" Operation="Push a with scope onto the scope stack">
    <Description><![CDATA[
scope_obj is popped off of the stack, and the object is pushed onto the scope stack. scope_obj can be of
any type.
Runtime exceptions
A TypeError is thrown if scope_obj is null or undefined.
]]></Description>
  </pushwith>
  <returnvalue Forms="0x48" Format="returnvalue" Stack="…, return_value => …" Operation="Return a value from a method.">
    <Description><![CDATA[
Return from the currently executing method. This returns the top value on the stack.
return_value is popped off of the stack, and coerced to the expected return type of the
method. The coerced value is what is actually returned from the method.
Runtime exceptions
A TypeError is thrown if return_value cannot be coerced to the expected return type of the
executing method
]]></Description>
  </returnvalue>
  <returnvoid Forms="0x47" Format="returnvoid" Stack="… => …" Operation="Return from a method.">
    <Description><![CDATA[
Return from the currently executing method. This returns the value undefined. If the
method has a return type, then undefined is coerced to that type and then returned.
]]></Description>
  </returnvoid>
  <rshift Forms="0xa6" Format="rshift" Stack="…, value1, value2 => …, value3" Operation="Signed bitwise right shift.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 to an int to create value1_int and
convert value2 to a uint to create value2_uint. Right shift value1_int by the result of
value2_uint & 0x1F (leaving only the 5 least significant bits of value2_uint), and push the
result onto the stack. The right shift is sign extended, resulting in a signed 32-bit integer. See
ECMA-262 section 11.7.
]]></Description>
  </rshift>
  <setlocal Forms="0x63" Format="setlocal index" Stack="…, value => …" Operation="Set a local register.">
    <Description><![CDATA[
index is a u30 that must be an index of a local register. The register at index is set to value,
and value is popped off the stack.
]]></Description>
  </setlocal>
  <setlocal_n Forms="0xd4 0xd5 0xd6 0xd7" Format="setlocal_n" Stack="…, value => …" Operation="Set a local register.">
    <Description><![CDATA[
<n> is an index of a local register. The register at that index is set to value, and value is
popped off the stack
]]></Description>
  </setlocal_n>
  <setglobalslot Forms="0x6f" Format="setglobalslot slotindex" Stack="…, value => …" Operation="Set the value of a slot on the global scope.">
    <Description><![CDATA[
slotindex is a u30 that must be an index of a slot on the global scope. The slotindex must be
greater than zero and less than or equal to the total number of slots the global scope has.
This instruction will set the value of the slot at slotindex of the global scope to value. value is
first coerced to the type of the slot indicated by slotindex.
]]></Description>
  </setglobalslot>
  <setproperty Forms="0x61" Format="setproperty index" Stack="…, obj, [ns], [name], value => …" Operation="Set a property.">
    <Description><![CDATA[
value is the value that the property will be set to. value is popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
The property with the name specified by the multiname will be resolved in obj, and will be
set to value. If the property is not found in obj, and obj is dynamic then the property will be
created and set to value. See “Resolving multinames” on page 10.
Runtime exceptions
A TypeError is thrown if obj is null or undefined.
A ReferenceError is thrown if the property is const, or if the property is unresolved and obj is
not dynamic
]]></Description>
  </setproperty>
  <setslot Forms="0x6d" Format="setslot slotindex" Stack="…, obj, value => …" Operation="Set the value of a slot.">
    <Description><![CDATA[
slotindex is a u30 that must be an index of a slot on obj. slotindex must be greater than 0 and
less than or equal to the total number of slots obj has.

This will set the value stored in the slot at slotindex on obj to value. value is first coerced to
the type of the slot at slotindex.
Runtime exceptions
A TypeError is thrown if obj is null or undefined
]]></Description>
  </setslot>
  <setsuper Forms="0x05" Format="setsuper index" Stack="…, obj, [ns], [name], value => …" Operation="Sets a property in a base class.">
    <Description><![CDATA[
value is the value that the property will be set to. value is popped off the stack and saved.
index is a u30 that must be an index into the multiname constant pool. If the multiname at
that index is a runtime multiname the name and/or namespace will also appear on the stack
so that the multiname can be constructed correctly at runtime.
Once the multiname is constructed the base class of obj is determined and the multiname is
resolved in the declared traits of the base class. The property is then set to value. See
“Resolving multinames” on page 10.
Runtime exceptions
A TypeError is thrown if obj is null or undefined.
A ReferenceError is thrown if the property is unresolved, or if the property is read-only
]]></Description>
  </setsuper>
  <strictequals Forms="0xac" Format="strictequals" Stack="…, value1, value2 => …, result" Operation="Compare two values strictly.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack. Compare the two values using the Strict Equality
Comparison Algorithm as described in ECMA-262 section 11.9.6. Push the resulting
Boolean value onto the stack
]]></Description>
  </strictequals>
  <subtract Forms="0xa1" Format="subtract" Stack="…, value1, value2 => …, value3" Operation="subtract one value from another.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack and convert value1 and value2 to Number to create
value1_number and value2_number. Subtract value2_number from value1_number. Push the
result onto the stack.
]]></Description>
    <Notes><![CDATA[
For more information, see ECMA-262 section 11.6 (“Additive Operators”)
			
]]></Notes>
  </subtract>
  <subtract_i Forms="0xc6" Format="subtract_i" Stack="…, value1, value2 => …, value3" Operation="Subtract an integer value from another integer value.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack and convert value1 and value2 to int to create
value1_int and value2_int. Subtract value2_int from value1_int. Push the result onto the
stack
]]></Description>
  </subtract_i>
  <swap Forms="0x2b" Format="swap" Stack="…, value1, value2 => …, value2, value1" Operation="Swap the top two operands on the stack">
    <Description><![CDATA[
Swap the top two values on the stack. Pop value2 and value1. Push value2, then push value1
]]></Description>
  </swap>
  <throw Forms="0x03" Format="throw" Stack="…, value => …" Operation="Throws an exception.">
    <Description><![CDATA[
The top value of the stack is popped off the stack and then thrown. The thrown value can be
of any type.

When a throw is executed, the current method’s exception handler table is searched for an
exception handler. An exception handler matches if its range of offsets includes the offset of
this instruction, and if its type matches the type of the thrown object, or is a base class of the
type thrown. The first handler that matches is the one used.
If a handler is found then the stack is cleared, the exception object is pushed onto the stack,
and then execution resumes at the instruction offset specified by the handler.
If a handler is not found, then the method exits, and the exception is rethrown in the
invoking method, at which point it is searched for an exception handler as described here
]]></Description>
  </throw>
  <typeof Forms="0x95" Format="typeof" Stack="…, value => …, typename" Operation="Get the type name of a value.">
    <Description><![CDATA[
Pop a value off of the stack. Determine its type name according to the type of value:
1. undefined = "undefined"
2. null = "object"
3. Boolean = "Boolean"
4. Number | int | uint = "number"
5. String = "string"
6. Function = "function"
7. XML | XMLList = "xml"
8. Object = "object"
Push typename onto the stack
]]></Description>
  </typeof>
  <urshift Forms="0xa7" Format="urshift" Stack="…, value1, value2 => …, value3" Operation="Unsigned bitwise right shift.">
    <Description><![CDATA[
Pop value1 and value2 off of the stack, convert value1 to an int to create value1_int and
convert value2 to a uint to create value2_uint. Right shift value1_int by the result of
value2_uint & 0x1F (leaving only the 5 least significant bits of value2_uint), and push the
result onto the stack. The right shift is unsigned and fills in missing bits with 0, resulting in
an unsigned 32-bit integer. See ECMA-262 section 11.7.
]]></Description>
  </urshift>
</op>
*/
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

/*
//00 
_as3_OP_0x00 
//01 
_as3_bkpt 
//02 
_as3_nop 
//03 
_as3_throw 
//04 00 
_as3_getsuper 
//05 00 
_as3_setsuper 
//06 00 
_as3_dxns 
//07 
_as3_dxnslate 
//08 00 
_as3_kill <0>
//09 
_as3_label 
//0a 
_as3_OP_0x0A 
//0b 
_as3_OP_0x0B 
//0c 00 00 00 
_as3_ifnlt offset: 0
//0d 00 00 00 
_as3_ifnle offset: 0
//0e 00 00 00 
_as3_ifngt offset: 0
//0f 00 00 00 
_as3_ifnge offset: 0
//10 00 00 00 
_as3_jump offset: 0
//11 00 00 00 
_as3_iftrue offset: 0
//12 00 00 00 
_as3_iffalse offset: 0
//13 00 00 00 
_as3_ifeq offset: 0
//14 00 00 00 
_as3_ifne offset: 0
//15 00 00 00 
_as3_iflt offset: 0
//16 00 00 00 
_as3_ifle offset: 0
//17 00 00 00 
_as3_ifgt offset: 0
//18 00 00 00 
_as3_ifge offset: 0
//19 00 00 00 
_as3_ifstricteq offset: 0
//1a 00 00 00 
_as3_ifstrictne offset: 0
//1b 00 00 00 00 00 00 00 
_as3_lookupswitch 0(0)[0]
//1c 
_as3_pushwith 
//1d 
_as3_popscope 
//1e 
_as3_nextname 
//1f 
_as3_hasnext 
//20 
_as3_pushnull 
//21 
_as3_pushundefined 
//22 00 
_as3_OP_0x22 (op_pushconstant)
//23 
_as3_nextvalue 
//24 00 
_as3_pushbyte 0
//25 00 
_as3_pushshort 0
//26 
_as3_pushtrue 
//27 
_as3_pushfalse 
//28 
_as3_pushnan 
//29 
_as3_pop 
//2a 
_as3_dup 
//2b 
_as3_swap 
//2c 00 
_as3_pushstring ""
//2d 00 
_as3_pushint 0
//2e 00 
_as3_pushuint 0
//2f 00 
_as3_pushdouble 0
//30 
_as3_pushscope 
//31 00 
_as3_pushnamespace 
//32 00 00 
_as3_hasnext2 0, 0
//33 
_as3_OP_0x33 
//34 
_as3_OP_0x34 
//35 
_as3_OP_0x35 
//36 
_as3_OP_0x36 
//37 
_as3_OP_0x37 
//38 
_as3_OP_0x38 
//39 
_as3_OP_0x39 
//3a 
_as3_OP_0x3A 
//3b 
_as3_OP_0x3B 
//3c 
_as3_OP_0x3C 
//3d 
_as3_OP_0x3D 
//3e 
_as3_OP_0x3E 
//3f 
_as3_OP_0x3F 
//40 00 
_as3_newfunction 
//41 00 
_as3_call (param count:0)
//42 00 
_as3_construct (param count:0)
//43 00 00 
_as3_callmethod (param count:0)
//44 00 00 
_as3_callstatic (param count:0)
//45 00 00 
_as3_callsuper (param count:0)
//46 00 00 
_as3_callproperty (param count:0)
//47 
_as3_returnvoid 
//48 
_as3_returnvalue 
//49 00 
_as3_constructsuper (param count:0)
//4a 00 00 
_as3_constructprop (param count:0)
//4b 
_as3_callsuperid 
//4c 00 00 
_as3_callproplex (param count:0)
//4d 
_as3_callinterface 
//4e 00 00 
_as3_callsupervoid (param count:0)
//4f 00 00 
_as3_callpropvoid (param count:0)
//50 
_as3_OP_0x50 
//51 
_as3_OP_0x51 
//52 
_as3_OP_0x52 
//53 
_as3_OP_0x53 
//54 
_as3_OP_0x54 
//55 00 
_as3_newobject {object count:0}
//56 00 
_as3_newarray [array size:0]
//57 
_as3_newactivation 
//58 00 
_as3_newclass EncryptTest
//59 00 
_as3_getdescendants 
//5a 00 
_as3_newcatch <0>
//5b 
_as3_OP_0x5B 
//5c 
_as3_OP_0x5C 
//5d 00 
_as3_findpropstrict 
//5e 00 
_as3_findproperty 
//5f 00 
_as3_finddef 
//60 00 
_as3_getlex 
//61 00 
_as3_setproperty 
//62 00 
_as3_getlocal <0>
//63 00 
_as3_setlocal <0>
//64 
_as3_getglobalscope 
//65 00 
_as3_getscopeobject 0
//66 00 
_as3_getproperty 
//67 
_as3_OP_0x67 
//68 00 
_as3_initproperty 
//69 
_as3_OP_0x69 
//6a 00 
_as3_deleteproperty 
//6b 
_as3_OP_0x6B 
//6c 00 
_as3_getslot <0>
//6d 00 
_as3_setslot <0>
//6e 00 
_as3_getglobalslot <0>
//6f 00 
_as3_setglobalslot <0>
//70 
_as3_convert_s 
//71 
_as3_esc_xelem 
//72 
_as3_esc_xattr 
//73 
_as3_convert_i 
//74 
_as3_convert_u 
//75 
_as3_convert_d 
//76 
_as3_convert_b 
//77 
_as3_convert_o 
//78 
_as3_checkfilter 
//79 
_as3_OP_0x79 
//7a 
_as3_OP_0x7A 
//7b 
_as3_OP_0x7B 
//7c 
_as3_OP_0x7C 
//7d 
_as3_OP_0x7D 
//7e 
_as3_OP_0x7E 
//7f 
_as3_OP_0x7F 
//80 00 
_as3_coerce 
//81 
_as3_coerce_b 
//82 
_as3_coerce_a 
//83 
_as3_coerce_i 
//84 
_as3_coerce_d 
//85 
_as3_coerce_s 
//86 00 
_as3_astype 
//87 
_as3_astypelate 
//88 
_as3_coerce_u 
//89 
_as3_coerce_o 
//8a 
_as3_OP_0x8A 
//8b 
_as3_OP_0x8B 
//8c 
_as3_OP_0x8C 
//8d 
_as3_OP_0x8D 
//8e 
_as3_OP_0x8E 
//8f 
_as3_OP_0x8F 
//90 
_as3_negate 
//91 
_as3_increment 
//92 00 
_as3_inclocal <0>
//93 
_as3_decrement 
//94 00 
_as3_declocal <0>
//95 
_as3_typeof 
//96 
_as3_not 
//97 
_as3_bitnot 
//98 
_as3_OP_0x98 
//99 
_as3_OP_0x99 
//9a 
_as3_concat 
//9b 
_as3_add_d 
//9c 
_as3_OP_0x9C 
//9d 
_as3_OP_0x9D 
//9e 
_as3_OP_0x9E 
//9f 
_as3_OP_0x9F 
//a0 
_as3_add 
//a1 
_as3_subtract 
//a2 
_as3_multiply 
//a3 
_as3_divide 
//a4 
_as3_modulo 
//a5 
_as3_lshift 
//a6 
_as3_rshift 
//a7 
_as3_urshift 
//a8 
_as3_bitand 
//a9 
_as3_bitor 
//aa 
_as3_bitxor 
//ab 
_as3_equals 
//ac 
_as3_strictequals 
//ad 
_as3_lessthan 
//ae 
_as3_lessequals 
//af 
_as3_greaterthan 
//b0 
_as3_greaterequals 
//b1 
_as3_instanceof 
//b2 00 
_as3_istype 
//b3 
_as3_istypelate 
//b4 
_as3_in 
//b5 
_as3_OP_0xB5 
//b6 
_as3_OP_0xB6 
//b7 
_as3_OP_0xB7 
//b8 
_as3_OP_0xB8 
//b9 
_as3_OP_0xB9 
//ba 
_as3_OP_0xBA 
//bb 
_as3_OP_0xBB 
//bc 
_as3_OP_0xBC 
//bd 
_as3_OP_0xBD 
//be 
_as3_OP_0xBE 
//bf 
_as3_OP_0xBF 
//c0 
_as3_increment_i 
//c1 
_as3_decrement_i 
//c2 00 
_as3_inclocal_i <0>
//c3 00 
_as3_declocal_i <0>
//c4 
_as3_negate_i 
//c5 
_as3_add_i 
//c6 
_as3_subtract_i 
//c7 
_as3_multiply_i 
//c8 
_as3_OP_0xC8 
//c9 
_as3_OP_0xC9 
//ca 
_as3_OP_0xCA 
//cb 
_as3_OP_0xCB 
//cc 
_as3_OP_0xCC 
//cd 
_as3_OP_0xCD 
//ce 
_as3_OP_0xCE 
//cf 
_as3_OP_0xCF 
//d0 
_as3_getlocal <0> 
//d1 
_as3_getlocal <1> 
//d2 
_as3_getlocal <2> 
//d3 
_as3_getlocal <3> 
//d4 
_as3_setlocal <0> 
//d5 
_as3_setlocal <1> 
//d6 
_as3_setlocal <2> 
//d7 
_as3_setlocal <3> 
//d8 
_as3_OP_0xD8 
//d9 
_as3_OP_0xD9 
//da 
_as3_OP_0xDA 
//db 
_as3_OP_0xDB 
//dc 
_as3_OP_0xDC 
//dd 
_as3_OP_0xDD 
//de 
_as3_OP_0xDE 
//df 
_as3_OP_0xDF 
//e0 
_as3_OP_0xE0 
//e1 
_as3_OP_0xE1 
//e2 
_as3_OP_0xE2 
//e3 
_as3_OP_0xE3 
//e4 
_as3_OP_0xE4 
//e5 
_as3_OP_0xE5 
//e6 
_as3_OP_0xE6 
//e7 
_as3_OP_0xE7 
//e8 
_as3_OP_0xE8 
//e9 
_as3_OP_0xE9 
//ea 
_as3_OP_0xEA 
//eb 
_as3_OP_0xEB 
//ec 
_as3_OP_0xEC 
//ed 
_as3_OP_0xED 
//ee 00 
_as3_abs_jump offset: 0
//ef 00 00 00 00 
_as3_debug 0, 0, 0, 0
//f0 00 
_as3_debugline line number: 0
//f1 00 
_as3_debugfile ""
//f2 00 
_as3_bkptline line number: 0
//f3 
_as3_timestamp 
//f4 
_as3_OP_0xF4 
//f5 
_as3_verifypass 
//f6 
_as3_alloc 
//f7 
_as3_mark 
//f8 
_as3_wb 
//f9 
_as3_prologue 
//fa 
_as3_sendenter 
//fb 
_as3_doubletoatom 
//fc 
_as3_sweep 
//fd 
_as3_codegenop 
//fe 
_as3_verifyop 
//ff 
_as3_decode 
*/