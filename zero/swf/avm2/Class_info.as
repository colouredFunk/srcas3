/***
Class_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月2日 20:19:34 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The class_info entry is used to define characteristics of an ActionScript 3.0 class.
//class_info
//{
//	u30 cinit
//	u30 trait_count
//	traits_info traits[trait_count]
//}

//This is an index into the method array of the abcFile; it references the method that is invoked when the
//class is first created. This method is also known as the static initializer for the class.

//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
//for the class (see above for information on traits).
package zero.swf.avm2{
	import zero.swf.avm2.Traits_info;
	import flash.utils.ByteArray;
	public class Class_info extends AVM2Obj{
		public var cinit:int;							//u30
		public var ctraits_infoV:Vector.<Traits_info>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{cinit=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{cinit=data[offset++];}
			//cinit
			
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var ctraits_info_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{ctraits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{ctraits_info_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{ctraits_info_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{ctraits_info_count=data[offset++];}
			//ctraits_info_count
			ctraits_infoV=new Vector.<Traits_info>(ctraits_info_count);
			for(var i:int=0;i<ctraits_info_count;i++){
			
				ctraits_infoV[i]=new Traits_info();
				offset=ctraits_infoV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(cinit>>>7){if(cinit>>>14){if(cinit>>>21){if(cinit>>>28){data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=((cinit>>>14)&0x7f)|0x80;data[offset++]=((cinit>>>21)&0x7f)|0x80;data[offset++]=cinit>>>28;}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=((cinit>>>14)&0x7f)|0x80;data[offset++]=cinit>>>21;}}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=cinit>>>14;}}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=cinit>>>7;}}else{data[offset++]=cinit;}
			//cinit
			var ctraits_info_count:int=ctraits_infoV.length;
			
			if(ctraits_info_count>>>7){if(ctraits_info_count>>>14){if(ctraits_info_count>>>21){if(ctraits_info_count>>>28){data[offset++]=(ctraits_info_count&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>7)&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>14)&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>21)&0x7f)|0x80;data[offset++]=ctraits_info_count>>>28;}else{data[offset++]=(ctraits_info_count&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>7)&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>14)&0x7f)|0x80;data[offset++]=ctraits_info_count>>>21;}}else{data[offset++]=(ctraits_info_count&0x7f)|0x80;data[offset++]=((ctraits_info_count>>>7)&0x7f)|0x80;data[offset++]=ctraits_info_count>>>14;}}else{data[offset++]=(ctraits_info_count&0x7f)|0x80;data[offset++]=ctraits_info_count>>>7;}}else{data[offset++]=ctraits_info_count;}
			//ctraits_info_count
			
			data.position=offset;
			for each(var ctraits_info:Traits_info in ctraits_infoV){
				data.writeBytes(ctraits_info.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="Class_info"
				cinit={cinit}
			/>;
			if(ctraits_infoV.length){
				var listXML:XML=<ctraits_infoList count={ctraits_infoV.length}/>
				for each(var ctraits_info:Traits_info in ctraits_infoV){
					listXML.appendChild(ctraits_info.toXML("ctraits_info"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			cinit=int(xml.@cinit.toString());
			if(xml.ctraits_infoList.length()){
				var listXML:XML=xml.ctraits_infoList[0];
				var ctraits_infoXMLList:XMLList=listXML.ctraits_info;
				var i:int=-1;
				ctraits_infoV=new Vector.<Traits_info>(ctraits_infoXMLList.length());
				for each(var ctraits_infoXML:XML in ctraits_infoXMLList){
					i++;
					ctraits_infoV[i]=new Traits_info();
					ctraits_infoV[i].initByXML(ctraits_infoXML);
				}
			}else{
				ctraits_infoV=new Vector.<Traits_info>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
