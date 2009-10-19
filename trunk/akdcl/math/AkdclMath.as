package akdcl.math{
	public class AkdclMath {
		import flash.utils.getTimer;
		public function AkdclMath() {
		}
		public static function fac(N:int):Number {
			//全称factorial阶乘
			var outN:Number=1;
			for (var i:int=1; i<=N; i++) {
				outN*=i;
			}
			return outN;
		}
		public static function comb(A:uint,B:uint):Number {
			//全称Combination A中B项的组合数
			var outN:Number;
			if (B>A) {
				outN=-1;
			} else {
				outN=fac(A)/(fac(A-B)*fac(B));
			}
			return outN;
		}
		public static function fullComb(N:uint):Number {
			//全组合，即P10-1到P10-10的和
			var outN:Number=0;
			for (var i:uint=1; i<=N; i++) {
				outN+=comb(N,i);
			}
			return outN;
		}
		public static function addup(N:int):Number {
			//累加
			var outN:Number=(1+N)/2*N;
			return outN;
		}
		public static function getComb(List:Array,amount:uint):Array {
			var opA:Array=[Math.pow(2,amount)-1];
			var outA:Array=new Array();
			amount<List.length&&operationComb(opA[0],List.length,opA);
			for (var i:int=0; i<opA.length; i++) {
				outA.push(getNameByCode(opA[i],List));
			}
			return outA;
		}
		public static function getMax(n:Array):Array {
			var test:Boolean=false;
			n[0]>n[1]?n.splice(1,1):n.splice(0,1);
			if (n.length>1) {
				test=true;
				n=getMax(n);
			}
			return n;
		}
		public static function getMin(n:Array):Array {
			var test:Boolean=false;
			n[0]<n[1]?n.splice(1,1):n.splice(0,1);
			if (n.length>1) {
				test=true;
				n=getMin(n);
			}
			return n;
		}
		//-----------------------
		static protected function operationComb(N:Number,Max:uint,inA:Array):void {
			var nowlevel:Array=N.toString(2).split("").reverse();
			for (var u:int=-1; u<nowlevel.length; u++) {
				if (! nowlevel[u]) {
					break;
				}
			}
			if (u<Max-1) {
				var now:uint=N.toString(2).length-1;
				for (var i:int=now; i>=0; i--) {
					N+=Math.pow(2,i);
					if (N&Math.pow(2,i)) {
						break;
					}
					if (N.toString(2).length<Max) {
						operationComb(N,Max,inA);
					}
					inA.push(N);
				}
			}
		}
		static protected function getNameByCode(code:uint,List:Array):String {
			var outString:String="";
			for (var i:uint=0; i<List.length; i++) {
				if (code&Math.pow(2,i)) {
					outString+=List[i];
				}
			}
			return outString;
		}
	}
}