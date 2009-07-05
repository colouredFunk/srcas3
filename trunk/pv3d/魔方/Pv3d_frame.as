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
			puzzleCube=new PuzzleCube(3);
			cubeWDH=100;
			btn_xp.release=function():void{
			rollStart(0,-1);
			};
			btn_xn.release=function():void{
			rollStart(0,1);
			};
			btn_yp.release=function():void{
			rollStart(1,-1);
			};
			btn_yn.release=function():void{
			rollStart(1,1);
			};
			btn_zp.release=function():void{
			rollStart(2,-1);
			};
			btn_zn.release=function():void{
			rollStart(2,1);
			};
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
			for (_x=0; _x<puzzleCube.rank; _x++) {
				for (_y=0; _y<puzzleCube.rank; _y++) {
					for (_z=0; _z<puzzleCube.rank; _z++) {
						_cubeModel=puzzleCube.getCube(_x,_y,_z);
						_ob={};
						_ob.left=puzzleMaterials.LEFT;
						_ob.right=puzzleMaterials.RIGHT;
						_ob.top=puzzleMaterials.TOP;
						_ob.bottom=puzzleMaterials.BOTTOM;
						_ob.back=puzzleMaterials.BACK;
						_ob.front=puzzleMaterials.FRONT;
						/*if (_cubeModel.x==0) {
						
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
						}*/
						_cube=new CubeIn(new MaterialsList(_ob),cubeWDH,cubeWDH,cubeWDH);
						_cube.model=_cubeModel;
						_cubeModel.cube=_cube;
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,rollOver_p);
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,rollOut_p);
						_cube.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,press_p);

						setRP(_cubeModel,0);
						viewCenter.addChild(_cube);
					}
				}
			}
			viewCenter.addChild(rotateOBJ);
			scene.addChild(viewCenter);
			mouseDrager=new MouseDrager(camera,viewCenter);
			mouseDrager.viewHuman=true;
			setMouse(this);
		}
		private function setRP(_cubeModel:*,_xyz:uint):void {
			var _cube:*=_cubeModel.cube;
			_cube.x=_cubeModel.x*cubeWDH-(puzzleCube.rank-1)*cubeWDH*0.5;
			_cube.y=_cubeModel.y*cubeWDH-(puzzleCube.rank-1)*cubeWDH*0.5;
			_cube.z=_cubeModel.z*cubeWDH-(puzzleCube.rank-1)*cubeWDH*0.5;
			switch (_xyz) {
				case 0 :
					//if (_cubeModel.vx>0) {
						_cube.rotationX=_cubeModel.vx;
						//Math.round((Math.atan2(_cubeModel.vz,_cubeModel.vy)-Math.PI*0.25)*180/Math.PI);
						//_cube.rotationY=Math.round((Math.atan2(_cubeModel.vx,_cubeModel.vz)-Math.PI*0.25)*180/Math.PI);
					
					//} else {
						//_cube.rotationX=360-Math.round((Math.atan2(_cubeModel.vz,_cubeModel.vy)-Math.PI*0.25)*180/Math.PI);
					//}
					break;
				case 1 :
					//if (_cubeModel.vy>0) {
						//_cube.rotationX=Math.round((Math.atan2(_cubeModel.vz,_cubeModel.vy)-Math.PI*0.25)*180/Math.PI);
						_cube.rotationY=_cubeModel.vy;
						//Math.round((Math.atan2(_cubeModel.vx,_cubeModel.vz)-Math.PI*0.25)*180/Math.PI);
					//} else {
						//_cube.rotationY=360-Math.round((Math.atan2(_cubeModel.vx,_cubeModel.vz)-Math.PI*0.25)*180/Math.PI);

					//}
					break;
				case 2 :
					//if (_cubeModel.vz>0) {
						_cube.rotationZ=_cubeModel.vz;
						//Math.round((Math.atan2(_cubeModel.vy,_cubeModel.vx)-Math.PI*0.25)*180/Math.PI);
					//} else {
						//_cube.rotationZ=360-Math.round((Math.atan2(_cubeModel.vy,_cubeModel.vx)-Math.PI*0.25)*180/Math.PI);
					//}
					break;
			}
			//trace(_cube.rotationX+"___"+_cube.rotationY+"___"+_cube.rotationZ);
		}
		private var cubeNow:*;
		private function press_p(_evt:InteractiveScene3DEvent):void {
			cubeNow=_evt.currentTarget;
			//stage.addEventListener(MouseEvent.MOUSE_UP, rollStart);
		}
		private function rollStart(_xyz:uint,_dir:int):void {
			var _e:*;
			var _obR:Object={};
			var _plane:*;
			var _cubeList:Array;
			switch (_xyz) {
				case 0 :
					_plane=puzzleCube.getPlane(_xyz,cubeNow.model.x);
					_obR.rotationX=String(90*_dir);
					break;
				case 1 :
					_plane=puzzleCube.getPlane(_xyz,cubeNow.model.y);
					_obR.rotationY=String(90*_dir);
					break;
				case 2 :
					_plane=puzzleCube.getPlane(_xyz,cubeNow.model.z);
					_obR.rotationZ=String(90*_dir);
					break;
			}
			_cubeList=_plane.getCubes();
			for each (_e in _cubeList) {
				viewCenter.removeChild(_e.cube);
				rotateOBJ.addChild(_e.cube);
			}
			_obR.onComplete=function():void{
			_plane.rotateCubes(_dir);
			for each(_e in _cubeList){
			setRP(_e,_xyz);
			rotateOBJ.removeChild(_e.cube);
			viewCenter.addChild(_e.cube);
			}
			rotateOBJ.rotationX=0;
			rotateOBJ.rotationY=0;
			rotateOBJ.rotationZ=0;
			};
			TweenLite.to(rotateOBJ,0.5,_obR);
			//stage.removeEventListener(MouseEvent.MOUSE_UP, rollStart);
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

class CubeIn extends Cube {
	public var model:*;
	public function CubeIn( materials:MaterialsList, width:Number=500, depth:Number=500, height:Number=500, segmentsS:int=1, segmentsT:int=1, segmentsH:int=1, insideFaces:int=0, excludeFaces:int=0 ) {
		super( materials, width, depth, height, segmentsS, segmentsT, segmentsH, insideFaces, excludeFaces);
	}
}