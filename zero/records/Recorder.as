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
		
		public var dataArr:Array;//frame1,data0,data1,...datan,frame2,data0,data1,...datan,...
		
		private var frame:int;
		private var recordTempSubDataArr:Array;
		private var playOffset:int;
		
		private var stage:Stage;
		
		private var mouseIsDown:Boolean;
		private var mouseIsUp:Boolean;
		
		private var onMouseDown:Function;
		private var onMouseUp:Function;
		private var onStep:Function;
		
		public var getInt:Function;
		
		private var onPlayComplete:Function;
		
		public function Recorder(){
		}
		public function stop():void{
			if(stage){
				stage.removeEventListener(Event.ENTER_FRAME,record_step);
				stage.removeEventListener(Event.ENTER_FRAME,play_step);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
				stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
				stage=null;
			}
			//recordTempSubDataArr=null;//不能置空，否则最后一个 step 可能会丢失数据
			onMouseDown=null;
			onMouseUp=null;
			onStep=null;
			getInt=null;
			onPlayComplete=null;
		}
		public function record(_stage:Stage,params:Object):void{
			stop();
			
			dataArr=new Array();
			
			stage=_stage;
			
			onMouseDown=params.mouseDown;
			onMouseUp=params.mouseUp;
			onStep=params.step;
			getInt=record_getInt;
			
			if(onMouseDown==null){
			}else{
				stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			}
			if(onMouseUp==null){
			}else{
				stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			}
			
			frame=0;
			stage.addEventListener(Event.ENTER_FRAME,record_step);//一帧之后才开始第一个 record_step()
			//record_step();
			
			recordTempSubDataArr=new Array();//用于记录 record() 和 第一个 record_step() 之间的数据
		}
		public function play(_stage:Stage,_onPlayComplete:Function,params:Object,_dataArr:Array=null):void{
			stop();
			
			if(_dataArr){
				dataArr=_dataArr;
			}
			
			//trace("dataArr="+dataArr);
			if(dataArr){
				stage=_stage;
				
				onMouseDown=params.mouseDown;
				onMouseUp=params.mouseUp;
				onStep=params.step;
				getInt=play_getInt;
				onPlayComplete=_onPlayComplete;
				
				frame=0;
				playOffset=0;
				stage.addEventListener(Event.ENTER_FRAME,play_step);//一帧之后才开始第一个 play_step()
				//play_step();
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
		
		private function record_step(...args):void{
			
			if(frame==0){
				if(recordTempSubDataArr.length){
					dataArr.push.apply(dataArr,recordTempSubDataArr);//record() 和 第一个 record_step() 之间的数据
				}
			}
			
			frame++;
			
			var subDataArr:Array=new Array();
			
			if(mouseIsDown){
				mouseIsDown=false;
				if(onMouseDown==null){
				}else{
					recordTempSubDataArr=new Array();
					if(onMouseDown()){
						subDataArr.push("d");
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
						subDataArr.push("u");
						subDataArr.push.apply(subDataArr,recordTempSubDataArr);
					}
				}
			}
			
			if(onStep==null){
			}else{
				recordTempSubDataArr=new Array();
				onStep();
				subDataArr.push.apply(subDataArr,recordTempSubDataArr);
			}
			
			recordTempSubDataArr=null;
			
			if(subDataArr.length){
				//trace("记录 frame="+frame,"subDataArr="+subDataArr);
				dataArr.push(frame);
				dataArr.push.apply(dataArr,subDataArr);
			}
		}
		private function play_step(...args):void{
			
			frame++;
			
			//trace("frame="+frame);
			
			if(playOffset>=dataArr.length){
				var _onPlayComplete:Function=onPlayComplete;
				stop();
				if(_onPlayComplete==null){
				}else{
					_onPlayComplete();
				}
				return;
			}
			
			//trace("check frame，dataArr[playOffset]="+dataArr[playOffset]);
			if(dataArr[playOffset]==frame){
				playOffset++;
			}else{
				return;
			}
			
			//trace("check d，dataArr[playOffset]="+dataArr[playOffset]);
			if(dataArr[playOffset]=="d"){
				playOffset++;
				//if(onMouseDown==null){
				//}else{
					onMouseDown();
				//}
			}
			
			//trace("check u，dataArr[playOffset]="+dataArr[playOffset]);
			if(dataArr[playOffset]=="u"){
				playOffset++;
				if(onMouseUp==null){
				}else{
					onMouseUp();
				}
			}
			
			//trace("check onStep，dataArr[playOffset]="+dataArr[playOffset]);
			if(onStep==null){
			}else{
				onStep();
			}
			
			//trace("回放 frame="+frame);
		}
		
		//record_getInt 和 play_getInt 仅发生在 onStep，onMouseDown，onMouseUp 里
		public function record_getInt(_int:int):int{
			recordTempSubDataArr.push(_int);
			return _int;
		}
		public function play_getInt(_int:int):int{
			//trace("playOffset="+playOffset,dataArr[playOffset]);
			return dataArr[playOffset++];
		}
	}
}