/***
Test
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 23:14:14
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds.effects{
	import flash.display.*;
	import flash.display3D.Context3DProgramType;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.stage3Ds.AGAL2ByteV;
	import zero.stage3Ds.getProgramByByteV;
	
	public class Test extends BaseEffect{
		
		//public static const fragmentProgram:ByteArray=getProgramByByteV();
		public static const fragmentProgram:ByteArray=AGAL2ByteV(
			Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
			"tex oc, v0, fs0 <2d>"
			//可理解为：oc=sample(fs0,v0)
			//fs<n>，fs0 在这里就是 stage3D.context3D.setTextureAt(0,texture); 中的 texture
			//v0 在这里就是 "mov v0, va1" 中的 v0
			//oc，用于像素着色器的输出寄存器
			
			//纹理采样寄存器是用来基于UV坐标从纹理中获取颜色值。
			//纹理是通过ActionScriptcall指定方法Context3D::setTextureAt()。
			//纹理样本的使用语法是：fs<n> <flags>，其中<n>是取样指数，<flags>是由一个或多个标记，用于指定如何进行采样。
			//<flags>是以逗号分隔的一组字符串，它定义：
			//纹理尺寸。可以是：二维，三维，多维数据集
			//纹理映射。可以是：nomip，mipnone，mipnearest，mipnone
			//纹理过滤。可以是：最近点采样，线性
			//纹理重复。可以是：重复，包装，夹取。
			//因此，举例来说，一个标准的2D纹理没有纹理映射，并进行线性过滤，可以进行采样到临时寄存器FT1，使用以下命令：
			//"tex ft1, v0, fs0 <2d,linear,nomip>"
			//变寄存器v0持有插值的纹理 UVs。
		);
		
		public function Test(){
			
		}
	}
}