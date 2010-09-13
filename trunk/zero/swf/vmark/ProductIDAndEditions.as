/***
ProductIDAndEditions 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月13日 14:31:20 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmark{
	import flash.utils.ByteArray;
	public class ProductIDAndEditions extends VMark{
		public static const ProductIDV:Vector.<String>=get_ProductIDV();
		private static function get_ProductIDV():Vector.<String>{
			var ProductIDV:Vector.<String>=new Vector.<String>(4);
			ProductIDV.fixed=true;
			ProductIDV[0]="Unknown";
			ProductIDV[1]="Macromedia_Flex_for_J2EE";
			ProductIDV[2]="Macromedia_Flex_for_dotNET";
			ProductIDV[3]="Adobe_Flex";
			return ProductIDV;
		}
		public static const Unknown:int=0;
		public static const Macromedia_Flex_for_J2EE:int=1;
		public static const Macromedia_Flex_for_dotNET:int=2;
		public static const Adobe_Flex:int=3;
		////
		public static const EditionV:Vector.<String>=get_EditionV();
		private static function get_EditionV():Vector.<String>{
			var EditionV:Vector.<String>=new Vector.<String>(7);
			EditionV.fixed=true;
			EditionV[0]="Developer_Edition";
			EditionV[1]="Full_Commercial_Edition";
			EditionV[2]="Non_Commercial_Edition";
			EditionV[3]="Educational_Edition";
			EditionV[4]="Not_For_Resale__NFR__Edition";
			EditionV[5]="Trial_Edition";
			EditionV[6]="None";
			return EditionV;
		}
		public static const Developer_Edition:int=0;
		public static const Full_Commercial_Edition:int=1;
		public static const Non_Commercial_Edition:int=2;
		public static const Educational_Edition:int=3;
		public static const Not_For_Resale__NFR__Edition:int=4;
		public static const Trial_Edition:int=5;
		public static const None:int=6;
		////
		//

	}
}