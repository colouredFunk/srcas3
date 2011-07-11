/***
LineExp 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月20日 16:01:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.exps{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	
	public class LineExp extends Exp{
		public function LineExp(...args){
			getDotV.apply(this,args);
		}
		override public function getValues(dot:DisplayObject,centerX:Number,centerY:Number):Object{
			var m:Matrix3D=new Matrix3D();
			//m.pointAt(new Vector3D(Math.random()-0.5,Math.random()-0.5,Math.random()-0.5));
			m.pointAt(new Vector3D(Math.random()-0.5,Math.random()-0.5,-1));
			dot.transform.matrix3D=m;
			
			return {
				m_rawData:m.rawData,
				speed:Math.random()*16+16,
				delayTime:Math.random()*16+40
			}
		}
		override public function dotRun(dot:DisplayObject,values:Object):Boolean{
			if(values.delayTime<=0){
				return false;
			}
			values.speed*=0.9;
			
			values.m_rawData[12]+=values.m_rawData[4]*values.speed;
			values.m_rawData[13]+=values.m_rawData[5]*values.speed;
			values.m_rawData[14]+=values.m_rawData[6]*values.speed;
			dot.transform.matrix3D.rawData=values.m_rawData;
			
			if(--values.delayTime<20){
				dot.alpha=0.05*values.delayTime;
			}
			return true;
		}
	}
}

