package zero.swf.avm2.advances.codes{
	public class Op{
		public static const type_simple:String="simple";
		public static const type_index_u30_multiname_info:String="index_u30_multiname_info";
		public static const type_index_u30_string:String="index_u30_string";
		public static const type_index_u30_register:String="index_u30_register";
		public static const type_index_u30_slot:String="index_u30_slot";
		public static const type_index_u30_int:String="index_u30_int";
		public static const type_index_u30_uint:String="index_u30_uint";
		public static const type_index_u30_double:String="index_u30_double";
		public static const type_index_u30_namespace_info:String="index_u30_namespace_info";
		public static const type_index_u30_method:String="index_u30_method";
		public static const type_index_u30_class:String="index_u30_class";
		public static const type_index_u30_exception_info:String="index_u30_exception_info";
		public static const type_index_u30_scope:String="index_u30_scope";
		public static const type_index_u30_finddef:String="index_u30_finddef";
		public static const type_index_args_u30_u30_multiname_info:String="index_args_u30_u30_multiname_info";
		public static const type_index_args_u30_u30_method:String="index_args_u30_u30_method";
		public static const type_args_u30:String="args_u30";
		public static const type_branch_s24:String="branch_s24";
		public static const type_value_byte_u8:String="value_byte_u8";
		public static const type_value_int_u30:String="value_int_u30";
		public static const type_special:String="special";

		//0x00
		public static const breakpoint:int=1;//0x01
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

		public static var opTypeV:Vector.<String>;
		public static const opNameV:Vector.<String>=get_opNameV();
		private static function get_opNameV():Vector.<String>{
			opTypeV=new Vector.<String>(256);
			var opNameV:Vector.<String>=new Vector.<String>(256);
			opNameV.fixed=true;
			
			//0x00
			//opTypeV[0];
			
			//0x01
			opTypeV[breakpoint]=type_simple;
			opNameV[breakpoint]="breakpoint";
			
			//0x02
			opTypeV[nop]=type_simple;
			opNameV[nop]="nop";
			
			//0x03
			opTypeV[throw_]=type_simple;
			opNameV[throw_]="throw_";
			
			//0x04
			opTypeV[getsuper]=type_index_u30_multiname_info;
			opNameV[getsuper]="getsuper";
			
			//0x05
			opTypeV[setsuper]=type_index_u30_multiname_info;
			opNameV[setsuper]="setsuper";
			
			//0x06
			opTypeV[dxns]=type_index_u30_string;
			opNameV[dxns]="dxns";
			
			//0x07
			opTypeV[dxnslate]=type_simple;
			opNameV[dxnslate]="dxnslate";
			
			//0x08
			opTypeV[kill]=type_index_u30_register;
			opNameV[kill]="kill";
			
			//0x09
			opTypeV[label]=type_simple;
			opNameV[label]="label";
			
			//0x0a
			//opTypeV[10];
			
			//0x0b
			//opTypeV[11];
			
			//0x0c
			opTypeV[ifnlt]=type_branch_s24;
			opNameV[ifnlt]="ifnlt";
			
			//0x0d
			opTypeV[ifnle]=type_branch_s24;
			opNameV[ifnle]="ifnle";
			
			//0x0e
			opTypeV[ifngt]=type_branch_s24;
			opNameV[ifngt]="ifngt";
			
			//0x0f
			opTypeV[ifnge]=type_branch_s24;
			opNameV[ifnge]="ifnge";
			
			//0x10
			opTypeV[jump]=type_branch_s24;
			opNameV[jump]="jump";
			
			//0x11
			opTypeV[iftrue]=type_branch_s24;
			opNameV[iftrue]="iftrue";
			
			//0x12
			opTypeV[iffalse]=type_branch_s24;
			opNameV[iffalse]="iffalse";
			
			//0x13
			opTypeV[ifeq]=type_branch_s24;
			opNameV[ifeq]="ifeq";
			
			//0x14
			opTypeV[ifne]=type_branch_s24;
			opNameV[ifne]="ifne";
			
			//0x15
			opTypeV[iflt]=type_branch_s24;
			opNameV[iflt]="iflt";
			
			//0x16
			opTypeV[ifle]=type_branch_s24;
			opNameV[ifle]="ifle";
			
			//0x17
			opTypeV[ifgt]=type_branch_s24;
			opNameV[ifgt]="ifgt";
			
			//0x18
			opTypeV[ifge]=type_branch_s24;
			opNameV[ifge]="ifge";
			
			//0x19
			opTypeV[ifstricteq]=type_branch_s24;
			opNameV[ifstricteq]="ifstricteq";
			
			//0x1a
			opTypeV[ifstrictne]=type_branch_s24;
			opNameV[ifstrictne]="ifstrictne";
			
			//0x1b
			opTypeV[lookupswitch]=type_special;
			opNameV[lookupswitch]="lookupswitch";
			
			//0x1c
			opTypeV[pushwith]=type_simple;
			opNameV[pushwith]="pushwith";
			
			//0x1d
			opTypeV[popscope]=type_simple;
			opNameV[popscope]="popscope";
			
			//0x1e
			opTypeV[nextname]=type_simple;
			opNameV[nextname]="nextname";
			
			//0x1f
			opTypeV[hasnext]=type_simple;
			opNameV[hasnext]="hasnext";
			
			//0x20
			opTypeV[pushnull]=type_simple;
			opNameV[pushnull]="pushnull";
			
			//0x21
			opTypeV[pushundefined]=type_simple;
			opNameV[pushundefined]="pushundefined";
			
			//0x22
			//opTypeV[34];
			
			//0x23
			opTypeV[nextvalue]=type_simple;
			opNameV[nextvalue]="nextvalue";
			
			//0x24
			opTypeV[pushbyte]=type_value_byte_u8;
			opNameV[pushbyte]="pushbyte";
			
			//0x25
			opTypeV[pushshort]=type_value_int_u30;
			opNameV[pushshort]="pushshort";
			
			//0x26
			opTypeV[pushtrue]=type_simple;
			opNameV[pushtrue]="pushtrue";
			
			//0x27
			opTypeV[pushfalse]=type_simple;
			opNameV[pushfalse]="pushfalse";
			
			//0x28
			opTypeV[pushnan]=type_simple;
			opNameV[pushnan]="pushnan";
			
			//0x29
			opTypeV[pop]=type_simple;
			opNameV[pop]="pop";
			
			//0x2a
			opTypeV[dup]=type_simple;
			opNameV[dup]="dup";
			
			//0x2b
			opTypeV[swap]=type_simple;
			opNameV[swap]="swap";
			
			//0x2c
			opTypeV[pushstring]=type_index_u30_string;
			opNameV[pushstring]="pushstring";
			
			//0x2d
			opTypeV[pushint]=type_index_u30_int;
			opNameV[pushint]="pushint";
			
			//0x2e
			opTypeV[pushuint]=type_index_u30_uint;
			opNameV[pushuint]="pushuint";
			
			//0x2f
			opTypeV[pushdouble]=type_index_u30_double;
			opNameV[pushdouble]="pushdouble";
			
			//0x30
			opTypeV[pushscope]=type_simple;
			opNameV[pushscope]="pushscope";
			
			//0x31
			opTypeV[pushnamespace]=type_index_u30_namespace_info;
			opNameV[pushnamespace]="pushnamespace";
			
			//0x32
			opTypeV[hasnext2]=type_special;
			opNameV[hasnext2]="hasnext2";
			
			//0x33
			//opTypeV[51];
			
			//0x34
			//opTypeV[52];
			
			//0x35
			opTypeV[li8]=type_simple;
			opNameV[li8]="li8";
			
			//0x36
			opTypeV[li16]=type_simple;
			opNameV[li16]="li16";
			
			//0x37
			opTypeV[li32]=type_simple;
			opNameV[li32]="li32";
			
			//0x38
			opTypeV[lf32]=type_simple;
			opNameV[lf32]="lf32";
			
			//0x39
			opTypeV[lf64]=type_simple;
			opNameV[lf64]="lf64";
			
			//0x3a
			opTypeV[si8]=type_simple;
			opNameV[si8]="si8";
			
			//0x3b
			opTypeV[si16]=type_simple;
			opNameV[si16]="si16";
			
			//0x3c
			opTypeV[si32]=type_simple;
			opNameV[si32]="si32";
			
			//0x3d
			opTypeV[sf32]=type_simple;
			opNameV[sf32]="sf32";
			
			//0x3e
			opTypeV[sf64]=type_simple;
			opNameV[sf64]="sf64";
			
			//0x3f
			//opTypeV[63];
			
			//0x40
			opTypeV[newfunction]=type_index_u30_method;
			opNameV[newfunction]="newfunction";
			
			//0x41
			opTypeV[call]=type_args_u30;
			opNameV[call]="call";
			
			//0x42
			opTypeV[construct]=type_args_u30;
			opNameV[construct]="construct";
			
			//0x43
			opTypeV[callmethod]=type_index_args_u30_u30_method;
			opNameV[callmethod]="callmethod";
			
			//0x44
			opTypeV[callstatic]=type_index_args_u30_u30_method;
			opNameV[callstatic]="callstatic";
			
			//0x45
			opTypeV[callsuper]=type_index_args_u30_u30_multiname_info;
			opNameV[callsuper]="callsuper";
			
			//0x46
			opTypeV[callproperty]=type_index_args_u30_u30_multiname_info;
			opNameV[callproperty]="callproperty";
			
			//0x47
			opTypeV[returnvoid]=type_simple;
			opNameV[returnvoid]="returnvoid";
			
			//0x48
			opTypeV[returnvalue]=type_simple;
			opNameV[returnvalue]="returnvalue";
			
			//0x49
			opTypeV[constructsuper]=type_args_u30;
			opNameV[constructsuper]="constructsuper";
			
			//0x4a
			opTypeV[constructprop]=type_index_args_u30_u30_multiname_info;
			opNameV[constructprop]="constructprop";
			
			//0x4b
			//opTypeV[75];
			
			//0x4c
			opTypeV[callproplex]=type_index_args_u30_u30_multiname_info;
			opNameV[callproplex]="callproplex";
			
			//0x4d
			//opTypeV[77];
			
			//0x4e
			opTypeV[callsupervoid]=type_index_args_u30_u30_multiname_info;
			opNameV[callsupervoid]="callsupervoid";
			
			//0x4f
			opTypeV[callpropvoid]=type_index_args_u30_u30_multiname_info;
			opNameV[callpropvoid]="callpropvoid";
			
			//0x50
			opTypeV[sxi1]=type_simple;
			opNameV[sxi1]="sxi1";
			
			//0x51
			opTypeV[sxi8]=type_simple;
			opNameV[sxi8]="sxi8";
			
			//0x52
			opTypeV[sxi16]=type_simple;
			opNameV[sxi16]="sxi16";
			
			//0x53
			opTypeV[applytype]=type_args_u30;
			opNameV[applytype]="applytype";
			
			//0x54
			//opTypeV[84];
			
			//0x55
			opTypeV[newobject]=type_args_u30;
			opNameV[newobject]="newobject";
			
			//0x56
			opTypeV[newarray]=type_args_u30;
			opNameV[newarray]="newarray";
			
			//0x57
			opTypeV[newactivation]=type_simple;
			opNameV[newactivation]="newactivation";
			
			//0x58
			opTypeV[newclass]=type_index_u30_class;
			opNameV[newclass]="newclass";
			
			//0x59
			opTypeV[getdescendants]=type_index_u30_multiname_info;
			opNameV[getdescendants]="getdescendants";
			
			//0x5a
			opTypeV[newcatch]=type_index_u30_exception_info;
			opNameV[newcatch]="newcatch";
			
			//0x5b
			//opTypeV[91];
			
			//0x5c
			//opTypeV[92];
			
			//0x5d
			opTypeV[findpropstrict]=type_index_u30_multiname_info;
			opNameV[findpropstrict]="findpropstrict";
			
			//0x5e
			opTypeV[findproperty]=type_index_u30_multiname_info;
			opNameV[findproperty]="findproperty";
			
			//0x5f
			opTypeV[finddef]=type_index_u30_finddef;
			opNameV[finddef]="finddef";
			
			//0x60
			opTypeV[getlex]=type_index_u30_multiname_info;
			opNameV[getlex]="getlex";
			
			//0x61
			opTypeV[setproperty]=type_index_u30_multiname_info;
			opNameV[setproperty]="setproperty";
			
			//0x62
			opTypeV[getlocal]=type_index_u30_register;
			opNameV[getlocal]="getlocal";
			
			//0x63
			opTypeV[setlocal]=type_index_u30_register;
			opNameV[setlocal]="setlocal";
			
			//0x64
			opTypeV[getglobalscope]=type_simple;
			opNameV[getglobalscope]="getglobalscope";
			
			//0x65
			opTypeV[getscopeobject]=type_index_u30_scope;
			opNameV[getscopeobject]="getscopeobject";
			
			//0x66
			opTypeV[getproperty]=type_index_u30_multiname_info;
			opNameV[getproperty]="getproperty";
			
			//0x67
			//opTypeV[103];
			
			//0x68
			opTypeV[initproperty]=type_index_u30_multiname_info;
			opNameV[initproperty]="initproperty";
			
			//0x69
			//opTypeV[105];
			
			//0x6a
			opTypeV[deleteproperty]=type_index_u30_multiname_info;
			opNameV[deleteproperty]="deleteproperty";
			
			//0x6b
			//opTypeV[107];
			
			//0x6c
			opTypeV[getslot]=type_index_u30_slot;
			opNameV[getslot]="getslot";
			
			//0x6d
			opTypeV[setslot]=type_index_u30_slot;
			opNameV[setslot]="setslot";
			
			//0x6e
			opTypeV[getglobalslot]=type_index_u30_slot;
			opNameV[getglobalslot]="getglobalslot";
			
			//0x6f
			opTypeV[setglobalslot]=type_index_u30_slot;
			opNameV[setglobalslot]="setglobalslot";
			
			//0x70
			opTypeV[convert_s]=type_simple;
			opNameV[convert_s]="convert_s";
			
			//0x71
			opTypeV[esc_xelem]=type_simple;
			opNameV[esc_xelem]="esc_xelem";
			
			//0x72
			opTypeV[esc_xattr]=type_simple;
			opNameV[esc_xattr]="esc_xattr";
			
			//0x73
			opTypeV[convert_i]=type_simple;
			opNameV[convert_i]="convert_i";
			
			//0x74
			opTypeV[convert_u]=type_simple;
			opNameV[convert_u]="convert_u";
			
			//0x75
			opTypeV[convert_d]=type_simple;
			opNameV[convert_d]="convert_d";
			
			//0x76
			opTypeV[convert_b]=type_simple;
			opNameV[convert_b]="convert_b";
			
			//0x77
			opTypeV[convert_o]=type_simple;
			opNameV[convert_o]="convert_o";
			
			//0x78
			opTypeV[checkfilter]=type_simple;
			opNameV[checkfilter]="checkfilter";
			
			//0x79
			//opTypeV[121];
			
			//0x7a
			//opTypeV[122];
			
			//0x7b
			//opTypeV[123];
			
			//0x7c
			//opTypeV[124];
			
			//0x7d
			//opTypeV[125];
			
			//0x7e
			//opTypeV[126];
			
			//0x7f
			//opTypeV[127];
			
			//0x80
			opTypeV[coerce]=type_index_u30_multiname_info;
			opNameV[coerce]="coerce";
			
			//0x81
			opTypeV[coerce_b]=type_simple;
			opNameV[coerce_b]="coerce_b";
			
			//0x82
			opTypeV[coerce_a]=type_simple;
			opNameV[coerce_a]="coerce_a";
			
			//0x83
			opTypeV[coerce_i]=type_simple;
			opNameV[coerce_i]="coerce_i";
			
			//0x84
			opTypeV[coerce_d]=type_simple;
			opNameV[coerce_d]="coerce_d";
			
			//0x85
			opTypeV[coerce_s]=type_simple;
			opNameV[coerce_s]="coerce_s";
			
			//0x86
			opTypeV[astype]=type_index_u30_multiname_info;
			opNameV[astype]="astype";
			
			//0x87
			opTypeV[astypelate]=type_simple;
			opNameV[astypelate]="astypelate";
			
			//0x88
			opTypeV[coerce_u]=type_simple;
			opNameV[coerce_u]="coerce_u";
			
			//0x89
			opTypeV[coerce_o]=type_simple;
			opNameV[coerce_o]="coerce_o";
			
			//0x8a
			//opTypeV[138];
			
			//0x8b
			//opTypeV[139];
			
			//0x8c
			//opTypeV[140];
			
			//0x8d
			//opTypeV[141];
			
			//0x8e
			//opTypeV[142];
			
			//0x8f
			//opTypeV[143];
			
			//0x90
			opTypeV[negate]=type_simple;
			opNameV[negate]="negate";
			
			//0x91
			opTypeV[increment]=type_simple;
			opNameV[increment]="increment";
			
			//0x92
			opTypeV[inclocal]=type_index_u30_register;
			opNameV[inclocal]="inclocal";
			
			//0x93
			opTypeV[decrement]=type_simple;
			opNameV[decrement]="decrement";
			
			//0x94
			opTypeV[declocal]=type_index_u30_register;
			opNameV[declocal]="declocal";
			
			//0x95
			opTypeV[typeof_]=type_simple;
			opNameV[typeof_]="typeof_";
			
			//0x96
			opTypeV[not]=type_simple;
			opNameV[not]="not";
			
			//0x97
			opTypeV[bitnot]=type_simple;
			opNameV[bitnot]="bitnot";
			
			//0x98
			//opTypeV[152];
			
			//0x99
			//opTypeV[153];
			
			//0x9a
			//opTypeV[154];
			
			//0x9b
			//opTypeV[155];
			
			//0x9c
			//opTypeV[156];
			
			//0x9d
			//opTypeV[157];
			
			//0x9e
			//opTypeV[158];
			
			//0x9f
			//opTypeV[159];
			
			//0xa0
			opTypeV[add]=type_simple;
			opNameV[add]="add";
			
			//0xa1
			opTypeV[subtract]=type_simple;
			opNameV[subtract]="subtract";
			
			//0xa2
			opTypeV[multiply]=type_simple;
			opNameV[multiply]="multiply";
			
			//0xa3
			opTypeV[divide]=type_simple;
			opNameV[divide]="divide";
			
			//0xa4
			opTypeV[modulo]=type_simple;
			opNameV[modulo]="modulo";
			
			//0xa5
			opTypeV[lshift]=type_simple;
			opNameV[lshift]="lshift";
			
			//0xa6
			opTypeV[rshift]=type_simple;
			opNameV[rshift]="rshift";
			
			//0xa7
			opTypeV[urshift]=type_simple;
			opNameV[urshift]="urshift";
			
			//0xa8
			opTypeV[bitand]=type_simple;
			opNameV[bitand]="bitand";
			
			//0xa9
			opTypeV[bitor]=type_simple;
			opNameV[bitor]="bitor";
			
			//0xaa
			opTypeV[bitxor]=type_simple;
			opNameV[bitxor]="bitxor";
			
			//0xab
			opTypeV[equals]=type_simple;
			opNameV[equals]="equals";
			
			//0xac
			opTypeV[strictequals]=type_simple;
			opNameV[strictequals]="strictequals";
			
			//0xad
			opTypeV[lessthan]=type_simple;
			opNameV[lessthan]="lessthan";
			
			//0xae
			opTypeV[lessequals]=type_simple;
			opNameV[lessequals]="lessequals";
			
			//0xaf
			opTypeV[greaterthan]=type_simple;
			opNameV[greaterthan]="greaterthan";
			
			//0xb0
			opTypeV[greaterequals]=type_simple;
			opNameV[greaterequals]="greaterequals";
			
			//0xb1
			opTypeV[instanceof_]=type_simple;
			opNameV[instanceof_]="instanceof_";
			
			//0xb2
			opTypeV[istype]=type_index_u30_multiname_info;
			opNameV[istype]="istype";
			
			//0xb3
			opTypeV[istypelate]=type_simple;
			opNameV[istypelate]="istypelate";
			
			//0xb4
			opTypeV[in_]=type_simple;
			opNameV[in_]="in_";
			
			//0xb5
			//opTypeV[181];
			
			//0xb6
			//opTypeV[182];
			
			//0xb7
			//opTypeV[183];
			
			//0xb8
			//opTypeV[184];
			
			//0xb9
			//opTypeV[185];
			
			//0xba
			//opTypeV[186];
			
			//0xbb
			//opTypeV[187];
			
			//0xbc
			//opTypeV[188];
			
			//0xbd
			//opTypeV[189];
			
			//0xbe
			//opTypeV[190];
			
			//0xbf
			//opTypeV[191];
			
			//0xc0
			opTypeV[increment_i]=type_simple;
			opNameV[increment_i]="increment_i";
			
			//0xc1
			opTypeV[decrement_i]=type_simple;
			opNameV[decrement_i]="decrement_i";
			
			//0xc2
			opTypeV[inclocal_i]=type_index_u30_register;
			opNameV[inclocal_i]="inclocal_i";
			
			//0xc3
			opTypeV[declocal_i]=type_index_u30_register;
			opNameV[declocal_i]="declocal_i";
			
			//0xc4
			opTypeV[negate_i]=type_simple;
			opNameV[negate_i]="negate_i";
			
			//0xc5
			opTypeV[add_i]=type_simple;
			opNameV[add_i]="add_i";
			
			//0xc6
			opTypeV[subtract_i]=type_simple;
			opNameV[subtract_i]="subtract_i";
			
			//0xc7
			opTypeV[multiply_i]=type_simple;
			opNameV[multiply_i]="multiply_i";
			
			//0xc8
			//opTypeV[200];
			
			//0xc9
			//opTypeV[201];
			
			//0xca
			//opTypeV[202];
			
			//0xcb
			//opTypeV[203];
			
			//0xcc
			//opTypeV[204];
			
			//0xcd
			//opTypeV[205];
			
			//0xce
			//opTypeV[206];
			
			//0xcf
			//opTypeV[207];
			
			//0xd0
			opTypeV[getlocal0]=type_simple;
			opNameV[getlocal0]="getlocal0";
			
			//0xd1
			opTypeV[getlocal1]=type_simple;
			opNameV[getlocal1]="getlocal1";
			
			//0xd2
			opTypeV[getlocal2]=type_simple;
			opNameV[getlocal2]="getlocal2";
			
			//0xd3
			opTypeV[getlocal3]=type_simple;
			opNameV[getlocal3]="getlocal3";
			
			//0xd4
			opTypeV[setlocal0]=type_simple;
			opNameV[setlocal0]="setlocal0";
			
			//0xd5
			opTypeV[setlocal1]=type_simple;
			opNameV[setlocal1]="setlocal1";
			
			//0xd6
			opTypeV[setlocal2]=type_simple;
			opNameV[setlocal2]="setlocal2";
			
			//0xd7
			opTypeV[setlocal3]=type_simple;
			opNameV[setlocal3]="setlocal3";
			
			//0xd8
			//opTypeV[216];
			
			//0xd9
			//opTypeV[217];
			
			//0xda
			//opTypeV[218];
			
			//0xdb
			//opTypeV[219];
			
			//0xdc
			//opTypeV[220];
			
			//0xdd
			//opTypeV[221];
			
			//0xde
			//opTypeV[222];
			
			//0xdf
			//opTypeV[223];
			
			//0xe0
			//opTypeV[224];
			
			//0xe1
			//opTypeV[225];
			
			//0xe2
			//opTypeV[226];
			
			//0xe3
			//opTypeV[227];
			
			//0xe4
			//opTypeV[228];
			
			//0xe5
			//opTypeV[229];
			
			//0xe6
			//opTypeV[230];
			
			//0xe7
			//opTypeV[231];
			
			//0xe8
			//opTypeV[232];
			
			//0xe9
			//opTypeV[233];
			
			//0xea
			//opTypeV[234];
			
			//0xeb
			//opTypeV[235];
			
			//0xec
			//opTypeV[236];
			
			//0xed
			//opTypeV[237];
			
			//0xee
			//opTypeV[238];
			
			//0xef
			opTypeV[debug]=type_special;
			opNameV[debug]="debug";
			
			//0xf0
			opTypeV[debugline]=type_value_int_u30;
			opNameV[debugline]="debugline";
			
			//0xf1
			opTypeV[debugfile]=type_index_u30_string;
			opNameV[debugfile]="debugfile";
			
			//0xf2
			opTypeV[bkptline]=type_value_int_u30;
			opNameV[bkptline]="bkptline";
			
			//0xf3
			opTypeV[timestamp]=type_simple;
			opNameV[timestamp]="timestamp";
			
			//0xf4
			//opTypeV[244];
			
			//0xf5
			//opTypeV[245];
			
			//0xf6
			//opTypeV[246];
			
			//0xf7
			//opTypeV[247];
			
			//0xf8
			//opTypeV[248];
			
			//0xf9
			//opTypeV[249];
			
			//0xfa
			//opTypeV[250];
			
			//0xfb
			//opTypeV[251];
			
			//0xfc
			//opTypeV[252];
			
			//0xfd
			//opTypeV[253];
			
			//0xfe
			//opTypeV[254];
			
			//0xff
			//opTypeV[255];
			return opNameV;
		}
	}
}
