package {
	import flash.utils.ByteArray;
	import zero.SWFMetadataGetter;


	/**
	 * ...
	 * @author akdcl
	 */
	final public class AuthorInformation {
		private static const author:String = "Chunlei.Duan";
		private static var modifyDate:String = "--";
		private static var version:String = "--";

		public static function setFileBytes(_bytes:ByteArray):void {
			SWFMetadataGetter.init(_bytes);
			var _modifyDate:String = SWFMetadataGetter.getModifyDate();
			if (_modifyDate){
				_modifyDate = _modifyDate.split("+")[0];

				modifyDate = _modifyDate.split("T").join(" ");

				var _ary:Array = _modifyDate.split("T");
				_ary[0] = _ary[0].split("-");
				_ary[1] = _ary[1].split(":");
				_modifyDate = _ary[0][1] + _ary[0][2] + "." + (int(_ary[1][0]) * 60 + int(_ary[1][1]));

				version = _ary[0][0].substr(2, 2) + "." + _modifyDate;
			}
		}

		public static function getModifyDate():String {
			return "ModifyDate: " + modifyDate;
		}

		public static function getVersion():String {
			return "Version: " + version;
		}

		public static function getAuthor():String {
			return "Author: " + author;
		}

		public static function getInformation():String {
			return getAuthor() + "\r\n" + getVersion() + "\r\n" + getModifyDate();
		}
	}

}