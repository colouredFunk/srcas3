/***
UVTest2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月14日 22:07:13
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
/*
package{
	import flash.display.*;
	import flash.display3D.*;
	import flash.display3D.textures.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.stage3Ds.AGAL2Program;
	
	public class UVTest2{
		
		private var stage3D:Stage3D;
		private var onOutput:Function;
		
		public function UVTest2(_stage3D:Stage3D,_onOutput:Function){
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
			var vertexBuffer:VertexBuffer3D=stage3D.context3D.createVertexBuffer(4,4);
			vertexBuffer.uploadFromVector(new <Number>[
				//x,y,u,v
				-1,1,0,0,//左上角
				1,1,1,0,//右上角
				1,-1,1,1,//右下角
				-1,-1,0,1//左下角
			],0,4);
			stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_4);
			
			//vc0
			stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,
				new <Number>[
					1,0,0,0,
					0,1,0,0,
					0,0,0,0,
					0,0,0,1
				]
			);
			
			//fs0
			var texture:Texture=stage3D.context3D.createTexture(256,256,Context3DTextureFormat.BGRA,false);
			var bmd:BitmapData=new BitmapData(256,256,true,0x00000000);
			bmd.noise(0);
			texture.uploadFromBitmapData(bmd);
			stage3D.context3D.setTextureAt(0,texture);
			
			var program:Program3D=stage3D.context3D.createProgram();
			program.upload(
				AGAL2Program(
					Context3DProgramType.VERTEX,//顶点着色器
					"m44 op, va0, vc0\n"+//可节省一个 va，但是变形了
					"mov v0, va0.zwzw"
				),
				AGAL2Program(
					Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
					"tex oc, v0.xy, fs0<2d>"
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
				}else{
					onOutput();
				}
			}
		}
	}
}
//*/

///*
package{
	import flash.display.*;
	import flash.display3D.*;
	import flash.display3D.textures.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.stage3Ds.AGAL2Program;
	
	public class UVTest2{
		
		private var stage3D:Stage3D;
		private var onOutput:Function;
		
		public function UVTest2(_stage3D:Stage3D,_onOutput:Function){
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
			
			//va0 和 va1
			var vertexBuffer:VertexBuffer3D=stage3D.context3D.createVertexBuffer(4,4);
			vertexBuffer.uploadFromVector(new <Number>[
				//x,y,u,v
				-1,1,0,0,//左上角
				1,1,1,0,//右上角
				1,-1,1,1,//右下角
				-1,-1,0,1//左下角
			],0,4);
			stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
			stage3D.context3D.setVertexBufferAt(1,vertexBuffer,2,Context3DVertexBufferFormat.FLOAT_2);
			
			//vc0
			stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,
				new <Number>[
					1,0,0,0,
					0,1,0,0,
					0,0,0,0,
					0,0,0,1
				]
			);
			
			//fs0
			var texture:Texture=stage3D.context3D.createTexture(256,256,Context3DTextureFormat.BGRA,false);
			var bmd:BitmapData=new BitmapData(256,256,true,0x00000000);
			bmd.noise(0);
			texture.uploadFromBitmapData(bmd);
			stage3D.context3D.setTextureAt(0,texture);
			
			var program:Program3D=stage3D.context3D.createProgram();
			program.upload(
				AGAL2Program(
					Context3DProgramType.VERTEX,//顶点着色器
					"m44 op, va0, vc0\n"+
					"mov v0, va1"
				),
				AGAL2Program(
					Context3DProgramType.FRAGMENT,//片段着色器（好像也叫像素着色器）
					
					//1
					//"mov oc, v0" //Error: Error #3697: 取样器 0 中绑定了纹理，但在片段程序中未使用该纹理。（需要 stage3D.context3D.enableErrorChecking=true;）
					
					//2
					"tex oc, v0.xy, fs0<2d>"
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
				}else{
					onOutput();
				}
			}
		}
	}
}
//*/