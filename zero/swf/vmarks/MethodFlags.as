/***
MethodFlags 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月28日 19:35:39 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmarks{

	public class MethodFlags{
		public static const NEED_ARGUMENTS:int=1;
		public static const NEED_ACTIVATION:int=2;
		public static const NEED_REST:int=4;
		public static const HAS_OPTIONAL:int=8;
		public static const SET_DXNS:int=64;
		public static const HAS_PARAM_NAMES:int=128;
		
		public static const flagV:Vector.<String>=get_flagV();
		private static function get_flagV():Vector.<String>{
			var flagV:Vector.<String>=new Vector.<String>(129);
			flagV.fixed=true;
			flagV[1]="NEED_ARGUMENTS";
			flagV[2]="NEED_ACTIVATION";
			flagV[4]="NEED_REST";
			flagV[8]="HAS_OPTIONAL";
			flagV[64]="SET_DXNS";
			flagV[128]="HAS_PARAM_NAMES";
			return flagV;
		}
		
		////
		//

	}
}