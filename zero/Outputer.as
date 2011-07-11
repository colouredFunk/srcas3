/***
Outputer 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2009年7月11日 17:41:48
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	public class Outputer{
		//输出转接，默认调用 trace，典型用法：
		
		//Outputer.output=outputPane.output;
		//Outputer.outputError=outputPane.outputError;
		
		public static var output:Function=trace;
		public static var outputError:Function=trace;
		public static function reset():void{
			output=trace;
			outputError=trace;
		}
	}
}

