/***
Recorder
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年3月1日 15:49:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.records{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class Recorder{
		
		private static const MARK_MOUSE_DOWN:String="m";
		private static const MARK_MOUSE_UP:String="M";
		private static const MARK_KEY_DOWN:String="k";
		private static const MARK_KEY_UP:String="K";
		private static const MARK_DEACTIVATE:String="d";
		//private static const MARK_END:String="e";
		
		//private static const STATUS_STOP:int=0;
		//private static const STATUS_RECORDING:int=1;
		//private static const STATUS_PLAYING:int=2;
		//private var status:int;
		
		public var dataArr:Array;//frame1,data0,data1,...datan,frame2,data0,data1,...datan,...
		
		private var frame:int;
		private var recordTempSubDataArr:Array;
		private var replayOffset:int;
		
		private var __stage:Stage;
		
		private var mouseIsDown:Boolean;
		private var mouseIsUp:Boolean;
		private var isDeactivate:Boolean;
		
		private var onMouseDown:Function;
		private var onMouseUp:Function;
		private var onKeyDown:Function;
		private var onKeyUp:Function;
		private var onStep:Function;
		
		public var getInt:Function;
		
		private var onPlayComplete:Function;
		
		private var oldKeyArr:Array;
		private var keyArr:Array;
		
		public function Recorder(){
			halt();
		}
		public function halt():void{
			if(__stage){
				__stage.removeEventListener(Event.ENTER_FRAME,record_step);
				__stage.removeEventListener(Event.ENTER_FRAME,replay_step);
				__stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				__stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
				__stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
				__stage.removeEventListener(KeyboardEvent.KEY_UP,keyUp);
				__stage.removeEventListener(Event.DEACTIVATE,deactivate);
				__stage=null;
			}
			//recordTempSubDataArr=null;//不能置空，否则最后一个 step 可能会丢失数据
			onMouseDown=null;
			onMouseUp=null;
			onKeyDown=null;
			onKeyUp=null;
			//oldKeyArr=null;//不能置空，否则最后一个 step 可能会报错
			//keyArr=null;//不能置空，否则最后一个 step 可能会报错
			onStep=null;
			getInt=null;
			onPlayComplete=null;
			//status=STATUS_STOP;
		}
		public function record(_stage:Stage,params:Object):void{
			halt();
			
			dataArr=new Array();
			//status=STATUS_RECORDING;
			
			__stage=_stage;
			
			onMouseDown=params.mouseDown;
			onMouseUp=params.mouseUp;
			onKeyDown=params.keyDown;
			onKeyUp=params.keyUp;
			onStep=params.step;
			getInt=record_getInt;
			
			if(onMouseDown==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			if(onMouseUp==null){
			}else{
				__stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			}
			
			__stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			__stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			__stage.addEventListener(Event.DEACTIVATE,deactivate);
			resetKeyArr();
			
			frame=0;
			__stage.addEventListener(Event.ENTER_FRAME,record_step);//一帧之后才开始第一个 record_step()
			//record_step();
			
			recordTempSubDataArr=new Array();//用于记录 record() 和 第一个 record_step() 之间的数据
		}
		private function resetKeyArr():void{
			keyArr=new Array(256);
			for(var keyCode:int=0;keyCode<256;keyCode++){
				keyArr[keyCode]=false;
			}
			oldKeyArr=keyArr.slice();
		}
		public function replay(_stage:Stage,_onPlayComplete:Function,params:Object,_dataArr:Array=null):void{
			halt();
			
			if(_dataArr){
				dataArr=_dataArr;
			}
			
			//trace("dataArr="+dataArr);
			if(dataArr){
				//status=STATUS_PLAYING;
				
				__stage=_stage;
				
				onMouseDown=params.mouseDown;
				onMouseUp=params.mouseUp;
				onKeyDown=params.keyDown;
				onKeyUp=params.keyUp;
				onStep=params.step;
				getInt=replay_getInt;
				onPlayComplete=_onPlayComplete;
				resetKeyArr();
				
				frame=0;
				replayOffset=0;
				__stage.addEventListener(Event.ENTER_FRAME,replay_step);//一帧之后才开始第一个 replay_step()
				//replay_step();
			}else{
				throw new Error("dataArr="+dataArr);
			}
		}
		
		private function mouseDown(...args):void{
			mouseIsDown=true;
		}
		private function mouseUp(...args):void{
			mouseIsUp=true;
		}
		private function deactivate(...args):void{
			isDeactivate=true;
		}
		private function keyDown(event:KeyboardEvent):void{
			keyArr[event.keyCode]=true;
		}
		private function keyUp(event:KeyboardEvent):void{
			keyArr[event.keyCode]=false;
		}
		public function keyIsDown(keyCode:int):Boolean{
			return keyArr[keyCode];
		}
		
		private function record_step(...args):void{
			
			if(frame==0){
				if(recordTempSubDataArr.length){
					dataArr.push.apply(dataArr,recordTempSubDataArr);//record() 和 第一个 record_step() 之间的数据
				}
			}
			
			frame++;
			
			var subDataArr:Array=new Array();
			
			if(isDeactivate){
				isDeactivate=false;
				subDataArr.push(MARK_DEACTIVATE);
				resetKeyArr();
			}
			
			if(mouseIsDown){
				mouseIsDown=false;
				if(onMouseDown==null){
				}else{
					recordTempSubDataArr=new Array();
					if(onMouseDown()){
						subDataArr.push(MARK_MOUSE_DOWN);
						subDataArr.push.apply(subDataArr,recordTempSubDataArr);
					}
				}
			}
			
			if(mouseIsUp){
				mouseIsUp=false;
				if(onMouseUp==null){
				}else{
					recordTempSubDataArr=new Array();
					if(onMouseUp()){
						subDataArr.push(MARK_MOUSE_UP);
						subDataArr.push.apply(subDataArr,recordTempSubDataArr);
					}
				}
			}
			
			var keyCode:int;
			for(keyCode=0;keyCode<256;keyCode++){
				if(!oldKeyArr[keyCode]&&keyArr[keyCode]){
					subDataArr.push(MARK_KEY_DOWN,keyCode);
					if(onKeyDown==null){
					}else{
						recordTempSubDataArr=new Array();
						onKeyDown(keyCode);
						subDataArr.push.apply(subDataArr,recordTempSubDataArr);
					}
				}
			}
			for(keyCode=0;keyCode<256;keyCode++){
				if(oldKeyArr[keyCode]&&!keyArr[keyCode]){
					subDataArr.push(MARK_KEY_UP,keyCode);
					if(onKeyUp==null){
					}else{
						recordTempSubDataArr=new Array();
						onKeyUp(keyCode);
						subDataArr.push.apply(subDataArr,recordTempSubDataArr);
					}
				}
			}
			
			if(subDataArr.length){
				dataArr.push(frame);
				dataArr.push.apply(dataArr,subDataArr);
			}
			
			if(onStep==null){
			}else{
				recordTempSubDataArr=new Array();
				onStep();
				dataArr.push.apply(dataArr,recordTempSubDataArr);
			}
			
			recordTempSubDataArr=null;
			
			//if(status==STATUS_STOP){
			//	dataArr.push(MARK_END);
			//}
			
			oldKeyArr=keyArr.slice();
		}
		private function replay_step(...args):void{
			
			frame++;
			
			//var isEnd:Boolean=false;
			
			if(dataArr[replayOffset+1] is String){//MARK
				if(dataArr[replayOffset]==frame){
					replayOffset++;
					
					var keyCode:int;
					
					while(dataArr[replayOffset] is String){
						replayOffset++;
						switch(dataArr[replayOffset-1]){
							case MARK_DEACTIVATE:
								resetKeyArr();
							break;
							case MARK_MOUSE_DOWN:
								//if(onMouseDown==null){
								//}else{
									onMouseDown();
								//}
							break;
							case MARK_MOUSE_UP:
								//if(onMouseUp==null){
								//}else{
									onMouseUp();
								//}
							break;
							case MARK_KEY_DOWN:
								keyCode=dataArr[replayOffset++];
								keyArr[keyCode]=true;
								if(onKeyDown==null){
								}else{
									onKeyDown(keyCode);
								}
							break;
							case MARK_KEY_UP:
								keyCode=dataArr[replayOffset++];
								keyArr[keyCode]=false;
								if(onKeyUp==null){
								}else{
									onKeyUp(keyCode);
								}
							break;
							//case MARK_END:
							//	isEnd=true;
							//break;
						}
					}
				}
			}
			
			if(onStep==null){
			}else{
				onStep();
			}
			
			/*
			if(isEnd||replayOffset>=dataArr.length){
				trace("isEnd="+isEnd);
				var _onPlayComplete:Function=onPlayComplete;
				stop();
				if(_onPlayComplete==null){
				}else{
					_onPlayComplete();
				}
			}
			*/
		}
		
		//record_getInt 和 replay_getInt 仅发生在 onStep，onMouseDown，onMouseUp 里
		public function record_getInt(_int:int):int{
			recordTempSubDataArr.push(_int);
			return _int;
		}
		public function replay_getInt(_int:int):int{
			//trace("replayOffset="+replayOffset,dataArr[replayOffset]);
			return dataArr[replayOffset++];
		}
	}
}