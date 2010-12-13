/***
BitsFillShapeGetter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年12月7日 19:07:08
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.records.*;
	import zero.swf.records.shapeRecords.*;
	import zero.swf.records.fillStyles.*;
	import zero.swf.records.lineStyles.*;
	import zero.swf.tagBodys.DefineShape;
	
	public class BitsFillShapeGetter{
		public static function getBitsFillShape(
			id:int,
			BitmapId:int,
			BitmapWid:int,
			BitmapHei:int
		):DefineShape{
			var defineShape:DefineShape=new DefineShape();
			
			defineShape.id=id;
			
			defineShape.ShapeBounds=new RECT();
			defineShape.ShapeBounds.Xmin=0;
			defineShape.ShapeBounds.Xmax=BitmapWid*20;
			defineShape.ShapeBounds.Ymin=0;
			defineShape.ShapeBounds.Ymax=BitmapHei*20;
			
			defineShape.Shapes=new SHAPEWITHSTYLE();
			defineShape.Shapes.FillStyleV=new Vector.<FILLSTYLE>();
			defineShape.Shapes.LineStyleV=new Vector.<BaseLineStyle>();
			defineShape.Shapes.NumFillBits=1;
			defineShape.Shapes.NumLineBits=0;
			
			var FillStyle:FILLSTYLE=new FILLSTYLE();
			FillStyle.FillStyleType=0x43;
			FillStyle.BitmapId=BitmapId;
			FillStyle.BitmapMatrix=new MATRIX();
			FillStyle.BitmapMatrix.HasScale=1;
			FillStyle.BitmapMatrix.ScaleX=1310720;
			FillStyle.BitmapMatrix.ScaleY=1310720;
			defineShape.Shapes.FillStyleV[0]=FillStyle;
			
			defineShape.Shapes.ShapeRecordV=new Vector.<SHAPERECORD>();
			var styleChangeRecord:STYLECHANGERECORD=new STYLECHANGERECORD();
			styleChangeRecord.StateFillStyle1=1;
			styleChangeRecord.FillStyle1=1;
			defineShape.Shapes.ShapeRecordV[0]=styleChangeRecord;
			
			var shapeRecord:STRAIGHTEDGERECORD;
			
			shapeRecord=new STRAIGHTEDGERECORD();
			shapeRecord.DeltaX=defineShape.ShapeBounds.Xmax;
			defineShape.Shapes.ShapeRecordV[1]=shapeRecord;
			
			shapeRecord=new STRAIGHTEDGERECORD();
			shapeRecord.VertLineFlag=1;
			shapeRecord.DeltaY=defineShape.ShapeBounds.Ymax;
			defineShape.Shapes.ShapeRecordV[2]=shapeRecord;
			
			shapeRecord=new STRAIGHTEDGERECORD();
			shapeRecord.DeltaX=-defineShape.ShapeBounds.Xmax;
			defineShape.Shapes.ShapeRecordV[3]=shapeRecord;
			
			shapeRecord=new STRAIGHTEDGERECORD();
			shapeRecord.VertLineFlag=1;
			shapeRecord.DeltaY=-defineShape.ShapeBounds.Ymax;
			defineShape.Shapes.ShapeRecordV[4]=shapeRecord;
			
			return defineShape;
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