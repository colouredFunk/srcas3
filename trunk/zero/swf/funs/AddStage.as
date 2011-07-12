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
		public static function add(swf:SWF,shellName:String,siageName:String):void{
			var putInSceneTagAndClassNameArr:Array=PutInSceneTagAndClassNames.getPutInSceneTagAndClassNameArr(swf);
			var i:int=putInSceneTagAndClassNameArr.length;
			var classNameMark:Object=new Object();
			while(--i>=0){
				if(putInSceneTagAndClassNameArr[i]){
					//trace(putInSceneTagAndClassNameArr[i][1]);
					classNameMark["~"+putInSceneTagAndClassNameArr[i][1]]=true;
				}
			}
			
			var packageNamespaceQNames:PackageNamespaceQNames=new PackageNamespaceQNames();
			
			var ABCData:ABCClasses;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(
							DoABC,{
								ABCDataClass:ABCClasses
							}
						).ABCData;
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(
							DoABCWithoutFlagsAndName,{
								ABCDataClass:ABCClasses
							}
						).ABCData;
					break;
					default:
						ABCData=null;
					break;
				}
				if(ABCData){
					for each(var clazz:ABCClass in ABCData.classV){
						if(classNameMark["~"+clazz.getClassName()]){
							if(
								clazz.super_name
								&&
								clazz.super_name.ns
								&&
								clazz.super_name.ns.kind==NamespaceKinds.PackageNamespace
								&&
								clazz.super_name.ns.name=="flash.display"
								&&
								(
									clazz.super_name.name=="Sprite"
									||
									clazz.super_name.name=="MovieClip"
								)
							){
								//trace(clazz.getClassName());
								_addStageToTraits(
									packageNamespaceQNames,
									clazz.itraitV,
									shellName,
									siageName
								);
							}
						}
					}
				}
			}
		}
		private static function _addStageToTraits(
			packageNamespaceQNames:PackageNamespaceQNames,
			traitV:Vector.<ABCTrait>,
			shellName:String,
			siageName:String
		):void{
			var trait:ABCTrait;
			for each(trait in traitV){
				if(trait.name.name=="stage"){
					return;
				}
			}
			
			var method:ABCMethod=new ABCMethod();
			method.return_type=packageNamespaceQNames.gen("flash.display.Stage");
			//method.name="";
			//method.NeedArguments=false;
			//method.NeedActivation=false;
			//method.NeedRest=false;
			//method.SetDxns=false;
			method.max_stack=2;
			method.local_count=1;
			method.init_scope_depth=0;//9
			method.max_scope_depth=1;//10
			method.codes=new AVM2Codes();
			method.codes.codeArr=SimpleCompilation.com(
				<codes><![CDATA[
					getlocal0
					pushscope
					getlex
					getproperty
					coerce flash.display.Stage
					returnvalue
				]]></codes>.toString(),
				packageNamespaceQNames
			);
			
			trait=new ABCTrait();
			trait.name=packageNamespaceQNames.gen("stage");
			//trait.ATTR_Final=false;
			trait.ATTR_Override=true;
			trait.kind_trait_type=TraitTypeAndAttributes.Getter;
			trait.disp_id=0;
			trait.method=method;
			
			traitV.push(trait);
		}
	}
}
		