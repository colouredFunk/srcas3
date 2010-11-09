/***
TraitTypes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 10:39:59 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmarks{

	public class TraitTypes{
		public static const Slot:int=0;
		public static const Method:int=1;
		public static const Getter:int=2;
		public static const Setter:int=3;
		public static const Clazz:int=4;
		public static const Function:int=5;
		public static const Const:int=6;
		
		public static const typeV:Vector.<String>=get_typeV();
		private static function get_typeV():Vector.<String>{
			var typeV:Vector.<String>=new Vector.<String>(7);
			typeV.fixed=true;
			typeV[0]="Slot";
			typeV[1]="Method";
			typeV[2]="Getter";
			typeV[3]="Setter";
			typeV[4]="Clazz";
			typeV[5]="Function";
			typeV[6]="Const";
			return typeV;
		}
		
		////
		//

	}
}