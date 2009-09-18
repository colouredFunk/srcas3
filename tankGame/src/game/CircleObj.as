/*
CircleObj 版本:v1.0
简要说明:
创建人:AKDCL
创建时间:2009年9月15日 09:13:19
历次修改:未有修改
用法举例:
*/

package game{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	public class CircleObj extends Sprite {
		protected var sideOff:Point;
		protected var speed:Point;
		protected var position:Point;
		protected var ptr:Point;
		protected var ptl:Point;
		protected var forceListAir:Dictionary;
		protected var forceListGround:Dictionary;
		public var mass:Number=1;
		public var ground:*;
		public var userData:*;
		public function CircleObj(_radius:uint=10) {
			radius=_radius;
			init();
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		protected function init():void{
			sideOff=new Point(0,radius);
			speed=new Point  ;
			position=new Point  ;
			ptr=new Point  ;
			ptl=new Point  ;
			forceListAir=new Dictionary(true);
			forceListGround=new Dictionary(true);
		}
		protected function added(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		protected function removed(event:Event):void {
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		public function addForceAir(_force:*):void{
			forceListAir[_force]=_force;
		}
		public function removeForceAir(_force:*):void{
			delete forceListAir[_force];
			_force=null;
		}
		public function addForceGround(_force:*):void{
			forceListGround[_force]=_force;
		}
		public function removeForceGround(_force:*):void{
			delete forceListGround[_force];
			_force=null;
		}
		public function addForceAll(_force:*):void{
			forceListAir[_force]=_force;
			forceListGround[_force]=_force;
		}
		public function removeForceAll(_force:*):void{
			delete forceListAir[_force];
			delete forceListGround[_force];
			_force=null;
		}
		public function run():void{
			var _e:*;
			if(isInAir){
				for each(_e in forceListAir){
					speed.x+=_e.x/mass;
					speed.y+=_e.y/mass;
				}
			}else{
				for each(_e in forceListGround){
					speed.x+=_e.x/mass;
					speed.y+=_e.y/mass;
				}
			}
			position.x+=speed.x;
			position.y+=speed.y;
			if(isInAir){
				inAir();
			}else{
				onGround();
			}
			if(onMove!=null){
				onMove();
			}
		}
		public function moveOnGround(_sp:Number):void{
			speed.x=_sp*Math.cos(radian);
			speed.y=_sp*Math.sin(radian);
		}
		public var onMove:Function;
		public var onFullBegin:Function;
		public var onFullEnd:Function;
		private var __radius:uint=15;
		public function get radius():uint {
			return __radius;
		}
		public function set radius(_radius:uint):void {
			__radius=_radius;
		}
		private var __radian:Number=0;
		public function get radian():Number {
			return __radian;
		}
		public function set radian(_radian:Number):void {
			__radian=_radian;
			setAngle(sideOff,__radian);
			if(!isInAir){
				setAngle(speed,__radian);
			}
		}
		public static function setAngle(_pt:Point,_angle:Number):void {
			var len:Number=_pt.length;
			_pt.x=Math.cos(_angle)*len;
			_pt.y=Math.sin(_angle)*len;
		}
		public static function getAngle(_pt:Point):Number {
			return Math.atan2(_pt.y,_pt.x);
		}
		private var __isInAir:Boolean=true;
		public function get isInAir():Boolean {
			return __isInAir;
		}
		private function inAir():void {
			var _b:Boolean=HitTest.crossPoint(position.x-speed.x,position.y-speed.y,position.x,position.y,ground,position);
			if (_b) {
				__isInAir=false;
				radian=adjustRadian();
				onGround();
				speed.x=0,speed.y=0;
				if(onFullEnd!=null){
					onFullEnd();
				}
			}
		}
		private function onGround():void {
			var _b:Boolean=HitTest.crossPoint(position.x+sideOff.y,position.y-sideOff.x,position.x-sideOff.y,position.y+sideOff.x,ground,position);
			if (_b) {
				radian=adjustRadian();
				return;
			}
			__isInAir=true;
			if(onFullBegin!=null){
				onFullBegin();
			}
		}
		private function adjustRadian():Number {
			if (! HitTest.crossPoint(position.x+sideOff.y,position.y-sideOff.x,position.x+sideOff.x,position.y+sideOff.y,ground,ptr)) {
				HitTest.crossPoint(position.x+sideOff.x,position.y+sideOff.y,position.x-sideOff.y,position.y+sideOff.x,ground,ptr);
			}
			if (!HitTest.crossPoint(position.x+sideOff.y,position.y-sideOff.x,position.x-sideOff.x,position.y-sideOff.y,ground,ptl)) {
				HitTest.crossPoint(position.x-sideOff.x,position.y-sideOff.y,position.x-sideOff.y,position.y+sideOff.x,ground,ptl);
			}
			return Math.atan2(ptr.y-ptl.y,ptr.x-ptl.x);
		}
	}
}