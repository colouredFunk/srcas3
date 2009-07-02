package {
	public class PuzzleCube {
		private var cubeMatrix:Array;
		private var planeArray:Array;
		private var __rank:uint;
		public function PuzzleCube(_rank:uint=3) {
			__rank=_rank;
			cubeMatrix=[];
			var _x,_y,_z:uint;
			var _cubeModel:CubeModel;
			for (_x=0; _x<rank; _x++) {
				cubeMatrix[_x]=[];
				for (_y=0; _y<rank; _y++) {
					cubeMatrix[_x][_y]=[];
					for (_z=0; _z<rank; _z++) {
						_cubeModel=new CubeModel(_x,_y,_z);
						cubeMatrix[_x][_y][_z]=_cubeModel;
					}
				}
			}
			planeArray=[];
			var _xyz,_id:uint;
			var _PlaneModel:PlaneModel;
			for (_xyz=0; _xyz<3; _xyz++) {
				planeArray[_xyz]=[];
				for (_id=0; _id<rank; _id++) {
					_PlaneModel=new PlaneModel(_xyz,_id,_rank);
					_PlaneModel.cubeMatrix=cubeMatrix;
					planeArray[_xyz][_id]=_PlaneModel;
				}
			}
		}
		public function get rank():uint {
			return __rank;
		}
		public function getCube(_x:uint,_y:uint,_z:uint):* {
			return cubeMatrix[_x][_y][_z];
		}
		public function getPlane(_xyz:uint,_id:uint):* {
			return planeArray[_xyz][_id];
		}

	}
}
class PlaneModel {
	public var cubeMatrix:Array;
	private var cubeArray:Array;
	private var xyz:uint;
	private var id:uint;
	private var __rank:uint;
	private var off:Number;
	public function PlaneModel(_xyz:uint,_id:uint,_rank:uint) {
		__rank=_rank;
		off=(rank-1)*0.5;
		xyz=_xyz;
		id=_id;
	}
	public function get rank():uint {
		return __rank;
	}
	public function getCubes():Array {
		cubeArray=[];
		var _cubeModel:*;
		for (var _i:uint=0; _i<rank; _i++) {
			for (var _j:uint=0; _j<rank; _j++) {
				switch (xyz) {
					case 0 :
						_cubeModel=cubeMatrix[id][_i][_j];
						break;
					case 1 :
						_cubeModel=cubeMatrix[_i][id][_j];
						break;
					case 2 :
						_cubeModel=cubeMatrix[_i][_j][id];
						break;
				}
				cubeArray.push(_cubeModel);
			}
		}
		return cubeArray;
	}
	public function rotateCubes(_dir:int):void {
		var _cubeModel:*;
		for each (_cubeModel in cubeArray) {
			rotateCube(_cubeModel,_dir);
		}
		for each (_cubeModel in cubeArray) {
			switch (xyz) {
				case 0 :
					cubeMatrix[id][_cubeModel.y][_cubeModel.z]=_cubeModel;
					break;
				case 1 :
					cubeMatrix[_cubeModel.x][id][_cubeModel.z]=_cubeModel;
					break;
				case 2 :
					cubeMatrix[_cubeModel.x][_cubeModel.y][id]=_cubeModel;
					break;
			}
		}
	}
	private function rotateCube(_cubeModel:*,_dir:int):void {
		var _v:Array;
		var _vx,_vy,_vz:Number;

		//旋转角度向量
		_vx=_cubeModel.vx,_vy=_cubeModel.vy,_vz=_cubeModel.vz;
		switch (xyz) {
			case 0 :
				_v=rotateV(_vy,_vz,Math.PI*0.5*_dir);
				_vy=_v[0],_vz=_v[1];
				break;
			case 1 :
				_v=rotateV(_vz,_vx,Math.PI*0.5*_dir);
				_vx=_v[1],_vz=_v[0];
				break;
			case 2 :
				_v=rotateV(_vx,_vy,Math.PI*0.5*_dir);
				_vx=_v[0],_vy=_v[1];
				break;
		}
		_cubeModel.setVXYZ(_vx,_vy,_vz);

		//旋转坐标向量
		_vx=_cubeModel.x,_vy=_cubeModel.y,_vz=_cubeModel.z;
		switch (xyz) {
			case 0 :
				_v=rotateV(_vy-off,_vz-off,Math.PI*0.5*_dir);
				_vy=_v[0]+off,_vz=_v[1]+off;
				break;
			case 1 :
				_v=rotateV(_vz-off,_vx-off,Math.PI*0.5*_dir);
				_vx=_v[1]+off,_vz=_v[0]+off;
				break;
			case 2 :
				_v=rotateV(_vx-off,_vy-off,Math.PI*0.5*_dir);
				_vx=_v[0]+off,_vy=_v[1]+off;
				break;
		}
		_cubeModel.setXYZ(_vx,_vy,_vz);
	}
	private static function rotateV(_v0:Number,_v1:Number,_rot:Number):Array {
		var _c:Number=Math.cos(_rot);
		var _s:Number=Math.sin(_rot);
		return [_v0 * _c - _v1 * _s,_v0 * _s + _v1 * _c];
	}
}
class CubeModel {
	private static var vectorList:Array=[[1,1],[1,-1],[-1,-1],[-1,1]];
	public var cube:*;
	public function CubeModel(_x:uint,_y:uint,_z:uint,_vx:int=1,_vy:int=1,_vz:int=1) {
		setXYZ(_x,_y,_z);
		setVXYZ(_vx,_vy,_vz);
	}
	private var __vx,__vy,__vz:int;
	public function get vx():int {
		return __vx;
	}
	public function get vy():int {
		return __vy;
	}
	public function get vz():int {
		return __vz;
	}
	public function setVXYZ(_vx:Number,_vy:Number,_vz:Number):void {
		__vx=Math.round(_vx);
		__vy=Math.round(_vy);
		__vz=Math.round(_vz);
		trace(__vx+"___"+__vy+"___"+__vz);
	}
	private var __x,__y,__z:uint;
	public function get x():uint {
		return __x;
	}
	public function get y():uint {
		return __y;
	}
	public function get z():uint {
		return __z;
	}
	public function setXYZ(_x:Number,_y:Number,_z:Number):void {
		__x=Math.round(_x);
		__y=Math.round(_y);
		__z=Math.round(_z);
	}
}