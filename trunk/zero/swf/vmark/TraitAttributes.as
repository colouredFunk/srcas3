/***
TraitAttributes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月19日 15:38:24 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmark{
	import flash.utils.ByteArray;
	public class TraitAttributes extends VMark{
		public static const Final:int=1;
		public static const Override:int=2;
		public static const Metadata:int=4;
		
		public static const flagV:Vector.<String>=get_flagV();
		private static function get_flagV():Vector.<String>{
			var flagV:Vector.<String>=new Vector.<String>(5);
			flagV.fixed=true;
			flagV[1]="Final";
			flagV[2]="Override";
			flagV[4]="Metadata";
			return flagV;
		}
		
		////
		//

	}
}