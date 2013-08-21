package {
	import flash.utils.ByteArray;
	
	import zero.codec.MyCRC32;
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
				swf_version = "SWF CRC32：#"+(0x100000000+MyCRC32.crc32(_bytes)).toString(16).substr(1).toUpperCase();
			}
		}

		public static function getModifyDate():String {
			return modifyDate||"修改时间：--";
		}
		
		public static function getVersion():String {
			return swf_version||"SWF 版本：--";
		}

		public static function getAuthor():String {
			return "Author: " + author;
		}

		public static function getInformation():String {
			return getAuthor() + "\r\n" + getVersion() + "\r\n" + getModifyDate();
		}
	}

}