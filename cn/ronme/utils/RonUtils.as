package cn.ronme.utils 
{
	import com.carlcalderon.arthropod.Debug;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ron Tian
	 */
	public class RonUtils
	{
		
		public function RonUtils() 
		{
			
		}
		
		public static function log(message:String = "", isDebug:Boolean = true):void
		{
			var str:String = "===>log===>" + message;
			trace(str);
			if (isDebug)
			{
				Debug.log(str);
			}
		}
		
		
		public static function gc():void
		{
			try
			{
				new LocalConnection().connect("www.ronme.cn");
				new LocalConnection().connect("www.ronme.cn");
			}
			catch (err:Error)
			{
				
			}
		}
		
		public static function getURL(url:String, window:String = "_blank", features:String = ""):void
		{
			var WINDOW_OPEN_FUNCTION:String = "window.open";
			var myURL:URLRequest = new URLRequest(url);			
			var browserName:String = getBrowserName();
			if (getBrowserName() == "Firefox")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			//If IE, 
			else if (browserName == "IE")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
				//ExternalInterface.call("function setWMWindow() {window.open(&apos;" + url + "&apos;);}");
			}
			//If Safari 
			else if (browserName == "Safari")
			{			  
				navigateToURL(myURL, window);
			}
			//If Opera 
			else if (browserName == "Opera")
			{	
				navigateToURL(myURL, window); 
			} else 
			{
				navigateToURL(myURL, window);
			}
			
			/*Alternate methodology...
			   var popSuccess:Boolean = ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features); 
			if(popSuccess == false)
			{
				navigateToURL(myURL, window);
			}*/
			 
		}
		
		private static function getBrowserName():String
		{
			var browser:String;
			var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			if (browserAgent != null && browserAgent.indexOf("Firefox") >= 0) 
			{
				browser = "Firefox";
			} 
			else if (browserAgent != null && browserAgent.indexOf("Safari") >= 0)
			{
				browser = "Safari";
			}			 
			else if (browserAgent != null && browserAgent.indexOf("MSIE") >= 0)
			{
				browser = "IE";
			}		 
			else if (browserAgent != null && browserAgent.indexOf("Opera") >= 0)
			{
				browser = "Opera";
			}
			else 
			{
				browser = "Undefined";
			}
			return browser;
		}
	}

}