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
		
		private static function getDateByDateStr(dateStr:String):Date{
			var timeArr:Array=dateStr.replace(/^\s*|\s*$/g,"").split(/\D+/g);
			return new Date(int(timeArr[0]),int(timeArr[1])-1,int(timeArr[2]),int(timeArr[3]),int(timeArr[4]),int(timeArr[5]));
		}
		
		private var serverDate:ServerDate;
		private var startDate:Date;
		private var timeUpDate:Date;
		public var startNum:int;
		public var k:Number;
		
		public var txt:*;
		
		public function NumIncreaser(){
			
			startNum=0;
			k=0.2;
			
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
			
			startNum=int(this.loaderInfo.parameters.startNum)||startNum;
			k=Number(this.loaderInfo.parameters.k)||k;
			
			if(startNum>0){
			}else{
				startNum=0;
			}
			if(k>0){
			}else{
				k=0.2;
			}
			
			start(
				serverDate,
				getDateByDateStr(this.loaderInfo.parameters.startTime),
				getDateByDateStr(this.loaderInfo.parameters.endTime)
			);
		}
		
		public function start(_serverDate:ServerDate,_startDate:Date,_timeUpDate:Date):void{
			serverDate=_serverDate;
			startDate=_startDate;
			timeUpDate=_timeUpDate;
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
			
			var i:int;
			
			var arrSum:int=0;
			for(i=0;i<100;i++){
				arrSum+=ranArr[i];
			}
			var dateSum:int=arrSum*864;
			var totalPeople:int=int(dTime/86400)*dateSum;
			dTime=dTime%86400;
			totalPeople+=int(dTime/100)*arrSum;
			dTime=dTime%100;
			for(i=0;i<dTime;i++){
				totalPeople+=ranArr[i];
			}
			
			if(txt is TextField){
				txt.text=int(startNum+totalPeople*k);
			}else{
				txt.value=int(startNum+totalPeople*k);
			}
		}
	}
}