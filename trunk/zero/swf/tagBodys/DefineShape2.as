﻿/***
DefineShape2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 14:54:30 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tagBodys{
	import zero.swf.records.RECT;
	import zero.swf.records.SHAPEWITHSTYLE;
	import flash.utils.ByteArray;
	public class DefineShape2{
		public var id:int;								//UI16
		public var ShapeBounds:RECT;
		public var Shapes:SHAPEWITHSTYLE;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			offset+=2;
			ShapeBounds=new RECT();
			offset=ShapeBounds.initByData(data,offset,endOffset);
			
			Shapes=new SHAPEWITHSTYLE();
			return Shapes.initByData(data,offset,endOffset);
		}
		public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(ShapeBounds.toData());
			data.writeBytes(Shapes.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		public function toXML():XML{
			var xml:XML=<DefineShape2
				id={id}
			>
				<ShapeBounds/>
				<Shapes/>
			</DefineShape2>;
			xml.ShapeBounds.appendChild(ShapeBounds.toXML());
			xml.Shapes.appendChild(Shapes.toXML());
			return xml;
		}
		public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			ShapeBounds=new RECT();
			ShapeBounds.initByXML(xml.ShapeBounds.children()[0]);
			Shapes=new SHAPEWITHSTYLE();
			Shapes.initByXML(xml.Shapes.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}