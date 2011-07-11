/***
Exp 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月24日 10:41:48
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.exps{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Exp extends Sprite{
		public var valuesV:Vector.<Object>;
		public var dotV:Vector.<DisplayObject>;
		private var dotContainer:DisplayObjectContainer;
		
		public function Exp(){
			//默认情况下，会加这些东西：
			this.mouseEnabled=this.mouseChildren=false;
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			//
		}
		
		private function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			var i:int=dotV.length;
			while(--i>=0){
				var dot:DisplayObject=dotV[i];
				if(dotRun(dot,valuesV[i])){
				}else{
					if(dot.parent){
						dot.parent.removeChild(dot);
					}
					dotV.splice(i,1);
					valuesV.splice(i,1);
					if(dotV.length){
					}else{
						removed(null);
						if(dotContainer){
							if(dotContainer.parent){
								dotContainer.parent.removeChild(dotContainer);
							}
						}
						return;
					}
				}
			}
			//trace("dotV="+dotV);
		}
		public function getValues(dot:DisplayObject,centerX:Number,centerY:Number):Object{
			trace("初始化时获取一些值，请 override 来使用");
			return null;
		}
		public function dotRun(dot:DisplayObject,values:Object):Boolean{
			trace("每隔一帧对每个 dot 调用一次，返回 true 表示继续，返回 false 表示此 dot 要删除，请 override 来使用");
			return true;
		}
		
		private function _getDotV(
			dotV:Vector.<DisplayObject>,
			classV:Vector.<Class>,
			dotContainerInitValues:Object,
			args:*
		):Boolean{
			var hasDisplayObject:Boolean;
			for each(var arg:* in args){
				if(arg is DisplayObject){
					hasDisplayObject=true;
					dotV.push(arg);
				}else if(arg is Class){
					classV.push(arg);
				}else if(arg is String){
					var clazz:Class=null;
					
					try{
						clazz=getDefinitionByName(arg) as Class;
					}catch(e:Error){}
					
					if(clazz){
						classV.push(clazz);
					}else{
						var classId:int=0;
						while(true){
							try{
								clazz=getDefinitionByName(arg+classId) as Class;
							}catch(e:Error){
								break;
							}
							classV.push(clazz);
							classId++;
						}
					}
				}else if(arg.constructor==Object){
					//参数
					for(var valueName:String in arg){
						dotContainerInitValues[valueName]=arg[valueName];
					}
				}else{
					//数组或 Vector
					if(_getDotV(dotV,classV,dotContainerInitValues,arg)){
						hasDisplayObject=true;
					}
				}
			}
			return hasDisplayObject;
		}
		public function getDotV(...args):void{
			var dot:DisplayObject;
			
			dotContainer=null;
			var dotContainerInitValues:Object=new Object();
			
			dotV=new Vector.<DisplayObject>();
			var classV:Vector.<Class>=new Vector.<Class>();
			if(args.length){
				if(_getDotV(dotV,classV,dotContainerInitValues,args)){
					if(classV.length){
						for each(var clazz:Class in classV){
							dotV.push(new clazz());
						}
					}else{
						if(dotV.length==1){
							//应该是作为粒子容器传入的
							dotContainer=dotV[0] as DisplayObjectContainer;
							dotV=new Vector.<DisplayObject>();
						}
					}
				}
			}
			
			if(dotContainer){
			}else{
				var dotHasParent:Boolean=false;
				for each(dot in dotV){
					if(dot.parent){
						dotHasParent=true;
						break;
					}
				}
				if(dotHasParent){
				}else{
					dotContainer=this;
				}
			}
			
			for(var valueName:String in dotContainerInitValues){
				switch(valueName){
					case "x":
						if(dotContainer){
							dotContainer.x=dotContainerInitValues.x;
						}
					break;
					case "y":
						if(dotContainer){
							dotContainer.y=dotContainerInitValues.y;
						}
					break;
					case "dotNum":
						dotNum=dotContainerInitValues.dotNum;
					break;
					default:
						trace("未知参数 "+valueName+" : "+dotContainerInitValues[valueName]);
					break;
				}
			}
			
			if(classV.length){
				if(dotNum>0){
				}else{
					var thisClass:Class=this["constructor"];
					while(thisClass){
						if(thisClass["dotNum"]>0){
							break;
						}
						if(thisClass==Sprite){
							break;
						}
						thisClass=getDefinitionByName(
							getQualifiedSuperclassName(
								thisClass
							)
						) as Class;
					}
					dotNum=thisClass["dotNum"];
					if(dotNum){
					}else{
						dotNum=30;
					}
				}
				while(--dotNum>=0){
					dotV.push(new classV[int(Math.random()*classV.length)]());
				}
			}
			
			if(dotContainer){
				//把 dotContainer 里面的也算进来
				for(var i:int=0;i<dotContainer.numChildren;i++){
					dotV.push(dotContainer.getChildAt(i));
				}
				//
				
				for each(dot in dotV){
					if(dot.parent==dotContainer){
					}else{
						dotContainer.addChild(dot);
					}
				}
			}
			
			valuesV=new Vector.<Object>();
			if(dotContainer){
				for each(dot in dotV){
					valuesV.push(getValues(dot,0,0));
				}
			}else{
				var centerX:Number=0;
				var centerY:Number=0;
				for each(dot in dotV){
					centerX+=dot.x;
					centerY+=dot.y;
				}
				
				centerX/=dotV.length;
				centerY/=dotV.length;
				
				for each(dot in dotV){
					valuesV.push(getValues(dot,centerX,centerY));
				}
			}
			
			var dotNum:int;
			
			
			
			//trace("dotV="+dotV);
		}
	}
}

