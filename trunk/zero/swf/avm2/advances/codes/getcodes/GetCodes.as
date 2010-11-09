/***
GetCodes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 15:42:20
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	
	public class GetCodes extends Sprite{
		private var urlLoader:URLLoader;
		private var codes:String;
		public function GetCodes(){
			urlLoader=new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,loadComplete);
			urlLoader.load(new URLRequest("yogda_avm.xml"));
		}
		private function loadComplete(event:Event):void{
			urlLoader.removeEventListener(Event.COMPLETE,loadComplete);
			init(new XML(urlLoader.data));
			urlLoader=null;
			
			var txt:TextField=new TextField();
			this.addChild(txt);
			txt.x=10;
			txt.y=10;
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.text="点击舞台另存为";
			
			stage.addEventListener(MouseEvent.CLICK,click);
		}
		private function click(event:MouseEvent):void{
			new FileReference().save(codes,"Op.as");
		}
		private function init(xml:XML):void{
			delete xml.extended;
			
			//优先级:
			//1 avm2overview.pdf
			//2 yogda_avm.xml
			//3 Op
			//事后实验验证
			
			var avm2Op:AVM2Op;
			
			var avm2OpV:Vector.<AVM2Op>=new Vector.<AVM2Op>(0x100);
			avm2OpV.fixed=true;
			
			var op:int;
			var opcodeXML:XML;
			
			var unusedOpCodesXML:XML=<unusedOpCodes>
				<opcode type="UNU" hex="$00" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$0A" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$0B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$22" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$33" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$34" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$3F" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$4B" string="Unused"><short>OP_callsuperid</short><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$4D" string="Unused"><short>OP_callinterface</short><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$54" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$5B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$5C" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$69" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$6B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$79" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7A" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7C" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7D" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7E" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$7F" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8A" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8C" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8D" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8E" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$8F" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$98" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$99" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9A" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9B" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9C" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9D" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9E" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$9F" string="Unused"><stack in_count="0" out_count="0"></stack></opcode>
				<opcode type="UNU" hex="$B5" string=""></opcode>
				<opcode type="UNU" hex="$B6" string=""></opcode>
				<opcode type="UNU" hex="$B7" string=""></opcode>
				<opcode type="UNU" hex="$B8" string=""></opcode>
				<opcode type="UNU" hex="$B9" string=""></opcode>
				<opcode type="UNU" hex="$BA" string=""></opcode>
				<opcode type="UNU" hex="$BB" string=""></opcode>
				<opcode type="UNU" hex="$BC" string=""></opcode>
				<opcode type="UNU" hex="$BD" string=""></opcode>
				<opcode type="UNU" hex="$BE" string=""></opcode>
				<opcode type="UNU" hex="$BF" string=""></opcode>
				<opcode type="UNU" hex="$C8" string=""></opcode>
				<opcode type="UNU" hex="$C9" string=""></opcode>
				<opcode type="UNU" hex="$CA" string=""></opcode>
				<opcode type="UNU" hex="$CB" string=""></opcode>
				<opcode type="UNU" hex="$CC" string=""></opcode>
				<opcode type="UNU" hex="$CD" string=""></opcode>
				<opcode type="UNU" hex="$CE" string=""></opcode>
				<opcode type="UNU" hex="$CF" string=""></opcode>
				<opcode type="UNU" hex="$D8" string=""></opcode>
				<opcode type="UNU" hex="$D9" string=""></opcode>
				<opcode type="UNU" hex="$DA" string=""></opcode>
				<opcode type="UNU" hex="$DB" string=""></opcode>
				<opcode type="UNU" hex="$DC" string=""></opcode>
				<opcode type="UNU" hex="$DD" string=""></opcode>
				<opcode type="UNU" hex="$DE" string=""></opcode>
				<opcode type="UNU" hex="$DF" string=""></opcode>
				<opcode type="UNU" hex="$E0" string=""></opcode>
				<opcode type="UNU" hex="$E1" string=""></opcode>
				<opcode type="UNU" hex="$E2" string=""></opcode>
				<opcode type="UNU" hex="$E3" string=""></opcode>
				<opcode type="UNU" hex="$E4" string=""></opcode>
				<opcode type="UNU" hex="$E5" string=""></opcode>
				<opcode type="UNU" hex="$E6" string=""></opcode>
				<opcode type="UNU" hex="$E7" string=""></opcode>
				<opcode type="UNU" hex="$E8" string=""></opcode>
				<opcode type="UNU" hex="$E9" string=""></opcode>
				<opcode type="UNU" hex="$EA" string=""></opcode>
				<opcode type="UNU" hex="$EB" string=""></opcode>
				<opcode type="UNU" hex="$EC" string=""></opcode>
				<opcode type="UNU" hex="$ED" string=""></opcode>
				<opcode type="UNU" hex="$F4" string=""></opcode>
				<opcode type="UNU" hex="$F5" string=""></opcode>
				<opcode type="UNU" hex="$F6" string=""></opcode>
				<opcode type="UNU" hex="$F7" string=""></opcode>
				<opcode type="UNU" hex="$F8" string=""></opcode>
				<opcode type="UNU" hex="$F9" string=""></opcode>
				<opcode type="UNU" hex="$FA" string=""></opcode>
				<opcode type="UNU" hex="$FB" string=""></opcode>
				<opcode type="UNU" hex="$FC" string=""></opcode>
				<opcode type="UNU" hex="$FD" string=""></opcode>
				<opcode type="UNU" hex="$FE" string=""></opcode>
				<opcode type="UNU" hex="$FF" string="OP_ext"><stack in_count="0" out_count="0"></stack></opcode>
			</unusedOpCodes>
			
			for each(var unusedOpCodeXML:XML in unusedOpCodesXML.opcode){
				op=int("0x"+unusedOpCodeXML.@hex.toString().substr(1));
				opcodeXML=xml.opcodes.opcode[op];
				if(opcodeXML.toXMLString()===unusedOpCodeXML.toXMLString()){
					opcodeXML.setChildren(<node/>);
					delete opcodeXML.node[0];
					opcodeXML.@string="";
				}else{
					throw new Error(opcodeXML.toXMLString());
				}
			}
			
			//修正 yogda_avm.xml
			xml.opcodes.opcode[0x81].@string="coerce_b";
			xml.opcodes.opcode[0x83].@string="coerce_i";
			xml.opcodes.opcode[0x84].@string="coerce_d";
			xml.opcodes.opcode[0x88].@string="coerce_u";
			
			xml.opcodes.opcode[0x4c].params[0]=
<params>
	<param name="index" type="u30" class="multiname"/>
	<param name="arg_count" type="u30" class="integer"/>
</params>
			
			xml.opcodes.opcode[0xf2]=
<opcode type="IID" hex="$F2" string="bkptline">
			<short>我补的</short>
			<params>
				<param name="linenum" type="u30" class="integer"/>
			</params>
			<stack in_count="0" out_count="0"><![CDATA[ _ => _ ]]></stack>
			<description>
				<![CDATA[
我补的
]]>
			</description>
			<tamarincode>
				<![CDATA[
我补的
]]>
			</tamarincode>
		</opcode>
			
			var opStr_v:Vector.<String>=Vector.<String>([	"",	"bkpt",	"nop",	"throw",	"getsuper",	"setsuper",	"dxns",	"dxnslate",	"kill",	"label",	"",	"",	"ifnlt",	"ifnle",	"ifngt",	"ifnge",	"jump",	"iftrue",	"iffalse",	"ifeq",	"ifne",	"iflt",	"ifle",	"ifgt",	"ifge",	"ifstricteq",	"ifstrictne",	"lookupswitch",	"pushwith",	"popscope",	"nextname",	"hasnext",	"pushnull",	"pushundefined",	"",	"nextvalue",	"pushbyte",	"pushshort",	"pushtrue",	"pushfalse",	"pushnan",	"pop",	"dup",	"swap",	"pushstring",	"pushint",	"pushuint",	"pushdouble",	"pushscope",	"pushnamespace",	"hasnext2",	"",	"",	"li8","li16","li32","lf32","lf64","si8","si16","si32","sf32","sf64",	"",	"newfunction",	"call",	"construct",	"callmethod",	"callstatic",	"callsuper",	"callproperty",	"returnvoid",	"returnvalue",	"constructsuper",	"constructprop",	"",	"callproplex",	"",	"callsupervoid",	"callpropvoid",	"sxi1","sxi8","sxi16",	"applytype",	"",	"newobject",	"newarray",	"newactivation",	"newclass",	"getdescendants",	"newcatch",	"",	"",	"findpropstrict",	"findproperty",	"finddef",	"getlex",	"setproperty",	"getlocal",	"setlocal",	"getglobalscope",	"getscopeobject",	"getproperty",	"",	"initproperty",	"",	"deleteproperty",	"",	"getslot",	"setslot",	"getglobalslot",	"setglobalslot",	"convert_s",	"esc_xelem",	"esc_xattr",	"convert_i",	"convert_u",	"convert_d",	"convert_b",	"convert_o",	"checkfilter",	"",	"",	"",	"",	"",	"",	"",	"coerce",	"coerce_b",	"coerce_a",	"coerce_i",	"coerce_d",	"coerce_s",	"astype",	"astypelate",	"coerce_u",	"coerce_o",	"",	"",	"",	"",	"",	"",	"negate",	"increment",	"inclocal",	"decrement",	"declocal",	"typeof",	"not",	"bitnot",	"",	"",	"",	"",	"",	"",	"",	"",	"add",	"subtract",	"multiply",	"divide",	"modulo",	"lshift",	"rshift",	"urshift",	"bitand",	"bitor",	"bitxor",	"equals",	"strictequals",	"lessthan",	"lessequals",	"greaterthan",	"greaterequals",	"instanceof",	"istype",	"istypelate",	"in",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"increment_i",	"decrement_i",	"inclocal_i",	"declocal_i",	"negate_i",	"add_i",	"subtract_i",	"multiply_i",	"",	"",	"",	"",	"",	"",	"",	"",	"getlocal0",	"getlocal1",	"getlocal2",	"getlocal3",	"setlocal0",	"setlocal1",	"setlocal2",	"setlocal3",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"debug",	"debugline",	"debugfile",	"bkptline",	"timestamp",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	"",	""]);
			
			//修正 Op:
			opStr_v[0x01]="breakpoint";
			opStr_v[0x67]="getouterscope";
			opStr_v[0xee]="abs_jump";
			
			op=0;
			for each(opcodeXML in xml.opcodes.opcode){
				var hexStr:String=op.toString(16).toUpperCase();
				if(op<0x10){
					hexStr="0"+hexStr;
				}
				
				var opStr:String=opStr_v[op];
				if(opcodeXML.@hex.toString()==="$"+hexStr){
					var type:String=opcodeXML.@type.toString();
					var string:String=opcodeXML.@string.toString();
					
					avm2Op=new AVM2Op(type);
					avm2OpV[op]=avm2Op;
					
					if(string===""){
						if(opStr){
							throw new Error("Op里有XML里没有的: 0x"+hexStr+" string="+string+",opStr="+opStr);
						}else if(opcodeXML.toXMLString()==='<opcode type="UNU" hex="$'+hexStr+'" string=""/>'){
							//正常
						}else{
							throw new Error(opcodeXML.toXMLString());
						}
					}else{
						if(type===AVM2Op.TYPE_UNU){
							throw new Error("type="+type);
						}else if(opStr){
							if(string===opStr){
								//正常
								var stackXMLStr:String=opcodeXML.stack.toXMLString().replace(/\s*[\r\n]\s*/g,"");
								switch(stackXMLStr){
									case '<stack in_count="0" out_count="0"/>':
									case '<stack in_count="0" out_count="0"><![CDATA[ _ => _ ]]></stack>':
									case '<stack in_count="0" out_count="0"><sparam name="addr" class="in"/><sparam name="value" class="out"/></stack>':	
										
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , value]]><sparam name="value" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , true ]]><sparam name="true" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , false]]><sparam name="false" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , NaN]]><sparam name="NaN" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , null]]><sparam name="null" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , undefined]]><sparam name="undefined" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , obj]]><sparam name="obj" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , namespace]]><sparam name="namespace" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , function_obj]]><sparam name="function_obj" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , catchscope]]><sparam name="catchscope" class="out"/></stack>':
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , scope]]><sparam name="scope" class="out"/></stack>':	
									case '<stack in_count="0" out_count="1"><![CDATA[ _ => _ , newactivation]]><sparam name="newactivation" class="out"/></stack>':	
									case '<stack in_count="0" out_count="1"><![CDATA[ ... ]]><sparam name=".." class="out"/></stack>':	
												
									case '<stack in_count="1" out_count="0"><![CDATA[ _ , value => _ ]]><sparam name="value" class="in"/></stack>':
									case '<stack in_count="1" out_count="0"><![CDATA[ _ , index => _ ]]><sparam name="index" class="in"/></stack>':
									case '<stack in_count="1" out_count="0"><![CDATA[ _ , scope_obj => _ ]]><sparam name="scope_obj" class="in"/></stack>':
										
									case '<stack in_count="1" out_count="1"><![CDATA[ _ value => value]]><sparam name="_value" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , value]]><sparam name="value" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , stringvalue]]><sparam name="value" class="in"/><sparam name="stringvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , intvalue]]><sparam name="value" class="in"/><sparam name="intvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , uintvalue]]><sparam name="value" class="in"/><sparam name="uintvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , doublevalue]]><sparam name="value" class="in"/><sparam name="doublevalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , booleanvalue]]><sparam name="value" class="in"/><sparam name="booleanvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , coercedvalue]]><sparam name="value" class="in"/><sparam name="coercedvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , incrementedvalue]]><sparam name="value" class="in"/><sparam name="incrementedvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , decrementedvalue]]><sparam name="value" class="in"/><sparam name="decrementedvalue" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , -value]]><sparam name="value" class="in"/><sparam name="-value" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , !value]]><sparam name="value" class="in"/><sparam name="!value" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , result]]><sparam name="value" class="in"/><sparam name="result" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , value => _ , typename]]><sparam name="value" class="in"/><sparam name="typename" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , obj => _ , value]]><sparam name="obj" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , basetype => _ , newclass]]><sparam name="basetype" class="in"/><sparam name="newclass" class="out"/></stack>':
									case '<stack in_count="1" out_count="1"><![CDATA[ _ , => _ , value]]><sparam name="" class="in"/><sparam name="value" class="out"/></stack>':	
											
									case '<stack in_count="2" out_count="0"><![CDATA[ _ , value1, value2 => _ ]]><sparam name="value1" class="in"/><sparam name="value2" class="in"/></stack>':
									case '<stack in_count="2" out_count="0"><![CDATA[ _ , obj, value => _ ]]><sparam name="obj" class="in"/><sparam name="value" class="in"/></stack>':
									case '<stack in_count="2" out_count="0"><sparam name="index" class="in"/><sparam name="d2l" class="in"/></stack>':	
									case '<stack in_count="2" out_count="0"><sparam name="addr" class="in"/><sparam name="value" class="in"/></stack>':
										
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , value1, value2 => _ , value3]]><sparam name="value1" class="in"/><sparam name="value2" class="in"/><sparam name="value3" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , value1, value2 => _ , result]]><sparam name="value1" class="in"/><sparam name="value2" class="in"/><sparam name="result" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , obj, index => _ , name]]><sparam name="obj" class="in"/><sparam name="index" class="in"/><sparam name="name" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , obj, index => _ , value]]><sparam name="obj" class="in"/><sparam name="index" class="in"/><sparam name="value" class="out"/></stack>':	
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , obj, cur_index => _ , next_index]]><sparam name="obj" class="in"/><sparam name="cur_index" class="in"/><sparam name="next_index" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , value, class => _ , value]]><sparam name="value" class="in"/><sparam name="class" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , value, type => _ , result]]><sparam name="value" class="in"/><sparam name="type" class="in"/><sparam name="result" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , name, obj => _ , result]]><sparam name="name" class="in"/><sparam name="obj" class="in"/><sparam name="result" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ , [ns], [name] => _ , obj]]><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="obj" class="out"/></stack>':
												
									case '<stack in_count="1" out_count="2"><![CDATA[ _ , value => _ , value, value]]><sparam name="value" class="in"/><sparam name="value" class="out"/><sparam name="value" class="out"/></stack>':	
									case '<stack in_count="2" out_count="2"><![CDATA[ _ , value1, value2 => _ , value2, value1]]><sparam name="value1" class="in"/><sparam name="value2" class="in"/><sparam name="value2" class="out"/><sparam name="value1" class="out"/></stack>':	
										
									case '<stack in_count="3" out_count="1"><![CDATA[ _ , obj, [ns], [name] => _ , value]]><sparam name="obj" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="3" out_count="1"><![CDATA[ _ , object, [ns], [name] => _ , value]]><sparam name="object" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="4" out_count="0"><![CDATA[ _ , obj, [ns], [name], value => _ ]]><sparam name="obj" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="value" class="in"/></stack>':
									case '<stack in_count="4" out_count="0"><![CDATA[ _ , object, [ns], [name], value => _ ]]><sparam name="object" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="value" class="in"/></stack>':
									case '<stack in_count="6" out_count="0"><![CDATA[ _ , obj, [ns], [name], arg1,...,argn => _ ]]><sparam name="obj" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="arg1" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/></stack>':
									case '<stack in_count="6" out_count="1"><![CDATA[ _ , obj, [ns], [name], arg1,...,argn => _ , value]]><sparam name="obj" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="arg1" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="5" out_count="0"><![CDATA[ _ , object, arg1, arg2, ..., argn => _ ]]><sparam name="object" class="in"/><sparam name="arg1" class="in"/><sparam name="arg2" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/></stack>':	
									case '<stack in_count="5" out_count="1"><![CDATA[ _ , receiver, arg1, arg2, ..., argn => _ , value]]><sparam name="receiver" class="in"/><sparam name="arg1" class="in"/><sparam name="arg2" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/><sparam name="value" class="out"/></stack>':
									case '<stack in_count="5" out_count="0"><![CDATA[ _ , receiver, [ns], [name], arg1, _ , argn => _ ]]><sparam name="receiver" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="arg1" class="in"/><sparam name="argn" class="in"/></stack>':
									case '<stack in_count="6" out_count="1"><![CDATA[ _ , receiver, [ns], [name], arg1,...,argn => _ , value]]><sparam name="receiver" class="in"/><sparam name="[ns]" class="in"/><sparam name="[name]" class="in"/><sparam name="arg1" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/><sparam name="value" class="out"/></stack>':	
									case '<stack in_count="6" out_count="1"><![CDATA[ _ , function, receiver, arg1, arg2, ..., argn => _ , value]]><sparam name="function" class="in"/><sparam name="receiver" class="in"/><sparam name="arg1" class="in"/><sparam name="arg2" class="in"/><sparam name="..." class="in"/><sparam name="argn" class="in"/><sparam name="value" class="out"/></stack>':	
										
									case '<stack in_count="4" out_count="1"><![CDATA[ _ , value1, value2, ..., valueN => _ , newarray]]><sparam name="value1" class="in"/><sparam name="value2" class="in"/><sparam name="..." class="in"/><sparam name="valueN" class="in"/><sparam name="newarray" class="out"/></stack>':
									case '<stack in_count="7" out_count="1"><![CDATA[ _ , name1, value1, name2, value2,...,nameN, valueN => _ , newobj]]><sparam name="name1" class="in"/><sparam name="value1" class="in"/><sparam name="name2" class="in"/><sparam name="value2" class="in"/><sparam name="..." class="in"/><sparam name="nameN" class="in"/><sparam name="valueN" class="in"/><sparam name="newobj" class="out"/></stack>':
									case '<stack in_count="2" out_count="1"><![CDATA[ _ arg1, .. argN => value]]><sparam name="_arg1" class="in"/><sparam name="..argN" class="in"/><sparam name="value" class="out"/></stack>':
									
										//暂时没什么用
									break;
									default:
										throw new Error("未知 stack: "+paramsXMLStr);
									break;
								}
								var paramsXMLStr:String=opcodeXML.params.toXMLString().replace(/\s*[\r\n]\s*/g,"");
								switch(paramsXMLStr){
									case '':
									case '<params/>':
										
									case '<params><param name="offset" type="s24" class="jump"/></params>':
										
									case '<params><param name="index" type="u30" class="string"/></params>':
									case '<params><param name="index" type="u30" class="integer"/></params>':
									case '<params><param name="index" type="u30" class="scopeindex"/></params>':
									case '<params><param name="index" type="u30" class="localscope"/></params>':
									case '<params><param name="index" type="u30" class="localregister"/></params>':
									case '<params><param name="index" type="u30" class="multiname"/></params>':
									case '<params><param name="index" type="u30" class="namespace"/></params>':
									case '<params><param name="index" type="u30" class="classinfo"/></params>':
									case '<params><param name="index" type="u30" class="exceptioninfo"/></params>':
									case '<params><param name="index" type="u30" class="multiname"/><param name="arg_count" type="u30" class="integer"/></params>':
									
									case '<params><param name="slotindex" type="u30" class="integer"/></params>':
										
									case '<params><param name="arg_count" type="u30" class="integer"/></params>':
									case '<params><param name="paramcount" type="u30" class="integer"/></params>':
									case '<params><param name="value" type="u30" class="integer"/></params>':
									case '<params><param name="linenum" type="u30" class="integer"/></params>':
												
										
									case '<params><param name="byte_value" type="u8" class="integer"/></params>':
									
									case '<params><param name="debug_type" type="u8" class="integer"/><param name="index" type="u30" class="string"/><param name="reg" type="u8" class="localregister"/><param name="extra" type="u30" class="integer"/></params>':
									
									case '<params><param name="object_reg" type="u30" class="integer"/><param name="index_reg" type="u30" class="jump"/></params>':
									case '<params><param name="default_offset" type="s24" class="jump"/><param name="case_count" type="u30" class="switch_count"/><param name="case_offsets" type="s24" countp="case_count" class="case_offsets"/></params>':
										
										//获取 params
									break;
									default:
										throw new Error("未知 params: "+paramsXMLStr);
									break;
								}
							}else{
								throw new Error("0x"+hexStr+" "+string+"!="+opStr);
							}
						}else{
							throw new Error("XML里有Op里没有的: 0x"+hexStr+" string="+string+",opStr="+opStr);
						}
					}
				}else{
					throw new Error(opcodeXML.@hex.toString()+"!=$"+hexStr);
				}
				
				delete opcodeXML.@hex;
				delete opcodeXML.@type;
				delete opcodeXML.@string;
				
				delete opcodeXML.stack;
				delete opcodeXML.params;
				
				delete opcodeXML.tamarincode;
				delete opcodeXML.short;
				delete opcodeXML.description;
				
				if(opcodeXML.toXMLString()==="<opcode/>"){
				}else{
					throw new Error("未处理的 opcodeXML: "+opcodeXML.toXMLString());
				}
				
				op++;
			}
			
			//////////////////////////////////////////////////////////////
			//20101108
			var opName:String;
			
			codes="package zero.swf.avm2.advances.codes{\n";
			codes+="\tpublic class Op{\n";
			
			opStr_v[3]+="_";
			opStr_v[149]+="_";
			opStr_v[177]+="_";
			opStr_v[180]+="_";
			
			avm2OpV[103].type=AVM2Op.TYPE_UNU;//getouterscope
			avm2OpV[238].type=AVM2Op.TYPE_UNU;//abs_jump
			
			//codes+="\t\tpublic static const TYPE_IIC:String=\"IIC\";\n";
			//codes+="\t\tpublic static const TYPE_IID:String=\"IID\";\n";
			//codes+="\t\tpublic static const TYPE_III:String=\"III\";\n";
			//codes+="\t\tpublic static const TYPE_IIM:String=\"IIM\";\n";
			//codes+="\t\tpublic static const TYPE_IIU:String=\"IIU\";\n";
			//codes+="\t\tpublic static const TYPE_UNU:String=\"UNU\";\n";
			//codes+="\t\t\n";
			
			var opNameArr:Array=[
				["simple",["breakpoint","nop","throw_","dxnslate","label","pushwith","popscope","nextname","hasnext","pushnull","pushundefined","nextvalue","pushtrue","pushfalse","pushnan","pop","dup","swap","pushscope","li8","li16","li32","lf32","lf64","si8","si16","si32","sf32","sf64","returnvoid","returnvalue","sxi1","sxi8","sxi16","newactivation","getglobalscope","convert_s","esc_xelem","esc_xattr","convert_i","convert_u","convert_d","convert_b","convert_o","checkfilter","coerce_b","coerce_a","coerce_i","coerce_d","coerce_s","astypelate","coerce_u","coerce_o","negate","increment","decrement","typeof_","not","bitnot","add","subtract","multiply","divide","modulo","lshift","rshift","urshift","bitand","bitor","bitxor","equals","strictequals","lessthan","lessequals","greaterthan","greaterequals","instanceof_","istypelate","in_","increment_i","decrement_i","negate_i","add_i","subtract_i","multiply_i","getlocal0","getlocal1","getlocal2","getlocal3","setlocal0","setlocal1","setlocal2","setlocal3","timestamp"]],
				
				["index_u30_multiname_info",["getsuper","setsuper","getdescendants","findpropstrict","findproperty","getlex","setproperty","getproperty","initproperty","deleteproperty","coerce","astype","istype"]],
				["index_u30_string",["dxns","pushstring","debugfile"]],
				["index_u30_register",["kill","getlocal","setlocal","inclocal","declocal","inclocal_i","declocal_i"]],
				["index_u30_slot",["getslot","setslot","getglobalslot","setglobalslot"]],
				["index_u30_int",["pushint"]],
				["index_u30_uint",["pushuint"]],
				["index_u30_double",["pushdouble"]],
				["index_u30_namespace_info",["pushnamespace"]],
				["index_u30_method",["newfunction"]],
				["index_u30_class",["newclass"]],
				["index_u30_exception_info",["newcatch"]],
				["index_u30_scope",["getscopeobject"]],
				["index_u30_finddef",["finddef"]],
				
				["index_args_u30_u30_multiname_info",["callsuper","callproperty","constructprop","callproplex","callsupervoid","callpropvoid"]],
				["index_args_u30_u30_method",["callmethod","callstatic"]],
				
				["args_u30",["call","construct","constructsuper","applytype","newobject","newarray"]],
				
				["branch_s24",["ifnlt","ifnle","ifngt","ifnge","jump","iftrue","iffalse","ifeq","ifne","iflt","ifle","ifgt","ifge","ifstricteq","ifstrictne"]],
				
				["value_byte_u8",["pushbyte"]],
				["value_int_u30",["pushshort","debugline","bkptline"]],
				
				["special",["lookupswitch","hasnext2","debug"]]
			];
			
			var subOpNameArr:Array;
			var opTypeMark:Object=new Object();
			for each(subOpNameArr in opNameArr){
				codes+="\t\tpublic static const type_"+subOpNameArr[0]+":String=\""+subOpNameArr[0]+"\";\n";
				for each(opName in subOpNameArr[1]){
					opTypeMark[opName]=subOpNameArr[0];
				}
			}
			codes+="\n";
			
			op=-1;
			for each(avm2Op in avm2OpV){
				op++;
				switch(avm2Op.type){
					case AVM2Op.TYPE_UNU:
						codes+="\t\t//"+getHexStr(op)+"\n";
						continue;
					break;
				}
				codes+="\t\tpublic static const "+opStr_v[op]+":int="+op+";//"+getHexStr(op)+"\n";
			}
			
			codes+="\n";
			codes+="\t\tpublic static var opTypeV:Vector.<String>;\n";
			codes+="\t\tpublic static const opNameV:Vector.<String>=get_opNameV();\n";
			codes+="\t\tprivate static function get_opNameV():Vector.<String>{\n";
			codes+="\t\t\topTypeV=new Vector.<String>(256);\n";
			codes+="\t\t\tvar opNameV:Vector.<String>=new Vector.<String>(256);\n";
			codes+="\t\t\topNameV.fixed=true;\n";
			
			op=-1;
			for each(avm2Op in avm2OpV){
				op++;
				opName=opStr_v[op];
				codes+="\t\t\t\n";
				codes+="\t\t\t//"+getHexStr(op)+"\n";
				switch(avm2Op.type){
					case AVM2Op.TYPE_UNU:
						codes+="\t\t\t\//opTypeV["+op+"];\n";
						continue;
					break;
				}
				var type_:String=opTypeMark[opName];
				if(type_){
				}else{
					throw new Error("type_="+type_);
				}
				codes+="\t\t\t\opTypeV["+opName+"]=type_"+type_+";\n";
				codes+="\t\t\topNameV["+opName+"]=\""+opName+"\";\n";
			}
			
			codes+="\t\t\treturn opNameV;\n";
			codes+="\t\t}\n";
			codes+="\t}\n";
			codes+="}\n";
		}
		private static function getHexStr(num:int):String{
			if(num<16){
				return "0x0"+num.toString(16);
			}
			return "0x"+num.toString(16);
		}
	}
}

class AVM2Op{
	public static const TYPE_IIC:String="IIC";
	public static const TYPE_IID:String="IID";
	public static const TYPE_III:String="III";
	public static const TYPE_IIM:String="IIM";
	public static const TYPE_IIU:String="IIU";
	public static const TYPE_UNU:String="UNU";
	
	public var type:String;
	public function AVM2Op(_type:String){
		if(AVM2Op["TYPE_"+_type]==_type){
			type=_type;
		}else{
			throw new Error("_type="+_type);
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