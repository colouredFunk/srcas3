package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.errors.*;
	public class Data extends ByteArray {
		public function Data(){
		}
		public static function getInstance(_stage:Stage):Data {
			if (_stage.loaderInfo.url.indexOf("http://localhost")==0) {
				var _data:Data=new Data  ;
				_data.writeUTFBytes("xxxxxxxxxxx");
				_data.position=0;
				return _data;
			}
			throw new Error("!!!");
			return null;
		}
	}
}
/*
var _parent=this;
while(_parent.parent){
	_parent=_parent.parent;
	if(_parent is Loader){
		throw new Error("!!!");
		return;
	}
}
var data:Data=Data.getInstance(stage);
if(data){
	var _str:String=data.readUTFBytes(data.length);
}
*/