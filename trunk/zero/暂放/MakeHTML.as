/***
MakeHTML 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月4日 21:35:57
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.URLRequest;
	//import flash.net.navigateToURL;
	import flash.utils.*;
	
	import zero.air.FileAndStr;
	
	public class MakeHTML{
		private var swfPath:String;
		private var wid:Number;
		private var hei:Number;
		public function MakeHTML(_swfPath:String,_wid:Number,_hei:Number){
			swfPath=_swfPath;
			wid=_wid;
			hei=_hei;
		}
		public function makeHTML():void{
			var dotId:int=swfPath.lastIndexOf(".");
			var htmlFile:File=new File(swfPath.substr(0,dotId)+".htm");
			var swfName:String=swfPath.substr(swfPath.lastIndexOf("/")+1);
			FileAndStr.writeStrToFile(
				'<object id="object_id" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="'+wid+'" height="'+hei+'">\r\n'+
				'  <param name="allowScriptAccess" value="always"/>\r\n'+
				'  <param name="movie" value="'+swfName+'" />\r\n'+
				'  <param name="quality" value="high" />\r\n'+
				'  <embed name="embed_name" src="'+swfName+'" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="'+wid+'" height="'+hei+'" allowScriptAccess="always"></embed>\r\n'+
				'</object>\r\n',
				htmlFile
			);
			
			htmlFile.openWithDefaultApplication();
			//navigateToURL(new URLRequest(decodeURI(htmlFile.url)));
		}
	}
}

