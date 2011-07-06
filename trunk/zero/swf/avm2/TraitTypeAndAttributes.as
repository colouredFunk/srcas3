/***
TraitTypeAndAttributes
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:48（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{

	public class TraitTypeAndAttributes{
		public static const Slot:int=0;
		public static const Method:int=1;
		public static const Getter:int=2;
		public static const Setter:int=3;
		public static const Class_:int=4;
		public static const Function_:int=5;
		public static const Const:int=6;
		
		public static const typeV:Vector.<String>=function():Vector.<String>{
			var typeV:Vector.<String>=new Vector.<String>(7);
			typeV.fixed=true;
			typeV[0]="Slot";
			typeV[1]="Method";
			typeV[2]="Getter";
			typeV[3]="Setter";
			typeV[4]="Class_";
			typeV[5]="Function_";
			typeV[6]="Const";
			return typeV;
		}();
		
		////
		public static const Final:int=1;
		public static const Override:int=2;
		public static const Metadata:int=4;
		
		public static const flagV:Vector.<String>=function():Vector.<String>{
			var flagV:Vector.<String>=new Vector.<String>(5);
			flagV.fixed=true;
			flagV[1]="Final";
			flagV[2]="Override";
			flagV[4]="Metadata";
			return flagV;
		}();
		
		////
		//

	}
}