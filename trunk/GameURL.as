package {
	import com.adobe.crypto.MD5;
	import flash.events.Event;
	import flash.net.LocalConnection;
	import flash.display.Loader;
	public class GameURL {
		private static var gameWin:String="/mhzx/200908/mzsendcode2/question.jsp";
		private static var url_time:String="/mhzx/mzsendcode2/flash!ReturnTime.action";
		private static var heroName:String;
		private static var tempURL:String;
		private static var server:LocalConnection=new LocalConnection();
		private static var time:*;
		private static var channel:String="_pwrd_mhxy";
		public static function getURL(_timeURL:String=null,_tempURL:String=null):void {
			if(_tempURL){
				tempURL=_tempURL;
			}
			Common.urlLoader((_timeURL||url_time),funLoaded);
		}
		public static function funLoaded(_evt:Event):void {
			time=String(_evt.currentTarget.data);
        	server.connect(channel);
			server.client = {swfLoaded:swfLoaded};
			Common.loader("pwrd.swf",null);
		}
		public static var onLoaded:Function;
		private static function swfLoaded(_tp:*):void{
			//
			var data:Data=Data.getInstance(rprt.stage);
			if(!data){
				if(onLoaded!=null){
					onLoaded(data);
				}
				return;
			}
			var _str:String=data.readUTFBytes(data.length);
			var _coded:String=String(Math.random()*100000);
			var _ob:Object={hashed:MD5.hash(_coded+time+_tp+_str),coded:_coded};
			Common.getURL((tempURL||gameWin),"_self",_ob);
			tempURL=null;
			if(onLoaded!=null){
				onLoaded(_ob);
			}
		}
	}
}