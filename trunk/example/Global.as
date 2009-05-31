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
		public static function save(_ob, _s:String):void {
			var so:SharedObject = sharedOb();
			so.data[_s] = _ob;
			so.flush();
		}
		//存储之后怎样修改_ob也不会影响sharedOb().data
		public static function saveUnQ(_ob, _s:String):void {
			sharedOb().data[_s] = _ob;
			sharedOb().flush();
		}
		//读取之后在执行sharedOb()之前，都可以通过修改_ob来达到修改sharedOb().data的目的
		public static function load(_s:String):* {
			var _ob=sharedOb().data[_s];
			return _ob;
		}
		//读取之后在怎样修改_ob也不会影响sharedOb().data
		public static function loadUnQ(_s:String):* {
			var _ob=sharedOb().data[_s];
			sharedOb();
			return _ob;
		}
		//存档全部删除
		public static function del():void {
			sharedOb().clear();
		}
	}
}