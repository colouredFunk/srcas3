package {
	public class PuzzleCube {
		private var cubeMatrix:Array;
		private var planeArray:Array;
		public function PuzzleCube() {
			cubeMatrix=[];
			var _x,_y,_z:int;
			var _cubeModel:CubeModel;
			for (_x=0; _x<3; _x++) {
				cubeMatrix[_x]=[];
				for (_y=0; _y<3; _y++) {
					cubeMatrix[_x][_y]=[];
					for (_z=0; _z<3; _z++) {
						_cubeModel=new CubeModel(_x-1,_y-1,_z-1);
						cubeMatrix[_x][_y][_z]=_cubeModel;
					}
				}
			}
			planeArray=[];
			var _xyz,_id:int;
			var _PlaneModel:PlaneModel;
			for (_xyz=0; _xyz<3; _xyz++) {
				planeArray[_xyz]=[];
				for (_id=0; _id<3; _id++) {
					_PlaneModel=new PlaneModel(_xyz,_id);
					_PlaneModel.setCubes(cubeMatrix);
					planeArray[_xyz][_id]=_PlaneModel;
				}
			}
		}
		public function getCube(_x:int,_y:int,_z:int):*{
			return cubeMatrix[_x][_y][_z];
		}
		public function getPlane(_xyz:int,_id:int):*{
			return planeArray[_xyz][_id];
		};
	}
}
class PlaneModel {
	private var cubeArray:Array;
	private var xyz:int;
	private var id:int;
	public function PlaneModel(_xyz:int,_id:int) {
		xyz=_xyz;
		id=_id;
		cubeArray=[];
		for (var _i:int=0; _i<3; _i++) {
			cubeArray[_i]=[];
		}
	}
	public function getCubes():Array{
		var _aTemp:Array=[];
		for (var _i:int=0; _i<3; _i++) {
			for (var _j:int=0; _j<3; _j++) {
				_aTemp.push(cubeArray[_i][_j]);
			}
		}
		return _aTemp;
	}
	public function setCubes(_cubeMatrix:Array):void {
		for (var _i:int=0; _i<3; _i++) {
			for (var _j:int=0; _j<3; _j++) {
				switch (xyz) {
					case 0 :
						cubeArray[_i][_j]=_cubeMatrix[id][_i][_j];
						break;
					case 1 :
						cubeArray[_i][_j]=_cubeMatrix[_i][id][_j];
						break;
					case 2 :
						cubeArray[_i][_j]=_cubeMatrix[_i][_j][id];
						break;
				}
			}
		}
	}
}
class CubeModel {
	public var cube:*;
	public function CubeModel(_x:int,_y:int,_z:int) {
		setXYZ(_x,_y,_z);
	}
	private var __x,__y,__z:int;
	public function get x():int {
		return __x;
	}
	public function get y():int {
		return __y;
	}
	public function get z():int {
		return __z;
	}
	public function setXYZ(_x:int,_y:int,_z:int):void {
		__x=_x;
		__y=_y;
		__z=_z;
	}
}