/***
FilterClasses 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月13日 15:19:01 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.vmark{
	import zero.swf.record.filters.DROPSHADOWFILTER;
	import zero.swf.record.filters.BLURFILTER;
	import zero.swf.record.filters.GLOWFILTER;
	import zero.swf.record.filters.BEVELFILTER;
	import zero.swf.record.filters.GRADIENTGLOWFILTER;
	import zero.swf.record.filters.CONVOLUTIONFILTER;
	import zero.swf.record.filters.COLORMATRIXFILTER;
	import zero.swf.record.filters.GRADIENTBEVELFILTER;
	import flash.utils.Dictionary;
	import flash.utils.ByteArray;
	public class FilterClasses extends VMark{
		public static const FilterClassV:Vector.<Class>=get_FilterClassV();
		private static function get_FilterClassV():Vector.<Class>{
			var FilterClassV:Vector.<Class>=new Vector.<Class>(8);
			FilterClassV.fixed=true;
			FilterClassV[0]=zero.swf.record.filters.DROPSHADOWFILTER;
			FilterClassV[1]=zero.swf.record.filters.BLURFILTER;
			FilterClassV[2]=zero.swf.record.filters.GLOWFILTER;
			FilterClassV[3]=zero.swf.record.filters.BEVELFILTER;
			FilterClassV[4]=zero.swf.record.filters.GRADIENTGLOWFILTER;
			FilterClassV[5]=zero.swf.record.filters.CONVOLUTIONFILTER;
			FilterClassV[6]=zero.swf.record.filters.COLORMATRIXFILTER;
			FilterClassV[7]=zero.swf.record.filters.GRADIENTBEVELFILTER;
			return FilterClassV;
		}
		public static const FilterClassVDict:Dictionary=get_FilterClassVDict();
		private static function get_FilterClassVDict():Dictionary{
			var FilterClassVDict:Dictionary=new Dictionary();
			FilterClassVDict[zero.swf.record.filters.DROPSHADOWFILTER]=0;
			FilterClassVDict[zero.swf.record.filters.BLURFILTER]=1;
			FilterClassVDict[zero.swf.record.filters.GLOWFILTER]=2;
			FilterClassVDict[zero.swf.record.filters.BEVELFILTER]=3;
			FilterClassVDict[zero.swf.record.filters.GRADIENTGLOWFILTER]=4;
			FilterClassVDict[zero.swf.record.filters.CONVOLUTIONFILTER]=5;
			FilterClassVDict[zero.swf.record.filters.COLORMATRIXFILTER]=6;
			FilterClassVDict[zero.swf.record.filters.GRADIENTBEVELFILTER]=7;
			return FilterClassVDict;
		}
		public static const DROPSHADOWFILTER:Class=zero.swf.record.filters.DROPSHADOWFILTER;
		public static const BLURFILTER:Class=zero.swf.record.filters.BLURFILTER;
		public static const GLOWFILTER:Class=zero.swf.record.filters.GLOWFILTER;
		public static const BEVELFILTER:Class=zero.swf.record.filters.BEVELFILTER;
		public static const GRADIENTGLOWFILTER:Class=zero.swf.record.filters.GRADIENTGLOWFILTER;
		public static const CONVOLUTIONFILTER:Class=zero.swf.record.filters.CONVOLUTIONFILTER;
		public static const COLORMATRIXFILTER:Class=zero.swf.record.filters.COLORMATRIXFILTER;
		public static const GRADIENTBEVELFILTER:Class=zero.swf.record.filters.GRADIENTBEVELFILTER;
		////
		//

	}
}