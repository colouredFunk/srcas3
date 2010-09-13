/***
BlendModes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月13日 14:31:20 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmark{
	import flash.utils.ByteArray;
	public class BlendModes extends VMark{
		public static const BlendModeV:Vector.<String>=get_BlendModeV();
		private static function get_BlendModeV():Vector.<String>{
			var BlendModeV:Vector.<String>=new Vector.<String>(15);
			BlendModeV.fixed=true;
			BlendModeV[0]="normal";
			BlendModeV[1]="normal_too";
			BlendModeV[2]="layer";
			BlendModeV[3]="multiply";
			BlendModeV[4]="screen";
			BlendModeV[5]="lighten";
			BlendModeV[6]="darken";
			BlendModeV[7]="difference";
			BlendModeV[8]="add";
			BlendModeV[9]="subtract";
			BlendModeV[10]="invert";
			BlendModeV[11]="alpha";
			BlendModeV[12]="erase";
			BlendModeV[13]="overlay";
			BlendModeV[14]="hardlight";
			return BlendModeV;
		}
		public static const normal:int=0;
		public static const normal_too:int=1;
		public static const layer:int=2;
		public static const multiply:int=3;
		public static const screen:int=4;
		public static const lighten:int=5;
		public static const darken:int=6;
		public static const difference:int=7;
		public static const add:int=8;
		public static const subtract:int=9;
		public static const invert:int=10;
		public static const alpha:int=11;
		public static const erase:int=12;
		public static const overlay:int=13;
		public static const hardlight:int=14;
		////
		//

	}
}