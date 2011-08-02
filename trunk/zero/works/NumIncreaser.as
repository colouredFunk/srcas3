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
		
		public function NumIncreaser(){
			
			var ranArr:Array=[1,2,1,1,1,1,1,3,2,3,1,1,2,1,2,1,1,2,2,1,3,2,2,2,2,2,1,2,1,2,2,2,1,2,1,2,1,2,1,1,2,1,1,2,1,1,1,2,1,2,2,2,2,1,2,3,1,1,2,1,2,2,2,1,1,1,2,2,2,1,1,1,2,2,2,2,2,2,1,2,2,2,2,2,1,1,2,2,2,1,2,2,2,1,1,2,1,2,1,1];
			
			var xml:XML;
			try{
				xml=getDefinitionByName("zero.works.BaseLoadURLPoj").xml;
			}catch(e:Error){
				xml=null;
			}
			
			var startNum:int=int(this.loaderInfo.parameters.startNum);
			var startTimeStr:String=this.loaderInfo.parameters.startTime;
			var endTimeStr:String=this.loaderInfo.parameters.endTime;
			var k:Number=Number(this.loaderInfo.parameters.k);
			
			if(xml){
				var numIncreaserXML:XML=xml.numIncreaser[0];
				if(numIncreaserXML){
					if(startNum>0){
					}else{
						startNum=int(numIncreaserXML.@startNum.toString());
					}
					if(startTimeStr){
					}else{
						startTimeStr=numIncreaserXML.@startTime.toString();
					}
					if(endTimeStr){
					}else{
						endTimeStr=numIncreaserXML.@endTime.toString();
					}
					if(k>0){
					}else{
						k=Number(numIncreaserXML.@k.toString());
					}
				}
			}
			
			if(startNum>0){
			}else{
				startNum=0;
			}
			if(startTimeStr){
			}else{
				startTimeStr="2011-08-02 10:00:00";
			}
			if(endTimeStr){
			}else{
				endTimeStr="2011-08-09 12:00:00";
			}
			if(k>0){
			}else{
				k=0.2;
			}
			
			//trace("startTimeStr="+startTimeStr);
			//trace("endTimeStr="+endTimeStr);
			
			var startTime:int=getTimeByDateStr(startTimeStr);
			var endTime:int=getTimeByDateStr(endTimeStr);
			
			//trace("startTime="+startTime);
			//trace("endTime="+endTime);
			
			var currTime:int=new Date().time/1000;
			//trace("currTime="+currTime);
			
			if(currTime<startTime){
				currTime=startTime;
			}else if(currTime>endTime){
				currTime=endTime;
			}
			//trace("currTime="+currTime);
			
			var dTime:int=currTime-startTime;
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
			
			i=this.numChildren;
			while(--i>=0){
				var txt:TextField=this.getChildAt(i) as TextField;
				if(txt){
					
					//trace("totalPeople="+totalPeople);
					//trace("k="+k);
					//trace("totalPeople*k="+totalPeople*k);
					//trace("startNum="+startNum);
					
					txt.text=int(startNum+totalPeople*k).toString();
					return;
				}
			}
			throw new Error("找不到 txt");
		}
		private static function getTimeByDateStr(dateStr:String):int{
			var timeArr:Array=dateStr.replace(/^\s*|\s*$/g,"").split(/\D+/g);
			return new Date(int(timeArr[0]),int(timeArr[1])-1,int(timeArr[2]),int(timeArr[3]),int(timeArr[4]),int(timeArr[5])).time/1000;
		}
	}
}