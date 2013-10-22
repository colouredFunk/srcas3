/***
Pixelate
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 21:02:39
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
	
	public class Pixelate extends BaseEffect{
		
		//public static const fragmentProgram:ByteArray=getProgramByByteV();
		
		public static const fragmentProgram:ByteArray=AGAL2ByteV(
			Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
			<AGAL><![CDATA[
				div ft0.xy,v0,fc0.xy			//ft0.xy=uv/uv_dimension
				
				//以下写法不兼容我家的电脑：
				//frc ft0.zw,ft0.xy			//ft0.zw=fract(ft0.xy)
				//sub ft0.xy,ft0.xy,ft0.zw	//ft0.xy=ft0.xy-ft0.zw
				//需换成以下写法：
				frc ft1.xy,ft0.xy				//ft1.xy=fract(ft0.xy)
				sub ft0.xy,ft0.xy,ft1.xy		//ft0.xy=ft0.xy-ft1.xy
				
				mul ft0.xy,ft0.xy,fc0.xy		//ft0.xy=ft0.xy*uv_dimension
				tex oc,ft0.xy,fs0<2d>
			]]></AGAL>.toString()
			
			/*
			
			1
			tex xxx,ftn,xxx<xxx>
			ftn 需要填满 xyzw，否则报错：Error: Error #3648: AGAL 验证失败: 对于 fragment 程序的 2 令牌中的 source operand 1，可读取临时寄存器组件，但无法写入。
			如纹理尺寸为2d亦可通过 tex xxx,ftn.xy,xxx<xxx> 避免
			
			2
			此处 fc0 只需要 x(uploadBmdWid),y(uploadBmdHei),z(dimension) 三个参数，但是 data 必须补足4个数，否则将引起获取 fc0.xy 和 fc0.z 不正确
			
			*/
		);
		
		/**
		 * 
		 * 单元大小 （1~100） 默认 10
		 * 
		 */
		public var dimension:Number;
		
		/**
		 * 
		 * 单元大小 （1~100） 默认 10<br/>
		 * 
		 */
		public function Pixelate(_dimension:Number=10){
			dimension=_dimension;
		}
		override public function updateParams():void{
			data[0]=dimension/uploadBmdWid;
			data[1]=dimension/uploadBmdHei;
			data[2]=0;
			data[3]=0;
			//trace("data="+data);
		}
	}
}