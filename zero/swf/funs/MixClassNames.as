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
			var swf:SWF=new SWF();
			swf.initBySWFData(swfData,null);
			
			var str0:String;
			var i:int;
			
			if(strtArr){
			}else{
				strtArr=str0Arr;
			}
			i=-1;
			for each(str0 in str0Arr){
				i++;
				mark["~"+str0]=strtArr[i];
			}
			
			var ABCData:ABCFile;
			var instance_info:Instance_info;
			var className:Multiname_info;
			var ns:Namespace_info;
			for each(var tag:Tag in swf.tagV){
				switch(tag.type){
					case TagTypes.DoABC:
						ABCData=tag.getBody(DoABC,{ABCDataClass:ABCFile}).ABCData;
						for each(instance_info in ABCData.instance_infoV){
							className=ABCData.multiname_infoV[instance_info.name];
							ns=ABCData.namespace_infoV[className.u30_1];
							if(ns){
								ABCData.stringV[ns.name]=mixStr(ABCData.stringV[ns.name]);
							}
							ABCData.stringV[className.u30_2]=mixStr(ABCData.stringV[className.u30_2]);
						}
					break;
					case TagTypes.DoABCWithoutFlagsAndName:
						ABCData=tag.getBody(DoABCWithoutFlagsAndName,{ABCDataClass:ABCFile}).ABCData;
						for each(instance_info in ABCData.instance_infoV){
							className=ABCData.multiname_infoV[instance_info.name];
							ns=ABCData.namespace_infoV[className.u30_1];
							if(ns){
								ABCData.stringV[ns.name]=mixStr(ABCData.stringV[ns.name]);
							}
							ABCData.stringV[className.u30_2]=mixStr(ABCData.stringV[className.u30_2]);
						}
					break;
					case TagTypes.SymbolClass:
						var NameV:Vector.<String>=tag.getBody(SymbolClass,null).NameV;
						i=NameV.length;
						while(--i>=0){
							var Name:String=NameV[i].replace(/\:\:/g,".");
							var dotId:int=Name.lastIndexOf(".");
							if(dotId>-1){
								var nsName:String=Name.substr(0,dotId);
								var name:String=Name.substr(dotId+1);
								NameV[i]=mixStr(nsName)+"."+mixStr(name);
							}else{
								NameV[i]=mixStr(NameV[i]);
							}
						}
						break;
				}
			}
			
			return swf.toSWFData(null);
		}
		private function mixStr(str:String):String{
			if(str){
				if(mark["~"+str]){
				}else{
					mark["~"+str]=RandomStrs.getRan();
					mark["~"+mark["~"+str]]=mark["~"+str];
				}
				return mark["~"+str];
			}
			return str;
		}
	}
}
		