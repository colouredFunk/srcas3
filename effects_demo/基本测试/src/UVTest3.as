/***
UVTest3
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月15日 16:24:34
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
	
	public class UVTest3{
		
		private var stage3D:Stage3D;
		private var onOutput:Function;
		
		public function UVTest3(_stage3D:Stage3D,_onOutput:Function){
			stage3D=_stage3D;
			//trace("stage3D="+stage3D);
			onOutput=_onOutput;
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.requestContext3D();
		}
		private function createContext3D(...args):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			
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
			stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
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
			
			////fs0
			//var texture:Texture=stage3D.context3D.createTexture(4,1,Context3DTextureFormat.BGRA,false);
			////4x1 的图片，从左至右颜色依次是 红，绿，蓝，白
			//var bmd:BitmapData=new BitmapData(4,1,true,0x00000000);
			//bmd.setPixel32(0,0,0xffff0000);
			//bmd.setPixel32(1,0,0xff00ff00);
			//bmd.setPixel32(2,0,0xff0000ff);
			//bmd.setPixel32(3,0,0xffffffff);
			//texture.uploadFromBitmapData(bmd);
			//stage3D.context3D.setTextureAt(0,texture);
			
			//px        0          1         2         3
			//u    0   1/8        3/8       5/8       7/8   1
			//     |　　红　　|　　绿　　|　　蓝　　|　　白　　|
			
			//已知 px 求 u：u=(px+0.5)/wid
			//已知 u 求 px：px=floor(u*wid)
			
			//fs0
			var texture:Texture=stage3D.context3D.createTexture(256,256,Context3DTextureFormat.BGRA,false);
			var bmd:BitmapData=new BitmapData(256,256,true,0x00000000);
			for(var y:int=0;y<256;y++){
				for(var x:int=0;x<256;x++){
					switch(x){
						case 0:
						case 63:
							bmd.setPixel32(x,y,0xffff0000);
						break;
						case 64:
						case 127:
							bmd.setPixel32(x,y,0xff00ff00);
						break;
						case 128:
						case 191:
							bmd.setPixel32(x,y,0xff0000ff);
						break;
						case 192:
						case 255:
							bmd.setPixel32(x,y,0xffffffff);
						break;
						default:
							bmd.setPixel32(x,y,0xff000000);
						break;
					}
				}
			}
			texture.uploadFromBitmapData(bmd);
			stage3D.context3D.setTextureAt(0,texture);
			
			//fc0
			stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,new <Number>[
				
				//(-2+0.5)/256 //黑
				//(-1+0.5)/256 //白
				//-0.01/256 //白
				
				//0/256 //红
				//(0+0.5)/256 //红
				//(1+0.5)/256 //黑
				//(62+0.5)/256 //黑
				//(63+0.5)/256 //红
				//63.99/256 //红
				
				//64/256 //绿
				//(64+0.5)/256 //绿
				//(65+0.5)/256 //黑
				//(126+0.5)/256 //黑
				//(127+0.5)/256 //绿
				//127.99/256 //绿
				
				//128/256 //蓝
				//(128+0.5)/256 //蓝
				//(129+0.5)/256 //黑
				//(190+0.5)/256 //黑
				//(191+0.5)/256 //蓝
				//191.99/256 //蓝
				
				//192/256 //白
				//(192+0.5)/256 //白
				//(193+0.5)/256 //黑
				//(254+0.5)/256 //黑
				//(255+0.5)/256 //白
				//255.99/256 //白
				
				//256/256 //红（clamp 模式下能“正确的获取白色）
				//(256+0.5)/256 //红	
				//(257+0.5)/256 //黑
				
				
				//-0.00003055 //白
				
				//-0.00003054 //红
				//0 //红
				//1/256 //黑
				//1/255 //黑
				//62/256 //黑
				//62/255 //黑
				//63/256 //红
				//63/255 //红
				
				//64/256 //绿
				//64/255 //绿
				//65/256 //黑
				//65/255 //黑
				//126/256 //黑
				//126/255 //黑
				//127/256 //绿
				//127/255 //绿
				
				//128/256 //蓝
				//128/255 //蓝
				//65/256 //黑
				//65/255 //黑
				//190/256 //黑
				//190/255 //黑
				//191/256 //蓝
				//191/255 //蓝
				
				//192/256 //白
				//192/255 //白
				//193/256 //黑
				//193/255 //黑
				//254/256 //黑
				//254/255 //白
				//255/256 //白
				//1-0.00003055 //白
				
				1-0.00003054 //红
				//1 //红
			,0,0,0]);
			
			
			
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
					"tex oc, v0.xy, fs0<2d,repeat>"//红绿蓝白
					
					//2
					//"tex oc, fc0.xy, fs0<2d,repeat>"
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