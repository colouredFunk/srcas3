/***
BlendModes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 12:21:11 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmarks{
	import flash.utils.ByteArray;
	public class BlendModes extends VMark{
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
		
		public static const blendModeV:Vector.<String>=get_blendModeV();
		private static function get_blendModeV():Vector.<String>{
			var blendModeV:Vector.<String>=new Vector.<String>(15);
			blendModeV.fixed=true;
			blendModeV[0]="normal";
			blendModeV[1]="normal_too";
			blendModeV[2]="layer";
			blendModeV[3]="multiply";
			blendModeV[4]="screen";
			blendModeV[5]="lighten";
			blendModeV[6]="darken";
			blendModeV[7]="difference";
			blendModeV[8]="add";
			blendModeV[9]="subtract";
			blendModeV[10]="invert";
			blendModeV[11]="alpha";
			blendModeV[12]="erase";
			blendModeV[13]="overlay";
			blendModeV[14]="hardlight";
			return blendModeV;
		}
		
		////
		//

	}
}