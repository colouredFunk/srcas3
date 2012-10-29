package {
	import flash.utils.ByteArray;
	
	import zero.codec.CRC32;
	import zero.swf.utils.getModificationDate;
	import zero.utils.getTime;

	/**
	 * ...
	 * @author akdcl
	 */
	final public class AuthorInformation {
		private static const author:String = "Zhibin.Lu";
		private static var modifyDate:String;
		private static var swf_version:String;
		private static var xml_version:String;

		public static function setFileBytes(_bytes:ByteArray):void {
			modifyDate=getTime("Y年m月d日 H:i:s.ms",getModificationDate(_bytes));
			if (modifyDate){
				swf_version = modifyDate;
			}else{
				modifyDate=null;
				swf_version = "SWF CRC32：#"+(0x100000000+uint(CRC32(_bytes))).toString(16).substr(1).toUpperCase();
			}
		}

		public static function getModifyDate():String {
			return modifyDate||"修改时间：--";
		}
		
		public static function getVersion():String {
			return swf_version||"SWF 版本：--";
		}
		
		/*
		private static function genVersion(_data:*,name:String):String{
			if(so){
				if(so.data.versions){
				}else{
					so.data.versions=new Object();
				}
				var saveData:Object=so.data.versions[name];
				if(saveData){
				}else{
					so.data.versions[name]=saveData=new Object();
				}
				if(saveData["version"]>0){
				}else{
					saveData["len"]=0;
					saveData["crc32"]=0;
					saveData["version"]=999;
				}
				if(_data is ByteArray){
					var data:ByteArray=_data;
				}else{
					data=new ByteArray();
					data.writeUTFBytes(_data);
				}
				//trace('saveData["len"]='+saveData["len"],'data.length='+data.length);
				if(saveData["len"]==data.length){
					var crc32:int=CRC32(data);
					if(saveData["crc32"]==crc32){
					}else{
						saveData["crc32"]=crc32;
						saveData["version"]++;
					}
				}else{
					saveData["len"]=data.length;
					delete saveData["crc32"];
					saveData["version"]++;
				}
				if(saveData["version"]>10000){
					saveData["version"]=9999;//9.9.9.9
				}else if(saveData["version"]<1000){
					saveData["version"]=1000;//1.0.0.0
				}
				return saveData["version"].toString().split("").join(".");
			}
			return null;
		}
		*/

		public static function getAuthor():String {
			return "Author: " + author;
		}

		public static function getInformation():String {
			return getAuthor() + "\r\n" + getVersion() + "\r\n" + getModifyDate();
		}
	}

}