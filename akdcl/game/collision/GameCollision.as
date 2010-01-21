package akdcl.game.collision
{
	import akdcl.game.GameModel;
	import akdcl.game.collision.Collision;
	import akdcl.game.collision.Map;
	import akdcl.game.collision.Tile;
	import akdcl.game.collision.Items;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import ui_2.Btn;
	import ui_2.ProgressBar;
	import flash.text.TextFormat;
	import cn.ronme.display.RonToolTip;
	
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Akdcl
	 */
	public class GameCollision extends GameModel
	{
		
		public var txt_score:TextField;
		public var bar_time:ProgressBar;
		public var btn_item_0:Btn;
		public var btn_item_1:Btn;
		public var btn_item_2:Btn;
		public var btn_item_3:Btn;
		public var btn_item_4:Btn;
		private var itemsList:Array;
		private var items:Items;
		public var onItemUse:Function;
		public var itemTipList:*;
		public function GameCollision() {
			
			RonToolTip.initStage(stage);
			var _tft:TextFormat = new TextFormat();
			_tft.size = 12;
			_tft.color = 0xFFFFFF;
			RonToolTip.initFormat(_tft, 0xFFFFFF, 0x000000);
			
			itemsList = [btn_item_0, btn_item_1, btn_item_2, btn_item_3, btn_item_4];
			var _btn:*;
			for (var _i:String in itemsList) {
				_btn = itemsList[_i];
				_btn.mouseChildren = false;
				_btn.userData = { id:int(_i) };
				_btn.release = function():void {
					if (!game.isControl) {
						return;
					}
					items.useItem(this.userData.id);
				}
			}
			Items.itemLength = 5;
			items = new Items();
			items.onEachUpdata = function(_item:Item, _id:uint):void {
				if (!_item) {
					itemsList[_id].clip.visible = false;
					itemsList[_id].txt.visible = false;
					return;
				}
				itemsList[_id].clip.visible = true;
				itemsList[_id].txt.visible = true;
				itemsList[_id].clip.gotoAndStop(_item.type);
				itemsList[_id].txt.text = "X" + _item.remain;
				RonToolTip.register(itemsList[_id], itemTipList[_item.type-1]);
			}
			items.onItemUse = function():void {
				if (onItemUse!=null) {
					onItemUse();
				}
			}
			items.updata();
			bar_time.value = 1;
			txt_score.text = "0";
			game.onScoreChange = function(_score:uint):void {
				TweenMax.to(txt_score, 0.5, { text:_score, roundProps:["text"] } );
			}
			game.onTimerChange = function(_time:int,_timeTotal:int):void {
				TweenMax.to(bar_time, 0.5, { value:1-_time/_timeTotal } );
			}
			game.onRemoveType = function(_value:uint):void {
				switch(_value) {
					case Map.VALUE_BOMB:
						items.addItem(Items.TYPE_BOMB);
						break;
					case Map.VALUE_OTHERITEM:
						items.addItem();
						break;
					case Map.VALUE_STONE:
						break;
				}
			}
			game.onTimerOver = function():void {
				gameOver();
			}
		}
		override protected function startGame():void {
			super.startGame();
			game.reset();
		}
		override protected function resetGame():void {
			super.resetGame();
			game.reset();
			items.reset();
		}
		override public function set pause(_pause:Boolean):void {
			super.pause = _pause;
			game.setPause(_pause);
		}
	}
	
}