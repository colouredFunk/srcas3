package {
	import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;
	final public class Global {
		public static  var NAME:String="";
		//版本号
		public static  var VERSION:String="V 0.00";
		//高
		//public static  var WIDTH:Number=Stage.width;
		//宽
		//public static  var HEIGHT:Number=Stage.height;
		//------------------------------------------------
		public static  var main;//主类的引用

		public static function sharedOb():SharedObject {
			return SharedObject.getLocal(NAME + "_data","/");
		}
		//存储之后在执行sharedOb()之前，都可以通过修改_ob来达到修改sharedOb().data的目的
		public static function saveShareOb(_ob:*, _s:String):void {
			var so:SharedObject = sharedOb();
			so.data[_s] = _ob;
			so.flush();
		}
		//读取之后在执行sharedOb()之前，都可以通过修改_ob来达到修改sharedOb().data的目的
		public static function loadShareOb(_s:String):* {
			var _ob=sharedOb().data[_s];
			return _ob;
		}
		//存档全部删除
		public static function delShareOb():void {
			sharedOb().clear();
		}
	}
}