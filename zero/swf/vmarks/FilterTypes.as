/***
FilterTypes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 12:14:18 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmarks{
	import zero.swf.records.filters.DROPSHADOWFILTER;
	import zero.swf.records.filters.BLURFILTER;
	import zero.swf.records.filters.GLOWFILTER;
	import zero.swf.records.filters.BEVELFILTER;
	import zero.swf.records.filters.GRADIENTGLOWFILTER;
	import zero.swf.records.filters.CONVOLUTIONFILTER;
	import zero.swf.records.filters.COLORMATRIXFILTER;
	import zero.swf.records.filters.GRADIENTBEVELFILTER;
	import flash.utils.ByteArray;
	public class FilterTypes extends VMark{
		public static const DROPSHADOWFILTER:int=0;
		public static const BLURFILTER:int=1;
		public static const GLOWFILTER:int=2;
		public static const BEVELFILTER:int=3;
		public static const GRADIENTGLOWFILTER:int=4;
		public static const CONVOLUTIONFILTER:int=5;
		public static const COLORMATRIXFILTER:int=6;
		public static const GRADIENTBEVELFILTER:int=7;
		
		public static const typeV:Vector.<String>=get_typeV();
		private static function get_typeV():Vector.<String>{
			var typeV:Vector.<String>=new Vector.<String>(8);
			typeV.fixed=true;
			typeV[0]="DROPSHADOWFILTER";
			typeV[1]="BLURFILTER";
			typeV[2]="GLOWFILTER";
			typeV[3]="BEVELFILTER";
			typeV[4]="GRADIENTGLOWFILTER";
			typeV[5]="CONVOLUTIONFILTER";
			typeV[6]="COLORMATRIXFILTER";
			typeV[7]="GRADIENTBEVELFILTER";
			return typeV;
		}
		
		public static const classV:Vector.<Class>=get_classV();
		private static function get_classV():Vector.<Class>{
			var classV:Vector.<Class>=new Vector.<Class>(8);
			classV.fixed=true;
			classV[0]=zero.swf.records.filters.DROPSHADOWFILTER;
			classV[1]=zero.swf.records.filters.BLURFILTER;
			classV[2]=zero.swf.records.filters.GLOWFILTER;
			classV[3]=zero.swf.records.filters.BEVELFILTER;
			classV[4]=zero.swf.records.filters.GRADIENTGLOWFILTER;
			classV[5]=zero.swf.records.filters.CONVOLUTIONFILTER;
			classV[6]=zero.swf.records.filters.COLORMATRIXFILTER;
			classV[7]=zero.swf.records.filters.GRADIENTBEVELFILTER;
			return classV;
		}
		////
		//

	}
}