/***
NumIncreaser
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年8月2日 09:48:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class NumIncreaser extends Sprite{
		private static const ranArr:Array=[1,2,1,1,1,1,1,3,2,3,1,1,2,1,2,1,1,2,2,1,3,2,2,2,2,2,1,2,1,2,2,2,1,2,1,2,1,2,1,1,2,1,1,2,1,1,1,2,1,2,2,2,2,1,2,3,1,1,2,1,2,2,2,1,1,1,2,2,2,1,1,1,2,2,2,2,2,2,1,2,2,2,2,2,1,1,2,2,2,1,2,2,2,1,1,2,1,2,1,1];
		
		private var serverDate:ServerDate;
		private var startDate:Date;
		private var timeUpDate:Date;
		private var startNum:int;
		private var endNum:int;
		
		private var arrSum:int;
		private var dateSum:int;
		private var k:Number;
		
		public var txt:*;
		
		[Inspectable(name="起始时间",defaultValue="2011-10-17 16:15:00")]
		public var set_startTime:String="2011-10-17 16:15:00";
		
		[Inspectable(name="终结时间",defaultValue="2012-12-21 15:14:35")]
		public var set_endTime:String="2012-12-21 15:14:35";
		
		[Inspectable(name="起始人数",defaultValue=0)]
		public var set_startNum:int=0;
		
		[Inspectable(name="终结人数",defaultValue=1000000)]
		public var set_endNum:int=1000000;
		
		private var delayTime:int;
		public function NumIncreaser(){
			var i:int;
			var _txt:*;
			
			i=this.numChildren;
			while(--i>=0){
				_txt=this.getChildAt(i);
				if(
					_txt is TextField
					||
					getQualifiedClassName(_txt).indexOf("TxtEffects")>-1
				){
					txt=_txt;
					break;;
				}
			}
			
			if(txt){
			}else{
				throw new Error("找不到 txt");
			}
			
			txt.text="";
			
			delayTime=5;
			this.addEventListener(Event.ENTER_FRAME,initDelay);
		}
		private function initDelay(event:Event):void{
			if(--delayTime<=0){
			}else{
				return;
			}
			
			this.removeEventListener(Event.ENTER_FRAME,initDelay);
			
			set_startTime=this.loaderInfo.parameters.startTime||set_startTime;
			set_endTime=this.loaderInfo.parameters.endTime||set_endTime;set_endNum
			if(int(this.loaderInfo.parameters.startNum)>0){
				set_startNum=int(this.loaderInfo.parameters.startNum);
			}
			if(int(this.loaderInfo.parameters.set_endNum)>0){
				set_endNum=int(this.loaderInfo.parameters.set_endNum);
			}
			
			serverDate=new ServerDate();
			serverDate.init(initServerDateComplete);
		}
		private function initServerDateComplete():void{
			start(
				serverDate,
				set_startTime,
				set_endTime,
				set_startNum,
				set_endNum
			);
		}
		
		public function start(_serverDate:ServerDate,_startDate:*,_timeUpDate:*,_startNum:int=0,_endNum:int=100000):void{
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			
			if(_startDate is Date){
			}else{
				_startDate=getDateByDateStr(_startDate);
			}
			if(_timeUpDate is Date){
			}else{
				_timeUpDate=getDateByDateStr(_timeUpDate);
			}
			startDate=_startDate;
			timeUpDate=_timeUpDate;
			
			var i:int;
			
			arrSum=0;
			for(i=0;i<100;i++){
				arrSum+=ranArr[i];
			}
			dateSum=arrSum*864;
			
			startNum=_startNum;
			endNum=_endNum;
			k=(endNum-startNum)/getNum((timeUpDate.time-startDate.time)/1000);
			//trace("k="+k);
			
			if(_serverDate){
				serverDate=_serverDate;
				selfInitServerDateComplete();
			}else{
				serverDate=new ServerDate();
				serverDate.init(selfInitServerDateComplete);
			}
			
		}
		private function selfInitServerDateComplete():void{
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
		}
		private function enterFrame(event:Event):void{
			
			var currTime:int=serverDate.getDate().time/1000;
			
			if(currTime<startDate.time/1000){
				currTime=startDate.time/1000;
			}else if(currTime>timeUpDate.time/1000){
				currTime=timeUpDate.time/1000;
			}
			
			var dTime:int=currTime-startDate.time/1000;
			if(dTime>0){
			}else{
				dTime=0;
			}
			
			if(txt is TextField){
				txt.text=int(startNum+getNum(dTime)*k);
			}else{
				txt.value=int(startNum+getNum(dTime)*k);
			}
		}
		private function getNum(dTime:int):int{
			var num:int=int(dTime/86400)*dateSum;
			dTime=dTime%86400;
			num+=int(dTime/100)*arrSum;
			dTime=dTime%100;
			for(var i:int=0;i<dTime;i++){
				num+=ranArr[i];
			}
			return num;
		}
	}
}