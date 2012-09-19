/***
MixClassNames
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月17日 19:35:05
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import flash.utils.*;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.avm2.*;
	import zero.swf.funs.*;
	import zero.swf.tagBodys.*;
	
	public class MixClassNames{
		public var mark:Object;
		public function MixClassNames(){
			//混淆类名以防和游戏中的类名冲突
			mark=new Object();
		}
		public function mix(
			swfData:ByteArray,
			str0Arr:Array,
			strtArr:Array
		):ByteArray{
			
			//把 DoABC 或 DoABCWithoutFlagsAndName 的 ABCData 里的 stringV 里的特定的字符串替换成特定的字符串
			
			var swf:SWFExtend=new SWFExtend();
			swf.initBySWFData(swfData,null);
			
			if(swf.isAS3){
			}else{
				throw new Error("swf 必须是 AS3 的");
			}
			
			if(strtArr){
			}else{
				strtArr=str0Arr;
			}
			var i:int=-1;
			for each(var str0:String in str0Arr){
				i++;
				mark["~"+str0]=strtArr[i];
			}
			
			for each(var ABCData:ABCFile in getABCFiles(swf)){
				for each(var instance_info:Instance_info in ABCData.instance_infoV){
					var className:Multiname_info=ABCData.multiname_infoV[instance_info.name];
					var ns:Namespace_info=ABCData.namespace_infoV[className.u30_1];
					if(ns){
						ABCData.stringV[ns.name]=mixStr(ABCData.stringV[ns.name]);
					}
					ABCData.stringV[className.u30_2]=mixStr(ABCData.stringV[className.u30_2]);
				}
			}
			
			for each(var tag:Tag in swf.tagV){
				if(tag.type==TagTypes.SymbolClass){
					var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
					i=NameV.length;
					while(--i>=0){
						NameV[i]=mixStr(NameV[i]);
					}
				}
			}
			
			return swf.toSWFData(null);
		}
		private function mixStr(str:String):String{
			if(str){
				var strArr:Array=str.split(/\:+|\./);
				var i:int=strArr.length;
				while(--i>=0){
					var subStr:String=strArr[i];
					if(mark["~"+subStr]){
					}else{
						mark["~"+subStr]=RandomStrs.getRan();
						mark["~"+mark["~"+subStr]]=mark["~"+subStr];
					}
					strArr[i]=mark["~"+subStr];
				}
				return strArr.join(".");
			}
			return str;
		}
	}
}	