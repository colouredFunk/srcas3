/***
getDocClassScript
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月5日 21:38:55
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.utils.*;
	import zero.swf.tagBodys.*;
	
	public function getDocClassScript(swf:SWFExtend):ABCScript{
		if(swf.isAS3){
			var docClassName:String=swf.docClassName;
			if(docClassName){
				for each(var ABCData:ABCClasses in getABCClasseses(swf)){
					for each(var script:ABCScript in ABCData.scriptV){
						for each(var trait:ABCTrait in script.traitV){
							if(trait.kind_trait_type==TraitTypeAndAttributes.Class_){
								if((trait.name.ns.name?trait.name.ns.name+".":"")+trait.name.name==docClassName){
									return script;
								}
							}
						}
					}
				}
				throw new Error("找不到 docClassScript"+docClassName);
			}
			return null;
		}
		throw new Error("swf.isAS3="+swf.isAS3);
	}
}