package cn.ronme.display 
{
	import cn.ronme.utils.RonUtils;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Ron Tian
	 */
	public class RonStage
	{
		private static var instance:RonStage;
		private static var stage:Stage;
		protected var tip_mc:Sprite;
		protected var alert_mc:Sprite;
		protected var window_mc:Sprite;
		protected var windows:Array;
		protected var alerts:Array;
		protected var tips:Array;
		public function RonStage() 
		{
			if (instance != null)
			{
				try
				{
					throw(new Error("This object is single instance!"));
				}
				catch (err:Error)
				{
					
				}
			}
			else
			{
				configUI();
			}
		}
		
		public function initParams(rsp:RonStageParams=null):void
		{
			if (rsp == null)
			{
				rsp = new RonStageParams();
			}
			stage.align = rsp.align;
			stage.scaleMode = rsp.scaleMode;
			stage.showDefaultContextMenu = rsp.showDefaultMenu;
		}
		
		public function getStage():Stage
		{
			return stage;
		}
		
		public function addWindow(window:DisplayObject):void
		{
			windows.push(window);
			window_mc.addChild(window);
		}
		
		public function removeWindow(window:DisplayObject):void
		{
			if (window != null && window_mc.contains(window))
			{
				windows.splice(windows.indexOf(window), 1);
				window_mc.removeChild(window);
				window = null;
				RonUtils.gc();
			}
		}
		
		public function removeAllWindows():void
		{
			var len:int = windows.length;
			var child:DisplayObject;
			for (var i:int = 0; i < len; i++)
			{
				child = windows[i];
				if (child!=null && window_mc.contains(child))
				{
					window_mc.removeChild(child);
					child = null;
				}
			}
			windows = new Array();
			RonUtils.gc();
		}
		
		public function addAlert(alert:DisplayObject):void
		{
			alerts.push(alert);
			alert_mc.addChild(alert);
		}
		
		public function removeAlert(alert:DisplayObject):void
		{
			if (alert != null && alert_mc.contains(alert))
			{
				alerts.splice(alerts.indexOf(alert), 1);
				alert_mc.removeChild(alert);
				alert = null;
				RonUtils.gc();
			}
		}
		
		public function removeAllAlerts():void
		{
			var len:int = alerts.length;
			var child:DisplayObject;
			for (var i:int = 0; i < len; i++)
			{
				child = alerts[i];
				if (child!=null && alert_mc.contains(child))
				{
					alert_mc.removeChild(child);
					child = null;
				}
			}
			alerts = new Array();
			RonUtils.gc();
		}
		
		public function addTip(tip:DisplayObject):void
		{
			tips.push(tip);
			tip_mc.addChild(tip);
		}
		
		public function removeTip(tip:DisplayObject):void
		{
			if (tip != null && tip_mc.contains(tip))
			{
				tips.splice(alerts.indexOf(tip), 1);
				tip_mc.removeChild(tip);
				tip = null;
				RonUtils.gc();
			}
		}
		
		public function removeAllTips():void
		{
			var len:int = tips.length;
			var child:DisplayObject;
			for (var i:int = 0; i < len; i++)
			{
				child = tips[i];
				if (child!=null && tip_mc.contains(child))
				{
					tip_mc.removeChild(child);
					child = null;
				}
			}
			tips = new Array();
			RonUtils.gc();
		}
		
		public static function getInstance(s:Stage):RonStage
		{
			if (instance == null)
			{
				stage = s;
				instance = new RonStage();
			}
			return instance;
		}
		
		private function configUI():void
		{
			window_mc = new Sprite();
			stage.addChild(window_mc);
			alert_mc = new Sprite();
			stage.addChild(alert_mc);
			tip_mc = new Sprite();
			stage.addChild(tip_mc);
			windows = new Array();
			alerts = new Array();
			tips = new Array();
		}
	}

}