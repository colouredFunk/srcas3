package cn.ronme.display 
{
	import cn.ronme.utils.RonUtils;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ron Tian
	 */
	public class RonSprite extends Sprite
	{
		protected var stageWidth:Number;
		protected var stageHeight:Number;
		protected var displays:Array;
		protected var ronStage:RonStage;
		public function RonSprite() 
		{
			displays = new Array();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStagehandler);
		}
		
		public function get flashVars():Object
		{
			if (stage)
			{
				return stage.loaderInfo.parameters;
			}
			return new Object();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			displays.push(child);
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			displays.push(child);
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			if (child != null && contains(child))
			{
				displays.splice(displays.indexOf(child), 1);
				return super.removeChild(child);
			}
			else
			{
				return null;
			}
		}
		
		override public function removeChildAt(index:int):DisplayObject 
		{
			if (index<0 || index > numChildren - 1)
			{
				return null;
			}
			var child:DisplayObject = getChildAt(index);
			displays.splice(displays.indexOf(child), 1);
			return super.removeChildAt(index);
		}
		
		private function removeAllChilds(isRemove:Boolean=false):void
		{
			var len:int = displays.length;
			var child:DisplayObject;
			for (var i:int = 0; i < len; i++)
			{
				child = displays[i];
				if (child != null && contains(child))
				{
					super.removeChild(child);
				}
			}
			displays = null;
			RonUtils.gc();
			if (!isRemove)
			{
				displays = new Array();
			}
		}
		
		protected function onRemovedFromStagehandler(event:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStagehandler);
			removeAllChilds(true);
		}
		
		protected function onAddedToStageHandler(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			ronStage = RonStage.getInstance(stage);
			stage.addEventListener(Event.RESIZE, onStageResizeHandler);
			onStageResizeHandler();
		}
		
		protected function onStageResizeHandler(event:Event=null):void 
		{
			if (!stage)
			{
				return;
			}
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
		}
		
	}

}