/***
NamespaceKind 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 12:21:11 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmark{
	import flash.utils.ByteArray;
	public class NamespaceKind extends VMark{
		public static const PrivateNs:int=5;
		public static const Namespace:int=8;
		public static const PackageNamespace:int=22;
		public static const PackageInternalNs:int=23;
		public static const ProtectedNamespace:int=24;
		public static const ExplicitNamespace:int=25;
		public static const StaticProtectedNs:int=26;
		
		public static const kindV:Vector.<String>=get_kindV();
		private static function get_kindV():Vector.<String>{
			var kindV:Vector.<String>=new Vector.<String>(27);
			kindV.fixed=true;
			kindV[5]="PrivateNs";
			kindV[8]="Namespace";
			kindV[22]="PackageNamespace";
			kindV[23]="PackageInternalNs";
			kindV[24]="ProtectedNamespace";
			kindV[25]="ExplicitNamespace";
			kindV[26]="StaticProtectedNs";
			return kindV;
		}
		
		////
		//

	}
}