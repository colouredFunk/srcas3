package {
	import flash.events.MouseEvent;

	import pv3d.*;
	import gs.TweenLite;
	
	import org.papervision3d.events.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.primitives.Cube;

	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.MovieAssetMaterial;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.BitmapFileMaterial;
	
	import org.papervision3d.events.InteractiveScene3DEvent;

	public class Pv3d_frame extends PvBase_2 {
		private var mouseDrager:MouseDrager;
		private var viewCenter:DisplayObject3D;
		private var puzzleMaterials:Object;
		public function Pv3d_frame() {
			init(550,400,true);
		}
		private var puzzleCube:PuzzleCube;
		private var cubeWDH:uint;
		override protected function init2d():void {
			puzzleCube=new PuzzleCube();
			cubeWDH=100;
		}
		private var rotateOBJ:DisplayObject3D;
		override protected function init3d():void {
			viewport.interactive=true;
			puzzleMaterials={};
			/*puzzleMaterials.LEFT=new ColorMaterial(0xff0000,1,true);
			puzzleMaterials.RIGHT=new ColorMaterial(0x0000ff,1,true);
			puzzleMaterials.TOP=new ColorMaterial(0xffff00,1,true);
			puzzleMaterials.BOTTOM=new ColorMaterial(0x00ffff,1,true);
			puzzleMaterials.BACK=new ColorMaterial(0x00ff00,1,true);
			puzzleMaterials.FRONT=new ColorMaterial(0x00ff00,1,true);
			puzzleMaterials.NAN=new ColorMaterial(0xFF00FF,0);*/
			puzzleMaterials.LEFT=new MovieAssetMaterial("leftM");
			puzzleMaterials.LEFT.interactive=true;
			puzzleMaterials.RIGHT=new MovieAssetMaterial("rightM");
			puzzleMaterials.RIGHT.interactive=true;
			puzzleMaterials.TOP=new MovieAssetMaterial("topM");
			puzzleMaterials.TOP.interactive=true;
			puzzleMaterials.BOTTOM=new MovieAssetMaterial("bottomM");
			puzzleMaterials.BOTTOM.interactive=true;
			puzzleMaterials.BACK=new MovieAssetMaterial("backM");
			puzzleMaterials.BACK.interactive=true;
			puzzleMaterials.FRONT=new MovieAssetMaterial("frontM");
			puzzleMaterials.FRONT.interactive=true;
			puzzleMaterials.NAN=new ColorMaterial(0xFF00FF,0);
			viewCenter = new DisplayObject3D();
			rotateOBJ= new DisplayObject3D();
			var _cubeModel:*;
			var _cube:*;
			var _ob:Object;
			var _x,_y,_z:int;
			for (_x=0; _x<3; _x++) {
				for (_y=0; _y<3; _y++) {
					for (_z=0; _z<3; _z++) {
						_cubeModel=puzzleCube.getCube(_x,_y,_z);
						_ob={};
						_ob.left=puzzleMaterials.NAN;
						_ob.right=puzzleMaterials.NAN;
						_ob.top=puzzleMaterials.NAN;
						_ob.bottom=puzzleMaterials.NAN;
						_ob.back=puzzleMaterials.NAN;
						_ob.front=puzzleMaterials.NAN;
						if (_cubeModel.x==0) {
							
						} else if (_cubeModel.x>0) {
							_ob.right=puzzleMaterials.RIGHT;
						} else {
							_ob.left=puzzleMaterials.LEFT;
						}
						if (_cubeModel.y==0) {
							
						} else if (_cubeModel.y>0) {
							_ob.bottom=puzzleMaterials.BOTTOM;
						} else {
							_ob.top=puzzleMaterials.TOP;
						}
						if (_cubeModel.z==0) {
							
						} else if (_cubeModel.z>0) {
							_ob.front=puzzleMaterials.FRONT;
						} else {
							_ob.back=puzzleMaterials.BACK;
						}
						_cube=new CubeIn(new MaterialsList(_ob),cubeWDH,cubeWDH,cubeWDH);
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,rollOver_p);
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,rollOut_p);
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,press_p);
						_cube.x=_cubeModel.x*cubeWDH;
						_cube.y=- _cubeModel.y*cubeWDH;
						_cube.z=_cubeModel.z*cubeWDH;
						_cube.model=_cubeModel;
						_cubeModel.cube=_cube;
						scene.addChild(_cube);
					}
				}
			}
			scene.addChild(rotateOBJ);
			mouseDrager=new MouseDrager(camera,viewCenter);
			mouseDrager.viewHuman=true;
			setMouse(this);
			/*var _ary:Array=puzzleCube.getPlane(0,0).getCubes();
			for each(var _e:* in _ary){
				rotateOBJ.addChild(_e.cube);
			}
			TweenLite.to(rotateOBJ,0.5,{rotationX:"180"});*/
			//rotateOBJ.pitch(-90);
			//scene.removeChild(rotateOBJ);
		}
		private var cubeNow:*;
		private function press_p(_evt:InteractiveScene3DEvent):void {
			cubeNow=_evt.currentTarget;
			stage.addEventListener(MouseEvent.MOUSE_UP, rollStart);
		}
		private var aPlane:Array;
		private function rollStart(_evt:MouseEvent):void {
			if(aPlane){
				for each(var _e0:* in aPlane){
					rotateOBJ.removeChild(_e0.cube);
				}
			}
			var _rdm:int=Common.random(2);
			rotateOBJ.rotationX=0;
			rotateOBJ.rotationY=0;
			rotateOBJ.rotationZ=0;
			if(_rdm==0){
				aPlane=puzzleCube.getPlane(0,cubeNow.model.x+1).getCubes();
			TweenLite.to(rotateOBJ,0.5,{rotationX:"90"});
			}else if(_rdm==1){
				aPlane=puzzleCube.getPlane(1,cubeNow.model.y+1).getCubes();
			TweenLite.to(rotateOBJ,0.5,{rotationY:"90"});
			}else{
				aPlane=puzzleCube.getPlane(2,cubeNow.model.z+1).getCubes();
			TweenLite.to(rotateOBJ,0.5,{rotationZ:"90"});
			}
			for each(var _e1:* in aPlane){
				rotateOBJ.addChild(_e1.cube);
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, rollStart);
		}
		private function rollOver_p(_evt:InteractiveScene3DEvent):void {
			//rollOut_p(null);
			
			//TweenLite.to(cubeNow,0.3,{scale:1.5});
		}
		private function rollOut_p(_evt:InteractiveScene3DEvent):void {
			//if(cubeNow){
				//TweenLite.to(cubeNow,0.3,{scale:1});
			//}
		}
		public function setMouse(_obj:*=null):void {
			if (_obj==null) {
				_obj=stage;
			}
			background.addEventListener(MouseEvent.MOUSE_DOWN, mouseDrager.onMouseClick);
			_obj.addEventListener(MouseEvent.MOUSE_WHEEL, mouseDrager.onWheel_handle);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseDrager.onMouseClick);
		}
		private var xAxis:Number3D=new Number3D(1,0,0);
		private var viewUpAxis:Number3D=new Number3D();
		override protected function processFrame():void {
			if (! mouseDrager.process()) {
				//viewCenter.rotationY-=0.5;
			}
			viewUpAxis.x=viewCenter.x-camera.x;
			viewUpAxis.y=viewCenter.y-camera.y;
			viewUpAxis.z=viewCenter.z-camera.z;
			viewUpAxis=Number3D.cross(xAxis,viewUpAxis);
			camera.lookAt(viewCenter,viewUpAxis);
			renderer.renderScene(scene,camera,viewport);
		}
	}
}
import org.papervision3d.objects.primitives.Cube;
import org.papervision3d.materials.utils.MaterialsList;

class CubeIn extends Cube{
	public var model:*;
	public function CubeIn( materials:MaterialsList, width:Number=500, depth:Number=500, height:Number=500, segmentsS:int=1, segmentsT:int=1, segmentsH:int=1, insideFaces:int=0, excludeFaces:int=0 ){
		super( materials, width, depth, height, segmentsS, segmentsT, segmentsH, insideFaces, excludeFaces);
	}
}