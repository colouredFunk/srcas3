/***
Fun
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月11日 17:41:49
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1.runners{
	
	import zero.swf.avm1.*;
	
	import flash.utils.Proxy;
	
	public class Fun{
		
		public var funHead:AVM1Code;
		public var registerArr:Array;
		public var codeArr:Array;
		
		//Clazz 专用
		private var __prototype:Object;
		public function get prototype():Object{
			return __prototype;
		}
		
		public var className:String;
		public var baseFun:Fun;
		//
		
		public function Fun(_codeArr:Array){
			
			var i:int;
			
			codeArr=_codeArr;
			funHead=codeArr.shift();
			registerArr=new Array();
			switch(funHead.op){
				case AVM1Op.function_:
				break;
				case AVM1Op.function2:
					var registerId:int=0;
					if(funHead.value.PreloadThisFlag){
						registerId++;
						//PreloadValueArr[PreloadValueArr.length]="r:"+registerId+"='this'";
						registerArr[registerId]="this";
					}//else if(funHead.value.SuppressThisFlag){
					//PreloadValueArr[PreloadValueArr.length]="'this'";
					//}
					if(funHead.value.PreloadArgumentsFlag){
						registerId++;
						//PreloadValueArr[PreloadValueArr.length]="r:"+registerId+"='arguments'";
						registerArr[registerId]="arguments";
					}//else if(funHead.value.SuppressArgumentsFlag){
					//PreloadValueArr[PreloadValueArr.length]="'arguments'";
					//}
					if(funHead.value.PreloadSuperFlag){
						registerId++;
						//PreloadValueArr[PreloadValueArr.length]="r:"+registerId+"='super'";
						registerArr[registerId]="super";
					}//else if(funHead.value.SuppressSuperFlag){
					//PreloadValueArr[PreloadValueArr.length]="'super'";
					//}
					if(funHead.value.PreloadRootFlag){
						registerId++;
						//PreloadValueArr[PreloadValueArr.length]="r:"+registerId+"='_root'";
						registerArr[registerId]="_root";
					}
					if(funHead.value.PreloadParentFlag){
						registerId++;
						//PreloadValueArr[PreloadValueArr.length]="r:"+registerId+"='_parent'";
						registerArr[registerId]="_parent";
					}
					i=0;
					for each(var Parameter:Object in funHead.value.Parameters){
						registerArr[Parameter.Register]="arg:"+i;
						i++;
					}
				break;
				default:
					throw new Error("不合法的 funHead");
				break;
			}
			//trace("Fun codeArr="+codeArr);
			
			__prototype=new Object();
		}
		public function run(codesRunner:CodesRunner,thisObj:*,argsArr:Array,globalVars:Object,vars:Object):*{
			if(baseFun){
				var registerId:int=registerArr.length;
				while(--registerId>=0){
					if(registerArr[registerId]=="super"){
						registerArr[registerId]="super";//- -
						break;
					}
				}
			}
			return codesRunner.runCodeArr(
				codeArr,
				thisObj,
				registerArr,
				argsArr,
				globalVars,
				vars
			)
		}
	}
}
		