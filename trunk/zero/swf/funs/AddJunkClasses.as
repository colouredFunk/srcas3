/***
AddJunkClasses
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月22日 00:07:19
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.codes.Code;
	import zero.swf.tagBodys.*;
	
	public class AddJunkClasses{
		//添加坏掉但不会被播放器运行到的 DoABC tag
		//如果是文档类可直接挂 ASV
		//如果是非文档类在点击查看代码时挂 ASV 和闪客精灵
		public static function add(swf:SWF):void{
			
			trace("目前只有 loopGenericName");
			
			var frontClassV:Vector.<ABCClass>=new Vector.<ABCClass>();
			var frontScriptV:Vector.<ABCScript>=new Vector.<ABCScript>();
			
			var backClassV:Vector.<ABCClass>=new Vector.<ABCClass>();
			var backScriptV:Vector.<ABCScript>=new Vector.<ABCScript>();
			
			var docClassName:String=getDocClassName(swf);
			
			trace("docClassName="+docClassName);
			
			var ABCData:ABCClasses;
			var frontPos:int=-1,backPos:int=-1;
			var i:int=-1;
			for each(var tag:Tag in swf.tagV){
				i++;
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(DoABC,{ABCDataClass:ABCClasses}).ABCData;
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCClasses}).ABCData;
					break;
					default:
						ABCData=null;
					break;
				}
				if(ABCData){
					if(frontPos>-1){
					}else{
						frontPos=i;
					}
					backPos=i;
					for each(var clazz:ABCClass in ABCData.classV){
						if(
							docClassName==clazz.getClassName()
							||
							Math.random()<0.5
						){
							trace("frontClass="+clazz.getClassName());
							frontClassV.push(clazz);
						}else{
							trace("backClass="+clazz.getClassName());
							backClassV.push(clazz);
						}
					}
					for each(var script:ABCScript in ABCData.scriptV){
						if(Math.random()<0.5){
							frontScriptV.push(script);
						}else{
							backScriptV.push(script);
						}
					}
				}
			}
			
			var avalibleDefineObjIdV:Vector.<int>=getAvalibleDefineObjIdV(swf.tagV);
			if(frontClassV.length>0||frontScriptV.length>0){
				swf.tagV.splice(frontPos,0,getJunkDoABCSpriteTag(avalibleDefineObjIdV.shift(),frontClassV,frontScriptV));
			}
			if(backClassV.length>0||backScriptV.length>0){
				swf.tagV.splice(backPos+2,0,getJunkDoABCSpriteTag(avalibleDefineObjIdV.shift(),backClassV,backScriptV));
			}
		}
		
		private static function getJunkDoABCSpriteTag(
			id:int,
			classV:Vector.<ABCClass>,
			scriptV:Vector.<ABCScript>
		):Tag{
			
			var abcClasses:ABCClasses=new ABCClasses();
			abcClasses.minor_version=16;
			abcClasses.major_version=46;
			abcClasses.classV=new Vector.<ABCClass>();
			abcClasses.scriptV=new Vector.<ABCScript>();
			
			for each(var clazz:ABCClass in classV){
				var copyClazz:ABCClass=new ABCClass();
				copyClazz.name=clazz.name;
				copyClazz.super_name=clazz.super_name;
				copyClazz.ClassSealed=clazz.ClassSealed;
				copyClazz.ClassFinal=clazz.ClassFinal;
				copyClazz.ClassInterface=clazz.ClassInterface;
				copyClazz.protectedNs=clazz.protectedNs;
				copyClazz.intrfV=clazz.intrfV;
				copyClazz.iinit=clazz.iinit;
				copyClazz.itraitV=new Vector.<ABCTrait>();
				var i:int=-1;
				for each(var trait:ABCTrait in clazz.itraitV){
					i++;
					copyClazz.itraitV[i]=makeJunkTrait(trait);
				}
				copyClazz.cinit=clazz.cinit;
				copyClazz.ctraitV=clazz.ctraitV;
				abcClasses.classV.push(copyClazz);
			}
			for each(var script:ABCScript in scriptV){
				var copyScript:ABCScript=new ABCScript();
				copyScript.init=script.init;
				copyScript.traitV=script.traitV;
				abcClasses.scriptV.push(copyScript);
			}
			
			var defineSprite:DefineSprite=new DefineSprite();
			defineSprite.id=id;
			defineSprite.tagV=new Vector.<Tag>();
			var doABCTag:Tag=new Tag();
			var doABCWithoutFlagsAndName:DoABCWithoutFlagsAndName=new DoABCWithoutFlagsAndName();
			doABCWithoutFlagsAndName.ABCData=abcClasses;
			doABCTag.setBody(doABCWithoutFlagsAndName);
			defineSprite.tagV[0]=doABCTag;
			defineSprite.tagV[1]=new Tag(TagTypes.ShowFrame);
			defineSprite.tagV[2]=new Tag(TagTypes.End);
			var defineSpriteTag:Tag=new Tag();
			defineSpriteTag.setBody(defineSprite);
			return defineSpriteTag;
		}
		private static function makeJunkTrait(trait:ABCTrait):ABCTrait{
			var loopGenericName:ABCMultiname=new ABCMultiname();
			loopGenericName.kind=MultinameKinds.GenericName;
			loopGenericName.TypeDefinition=loopGenericName;
			loopGenericName.ParamV=new Vector.<ABCMultiname>();
			loopGenericName.ParamV[0]=loopGenericName;
			var copyTrait:ABCTrait=new ABCTrait();
			copyTrait.ATTR_Final=false;
			copyTrait.ATTR_Override=false;
			copyTrait.kind_trait_type=TraitTypeAndAttributes.Slot;
			copyTrait.slot_id=0;
			copyTrait.name=trait.name;
			copyTrait.type_name=loopGenericName;
			return copyTrait;
		}
	}
}
		