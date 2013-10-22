/***
FRCTest
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月14日 23:27:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package{
	import flash.display.*;
	import flash.display3D.*;
	import flash.display3D.textures.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.stage3Ds.AGAL2Program;
	
	public class FRCTest{
		
		private var stage3D:Stage3D;
		private var onOutput:Function;
		
		public function FRCTest(_stage3D:Stage3D,_onOutput:Function){
			stage3D=_stage3D;
			//trace("stage3D="+stage3D);
			onOutput=_onOutput;
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.requestContext3D();
		}
		private function createContext3D(...args):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.context3D.enableErrorChecking=true;
			
			stage3D.context3D.configureBackBuffer(256,256,0,false);
			
			//va0
			var vertexBuffer:VertexBuffer3D=stage3D.context3D.createVertexBuffer(4,2);
			vertexBuffer.uploadFromVector(new <Number>[
				//x,y
				-1,1,//左上角
				1,1,//右上角
				1,-1,//右下角
				-1,-1//左下角
			],0,4);
			stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
			
			//vc0
			stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,
				new <Number>[
					1,0,0,0,
					0,1,0,0,
					0,0,0,0,
					0,0,0,1
				]
			);
			stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,new <Number>[0.7,-0.3,0,1]);
			
			var program:Program3D=stage3D.context3D.createProgram();
			program.upload(
				AGAL2Program(
					Context3DProgramType.VERTEX,//顶点着色器
					"m44 op, va0, vc0"
				),
				AGAL2Program(
					Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
					"mov ft0, fc0\n"+
					
					//1
					"mov oc, ft0"//暗红色，QQ截图显示：RGB:(178,0,0)
					
					//2
					//"frc oc, ft0"//屎黄色，QQ截图显示：RGB:(178,178,0)，证明 frc 确实是 x-floor(x)，frc(0.7)=0.7，frc(-0.3)=0.7（而不是 0.3）
				)
			);
			stage3D.context3D.setProgram(program);
			
			stage3D.context3D.clear();
			
			var indexBuffer:IndexBuffer3D=stage3D.context3D.createIndexBuffer(6);
			indexBuffer.uploadFromVector(new <uint>[0,1,2,2,3,0],0,6);
			stage3D.context3D.drawTriangles(indexBuffer);
			
			if(onOutput==null){
				stage3D.context3D.present();
			}else{
				if(onOutput.length==1){
					var outputBmd:BitmapData=new BitmapData(256,256,true,0x00000000);
					stage3D.context3D.drawToBitmapData(outputBmd);
					onOutput(outputBmd);
					//trace("0x"+outputBmd.getPixel32(0,0).toString(16));
				}else{
					onOutput();
				}
			}
		}
	}
}