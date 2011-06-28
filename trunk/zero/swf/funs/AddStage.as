/***
AddStage
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月27日 19:34:00
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.tagBodys.*;
	
	public class AddStage{
		private var packageNamespaceQNames:PackageNamespaceQNames;
		public function AddStage(){
			packageNamespaceQNames=new PackageNamespaceQNames();
		}
		public function add(swf:SWF,shellName:String,siageName:String):void{
			var i:int;
			var ABCData:ABCClasses,clazz:ABCClass,trait:ABCTrait;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=(tag.getBody({ABCFileClass:ABCClasses}) as DoABC).ABCData;
						for each(clazz in ABCData.classV){
							_addStageToTraits(clazz.itraitV,shellName,siageName);
						}
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=(tag.getBody({ABCFileClass:ABCClasses}) as DoABCWithoutFlagsAndName).ABCData;
						for each(clazz in ABCData.classV){
							_addStageToTraits(clazz.itraitV,shellName,siageName);
						}
					break;
				}
			}
		}
		private function _addStageToTraits(traitV:Vector.<ABCTrait>,shellName:String,siageName:String):void{
			var trait:ABCTrait;
			for each(trait in traitV){
				if(trait.name.name=="stage"){
					return;
				}
			}
			
			var method:ABCMethod=new ABCMethod();
			method.return_type=packageNamespaceQNames.gen("flash.display.Stage");
			//method.name="";
			method.flags=0;
			method.max_stack=2;
			method.local_count=1;
			method.init_scope_depth=0;//9
			method.max_scope_depth=1;//10
			method.codes=new AVM2Codes();
			method.codes.codeArr=[
				AVM2Ops.getlocal0,
				AVM2Ops.pushscope,
				new AVM2Code(AVM2Ops.getlex,packageNamespaceQNames.gen(shellName)),
				new AVM2Code(AVM2Ops.getproperty,packageNamespaceQNames.gen(siageName)),
				new AVM2Code(AVM2Ops.coerce,packageNamespaceQNames.gen("flash.display.Stage")),
				AVM2Ops.returnvalue
			];
			
			trait=new ABCTrait();
			trait.name=packageNamespaceQNames.gen("stage");
			trait.kind_attributes=TraitTypeAndAttributes.Override;
			trait.kind_trait_type=TraitTypeAndAttributes.Getter;
			trait.disp_id=0;
			trait.method=method;
			
			traitV.push(trait);
		}
	}
}
		