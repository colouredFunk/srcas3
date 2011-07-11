/***
MoveCamera 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年3月26日 09:43:55
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.zero3D.cameras{
	import zero.zero3D.*;
	import zero.zero3D.objs.*;
	public class MoveCamera extends Camera3D{
		public function MoveCamera(_scene3D:Scene3D,_dScreen:Number){
			super(_scene3D,_dScreen);
		}
		public function move(speed:Number):void{
			//向 y 方向前进
			var rawData:Vector.<Number>=matrix3D.rawData;
			rawData[12]+=rawData[4]*speed;
			rawData[13]+=rawData[5]*speed;
			rawData[14]+=rawData[6]*speed;
			matrix3D.rawData=rawData;
		}
	}
}

