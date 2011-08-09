/***
AddDocClassAdded
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月5日 17:09:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.ComplexString;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.*;
	import zero.swf.funs.*;
	import zero.swf.tagBodys.*;
	
	public class AddDocClassAdded{
		public static function add(swf:SWF):Boolean{
			var docClass:ABCClass=getDocClass(swf);
			if(docClass){
				for each(var code:* in docClass.iinit.codes.codeArr){
					if(
						code is Code
						&&
						code.op==AVM2Ops.constructsuper
					){
						var codeId:int=docClass.iinit.codes.codeArr.indexOf(code)+1;
						var codeHead:Array=docClass.iinit.codes.codeArr.slice(0,codeId);
						var codeTail:Array=docClass.iinit.codes.codeArr.slice(codeId);
						
						var genMultiname:GenMultiname=new GenMultiname();
						var funName:ABCMultiname=genMultiname.gen("[PrivateNs](name=undefined)."+ComplexString.ext.escape(new Date()+"_"+int(Math.random()*1000000)));
						
						var addedTrait:ABCTrait=new ABCTrait();
						addedTrait.ATTR_Final=false;
						addedTrait.ATTR_Override=false;
						addedTrait.kind_trait_type=TraitTypeAndAttributes.Method;
						addedTrait.disp_id=0;
						addedTrait.name=genMultiname.gen("[PrivateNs](name=undefined).added");
						addedTrait.method=new ABCMethod();
						addedTrait.method.NeedArguments=false;
						addedTrait.method.NeedActivation=false;
						addedTrait.method.NeedRest=true;
						addedTrait.method.SetDxns=false;
						addedTrait.method.max_stack=3;
						addedTrait.method.local_count=2;//- -
						addedTrait.method.init_scope_depth=9;
						addedTrait.method.max_scope_depth=10;
						addedTrait.method.return_type=genMultiname.gen("void");
						addedTrait.method.codes=new AVM2Codes();
						addedTrait.method.codes.codeArr=[
							AVM2Ops.getlocal0,
							AVM2Ops.pushscope,
							AVM2Ops.getlocal0,
							new Code(AVM2Ops.getlex,genMultiname.gen("flash.events.Event")),
							new Code(AVM2Ops.getproperty,genMultiname.gen("ADDED_TO_STAGE")),
							AVM2Ops.getlocal0,
							new Code(AVM2Ops.getproperty,genMultiname.gen("[PrivateNs](name=undefined).added")),
							new Code(AVM2Ops.callpropvoid,{multiname:genMultiname.gen("removeEventListener"),args:2}),
							AVM2Ops.getlocal0,
							new Code(AVM2Ops.callpropvoid,{multiname:funName,args:0}),
							AVM2Ops.returnvoid
						];
						
						var funTrait:ABCTrait=new ABCTrait();
						funTrait.ATTR_Final=false;
						funTrait.ATTR_Override=false;
						funTrait.kind_trait_type=TraitTypeAndAttributes.Method;
						funTrait.disp_id=0;
						funTrait.name=funName;
						funTrait.method=new ABCMethod();
						funTrait.method.NeedArguments=false;
						funTrait.method.NeedActivation=false;
						funTrait.method.NeedRest=false;
						funTrait.method.SetDxns=false;
						funTrait.method.max_stack=docClass.iinit.max_stack;
						funTrait.method.local_count=docClass.iinit.local_count;
						funTrait.method.init_scope_depth=docClass.iinit.init_scope_depth;
						funTrait.method.max_scope_depth=docClass.iinit.max_scope_depth;
						funTrait.method.return_type=genMultiname.gen("void");
						funTrait.method.codes=new AVM2Codes();
						funTrait.method.codes.codeArr=[
							AVM2Ops.getlocal0,
							AVM2Ops.pushscope
						].concat(codeTail);
						
						docClass.itraitV.unshift(addedTrait,funTrait);
						
						if(docClass.iinit.max_stack<3){
							docClass.iinit.max_stack=3;
						}
						docClass.iinit.codes.codeArr=codeHead.concat([
							
							AVM2Ops.getlocal0,
							new Code(AVM2Ops.getlex,genMultiname.gen("flash.events.Event")),
							new Code(AVM2Ops.getproperty,genMultiname.gen("ADDED_TO_STAGE")),
							new Code(AVM2Ops.getlex,genMultiname.gen("[PrivateNs](name=undefined).added")),
							new Code(AVM2Ops.callpropvoid,{multiname:genMultiname.gen("addEventListener"),args:2}),
							
							AVM2Ops.returnvoid
						]);
						
						return true;
					}
				}
			}
			return false;
		}
	}
}