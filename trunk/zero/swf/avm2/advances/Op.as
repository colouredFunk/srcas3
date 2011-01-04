package zero.swf.avm2.advances{
	public class Op{
		
		public static const dataType_u8:String="u8";
		public static const type_u8:String="u8";
		
		public static const dataType_u8_u8:String="u8_u8";
		public static const type_u8_u8__value_byte:String="u8_u8__value_byte";
		
		public static const dataType_u8_u30:String="u8_u30";
		public static const type_u8_u30__value_int:String="u8_u30__value_int";
		public static const type_u8_u30__scope:String="u8_u30__scope";
		public static const type_u8_u30__slot:String="u8_u30__slot";
		public static const type_u8_u30__register:String="u8_u30__register";
		public static const type_u8_u30__args:String="u8_u30__args";
		public static const type_u8_u30__int:String="u8_u30__int";
		public static const type_u8_u30__uint:String="u8_u30__uint";
		public static const type_u8_u30__double:String="u8_u30__double";
		public static const type_u8_u30__string:String="u8_u30__string";
		public static const type_u8_u30__namespace_info:String="u8_u30__namespace_info";
		public static const type_u8_u30__multiname_info:String="u8_u30__multiname_info";
		public static const type_u8_u30__method:String="u8_u30__method";
		public static const type_u8_u30__class:String="u8_u30__class";
		public static const type_u8_u30__exception_info:String="u8_u30__exception_info";
		public static const type_u8_u30__finddef:String="u8_u30__finddef";
		
		public static const dataType_u8_u30_u30:String="u8_u30_u30";
		public static const type_u8_u30_u30__register_register:String="u8_u30_u30__register_register";
		public static const type_u8_u30_u30__multiname_info_args:String="u8_u30_u30__multiname_info_args";
		public static const type_u8_u30_u30__method_args:String="u8_u30_u30__method_args";
		
		public static const dataType_u8_s24:String="u8_s24";
		public static const type_u8_s24__branch:String="u8_s24__branch";
		
		public static const dataType_u8_s24_u30_s24List:String="u8_s24_u30_s24List";
		public static const type_u8_s24_u30_s24List__lookupswitch:String="u8_s24_u30_s24List__lookupswitch";
		
		public static const dataType_u8_u8_u30_u8_u30:String="u8_u8_u30_u8_u30";
		public static const type_u8_u8_u30_u8_u30__debug:String="u8_u8_u30_u8_u30__debug";

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

		public static var opDataTypeV:Vector.<String>;
		public static var opTypeV:Vector.<String>;
		public static var ops:Object;
		public static const opNameV:Vector.<String>=get_opNameV();
		private static function get_opNameV():Vector.<String>{
			opDataTypeV=new Vector.<String>(256);
			opDataTypeV.fixed=true;
			opTypeV=new Vector.<String>(256);
			opTypeV.fixed=true;
			ops=new Object();
			var opNameV:Vector.<String>=new Vector.<String>(256);
			opNameV.fixed=true;
			
			//0x00
			//opDataTypeV[0]="";
			//opTypeV[0]="";
			//ops[0]="";
			//opNameV[""]=0;
			
			//0x01
			opDataTypeV[breakpoint]=dataType_u8;
			opTypeV[breakpoint]=type_u8;
			ops["breakpoint"]=breakpoint;
			opNameV[breakpoint]="breakpoint";
			
			//0x02
			opDataTypeV[nop]=dataType_u8;
			opTypeV[nop]=type_u8;
			ops["nop"]=nop;
			opNameV[nop]="nop";
			
			//0x03
			opDataTypeV[throw_]=dataType_u8;
			opTypeV[throw_]=type_u8;
			ops["throw_"]=throw_;
			opNameV[throw_]="throw_";
			
			//0x04
			opDataTypeV[getsuper]=dataType_u8_u30;
			opTypeV[getsuper]=type_u8_u30__multiname_info;
			ops["getsuper"]=getsuper;
			opNameV[getsuper]="getsuper";
			
			//0x05
			opDataTypeV[setsuper]=dataType_u8_u30;
			opTypeV[setsuper]=type_u8_u30__multiname_info;
			ops["setsuper"]=setsuper;
			opNameV[setsuper]="setsuper";
			
			//0x06
			opDataTypeV[dxns]=dataType_u8_u30;
			opTypeV[dxns]=type_u8_u30__string;
			ops["dxns"]=dxns;
			opNameV[dxns]="dxns";
			
			//0x07
			opDataTypeV[dxnslate]=dataType_u8;
			opTypeV[dxnslate]=type_u8;
			ops["dxnslate"]=dxnslate;
			opNameV[dxnslate]="dxnslate";
			
			//0x08
			opDataTypeV[kill]=dataType_u8_u30;
			opTypeV[kill]=type_u8_u30__register;
			ops["kill"]=kill;
			opNameV[kill]="kill";
			
			//0x09
			opDataTypeV[label]=dataType_u8;
			opTypeV[label]=type_u8;
			ops["label"]=label;
			opNameV[label]="label";
			
			//0x0a
			//opDataTypeV[10]="";
			//opTypeV[10]="";
			//ops[10]="";
			//opNameV[""]=10;
			
			//0x0b
			//opDataTypeV[11]="";
			//opTypeV[11]="";
			//ops[11]="";
			//opNameV[""]=11;
			
			//0x0c
			opDataTypeV[ifnlt]=dataType_u8_s24;
			opTypeV[ifnlt]=type_u8_s24__branch;
			ops["ifnlt"]=ifnlt;
			opNameV[ifnlt]="ifnlt";
			
			//0x0d
			opDataTypeV[ifnle]=dataType_u8_s24;
			opTypeV[ifnle]=type_u8_s24__branch;
			ops["ifnle"]=ifnle;
			opNameV[ifnle]="ifnle";
			
			//0x0e
			opDataTypeV[ifngt]=dataType_u8_s24;
			opTypeV[ifngt]=type_u8_s24__branch;
			ops["ifngt"]=ifngt;
			opNameV[ifngt]="ifngt";
			
			//0x0f
			opDataTypeV[ifnge]=dataType_u8_s24;
			opTypeV[ifnge]=type_u8_s24__branch;
			ops["ifnge"]=ifnge;
			opNameV[ifnge]="ifnge";
			
			//0x10
			opDataTypeV[jump]=dataType_u8_s24;
			opTypeV[jump]=type_u8_s24__branch;
			ops["jump"]=jump;
			opNameV[jump]="jump";
			
			//0x11
			opDataTypeV[iftrue]=dataType_u8_s24;
			opTypeV[iftrue]=type_u8_s24__branch;
			ops["iftrue"]=iftrue;
			opNameV[iftrue]="iftrue";
			
			//0x12
			opDataTypeV[iffalse]=dataType_u8_s24;
			opTypeV[iffalse]=type_u8_s24__branch;
			ops["iffalse"]=iffalse;
			opNameV[iffalse]="iffalse";
			
			//0x13
			opDataTypeV[ifeq]=dataType_u8_s24;
			opTypeV[ifeq]=type_u8_s24__branch;
			ops["ifeq"]=ifeq;
			opNameV[ifeq]="ifeq";
			
			//0x14
			opDataTypeV[ifne]=dataType_u8_s24;
			opTypeV[ifne]=type_u8_s24__branch;
			ops["ifne"]=ifne;
			opNameV[ifne]="ifne";
			
			//0x15
			opDataTypeV[iflt]=dataType_u8_s24;
			opTypeV[iflt]=type_u8_s24__branch;
			ops["iflt"]=iflt;
			opNameV[iflt]="iflt";
			
			//0x16
			opDataTypeV[ifle]=dataType_u8_s24;
			opTypeV[ifle]=type_u8_s24__branch;
			ops["ifle"]=ifle;
			opNameV[ifle]="ifle";
			
			//0x17
			opDataTypeV[ifgt]=dataType_u8_s24;
			opTypeV[ifgt]=type_u8_s24__branch;
			ops["ifgt"]=ifgt;
			opNameV[ifgt]="ifgt";
			
			//0x18
			opDataTypeV[ifge]=dataType_u8_s24;
			opTypeV[ifge]=type_u8_s24__branch;
			ops["ifge"]=ifge;
			opNameV[ifge]="ifge";
			
			//0x19
			opDataTypeV[ifstricteq]=dataType_u8_s24;
			opTypeV[ifstricteq]=type_u8_s24__branch;
			ops["ifstricteq"]=ifstricteq;
			opNameV[ifstricteq]="ifstricteq";
			
			//0x1a
			opDataTypeV[ifstrictne]=dataType_u8_s24;
			opTypeV[ifstrictne]=type_u8_s24__branch;
			ops["ifstrictne"]=ifstrictne;
			opNameV[ifstrictne]="ifstrictne";
			
			//0x1b
			opDataTypeV[lookupswitch]=dataType_u8_s24_u30_s24List;
			opTypeV[lookupswitch]=type_u8_s24_u30_s24List__lookupswitch;
			ops["lookupswitch"]=lookupswitch;
			opNameV[lookupswitch]="lookupswitch";
			
			//0x1c
			opDataTypeV[pushwith]=dataType_u8;
			opTypeV[pushwith]=type_u8;
			ops["pushwith"]=pushwith;
			opNameV[pushwith]="pushwith";
			
			//0x1d
			opDataTypeV[popscope]=dataType_u8;
			opTypeV[popscope]=type_u8;
			ops["popscope"]=popscope;
			opNameV[popscope]="popscope";
			
			//0x1e
			opDataTypeV[nextname]=dataType_u8;
			opTypeV[nextname]=type_u8;
			ops["nextname"]=nextname;
			opNameV[nextname]="nextname";
			
			//0x1f
			opDataTypeV[hasnext]=dataType_u8;
			opTypeV[hasnext]=type_u8;
			ops["hasnext"]=hasnext;
			opNameV[hasnext]="hasnext";
			
			//0x20
			opDataTypeV[pushnull]=dataType_u8;
			opTypeV[pushnull]=type_u8;
			ops["pushnull"]=pushnull;
			opNameV[pushnull]="pushnull";
			
			//0x21
			opDataTypeV[pushundefined]=dataType_u8;
			opTypeV[pushundefined]=type_u8;
			ops["pushundefined"]=pushundefined;
			opNameV[pushundefined]="pushundefined";
			
			//0x22
			//opDataTypeV[34]="";
			//opTypeV[34]="";
			//ops[34]="";
			//opNameV[""]=34;
			
			//0x23
			opDataTypeV[nextvalue]=dataType_u8;
			opTypeV[nextvalue]=type_u8;
			ops["nextvalue"]=nextvalue;
			opNameV[nextvalue]="nextvalue";
			
			//0x24
			opDataTypeV[pushbyte]=dataType_u8_u8;
			opTypeV[pushbyte]=type_u8_u8__value_byte;
			ops["pushbyte"]=pushbyte;
			opNameV[pushbyte]="pushbyte";
			
			//0x25
			opDataTypeV[pushshort]=dataType_u8_u30;
			opTypeV[pushshort]=type_u8_u30__value_int;
			ops["pushshort"]=pushshort;
			opNameV[pushshort]="pushshort";
			
			//0x26
			opDataTypeV[pushtrue]=dataType_u8;
			opTypeV[pushtrue]=type_u8;
			ops["pushtrue"]=pushtrue;
			opNameV[pushtrue]="pushtrue";
			
			//0x27
			opDataTypeV[pushfalse]=dataType_u8;
			opTypeV[pushfalse]=type_u8;
			ops["pushfalse"]=pushfalse;
			opNameV[pushfalse]="pushfalse";
			
			//0x28
			opDataTypeV[pushnan]=dataType_u8;
			opTypeV[pushnan]=type_u8;
			ops["pushnan"]=pushnan;
			opNameV[pushnan]="pushnan";
			
			//0x29
			opDataTypeV[pop]=dataType_u8;
			opTypeV[pop]=type_u8;
			ops["pop"]=pop;
			opNameV[pop]="pop";
			
			//0x2a
			opDataTypeV[dup]=dataType_u8;
			opTypeV[dup]=type_u8;
			ops["dup"]=dup;
			opNameV[dup]="dup";
			
			//0x2b
			opDataTypeV[swap]=dataType_u8;
			opTypeV[swap]=type_u8;
			ops["swap"]=swap;
			opNameV[swap]="swap";
			
			//0x2c
			opDataTypeV[pushstring]=dataType_u8_u30;
			opTypeV[pushstring]=type_u8_u30__string;
			ops["pushstring"]=pushstring;
			opNameV[pushstring]="pushstring";
			
			//0x2d
			opDataTypeV[pushint]=dataType_u8_u30;
			opTypeV[pushint]=type_u8_u30__int;
			ops["pushint"]=pushint;
			opNameV[pushint]="pushint";
			
			//0x2e
			opDataTypeV[pushuint]=dataType_u8_u30;
			opTypeV[pushuint]=type_u8_u30__uint;
			ops["pushuint"]=pushuint;
			opNameV[pushuint]="pushuint";
			
			//0x2f
			opDataTypeV[pushdouble]=dataType_u8_u30;
			opTypeV[pushdouble]=type_u8_u30__double;
			ops["pushdouble"]=pushdouble;
			opNameV[pushdouble]="pushdouble";
			
			//0x30
			opDataTypeV[pushscope]=dataType_u8;
			opTypeV[pushscope]=type_u8;
			ops["pushscope"]=pushscope;
			opNameV[pushscope]="pushscope";
			
			//0x31
			opDataTypeV[pushnamespace]=dataType_u8_u30;
			opTypeV[pushnamespace]=type_u8_u30__namespace_info;
			ops["pushnamespace"]=pushnamespace;
			opNameV[pushnamespace]="pushnamespace";
			
			//0x32
			opDataTypeV[hasnext2]=dataType_u8_u30_u30;
			opTypeV[hasnext2]=type_u8_u30_u30__register_register;
			ops["hasnext2"]=hasnext2;
			opNameV[hasnext2]="hasnext2";
			
			//0x33
			//opDataTypeV[51]="";
			//opTypeV[51]="";
			//ops[51]="";
			//opNameV[""]=51;
			
			//0x34
			//opDataTypeV[52]="";
			//opTypeV[52]="";
			//ops[52]="";
			//opNameV[""]=52;
			
			//0x35
			opDataTypeV[li8]=dataType_u8;
			opTypeV[li8]=type_u8;
			ops["li8"]=li8;
			opNameV[li8]="li8";
			
			//0x36
			opDataTypeV[li16]=dataType_u8;
			opTypeV[li16]=type_u8;
			ops["li16"]=li16;
			opNameV[li16]="li16";
			
			//0x37
			opDataTypeV[li32]=dataType_u8;
			opTypeV[li32]=type_u8;
			ops["li32"]=li32;
			opNameV[li32]="li32";
			
			//0x38
			opDataTypeV[lf32]=dataType_u8;
			opTypeV[lf32]=type_u8;
			ops["lf32"]=lf32;
			opNameV[lf32]="lf32";
			
			//0x39
			opDataTypeV[lf64]=dataType_u8;
			opTypeV[lf64]=type_u8;
			ops["lf64"]=lf64;
			opNameV[lf64]="lf64";
			
			//0x3a
			opDataTypeV[si8]=dataType_u8;
			opTypeV[si8]=type_u8;
			ops["si8"]=si8;
			opNameV[si8]="si8";
			
			//0x3b
			opDataTypeV[si16]=dataType_u8;
			opTypeV[si16]=type_u8;
			ops["si16"]=si16;
			opNameV[si16]="si16";
			
			//0x3c
			opDataTypeV[si32]=dataType_u8;
			opTypeV[si32]=type_u8;
			ops["si32"]=si32;
			opNameV[si32]="si32";
			
			//0x3d
			opDataTypeV[sf32]=dataType_u8;
			opTypeV[sf32]=type_u8;
			ops["sf32"]=sf32;
			opNameV[sf32]="sf32";
			
			//0x3e
			opDataTypeV[sf64]=dataType_u8;
			opTypeV[sf64]=type_u8;
			ops["sf64"]=sf64;
			opNameV[sf64]="sf64";
			
			//0x3f
			//opDataTypeV[63]="";
			//opTypeV[63]="";
			//ops[63]="";
			//opNameV[""]=63;
			
			//0x40
			opDataTypeV[newfunction]=dataType_u8_u30;
			opTypeV[newfunction]=type_u8_u30__method;
			ops["newfunction"]=newfunction;
			opNameV[newfunction]="newfunction";
			
			//0x41
			opDataTypeV[call]=dataType_u8_u30;
			opTypeV[call]=type_u8_u30__args;
			ops["call"]=call;
			opNameV[call]="call";
			
			//0x42
			opDataTypeV[construct]=dataType_u8_u30;
			opTypeV[construct]=type_u8_u30__args;
			ops["construct"]=construct;
			opNameV[construct]="construct";
			
			//0x43
			opDataTypeV[callmethod]=dataType_u8_u30_u30;
			opTypeV[callmethod]=type_u8_u30_u30__method_args;
			ops["callmethod"]=callmethod;
			opNameV[callmethod]="callmethod";
			
			//0x44
			opDataTypeV[callstatic]=dataType_u8_u30_u30;
			opTypeV[callstatic]=type_u8_u30_u30__method_args;
			ops["callstatic"]=callstatic;
			opNameV[callstatic]="callstatic";
			
			//0x45
			opDataTypeV[callsuper]=dataType_u8_u30_u30;
			opTypeV[callsuper]=type_u8_u30_u30__multiname_info_args;
			ops["callsuper"]=callsuper;
			opNameV[callsuper]="callsuper";
			
			//0x46
			opDataTypeV[callproperty]=dataType_u8_u30_u30;
			opTypeV[callproperty]=type_u8_u30_u30__multiname_info_args;
			ops["callproperty"]=callproperty;
			opNameV[callproperty]="callproperty";
			
			//0x47
			opDataTypeV[returnvoid]=dataType_u8;
			opTypeV[returnvoid]=type_u8;
			ops["returnvoid"]=returnvoid;
			opNameV[returnvoid]="returnvoid";
			
			//0x48
			opDataTypeV[returnvalue]=dataType_u8;
			opTypeV[returnvalue]=type_u8;
			ops["returnvalue"]=returnvalue;
			opNameV[returnvalue]="returnvalue";
			
			//0x49
			opDataTypeV[constructsuper]=dataType_u8_u30;
			opTypeV[constructsuper]=type_u8_u30__args;
			ops["constructsuper"]=constructsuper;
			opNameV[constructsuper]="constructsuper";
			
			//0x4a
			opDataTypeV[constructprop]=dataType_u8_u30_u30;
			opTypeV[constructprop]=type_u8_u30_u30__multiname_info_args;
			ops["constructprop"]=constructprop;
			opNameV[constructprop]="constructprop";
			
			//0x4b
			//opDataTypeV[75]="";
			//opTypeV[75]="";
			//ops[75]="";
			//opNameV[""]=75;
			
			//0x4c
			opDataTypeV[callproplex]=dataType_u8_u30_u30;
			opTypeV[callproplex]=type_u8_u30_u30__multiname_info_args;
			ops["callproplex"]=callproplex;
			opNameV[callproplex]="callproplex";
			
			//0x4d
			//opDataTypeV[77]="";
			//opTypeV[77]="";
			//ops[77]="";
			//opNameV[""]=77;
			
			//0x4e
			opDataTypeV[callsupervoid]=dataType_u8_u30_u30;
			opTypeV[callsupervoid]=type_u8_u30_u30__multiname_info_args;
			ops["callsupervoid"]=callsupervoid;
			opNameV[callsupervoid]="callsupervoid";
			
			//0x4f
			opDataTypeV[callpropvoid]=dataType_u8_u30_u30;
			opTypeV[callpropvoid]=type_u8_u30_u30__multiname_info_args;
			ops["callpropvoid"]=callpropvoid;
			opNameV[callpropvoid]="callpropvoid";
			
			//0x50
			opDataTypeV[sxi1]=dataType_u8;
			opTypeV[sxi1]=type_u8;
			ops["sxi1"]=sxi1;
			opNameV[sxi1]="sxi1";
			
			//0x51
			opDataTypeV[sxi8]=dataType_u8;
			opTypeV[sxi8]=type_u8;
			ops["sxi8"]=sxi8;
			opNameV[sxi8]="sxi8";
			
			//0x52
			opDataTypeV[sxi16]=dataType_u8;
			opTypeV[sxi16]=type_u8;
			ops["sxi16"]=sxi16;
			opNameV[sxi16]="sxi16";
			
			//0x53
			opDataTypeV[applytype]=dataType_u8_u30;
			opTypeV[applytype]=type_u8_u30__args;
			ops["applytype"]=applytype;
			opNameV[applytype]="applytype";
			
			//0x54
			//opDataTypeV[84]="";
			//opTypeV[84]="";
			//ops[84]="";
			//opNameV[""]=84;
			
			//0x55
			opDataTypeV[newobject]=dataType_u8_u30;
			opTypeV[newobject]=type_u8_u30__args;
			ops["newobject"]=newobject;
			opNameV[newobject]="newobject";
			
			//0x56
			opDataTypeV[newarray]=dataType_u8_u30;
			opTypeV[newarray]=type_u8_u30__args;
			ops["newarray"]=newarray;
			opNameV[newarray]="newarray";
			
			//0x57
			opDataTypeV[newactivation]=dataType_u8;
			opTypeV[newactivation]=type_u8;
			ops["newactivation"]=newactivation;
			opNameV[newactivation]="newactivation";
			
			//0x58
			opDataTypeV[newclass]=dataType_u8_u30;
			opTypeV[newclass]=type_u8_u30__class;
			ops["newclass"]=newclass;
			opNameV[newclass]="newclass";
			
			//0x59
			opDataTypeV[getdescendants]=dataType_u8_u30;
			opTypeV[getdescendants]=type_u8_u30__multiname_info;
			ops["getdescendants"]=getdescendants;
			opNameV[getdescendants]="getdescendants";
			
			//0x5a
			opDataTypeV[newcatch]=dataType_u8_u30;
			opTypeV[newcatch]=type_u8_u30__exception_info;
			ops["newcatch"]=newcatch;
			opNameV[newcatch]="newcatch";
			
			//0x5b
			//opDataTypeV[91]="";
			//opTypeV[91]="";
			//ops[91]="";
			//opNameV[""]=91;
			
			//0x5c
			//opDataTypeV[92]="";
			//opTypeV[92]="";
			//ops[92]="";
			//opNameV[""]=92;
			
			//0x5d
			opDataTypeV[findpropstrict]=dataType_u8_u30;
			opTypeV[findpropstrict]=type_u8_u30__multiname_info;
			ops["findpropstrict"]=findpropstrict;
			opNameV[findpropstrict]="findpropstrict";
			
			//0x5e
			opDataTypeV[findproperty]=dataType_u8_u30;
			opTypeV[findproperty]=type_u8_u30__multiname_info;
			ops["findproperty"]=findproperty;
			opNameV[findproperty]="findproperty";
			
			//0x5f
			opDataTypeV[finddef]=dataType_u8_u30;
			opTypeV[finddef]=type_u8_u30__finddef;
			ops["finddef"]=finddef;
			opNameV[finddef]="finddef";
			
			//0x60
			opDataTypeV[getlex]=dataType_u8_u30;
			opTypeV[getlex]=type_u8_u30__multiname_info;
			ops["getlex"]=getlex;
			opNameV[getlex]="getlex";
			
			//0x61
			opDataTypeV[setproperty]=dataType_u8_u30;
			opTypeV[setproperty]=type_u8_u30__multiname_info;
			ops["setproperty"]=setproperty;
			opNameV[setproperty]="setproperty";
			
			//0x62
			opDataTypeV[getlocal]=dataType_u8_u30;
			opTypeV[getlocal]=type_u8_u30__register;
			ops["getlocal"]=getlocal;
			opNameV[getlocal]="getlocal";
			
			//0x63
			opDataTypeV[setlocal]=dataType_u8_u30;
			opTypeV[setlocal]=type_u8_u30__register;
			ops["setlocal"]=setlocal;
			opNameV[setlocal]="setlocal";
			
			//0x64
			opDataTypeV[getglobalscope]=dataType_u8;
			opTypeV[getglobalscope]=type_u8;
			ops["getglobalscope"]=getglobalscope;
			opNameV[getglobalscope]="getglobalscope";
			
			//0x65
			opDataTypeV[getscopeobject]=dataType_u8_u30;
			opTypeV[getscopeobject]=type_u8_u30__scope;
			ops["getscopeobject"]=getscopeobject;
			opNameV[getscopeobject]="getscopeobject";
			
			//0x66
			opDataTypeV[getproperty]=dataType_u8_u30;
			opTypeV[getproperty]=type_u8_u30__multiname_info;
			ops["getproperty"]=getproperty;
			opNameV[getproperty]="getproperty";
			
			//0x67
			//opDataTypeV[103]="";
			//opTypeV[103]="";
			//ops[103]="";
			//opNameV[""]=103;
			
			//0x68
			opDataTypeV[initproperty]=dataType_u8_u30;
			opTypeV[initproperty]=type_u8_u30__multiname_info;
			ops["initproperty"]=initproperty;
			opNameV[initproperty]="initproperty";
			
			//0x69
			//opDataTypeV[105]="";
			//opTypeV[105]="";
			//ops[105]="";
			//opNameV[""]=105;
			
			//0x6a
			opDataTypeV[deleteproperty]=dataType_u8_u30;
			opTypeV[deleteproperty]=type_u8_u30__multiname_info;
			ops["deleteproperty"]=deleteproperty;
			opNameV[deleteproperty]="deleteproperty";
			
			//0x6b
			//opDataTypeV[107]="";
			//opTypeV[107]="";
			//ops[107]="";
			//opNameV[""]=107;
			
			//0x6c
			opDataTypeV[getslot]=dataType_u8_u30;
			opTypeV[getslot]=type_u8_u30__slot;
			ops["getslot"]=getslot;
			opNameV[getslot]="getslot";
			
			//0x6d
			opDataTypeV[setslot]=dataType_u8_u30;
			opTypeV[setslot]=type_u8_u30__slot;
			ops["setslot"]=setslot;
			opNameV[setslot]="setslot";
			
			//0x6e
			opDataTypeV[getglobalslot]=dataType_u8_u30;
			opTypeV[getglobalslot]=type_u8_u30__slot;
			ops["getglobalslot"]=getglobalslot;
			opNameV[getglobalslot]="getglobalslot";
			
			//0x6f
			opDataTypeV[setglobalslot]=dataType_u8_u30;
			opTypeV[setglobalslot]=type_u8_u30__slot;
			ops["setglobalslot"]=setglobalslot;
			opNameV[setglobalslot]="setglobalslot";
			
			//0x70
			opDataTypeV[convert_s]=dataType_u8;
			opTypeV[convert_s]=type_u8;
			ops["convert_s"]=convert_s;
			opNameV[convert_s]="convert_s";
			
			//0x71
			opDataTypeV[esc_xelem]=dataType_u8;
			opTypeV[esc_xelem]=type_u8;
			ops["esc_xelem"]=esc_xelem;
			opNameV[esc_xelem]="esc_xelem";
			
			//0x72
			opDataTypeV[esc_xattr]=dataType_u8;
			opTypeV[esc_xattr]=type_u8;
			ops["esc_xattr"]=esc_xattr;
			opNameV[esc_xattr]="esc_xattr";
			
			//0x73
			opDataTypeV[convert_i]=dataType_u8;
			opTypeV[convert_i]=type_u8;
			ops["convert_i"]=convert_i;
			opNameV[convert_i]="convert_i";
			
			//0x74
			opDataTypeV[convert_u]=dataType_u8;
			opTypeV[convert_u]=type_u8;
			ops["convert_u"]=convert_u;
			opNameV[convert_u]="convert_u";
			
			//0x75
			opDataTypeV[convert_d]=dataType_u8;
			opTypeV[convert_d]=type_u8;
			ops["convert_d"]=convert_d;
			opNameV[convert_d]="convert_d";
			
			//0x76
			opDataTypeV[convert_b]=dataType_u8;
			opTypeV[convert_b]=type_u8;
			ops["convert_b"]=convert_b;
			opNameV[convert_b]="convert_b";
			
			//0x77
			opDataTypeV[convert_o]=dataType_u8;
			opTypeV[convert_o]=type_u8;
			ops["convert_o"]=convert_o;
			opNameV[convert_o]="convert_o";
			
			//0x78
			opDataTypeV[checkfilter]=dataType_u8;
			opTypeV[checkfilter]=type_u8;
			ops["checkfilter"]=checkfilter;
			opNameV[checkfilter]="checkfilter";
			
			//0x79
			//opDataTypeV[121]="";
			//opTypeV[121]="";
			//ops[121]="";
			//opNameV[""]=121;
			
			//0x7a
			//opDataTypeV[122]="";
			//opTypeV[122]="";
			//ops[122]="";
			//opNameV[""]=122;
			
			//0x7b
			//opDataTypeV[123]="";
			//opTypeV[123]="";
			//ops[123]="";
			//opNameV[""]=123;
			
			//0x7c
			//opDataTypeV[124]="";
			//opTypeV[124]="";
			//ops[124]="";
			//opNameV[""]=124;
			
			//0x7d
			//opDataTypeV[125]="";
			//opTypeV[125]="";
			//ops[125]="";
			//opNameV[""]=125;
			
			//0x7e
			//opDataTypeV[126]="";
			//opTypeV[126]="";
			//ops[126]="";
			//opNameV[""]=126;
			
			//0x7f
			//opDataTypeV[127]="";
			//opTypeV[127]="";
			//ops[127]="";
			//opNameV[""]=127;
			
			//0x80
			opDataTypeV[coerce]=dataType_u8_u30;
			opTypeV[coerce]=type_u8_u30__multiname_info;
			ops["coerce"]=coerce;
			opNameV[coerce]="coerce";
			
			//0x81
			opDataTypeV[coerce_b]=dataType_u8;
			opTypeV[coerce_b]=type_u8;
			ops["coerce_b"]=coerce_b;
			opNameV[coerce_b]="coerce_b";
			
			//0x82
			opDataTypeV[coerce_a]=dataType_u8;
			opTypeV[coerce_a]=type_u8;
			ops["coerce_a"]=coerce_a;
			opNameV[coerce_a]="coerce_a";
			
			//0x83
			opDataTypeV[coerce_i]=dataType_u8;
			opTypeV[coerce_i]=type_u8;
			ops["coerce_i"]=coerce_i;
			opNameV[coerce_i]="coerce_i";
			
			//0x84
			opDataTypeV[coerce_d]=dataType_u8;
			opTypeV[coerce_d]=type_u8;
			ops["coerce_d"]=coerce_d;
			opNameV[coerce_d]="coerce_d";
			
			//0x85
			opDataTypeV[coerce_s]=dataType_u8;
			opTypeV[coerce_s]=type_u8;
			ops["coerce_s"]=coerce_s;
			opNameV[coerce_s]="coerce_s";
			
			//0x86
			opDataTypeV[astype]=dataType_u8_u30;
			opTypeV[astype]=type_u8_u30__multiname_info;
			ops["astype"]=astype;
			opNameV[astype]="astype";
			
			//0x87
			opDataTypeV[astypelate]=dataType_u8;
			opTypeV[astypelate]=type_u8;
			ops["astypelate"]=astypelate;
			opNameV[astypelate]="astypelate";
			
			//0x88
			opDataTypeV[coerce_u]=dataType_u8;
			opTypeV[coerce_u]=type_u8;
			ops["coerce_u"]=coerce_u;
			opNameV[coerce_u]="coerce_u";
			
			//0x89
			opDataTypeV[coerce_o]=dataType_u8;
			opTypeV[coerce_o]=type_u8;
			ops["coerce_o"]=coerce_o;
			opNameV[coerce_o]="coerce_o";
			
			//0x8a
			//opDataTypeV[138]="";
			//opTypeV[138]="";
			//ops[138]="";
			//opNameV[""]=138;
			
			//0x8b
			//opDataTypeV[139]="";
			//opTypeV[139]="";
			//ops[139]="";
			//opNameV[""]=139;
			
			//0x8c
			//opDataTypeV[140]="";
			//opTypeV[140]="";
			//ops[140]="";
			//opNameV[""]=140;
			
			//0x8d
			//opDataTypeV[141]="";
			//opTypeV[141]="";
			//ops[141]="";
			//opNameV[""]=141;
			
			//0x8e
			//opDataTypeV[142]="";
			//opTypeV[142]="";
			//ops[142]="";
			//opNameV[""]=142;
			
			//0x8f
			//opDataTypeV[143]="";
			//opTypeV[143]="";
			//ops[143]="";
			//opNameV[""]=143;
			
			//0x90
			opDataTypeV[negate]=dataType_u8;
			opTypeV[negate]=type_u8;
			ops["negate"]=negate;
			opNameV[negate]="negate";
			
			//0x91
			opDataTypeV[increment]=dataType_u8;
			opTypeV[increment]=type_u8;
			ops["increment"]=increment;
			opNameV[increment]="increment";
			
			//0x92
			opDataTypeV[inclocal]=dataType_u8_u30;
			opTypeV[inclocal]=type_u8_u30__register;
			ops["inclocal"]=inclocal;
			opNameV[inclocal]="inclocal";
			
			//0x93
			opDataTypeV[decrement]=dataType_u8;
			opTypeV[decrement]=type_u8;
			ops["decrement"]=decrement;
			opNameV[decrement]="decrement";
			
			//0x94
			opDataTypeV[declocal]=dataType_u8_u30;
			opTypeV[declocal]=type_u8_u30__register;
			ops["declocal"]=declocal;
			opNameV[declocal]="declocal";
			
			//0x95
			opDataTypeV[typeof_]=dataType_u8;
			opTypeV[typeof_]=type_u8;
			ops["typeof_"]=typeof_;
			opNameV[typeof_]="typeof_";
			
			//0x96
			opDataTypeV[not]=dataType_u8;
			opTypeV[not]=type_u8;
			ops["not"]=not;
			opNameV[not]="not";
			
			//0x97
			opDataTypeV[bitnot]=dataType_u8;
			opTypeV[bitnot]=type_u8;
			ops["bitnot"]=bitnot;
			opNameV[bitnot]="bitnot";
			
			//0x98
			//opDataTypeV[152]="";
			//opTypeV[152]="";
			//ops[152]="";
			//opNameV[""]=152;
			
			//0x99
			//opDataTypeV[153]="";
			//opTypeV[153]="";
			//ops[153]="";
			//opNameV[""]=153;
			
			//0x9a
			//opDataTypeV[154]="";
			//opTypeV[154]="";
			//ops[154]="";
			//opNameV[""]=154;
			
			//0x9b
			//opDataTypeV[155]="";
			//opTypeV[155]="";
			//ops[155]="";
			//opNameV[""]=155;
			
			//0x9c
			//opDataTypeV[156]="";
			//opTypeV[156]="";
			//ops[156]="";
			//opNameV[""]=156;
			
			//0x9d
			//opDataTypeV[157]="";
			//opTypeV[157]="";
			//ops[157]="";
			//opNameV[""]=157;
			
			//0x9e
			//opDataTypeV[158]="";
			//opTypeV[158]="";
			//ops[158]="";
			//opNameV[""]=158;
			
			//0x9f
			//opDataTypeV[159]="";
			//opTypeV[159]="";
			//ops[159]="";
			//opNameV[""]=159;
			
			//0xa0
			opDataTypeV[add]=dataType_u8;
			opTypeV[add]=type_u8;
			ops["add"]=add;
			opNameV[add]="add";
			
			//0xa1
			opDataTypeV[subtract]=dataType_u8;
			opTypeV[subtract]=type_u8;
			ops["subtract"]=subtract;
			opNameV[subtract]="subtract";
			
			//0xa2
			opDataTypeV[multiply]=dataType_u8;
			opTypeV[multiply]=type_u8;
			ops["multiply"]=multiply;
			opNameV[multiply]="multiply";
			
			//0xa3
			opDataTypeV[divide]=dataType_u8;
			opTypeV[divide]=type_u8;
			ops["divide"]=divide;
			opNameV[divide]="divide";
			
			//0xa4
			opDataTypeV[modulo]=dataType_u8;
			opTypeV[modulo]=type_u8;
			ops["modulo"]=modulo;
			opNameV[modulo]="modulo";
			
			//0xa5
			opDataTypeV[lshift]=dataType_u8;
			opTypeV[lshift]=type_u8;
			ops["lshift"]=lshift;
			opNameV[lshift]="lshift";
			
			//0xa6
			opDataTypeV[rshift]=dataType_u8;
			opTypeV[rshift]=type_u8;
			ops["rshift"]=rshift;
			opNameV[rshift]="rshift";
			
			//0xa7
			opDataTypeV[urshift]=dataType_u8;
			opTypeV[urshift]=type_u8;
			ops["urshift"]=urshift;
			opNameV[urshift]="urshift";
			
			//0xa8
			opDataTypeV[bitand]=dataType_u8;
			opTypeV[bitand]=type_u8;
			ops["bitand"]=bitand;
			opNameV[bitand]="bitand";
			
			//0xa9
			opDataTypeV[bitor]=dataType_u8;
			opTypeV[bitor]=type_u8;
			ops["bitor"]=bitor;
			opNameV[bitor]="bitor";
			
			//0xaa
			opDataTypeV[bitxor]=dataType_u8;
			opTypeV[bitxor]=type_u8;
			ops["bitxor"]=bitxor;
			opNameV[bitxor]="bitxor";
			
			//0xab
			opDataTypeV[equals]=dataType_u8;
			opTypeV[equals]=type_u8;
			ops["equals"]=equals;
			opNameV[equals]="equals";
			
			//0xac
			opDataTypeV[strictequals]=dataType_u8;
			opTypeV[strictequals]=type_u8;
			ops["strictequals"]=strictequals;
			opNameV[strictequals]="strictequals";
			
			//0xad
			opDataTypeV[lessthan]=dataType_u8;
			opTypeV[lessthan]=type_u8;
			ops["lessthan"]=lessthan;
			opNameV[lessthan]="lessthan";
			
			//0xae
			opDataTypeV[lessequals]=dataType_u8;
			opTypeV[lessequals]=type_u8;
			ops["lessequals"]=lessequals;
			opNameV[lessequals]="lessequals";
			
			//0xaf
			opDataTypeV[greaterthan]=dataType_u8;
			opTypeV[greaterthan]=type_u8;
			ops["greaterthan"]=greaterthan;
			opNameV[greaterthan]="greaterthan";
			
			//0xb0
			opDataTypeV[greaterequals]=dataType_u8;
			opTypeV[greaterequals]=type_u8;
			ops["greaterequals"]=greaterequals;
			opNameV[greaterequals]="greaterequals";
			
			//0xb1
			opDataTypeV[instanceof_]=dataType_u8;
			opTypeV[instanceof_]=type_u8;
			ops["instanceof_"]=instanceof_;
			opNameV[instanceof_]="instanceof_";
			
			//0xb2
			opDataTypeV[istype]=dataType_u8_u30;
			opTypeV[istype]=type_u8_u30__multiname_info;
			ops["istype"]=istype;
			opNameV[istype]="istype";
			
			//0xb3
			opDataTypeV[istypelate]=dataType_u8;
			opTypeV[istypelate]=type_u8;
			ops["istypelate"]=istypelate;
			opNameV[istypelate]="istypelate";
			
			//0xb4
			opDataTypeV[in_]=dataType_u8;
			opTypeV[in_]=type_u8;
			ops["in_"]=in_;
			opNameV[in_]="in_";
			
			//0xb5
			//opDataTypeV[181]="";
			//opTypeV[181]="";
			//ops[181]="";
			//opNameV[""]=181;
			
			//0xb6
			//opDataTypeV[182]="";
			//opTypeV[182]="";
			//ops[182]="";
			//opNameV[""]=182;
			
			//0xb7
			//opDataTypeV[183]="";
			//opTypeV[183]="";
			//ops[183]="";
			//opNameV[""]=183;
			
			//0xb8
			//opDataTypeV[184]="";
			//opTypeV[184]="";
			//ops[184]="";
			//opNameV[""]=184;
			
			//0xb9
			//opDataTypeV[185]="";
			//opTypeV[185]="";
			//ops[185]="";
			//opNameV[""]=185;
			
			//0xba
			//opDataTypeV[186]="";
			//opTypeV[186]="";
			//ops[186]="";
			//opNameV[""]=186;
			
			//0xbb
			//opDataTypeV[187]="";
			//opTypeV[187]="";
			//ops[187]="";
			//opNameV[""]=187;
			
			//0xbc
			//opDataTypeV[188]="";
			//opTypeV[188]="";
			//ops[188]="";
			//opNameV[""]=188;
			
			//0xbd
			//opDataTypeV[189]="";
			//opTypeV[189]="";
			//ops[189]="";
			//opNameV[""]=189;
			
			//0xbe
			//opDataTypeV[190]="";
			//opTypeV[190]="";
			//ops[190]="";
			//opNameV[""]=190;
			
			//0xbf
			//opDataTypeV[191]="";
			//opTypeV[191]="";
			//ops[191]="";
			//opNameV[""]=191;
			
			//0xc0
			opDataTypeV[increment_i]=dataType_u8;
			opTypeV[increment_i]=type_u8;
			ops["increment_i"]=increment_i;
			opNameV[increment_i]="increment_i";
			
			//0xc1
			opDataTypeV[decrement_i]=dataType_u8;
			opTypeV[decrement_i]=type_u8;
			ops["decrement_i"]=decrement_i;
			opNameV[decrement_i]="decrement_i";
			
			//0xc2
			opDataTypeV[inclocal_i]=dataType_u8_u30;
			opTypeV[inclocal_i]=type_u8_u30__register;
			ops["inclocal_i"]=inclocal_i;
			opNameV[inclocal_i]="inclocal_i";
			
			//0xc3
			opDataTypeV[declocal_i]=dataType_u8_u30;
			opTypeV[declocal_i]=type_u8_u30__register;
			ops["declocal_i"]=declocal_i;
			opNameV[declocal_i]="declocal_i";
			
			//0xc4
			opDataTypeV[negate_i]=dataType_u8;
			opTypeV[negate_i]=type_u8;
			ops["negate_i"]=negate_i;
			opNameV[negate_i]="negate_i";
			
			//0xc5
			opDataTypeV[add_i]=dataType_u8;
			opTypeV[add_i]=type_u8;
			ops["add_i"]=add_i;
			opNameV[add_i]="add_i";
			
			//0xc6
			opDataTypeV[subtract_i]=dataType_u8;
			opTypeV[subtract_i]=type_u8;
			ops["subtract_i"]=subtract_i;
			opNameV[subtract_i]="subtract_i";
			
			//0xc7
			opDataTypeV[multiply_i]=dataType_u8;
			opTypeV[multiply_i]=type_u8;
			ops["multiply_i"]=multiply_i;
			opNameV[multiply_i]="multiply_i";
			
			//0xc8
			//opDataTypeV[200]="";
			//opTypeV[200]="";
			//ops[200]="";
			//opNameV[""]=200;
			
			//0xc9
			//opDataTypeV[201]="";
			//opTypeV[201]="";
			//ops[201]="";
			//opNameV[""]=201;
			
			//0xca
			//opDataTypeV[202]="";
			//opTypeV[202]="";
			//ops[202]="";
			//opNameV[""]=202;
			
			//0xcb
			//opDataTypeV[203]="";
			//opTypeV[203]="";
			//ops[203]="";
			//opNameV[""]=203;
			
			//0xcc
			//opDataTypeV[204]="";
			//opTypeV[204]="";
			//ops[204]="";
			//opNameV[""]=204;
			
			//0xcd
			//opDataTypeV[205]="";
			//opTypeV[205]="";
			//ops[205]="";
			//opNameV[""]=205;
			
			//0xce
			//opDataTypeV[206]="";
			//opTypeV[206]="";
			//ops[206]="";
			//opNameV[""]=206;
			
			//0xcf
			//opDataTypeV[207]="";
			//opTypeV[207]="";
			//ops[207]="";
			//opNameV[""]=207;
			
			//0xd0
			opDataTypeV[getlocal0]=dataType_u8;
			opTypeV[getlocal0]=type_u8;
			ops["getlocal0"]=getlocal0;
			opNameV[getlocal0]="getlocal0";
			
			//0xd1
			opDataTypeV[getlocal1]=dataType_u8;
			opTypeV[getlocal1]=type_u8;
			ops["getlocal1"]=getlocal1;
			opNameV[getlocal1]="getlocal1";
			
			//0xd2
			opDataTypeV[getlocal2]=dataType_u8;
			opTypeV[getlocal2]=type_u8;
			ops["getlocal2"]=getlocal2;
			opNameV[getlocal2]="getlocal2";
			
			//0xd3
			opDataTypeV[getlocal3]=dataType_u8;
			opTypeV[getlocal3]=type_u8;
			ops["getlocal3"]=getlocal3;
			opNameV[getlocal3]="getlocal3";
			
			//0xd4
			opDataTypeV[setlocal0]=dataType_u8;
			opTypeV[setlocal0]=type_u8;
			ops["setlocal0"]=setlocal0;
			opNameV[setlocal0]="setlocal0";
			
			//0xd5
			opDataTypeV[setlocal1]=dataType_u8;
			opTypeV[setlocal1]=type_u8;
			ops["setlocal1"]=setlocal1;
			opNameV[setlocal1]="setlocal1";
			
			//0xd6
			opDataTypeV[setlocal2]=dataType_u8;
			opTypeV[setlocal2]=type_u8;
			ops["setlocal2"]=setlocal2;
			opNameV[setlocal2]="setlocal2";
			
			//0xd7
			opDataTypeV[setlocal3]=dataType_u8;
			opTypeV[setlocal3]=type_u8;
			ops["setlocal3"]=setlocal3;
			opNameV[setlocal3]="setlocal3";
			
			//0xd8
			//opDataTypeV[216]="";
			//opTypeV[216]="";
			//ops[216]="";
			//opNameV[""]=216;
			
			//0xd9
			//opDataTypeV[217]="";
			//opTypeV[217]="";
			//ops[217]="";
			//opNameV[""]=217;
			
			//0xda
			//opDataTypeV[218]="";
			//opTypeV[218]="";
			//ops[218]="";
			//opNameV[""]=218;
			
			//0xdb
			//opDataTypeV[219]="";
			//opTypeV[219]="";
			//ops[219]="";
			//opNameV[""]=219;
			
			//0xdc
			//opDataTypeV[220]="";
			//opTypeV[220]="";
			//ops[220]="";
			//opNameV[""]=220;
			
			//0xdd
			//opDataTypeV[221]="";
			//opTypeV[221]="";
			//ops[221]="";
			//opNameV[""]=221;
			
			//0xde
			//opDataTypeV[222]="";
			//opTypeV[222]="";
			//ops[222]="";
			//opNameV[""]=222;
			
			//0xdf
			//opDataTypeV[223]="";
			//opTypeV[223]="";
			//ops[223]="";
			//opNameV[""]=223;
			
			//0xe0
			//opDataTypeV[224]="";
			//opTypeV[224]="";
			//ops[224]="";
			//opNameV[""]=224;
			
			//0xe1
			//opDataTypeV[225]="";
			//opTypeV[225]="";
			//ops[225]="";
			//opNameV[""]=225;
			
			//0xe2
			//opDataTypeV[226]="";
			//opTypeV[226]="";
			//ops[226]="";
			//opNameV[""]=226;
			
			//0xe3
			//opDataTypeV[227]="";
			//opTypeV[227]="";
			//ops[227]="";
			//opNameV[""]=227;
			
			//0xe4
			//opDataTypeV[228]="";
			//opTypeV[228]="";
			//ops[228]="";
			//opNameV[""]=228;
			
			//0xe5
			//opDataTypeV[229]="";
			//opTypeV[229]="";
			//ops[229]="";
			//opNameV[""]=229;
			
			//0xe6
			//opDataTypeV[230]="";
			//opTypeV[230]="";
			//ops[230]="";
			//opNameV[""]=230;
			
			//0xe7
			//opDataTypeV[231]="";
			//opTypeV[231]="";
			//ops[231]="";
			//opNameV[""]=231;
			
			//0xe8
			//opDataTypeV[232]="";
			//opTypeV[232]="";
			//ops[232]="";
			//opNameV[""]=232;
			
			//0xe9
			//opDataTypeV[233]="";
			//opTypeV[233]="";
			//ops[233]="";
			//opNameV[""]=233;
			
			//0xea
			//opDataTypeV[234]="";
			//opTypeV[234]="";
			//ops[234]="";
			//opNameV[""]=234;
			
			//0xeb
			//opDataTypeV[235]="";
			//opTypeV[235]="";
			//ops[235]="";
			//opNameV[""]=235;
			
			//0xec
			//opDataTypeV[236]="";
			//opTypeV[236]="";
			//ops[236]="";
			//opNameV[""]=236;
			
			//0xed
			//opDataTypeV[237]="";
			//opTypeV[237]="";
			//ops[237]="";
			//opNameV[""]=237;
			
			//0xee
			//opDataTypeV[238]="";
			//opTypeV[238]="";
			//ops[238]="";
			//opNameV[""]=238;
			
			//0xef
			opDataTypeV[debug]=dataType_u8_u8_u30_u8_u30;
			opTypeV[debug]=type_u8_u8_u30_u8_u30__debug;
			ops["debug"]=debug;
			opNameV[debug]="debug";
			
			//0xf0
			opDataTypeV[debugline]=dataType_u8_u30;
			opTypeV[debugline]=type_u8_u30__value_int;
			ops["debugline"]=debugline;
			opNameV[debugline]="debugline";
			
			//0xf1
			opDataTypeV[debugfile]=dataType_u8_u30;
			opTypeV[debugfile]=type_u8_u30__string;
			ops["debugfile"]=debugfile;
			opNameV[debugfile]="debugfile";
			
			//0xf2
			opDataTypeV[bkptline]=dataType_u8_u30;
			opTypeV[bkptline]=type_u8_u30__value_int;
			ops["bkptline"]=bkptline;
			opNameV[bkptline]="bkptline";
			
			//0xf3
			opDataTypeV[timestamp]=dataType_u8;
			opTypeV[timestamp]=type_u8;
			ops["timestamp"]=timestamp;
			opNameV[timestamp]="timestamp";
			
			//0xf4
			//opDataTypeV[244]="";
			//opTypeV[244]="";
			//ops[244]="";
			//opNameV[""]=244;
			
			//0xf5
			//opDataTypeV[245]="";
			//opTypeV[245]="";
			//ops[245]="";
			//opNameV[""]=245;
			
			//0xf6
			//opDataTypeV[246]="";
			//opTypeV[246]="";
			//ops[246]="";
			//opNameV[""]=246;
			
			//0xf7
			//opDataTypeV[247]="";
			//opTypeV[247]="";
			//ops[247]="";
			//opNameV[""]=247;
			
			//0xf8
			//opDataTypeV[248]="";
			//opTypeV[248]="";
			//ops[248]="";
			//opNameV[""]=248;
			
			//0xf9
			//opDataTypeV[249]="";
			//opTypeV[249]="";
			//ops[249]="";
			//opNameV[""]=249;
			
			//0xfa
			//opDataTypeV[250]="";
			//opTypeV[250]="";
			//ops[250]="";
			//opNameV[""]=250;
			
			//0xfb
			//opDataTypeV[251]="";
			//opTypeV[251]="";
			//ops[251]="";
			//opNameV[""]=251;
			
			//0xfc
			//opDataTypeV[252]="";
			//opTypeV[252]="";
			//ops[252]="";
			//opNameV[""]=252;
			
			//0xfd
			//opDataTypeV[253]="";
			//opTypeV[253]="";
			//ops[253]="";
			//opNameV[""]=253;
			
			//0xfe
			//opDataTypeV[254]="";
			//opTypeV[254]="";
			//ops[254]="";
			//opNameV[""]=254;
			
			//0xff
			//opDataTypeV[255]="";
			//opTypeV[255]="";
			//ops[255]="";
			//opNameV[""]=255;
			return opNameV;
		}
	}
}
