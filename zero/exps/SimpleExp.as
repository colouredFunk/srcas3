﻿/***
SimpleExp 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年2月12日 20:12:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.exps{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class SimpleExp extends Exp{
		public static var speed_base:Number=30;	//速度基值
		public static var speed_ran:Number=30;	//速度随机附加值
		public static var speed_u:Number=0.8;		//减速系数，0~1，越小减速的越快
		public static var fade_speed:Number=10;	//速度小于此值时开始渐变透明消失
		public static var fade_u:Number=0.9;		//渐变透明消失的系数，0~1，越小消失的越快
		
		public static var dotNum:int=50;
		
		
		public function SimpleExp(...args){
			//一个简单的平面爆炸效果，粒子直线四散，速度小于一定值以后渐变透明消失。
			getDotV.apply(this,args);
		}
		override public function getValues(dot:DisplayObject,centerX:Number,centerY:Number):Object{
			var speedX:Number=dot.x-centerX;
			var speedY:Number=dot.y-centerY;
			var d2:Number=speedX*speedX+speedY*speedY;
			if(d2<0.01){
				speedX=Math.random()-0.5;
				speedY=Math.random()-0.5;
				d2=speedX*speedX+speedY*speedY;
			}
			var d:Number=Math.sqrt(d2);
			var speed:Number=speed_base+Math.random()*speed_ran;
			return {
				speedX:speedX*speed/d,
				speedY:speedY*speed/d
			}
		}
		override public function dotRun(dot:DisplayObject,values:Object):Boolean{
			if(dot.alpha<0.05){
				return false;
			}
			dot.x+=values.speedX;
			dot.y+=values.speedY;
			values.speedX*=speed_u;
			values.speedY*=speed_u;
			if(values.speedX*values.speedX+values.speedY*values.speedY<fade_speed*fade_speed){
				dot.alpha*=fade_u;
			}
			return true;
		}
	}
}

