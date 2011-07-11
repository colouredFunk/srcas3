/***
PHPXMLLoader 版本:v1.0
简要说明:加载 php 生成的 xml
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年9月1日 12:58:04
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.net{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	public class PHPXMLLoader extends DataLoader{
		
		public var xml:XML;
		public var onLoadFinished:Function;
		
		public function PHPXMLLoader(_onLoadProgress:Function,_onLoadFinished:Function){
			onLoadFinished=_onLoadFinished;
			super(_onLoadProgress,loadPHPXMLFinished);
		}
		override public function clear():void{super.clear();
			xml=null;
			onLoadFinished=null;
		}
		public function loadPHPXMLFinished(info:String):void{
			//trace("info="+info);
			//trace("data="+data);
			if(info==RequestLoader.SUCCESS){
				try{
					xml=new XML(this.data);
					//trace("PHPXMLLoader xml=\n"+xml.toXMLString());
				}catch(e:Error){
					trace("不是有效的 xml 数据");
					trace(this.data);
					onLoadFinished(RequestLoader.ERROR);
					return;
				}
				
				var xmlName:String;
				try{
					xmlName=xml.name().toString();
				}catch(e:Error){
					xmlName=null;
				}
				
				if(xmlName){
					onLoadFinished(info);
				}else{
					onLoadFinished(RequestLoader.ERROR);
				}
				return;
			}
			onLoadFinished(info);
		}
	}
}

