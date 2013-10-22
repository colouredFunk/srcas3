/***
ARGB
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月12日 09:28:58
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
	
	public class ARGB extends BaseEffect{
		//public static const fragmentProgram:ByteArray=getProgramByByteV();
		public static const fragmentProgram:ByteArray=AGAL2ByteV(
			Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
			<AGAL><![CDATA[
				tex ft0,v0,fs0<2d>
				mul ft0.rgb,ft0.rgb,fc0.rgb
				mul oc,ft0,fc0.a
			]]></AGAL>.toString()
			
			/*
			
			1
			如仅想显示一个纯黄色矩形，亦需要先执行 tex...（可能是因为汇编 tex 后的字节码还带一种初始化画布的作用？）：
			fc0=[1,1,0,1]
			tex ft0,v0,fs0<2d>
			mov oc,fc0
			
			2
			如需显示透明效果，除需要修改透明通道的值外，还需要分别给红，绿，蓝通道乘以透明值：
			tex ft0,v0,fs0<2d>
			mul ft0.rgb,ft0.rgb,fc0.rgb
			mul oc,ft0,fc0.a
			如直接：
			tex ft0,v0,fs0<2d>
			mul oc,ft0,fc0
			将会不正确
			
			*/
			
		);
		
		/**
		 * 
		 * 透明度 （0~1） 默认 1
		 * 
		 */
		public var alpha:Number;
		
		/**
		 * 
		 * 红 （0~1） 默认 1
		 * 
		 */
		public var red:Number;
		
		/**
		 * 
		 * 绿 （0~1） 默认 1
		 * 
		 */
		public var green:Number;
		
		/**
		 * 
		 * 蓝 （0~1） 默认 1
		 * 
		 */
		public var blue:Number;
		
		
		/**
		 * 
		 * 透明度 （0~1） 默认 1<br/>
		 * 红 （0~1） 默认 1<br/>
		 * 绿 （0~1） 默认 1<br/>
		 * 蓝 （0~1） 默认 1<br/>
		 * 
		 */
		public function ARGB(_alpha:Number=1,_red:Number=1,_green:Number=1,_blue:Number=1){
			alpha=_alpha;
			red=_red;
			green=_green;
			blue=_blue;
		}
		override public function updateParams():void{
			data[0]=red;
			data[1]=green;
			data[2]=blue;
			data[3]=alpha;
			//trace("data="+data);
		}
	}
}