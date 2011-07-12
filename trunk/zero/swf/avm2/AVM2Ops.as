/***
AVM2Ops
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:18（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{

	public class AVM2Ops{
		//0x00
		public static const bkpt:int=1;//0x01
		public static const nop:int=2;//0x02
		public static const throw_:int=3;//0x03
		public static const getsuper:int=4;//0x04
		public static const setsuper:int=5;//0x05
		public static const dxns:int=6;//0x06
		public static const dxnslate:int=7;//0x07
		public static const kill:int=8;//0x08
		public static const label:int=9;//0x09
		//0x0a
		//0x0b
		public static const ifnlt:int=12;//0x0c
		public static const ifnle:int=13;//0x0d
		public static const ifngt:int=14;//0x0e
		public static const ifnge:int=15;//0x0f
		public static const jump:int=16;//0x10
		public static const iftrue:int=17;//0x11
		public static const iffalse:int=18;//0x12
		public static const ifeq:int=19;//0x13
		public static const ifne:int=20;//0x14
		public static const iflt:int=21;//0x15
		public static const ifle:int=22;//0x16
		public static const ifgt:int=23;//0x17
		public static const ifge:int=24;//0x18
		public static const ifstricteq:int=25;//0x19
		public static const ifstrictne:int=26;//0x1a
		public static const lookupswitch:int=27;//0x1b
		public static const pushwith:int=28;//0x1c
		public static const popscope:int=29;//0x1d
		public static const nextname:int=30;//0x1e
		public static const hasnext:int=31;//0x1f
		public static const pushnull:int=32;//0x20
		public static const pushundefined:int=33;//0x21
		//0x22
		public static const nextvalue:int=35;//0x23
		public static const pushbyte:int=36;//0x24
		public static const pushshort:int=37;//0x25
		public static const pushtrue:int=38;//0x26
		public static const pushfalse:int=39;//0x27
		public static const pushnan:int=40;//0x28
		public static const pop:int=41;//0x29
		public static const dup:int=42;//0x2a
		public static const swap:int=43;//0x2b
		public static const pushstring:int=44;//0x2c
		public static const pushint:int=45;//0x2d
		public static const pushuint:int=46;//0x2e
		public static const pushdouble:int=47;//0x2f
		public static const pushscope:int=48;//0x30
		public static const pushnamespace:int=49;//0x31
		public static const hasnext2:int=50;//0x32
		//0x33
		//0x34
		public static const li8:int=53;//0x35
		public static const li16:int=54;//0x36
		public static const li32:int=55;//0x37
		public static const lf32:int=56;//0x38
		public static const lf64:int=57;//0x39
		public static const si8:int=58;//0x3a
		public static const si16:int=59;//0x3b
		public static const si32:int=60;//0x3c
		public static const sf32:int=61;//0x3d
		public static const sf64:int=62;//0x3e
		//0x3f
		public static const newfunction:int=64;//0x40
		public static const call:int=65;//0x41
		public static const construct:int=66;//0x42
		public static const callmethod:int=67;//0x43
		public static const callstatic:int=68;//0x44
		public static const callsuper:int=69;//0x45
		public static const callproperty:int=70;//0x46
		public static const returnvoid:int=71;//0x47
		public static const returnvalue:int=72;//0x48
		public static const constructsuper:int=73;//0x49
		public static const constructprop:int=74;//0x4a
		//0x4b
		public static const callproplex:int=76;//0x4c
		//0x4d
		public static const callsupervoid:int=78;//0x4e
		public static const callpropvoid:int=79;//0x4f
		public static const sxi1:int=80;//0x50
		public static const sxi8:int=81;//0x51
		public static const sxi16:int=82;//0x52
		public static const applytype:int=83;//0x53
		//0x54
		public static const newobject:int=85;//0x55
		public static const newarray:int=86;//0x56
		public static const newactivation:int=87;//0x57
		public static const newclass:int=88;//0x58
		public static const getdescendants:int=89;//0x59
		public static const newcatch:int=90;//0x5a
		//0x5b
		//0x5c
		public static const findpropstrict:int=93;//0x5d
		public static const findproperty:int=94;//0x5e
		public static const finddef:int=95;//0x5f
		public static const getlex:int=96;//0x60
		public static const setproperty:int=97;//0x61
		public static const getlocal:int=98;//0x62
		public static const setlocal:int=99;//0x63
		public static const getglobalscope:int=100;//0x64
		public static const getscopeobject:int=101;//0x65
		public static const getproperty:int=102;//0x66
		//0x67
		public static const initproperty:int=104;//0x68
		//0x69
		public static const deleteproperty:int=106;//0x6a
		//0x6b
		public static const getslot:int=108;//0x6c
		public static const setslot:int=109;//0x6d
		public static const getglobalslot:int=110;//0x6e
		public static const setglobalslot:int=111;//0x6f
		public static const convert_s:int=112;//0x70
		public static const esc_xelem:int=113;//0x71
		public static const esc_xattr:int=114;//0x72
		public static const convert_i:int=115;//0x73
		public static const convert_u:int=116;//0x74
		public static const convert_d:int=117;//0x75
		public static const convert_b:int=118;//0x76
		public static const convert_o:int=119;//0x77
		public static const checkfilter:int=120;//0x78
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		public static const coerce:int=128;//0x80
		public static const coerce_b:int=129;//0x81
		public static const coerce_a:int=130;//0x82
		public static const coerce_i:int=131;//0x83
		public static const coerce_d:int=132;//0x84
		public static const coerce_s:int=133;//0x85
		public static const astype:int=134;//0x86
		public static const astypelate:int=135;//0x87
		public static const coerce_u:int=136;//0x88
		public static const coerce_o:int=137;//0x89
		//0x8a
		//0x8b
		//0x8c
		//0x8d
		//0x8e
		//0x8f
		public static const negate:int=144;//0x90
		public static const increment:int=145;//0x91
		public static const inclocal:int=146;//0x92
		public static const decrement:int=147;//0x93
		public static const declocal:int=148;//0x94
		public static const typeof_:int=149;//0x95
		public static const not:int=150;//0x96
		public static const bitnot:int=151;//0x97
		//0x98
		//0x99
		//0x9a
		//0x9b
		//0x9c
		//0x9d
		//0x9e
		//0x9f
		public static const add:int=160;//0xa0
		public static const subtract:int=161;//0xa1
		public static const multiply:int=162;//0xa2
		public static const divide:int=163;//0xa3
		public static const modulo:int=164;//0xa4
		public static const lshift:int=165;//0xa5
		public static const rshift:int=166;//0xa6
		public static const urshift:int=167;//0xa7
		public static const bitand:int=168;//0xa8
		public static const bitor:int=169;//0xa9
		public static const bitxor:int=170;//0xaa
		public static const equals:int=171;//0xab
		public static const strictequals:int=172;//0xac
		public static const lessthan:int=173;//0xad
		public static const lessequals:int=174;//0xae
		public static const greaterthan:int=175;//0xaf
		public static const greaterequals:int=176;//0xb0
		public static const instanceof_:int=177;//0xb1
		public static const istype:int=178;//0xb2
		public static const istypelate:int=179;//0xb3
		public static const in_:int=180;//0xb4
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
		public static const increment_i:int=192;//0xc0
		public static const decrement_i:int=193;//0xc1
		public static const inclocal_i:int=194;//0xc2
		public static const declocal_i:int=195;//0xc3
		public static const negate_i:int=196;//0xc4
		public static const add_i:int=197;//0xc5
		public static const subtract_i:int=198;//0xc6
		public static const multiply_i:int=199;//0xc7
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		public static const getlocal0:int=208;//0xd0
		public static const getlocal1:int=209;//0xd1
		public static const getlocal2:int=210;//0xd2
		public static const getlocal3:int=211;//0xd3
		public static const setlocal0:int=212;//0xd4
		public static const setlocal1:int=213;//0xd5
		public static const setlocal2:int=214;//0xd6
		public static const setlocal3:int=215;//0xd7
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
		public static const debug:int=239;//0xef
		public static const debugline:int=240;//0xf0
		public static const debugfile:int=241;//0xf1
		public static const bkptline:int=242;//0xf2
		public static const timestamp:int=243;//0xf3
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
		
		public static const opNameV:Vector.<String>=Vector.<String>([
			null,//0x00
			"bkpt",//0x01
			"nop",//0x02
			"throw_",//0x03
			"getsuper",//0x04
			"setsuper",//0x05
			"dxns",//0x06
			"dxnslate",//0x07
			"kill",//0x08
			"label",//0x09
			null,//0x0a
			null,//0x0b
			"ifnlt",//0x0c
			"ifnle",//0x0d
			"ifngt",//0x0e
			"ifnge",//0x0f
			"jump",//0x10
			"iftrue",//0x11
			"iffalse",//0x12
			"ifeq",//0x13
			"ifne",//0x14
			"iflt",//0x15
			"ifle",//0x16
			"ifgt",//0x17
			"ifge",//0x18
			"ifstricteq",//0x19
			"ifstrictne",//0x1a
			"lookupswitch",//0x1b
			"pushwith",//0x1c
			"popscope",//0x1d
			"nextname",//0x1e
			"hasnext",//0x1f
			"pushnull",//0x20
			"pushundefined",//0x21
			null,//0x22
			"nextvalue",//0x23
			"pushbyte",//0x24
			"pushshort",//0x25
			"pushtrue",//0x26
			"pushfalse",//0x27
			"pushnan",//0x28
			"pop",//0x29
			"dup",//0x2a
			"swap",//0x2b
			"pushstring",//0x2c
			"pushint",//0x2d
			"pushuint",//0x2e
			"pushdouble",//0x2f
			"pushscope",//0x30
			"pushnamespace",//0x31
			"hasnext2",//0x32
			null,//0x33
			null,//0x34
			"li8",//0x35
			"li16",//0x36
			"li32",//0x37
			"lf32",//0x38
			"lf64",//0x39
			"si8",//0x3a
			"si16",//0x3b
			"si32",//0x3c
			"sf32",//0x3d
			"sf64",//0x3e
			null,//0x3f
			"newfunction",//0x40
			"call",//0x41
			"construct",//0x42
			"callmethod",//0x43
			"callstatic",//0x44
			"callsuper",//0x45
			"callproperty",//0x46
			"returnvoid",//0x47
			"returnvalue",//0x48
			"constructsuper",//0x49
			"constructprop",//0x4a
			null,//0x4b
			"callproplex",//0x4c
			null,//0x4d
			"callsupervoid",//0x4e
			"callpropvoid",//0x4f
			"sxi1",//0x50
			"sxi8",//0x51
			"sxi16",//0x52
			"applytype",//0x53
			null,//0x54
			"newobject",//0x55
			"newarray",//0x56
			"newactivation",//0x57
			"newclass",//0x58
			"getdescendants",//0x59
			"newcatch",//0x5a
			null,//0x5b
			null,//0x5c
			"findpropstrict",//0x5d
			"findproperty",//0x5e
			"finddef",//0x5f
			"getlex",//0x60
			"setproperty",//0x61
			"getlocal",//0x62
			"setlocal",//0x63
			"getglobalscope",//0x64
			"getscopeobject",//0x65
			"getproperty",//0x66
			null,//0x67
			"initproperty",//0x68
			null,//0x69
			"deleteproperty",//0x6a
			null,//0x6b
			"getslot",//0x6c
			"setslot",//0x6d
			"getglobalslot",//0x6e
			"setglobalslot",//0x6f
			"convert_s",//0x70
			"esc_xelem",//0x71
			"esc_xattr",//0x72
			"convert_i",//0x73
			"convert_u",//0x74
			"convert_d",//0x75
			"convert_b",//0x76
			"convert_o",//0x77
			"checkfilter",//0x78
			null,//0x79
			null,//0x7a
			null,//0x7b
			null,//0x7c
			null,//0x7d
			null,//0x7e
			null,//0x7f
			"coerce",//0x80
			"coerce_b",//0x81
			"coerce_a",//0x82
			"coerce_i",//0x83
			"coerce_d",//0x84
			"coerce_s",//0x85
			"astype",//0x86
			"astypelate",//0x87
			"coerce_u",//0x88
			"coerce_o",//0x89
			null,//0x8a
			null,//0x8b
			null,//0x8c
			null,//0x8d
			null,//0x8e
			null,//0x8f
			"negate",//0x90
			"increment",//0x91
			"inclocal",//0x92
			"decrement",//0x93
			"declocal",//0x94
			"typeof_",//0x95
			"not",//0x96
			"bitnot",//0x97
			null,//0x98
			null,//0x99
			null,//0x9a
			null,//0x9b
			null,//0x9c
			null,//0x9d
			null,//0x9e
			null,//0x9f
			"add",//0xa0
			"subtract",//0xa1
			"multiply",//0xa2
			"divide",//0xa3
			"modulo",//0xa4
			"lshift",//0xa5
			"rshift",//0xa6
			"urshift",//0xa7
			"bitand",//0xa8
			"bitor",//0xa9
			"bitxor",//0xaa
			"equals",//0xab
			"strictequals",//0xac
			"lessthan",//0xad
			"lessequals",//0xae
			"greaterthan",//0xaf
			"greaterequals",//0xb0
			"instanceof_",//0xb1
			"istype",//0xb2
			"istypelate",//0xb3
			"in_",//0xb4
			null,//0xb5
			null,//0xb6
			null,//0xb7
			null,//0xb8
			null,//0xb9
			null,//0xba
			null,//0xbb
			null,//0xbc
			null,//0xbd
			null,//0xbe
			null,//0xbf
			"increment_i",//0xc0
			"decrement_i",//0xc1
			"inclocal_i",//0xc2
			"declocal_i",//0xc3
			"negate_i",//0xc4
			"add_i",//0xc5
			"subtract_i",//0xc6
			"multiply_i",//0xc7
			null,//0xc8
			null,//0xc9
			null,//0xca
			null,//0xcb
			null,//0xcc
			null,//0xcd
			null,//0xce
			null,//0xcf
			"getlocal0",//0xd0
			"getlocal1",//0xd1
			"getlocal2",//0xd2
			"getlocal3",//0xd3
			"setlocal0",//0xd4
			"setlocal1",//0xd5
			"setlocal2",//0xd6
			"setlocal3",//0xd7
			null,//0xd8
			null,//0xd9
			null,//0xda
			null,//0xdb
			null,//0xdc
			null,//0xdd
			null,//0xde
			null,//0xdf
			null,//0xe0
			null,//0xe1
			null,//0xe2
			null,//0xe3
			null,//0xe4
			null,//0xe5
			null,//0xe6
			null,//0xe7
			null,//0xe8
			null,//0xe9
			null,//0xea
			null,//0xeb
			null,//0xec
			null,//0xed
			null,//0xee
			"debug",//0xef
			"debugline",//0xf0
			"debugfile",//0xf1
			"bkptline",//0xf2
			"timestamp",//0xf3
			null,//0xf4
			null,//0xf5
			null,//0xf6
			null,//0xf7
			null,//0xf8
			null,//0xf9
			null,//0xfa
			null,//0xfb
			null,//0xfc
			null,//0xfd
			null,//0xfe
			null,//0xff
		]);
		////
		//

	}
}