/***
SWFRunner
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月11日 13:36:02
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm1.runners{
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import zero.swf.*;

	public class SWFRunner{
		private var swf:SWF;
		private var frameV:Vector.<Frame>;
		private var isStop:Boolean;
		private var hasMoveFrame:Boolean;//是否改变了播放头位置
		private var isImmediately:Boolean;
		private var intervalId:int;
		
		private var globalVars:Object;
		private var codesRunner:CodesRunner;
		private var thisObj:*;
		
		public function SWFRunner(swfData:ByteArray,_thisObj:*=null):void{
			//支持简单的帧动作，类
			
			swf=new SWF();
			swf.initBySWFData(swfData,null);
			
			frameV=new Vector.<Frame>();
			frameV[0]=null;
			var frameTagV:Vector.<Tag>=new Vector.<Tag>();
			var currentFrame:int=0;
			for each(var tag:Tag in swf.tagV){
				frameTagV.push(tag);
				switch(tag.type){
					case TagType.ShowFrame:
						currentFrame++;
						frameV[currentFrame]=new Frame(currentFrame,frameTagV);
						frameTagV=new Vector.<Tag>();
					break;
				}
			}
			
			if(_thisObj){
				thisObj=_thisObj;
				trace("用户自定义 thisObj："+thisObj+"，播放头操作将指向 "+thisObj);
			}else{
				thisObj=new ThisObj();
				thisObj.gotoAndPlay=gotoAndPlay;
				thisObj.gotoAndStop=gotoAndStop;
				thisObj.nextFrame=nextFrame;
				thisObj.play=play;
				thisObj.prevFrame=prevFrame;
				thisObj.stop=stop;
			}
		}
		public function run():void{
			
			clearInterval(intervalId);
			isStop=false;
			hasMoveFrame=false;
			isImmediately=false;
			
			globalVars=new Object();
			globalVars["_global"]=new Object();
			globalVars["ASSetPropFlags"]=trace;
			
			codesRunner=new CodesRunner();
			
			thisObj.__currentFrame=1;
			thisObj.__totalFrames=swf.FrameCount;
			
			if(swf.FrameCount>1){
				intervalId=setInterval(showFrame,Math.round(1000/swf.FrameRate));
			}
			
			runFrameActions();
		}
		public function clear():void{
			 clearInterval(intervalId);
			 swf=null;
			 frameV=null;
			 globalVars=null;
			 codesRunner=null;
			 thisObj=null;
		}
		
		private function showFrame():void{
			if(isStop){
				return;
			}
			runFrameActions();
		}
		
		private function markClazzFuns(obj:Object):Object{
			var _mark:Object=new Object();
			for(var name:String in obj){
				_mark[name]=markClazzFuns(obj[name]);
			}
			return _mark;
		}
		private function setNewClazzFunNames(obj:Object,_mark:Object,packageNameArr:Array):void{
			for(var name:String in obj){
				if(_mark[name]){
				}else{
					if(obj[name] is Fun){
						(obj[name] as Fun).className=(packageNameArr.length?packageNameArr.join(".")+".":"")+name;
					}else{
						packageNameArr.push(name);
						setNewClazzFunNames(obj[name],new Object(),packageNameArr);
						packageNameArr.pop();
					}
				}
			}
		}
		
		private function runFrameActions():void{
			
			//trace("showFrame："+thisObj.__currentFrame);
			hasMoveFrame=false;
			isImmediately=false;
			var oldCurrentFrame:int=thisObj.__currentFrame;
			var frame:Frame=frameV[thisObj.__currentFrame];
			if(frame.classCodes){
				var className:String;
				
				for each(className in frame.classNameV){
					
					trace("className="+className);
					
					var classNameMark:Object=markClazzFuns(globalVars["_global"]);//记录已有的 Clazz Fun
					
					codesRunner.runCodeArr(
						frame.classCodes["~"+className],
						thisObj,
						null,
						null,
						globalVars,
						globalVars
					);
					
					setNewClazzFunNames(globalVars["_global"],classNameMark,[]);
				}
				
				//只运行一次
				frame.classNameV=null;
				frame.classCodes=null;
			}
			if(frame.doActionCodeArrV){
				for each(var doActionCodeArr:Array in frame.doActionCodeArrV){
					codesRunner.runCodeArr(
						doActionCodeArr,
						thisObj,
						null,
						null,
						globalVars,
						globalVars
					);
				}
			}
			
			//trace("hasMoveFrame="+hasMoveFrame);
			if(hasMoveFrame){
				//trace("oldCurrentFrame="+oldCurrentFrame);
				//trace("thisObj.__currentFrame="+thisObj.__currentFrame);
				//trace("isImmediately="+isImmediately);
				if(oldCurrentFrame==thisObj.__currentFrame){
				}else if(isImmediately){//- -
					runFrameActions();
				}
			}else if(isStop){
			}else{
				thisObj.__currentFrame++;//播放头自然播放到下一帧
				if(thisObj.__currentFrame>=frameV.length){
					if(isStop){
						thisObj.__currentFrame=frameV.length-1
					}else{
						thisObj.__currentFrame=1;
					}
				}
			}
		}
		
		////
		public function gotoAndPlay(frame:*, scene:String = null):void{
			if(scene){
				throw new Error("gotoAndPlay 暂不支持 frame："+frame+"，scene="+scene);
			}
			if(frame is int){
				if(frame>0&&frame<=thisObj.__totalFrames){
					thisObj.__currentFrame=frame;
				}
			}else{
				throw new Error("gotoAndPlay 暂不支持 frame："+frame+"，scene="+scene);
			}
			isStop=false;
			//trace("gotoAndPlay isImmediately="+isImmediately);
		}
		
		//gotoAndStop(frame:Object, scene:String = null):void 
		//将播放头移到影片剪辑的指定帧并停在那里。
		public function gotoAndStop(frame:*, scene:String = null):void{
			if(scene){
				throw new Error("gotoAndPlay 暂不支持 frame："+frame+"，scene="+scene);
			}
			if(frame is int){
				if(frame>0&&frame<=thisObj.__totalFrames){
					thisObj.__currentFrame=frame;
				}
			}else{
				throw new Error("gotoAndPlay 暂不支持 frame："+frame+"，scene="+scene);
			}
			isStop=true;
			hasMoveFrame=true;
			isImmediately=true;
			//trace("gotoAndStop isImmediately="+isImmediately);
		}
		
		//nextFrame():void 
		//将播放头转到下一帧并停止。
		public function nextFrame():void{
			if(++thisObj.__currentFrame>thisObj.__totalFrames){
				thisObj.__currentFrame=thisObj.__totalFrames;
			}
			isStop=true;
			hasMoveFrame=true;
			isImmediately=true;
			//trace("nextFrame isImmediately="+isImmediately);
		}
		
		//nextScene():void 
		//将播放头移动到 MovieClip 实例的下一场景。
		//play():void 
		//在影片剪辑的时间轴中移动播放头。
		public function play():void{
			isStop=false;
		}
		
		//prevFrame():void 
		//将播放头转到前一帧并停止。
		public function prevFrame():void{
			if(--thisObj.__currentFrame<1){
				thisObj.__currentFrame=1;
			}
			isStop=true;
			hasMoveFrame=true;
			isImmediately=true;
			//trace("prevFrame isImmediately="+isImmediately);
		}
		
		//prevScene():void 
		//将播放头移动到 MovieClip 实例的前一场景。
		
		//stop():void 
		//停止影片剪辑中的播放头。
		public function stop():void{
			isStop=true;
		}
	}
}

import flash.utils.ByteArray;

import zero.swf.*;
import zero.swf.avm1.*;
import zero.swf.avm1.runners.*;
import zero.swf.funs.*;
import zero.swf.tagBodys.*;

class ThisObj{
	//模拟 MovieClip
	
	//currentFrame : int 
	//[read-only] 指定播放头在 MovieClip 实例的时间轴中所处的帧的编号。
	public var __currentFrame:int;
	public function get currentFrame():int{
		return __currentFrame;
	}
	public function get _currentframe():int{
		return __currentFrame;
	}
	
	//currentLabel : String 
	//[read-only] 在 MovieClip 实例的时间轴中播放头所在的当前标签。 
	//currentLabels : Array 
	//[read-only] 返回由当前场景的 FrameLabel 对象组成的数组。 
	//currentScene : Scene 
	//[read-only] 在 MovieClip 实例的时间轴中播放头所在的当前场景。
	//enabled : Boolean 
	//一个布尔值，指示影片剪辑是否处于活动状态。
	//framesLoaded : int 
	//[read-only] 从流式 SWF 文件加载的帧数。
	//scenes : Array 
	//[read-only] 一个由 Scene 对象组成的数组，每个对象都列出了 MovieClip 实例中场景的名称、帧数和帧标签。
	
	//totalFrames : int 
	//[read-only] MovieClip 实例中帧的总数。
	
	public var __totalFrames:int;
	public function get totalFrames():int{
		return __totalFrames;
	}
	public function get _totalframes():int{
		return __totalFrames;
	}
	
	//trackAsMenu : Boolean 
	//指示属于 SimpleButton 或 MovieClip 对象的其它显示对象是否可以接收鼠标释放事件。
	
	//gotoAndPlay(frame:Object, scene:String = null):void 
	//从指定帧开始播放 SWF 文件。
	public var gotoAndPlay:Function;
	
	//gotoAndStop(frame:Object, scene:String = null):void 
	//将播放头移到影片剪辑的指定帧并停在那里。
	public var gotoAndStop:Function;
	
	//nextFrame():void 
	//将播放头转到下一帧并停止。
	public var nextFrame:Function;
	
	//nextScene():void 
	//将播放头移动到 MovieClip 实例的下一场景。
	//play():void 
	//在影片剪辑的时间轴中移动播放头。
	public var play:Function;
	
	//prevFrame():void 
	//将播放头转到前一帧并停止。
	public var prevFrame:Function;
	
	//prevScene():void 
	//将播放头移动到 MovieClip 实例的前一场景。
	
	//stop():void 
	//停止影片剪辑中的播放头。
	public var stop:Function;
	
	public function ThisObj(){
	}
}

class Frame{
	
	private var currentFrame:int;
	public var tagV:Vector.<Tag>;
	
	public var classNameV:Vector.<String>;
	public var classCodes:Object;
	public var doActionCodeArrV:Vector.<Array>;
	
	public function Frame(_currentFrame:int,_tagV:Vector.<Tag>):void{
		
		currentFrame=_currentFrame;
		tagV=_tagV;
		
		doActionCodeArrV=new Vector.<Array>();
		
		var classNameArr:Array=new Array();
		var doInitActionCodeArr:Array=new Array();
		
		var _initByDataOptions:Object/*zero_swf_InitByDataOptions*/=OptionsGetter.getInitByDataOptions({ActionsClass:ACTIONRECORD});
		
		var id:int,Name:String;
		var idV:Vector.<int>=new Vector.<int>();
		for each(var tag:Tag in tagV){
			switch(tag.type){
				case TagType.ExportAssets:
					var exportAssets:ExportAssets=tag.getBody(null) as ExportAssets;
					var i:int=0;
					for each(Name in exportAssets.NameV){
						id=exportAssets.TagV[i];
						idV.push(id);
						classNameArr[id]=Name;
						i++;
					}
				break;
				case TagType.DoAction:
					doActionCodeArrV.push(
						(
							(
								tag.getBody(_initByDataOptions) as DoAction
							).Actions as ACTIONRECORD
						).codeArr
					);
				break;
				case TagType.DoInitAction:
					var doInitAction:DoInitAction=tag.getBody(_initByDataOptions) as DoInitAction;
					doInitActionCodeArr[doInitAction.SpriteID]=(doInitAction.Actions as ACTIONRECORD).codeArr;
				break;
			}
		}
		
		if(doInitActionCodeArr.length){
			classNameV=new Vector.<String>();
			classCodes=new Object();
			for each(id in idV){
				Name=classNameArr[id];
				if(Name){
					classNameV.push(Name);
					classCodes["~"+Name]=doInitActionCodeArr[id];
				}
			}
		}
		
		if(doActionCodeArrV.length){
		}else{
			doActionCodeArrV=null;
		}
	}
}
