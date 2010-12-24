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

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/