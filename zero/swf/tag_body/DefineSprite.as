﻿/***
DefineSprite 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月7日 03:27:59 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.tag_body{
	import zero.swf.DataAndTags;
	import flash.utils.ByteArray;
	public class DefineSprite extends TagBody{
		public var id:int;								//UI16
		public var dataAndTags:DataAndTags;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			id=data[offset]|(data[offset+1]<<8);
			//#offsetpp
			offset+=2;
			dataAndTags=new DataAndTags();
			return dataAndTags.initByData(data,offset,endOffset);
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			data[0]=id;
			data[1]=id>>8;
			data.position=2;
			data.writeBytes(dataAndTags.toData());
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<DefineSprite
				id={id}
			>
				<dataAndTags/>
			</DefineSprite>;
			xml.dataAndTags.appendChild(dataAndTags.toXML());
			return xml;
		}
		override public function initByXML(xml:XML):void{
			id=int(xml.@id.toString());
			dataAndTags=new DataAndTags();
			dataAndTags.initByXML(xml.dataAndTags.children()[0]);
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}