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
		
		public function NumIncreaser(){
			
			if(txt){
				return;
			}
			
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
			
			if(
				this.loaderInfo.parameters.startTime//"2011-08-02 10:00:00";
				&&
				this.loaderInfo.parameters.endTime//"2011-08-09 12:00:00";
			){
				
				serverDate=new ServerDate();
				serverDate.init(initServerDateComplete);
			}
		}
		private function initServerDateComplete():void{
			
			startNum=int(this.loaderInfo.parameters.startNum);
			endNum=int(this.loaderInfo.parameters.endNum);
			
			if(int(this.loaderInfo.parameters.startNum)>0){
				startNum=int(this.loaderInfo.parameters.startNum);
			}else{
				startNum=0;
			}
			if(int(this.loaderInfo.parameters.endNum)>0){
				endNum=int(this.loaderInfo.parameters.endNum);
			}else{
				endNum=100000;
			}
			
			start(
				serverDate,
				this.loaderInfo.parameters.startTime,
				this.loaderInfo.parameters.endTime,
				startNum,
				endNum
			);
		}
		
		public function start(_serverDate:ServerDate,_startDate:*,_timeUpDate:*,_startNum:int=0,_endNum:int=100000):void{
			
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
			trace("k="+k);
			
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