package tileHitTest
{
	import akdcl.game.tileGame.ObjMove;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import akdcl.key.Key;
	import akdcl.key.AtkKey;;
	import akdcl.key.KeyManager;
	import akdcl.events.KeyEvent;
	/**
	 * ...
	 * @author Akdcl
	 */
	public class ObjMoveModel extends Sprite 
	{
		private var objMove:ObjMove;
		private var upKey:Key;
		private var downKey:Key;
		private var leftKey:Key;
		private var rightKey:Key;
		private var fireKey:Key;
		private var xAxisKeys:AtkKey;
		private var yAxisKeys:AtkKey;
		private var keyManager:KeyManager;
		public function ObjMoveModel() {
			keyManager=new KeyManager(stage,500);
			upKey=new Key("W");
			downKey=new Key("S");
			leftKey=new Key("A");
			rightKey=new Key("D");
			xAxisKeys = new AtkKey(keyManager, leftKey, rightKey);
			yAxisKeys = new AtkKey(keyManager, upKey, downKey);
			
			xAxisKeys.onKeyDown=function(_evt:KeyEvent):void{
				switch(_evt.keyName) {
					case "A":
						objMove.vectorSpeed.x = -10;
						break;
					case "D":
						objMove.vectorSpeed.x = 10;
						break;
				}
			}
			xAxisKeys.onKeyUp = function(_evt:KeyEvent):void {
				if(_evt.keysName.length<2){
					objMove.vectorSpeed.x = 0;
				}else if(_evt.keyName=="A"){
					objMove.vectorSpeed.x = 10;
				}else{
					objMove.vectorSpeed.x = -10;
				}
			}
			yAxisKeys.onKeyDown=function(_evt:KeyEvent):void{
				switch(_evt.keyName) {
					case "W":
						objMove.vectorSpeed.y = -10;
						break;
					case "S":
						objMove.vectorSpeed.y = 10;
						break;
				}
			}
			yAxisKeys.onKeyUp = function(_evt:KeyEvent):void {
				if(_evt.keysName.length<2){
					//objMove.vectorSpeed.y = 0;
				}else if(_evt.keyName=="A"){
					//objMove.vectorSpeed.y = 10;
				}else{
					//objMove.vectorSpeed.y = -10;
				}
			}
			xAxisKeys.start();
			yAxisKeys.start();
			addEventListener(Event.ENTER_FRAME, runStep);
		}
		public function setObjMove(_objMove:ObjMove):void {
			objMove = _objMove;
			objMove.onHitTile = function(_isXaxis:Boolean):void {
				if (!_isXaxis) {
					objMove.vectorSpeed.y = 0;
				}
			}
		}
		public function update():void {
			x = objMove.x;
			y = objMove.y;
		}
		private var g:Number = 0.5;
		private var isFall:Boolean = true;
		private function runStep(_evt:Event):void {
			objMove.runStep();
			update();
				objMove.vectorSpeed.y += g;
			/*if (isFall) {
			}
			if (objMove.hitTestY(g) == 0) {
				isFall = true;
			}else {
				isFall = false;
			}*/
			
		}
	}
	
}