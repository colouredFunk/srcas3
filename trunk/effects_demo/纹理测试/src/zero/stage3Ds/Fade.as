/***
Fade
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月11日 20:19:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds{
	import flash.display.*;
	import flash.display3D.*;
	import flash.display3D.textures.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import zero.stage3Ds.effects.BaseEffect;

	public class Fade{
		
		//private static const vertexProgram:ByteArray=getProgramByByteV(0xa0,0x01,0x00,0x00,0x00,0xa1,0x00,0x18,0x00,0x00,0x00,0x00,0x00,0x0f,0x03,0x00,0x00,0x00,0xe4,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xe4,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0f,0x04,0x01,0x00,0x00,0xe4,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00);
		private static const vertexProgram:ByteArray=AGAL2ByteV(
			Context3DProgramType.VERTEX,//顶点着色器
			
			"m44 op, va0, vc0\n" + 
			//可理解为：op=vc0.transformVector(va0)
			//vc<n>，用于顶点着色器的常量寄存器，vc0 在这里就是 stage3D.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,new Matrix3D(),true); 中的 new Matrix()
			//va<n>，用于顶点着色器的属性寄存器，va0 在这里就是 stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3); 中的 vertexBuffer 的 xyz 们
			//op，用于顶点着色器的输出寄存器
			
			"mov v0, va1"
			//可理解为：v0=va1
			//va1 在这里就是 stage3D.context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2); 中的 vertexBuffer 的 uv 们
			//v<n>，变寄存器，用来从顶点着色器传递数据到像素着色器，以这种方式获取传递的典型数据是顶点颜色，或 纹理UV 坐标。
		);
		
		private static var stage3D:Stage3D;
		private static var onInitComplete:Function;
		
		private static var texture:Texture;
		private static var program:Program3D;
		private static var vertexBuffer:VertexBuffer3D;
		private static var indexBuffer:IndexBuffer3D;
		
		private static var effect:BaseEffect;
		
		private static const vertices:Vector.<Number>=new <Number>[
			//x,y,z,u,v
			-1,1,0,0,0,//左上角
			1,1,0,0,0,//右上角
			1,-1,0,0,0,//右下角
			-1,-1,0,0,0//左下角
		];
		private static const indices:Vector.<uint>=new <uint>[0,1,2,2,3,0];
		
		public static function init(_stage3D:Stage3D,_onInitComplete:Function):void{
			
			clear();
			
			if(_stage3D){
			}else{
				throw new Error("_stage3D="+_stage3D);
				return;
			}
			
			stage3D=_stage3D;
			onInitComplete=_onInitComplete;
			//trace("stage3D="+stage3D);
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			stage3D.requestContext3D();
		}
		public static function clear():void{
			if(stage3D){
				stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
				stage3D=null;
			}
			onInitComplete=null;
			if(texture){
				texture.dispose();
				texture=null;
			}
			if(program){
				program.dispose();
				program=null;
			}
			if(vertexBuffer){
				vertexBuffer.dispose();
				vertexBuffer=null;
			}
			effect=null;
		}
		private static function createContext3D(...args):void{
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE,createContext3D);
			
			stage3D.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,new Matrix3D(),true);
			
			indexBuffer=stage3D.context3D.createIndexBuffer(6);
			indexBuffer.uploadFromVector(indices,0,6);
			
			if(onInitComplete==null){
			}else{
				onInitComplete();
				onInitComplete=null;
			}
		}
		public static function initEffect(bmd:BitmapData,_effect:BaseEffect):void{
			if(texture){
				texture.dispose();
			}
			if(program){
				program.dispose();
			}
			if(vertexBuffer){
				vertexBuffer.dispose();
			}
			
			stage3D.context3D.configureBackBuffer(bmd.width,bmd.height,2,true);
			
			var uploadBmdWid:int=1;
			while(uploadBmdWid<bmd.width){
				uploadBmdWid<<=1;
			}
			var uploadBmdHei:int=1;
			while(uploadBmdHei<bmd.height){
				uploadBmdHei<<=1;
			}
			
			effect=_effect;
			effect.wid=bmd.width;
			effect.hei=bmd.height;
			effect.uploadBmdWid=uploadBmdWid;
			effect.uploadBmdHei=uploadBmdHei;
			
			//trace(bmd.width+"x"+bmd.height);
			//trace(uploadBmdWid+"x"+uploadBmdHei);
			var uploadBmd:BitmapData=new BitmapData(uploadBmdWid,uploadBmdHei,true,0x00000000);
			uploadBmd.copyPixels(bmd,bmd.rect,new Point());
			
			texture=stage3D.context3D.createTexture(uploadBmdWid,uploadBmdHei,Context3DTextureFormat.BGRA,false);
			texture.uploadFromBitmapData(uploadBmd);
			uploadBmd.dispose();
			uploadBmd=null;
			stage3D.context3D.setTextureAt(0,texture);
			
			program=stage3D.context3D.createProgram();
			program.upload(vertexProgram,effect["constructor"].fragmentProgram);
			stage3D.context3D.setProgram(program);
			
			vertices[8]=vertices[13]=bmd.width/uploadBmdWid;
			vertices[14]=vertices[19]=bmd.height/uploadBmdHei;
			
			//trace("vertices="+vertices.toString().replace(/(([^,]+,){5})/g,"$1\n"));
			//trace("indices="+indices.toString().replace(/(([^,]+,){6})/g,"$1\n"));
			
			vertexBuffer=stage3D.context3D.createVertexBuffer(4,5);
			vertexBuffer.uploadFromVector(vertices,0,4);
			
			// vertex position to attribute register 0
			stage3D.context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			// UV to attribute register 1
			stage3D.context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
			
		}
		public static function update(outputBmd:BitmapData):void{
			stage3D.context3D.clear();
			effect.updateParams();
			if(effect.data.length){
				if(effect.data.length%4==0){
					stage3D.context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,effect.data);
				}else{
					throw new Error("effect.data.length="+effect.data.length+" 不是 4 的倍数");
				}
			}
			stage3D.context3D.drawTriangles(indexBuffer);
			if(outputBmd){
				stage3D.context3D.drawToBitmapData(outputBmd);
			}else{
				stage3D.context3D.present();
			}
		}
	}
}