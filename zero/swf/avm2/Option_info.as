/***
Option_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 23:10:23 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//The option_info entry is used to define the default values for the optional parameters of the method. The
//number of optional parameters is given by option_count, which must not be zero nor greater than the
//parameter_count field of the enclosing method_info structure.
//默认参数信息
//option_count 不能是0, 也不能大于 parameter_count

//option_info
//{
//	u30 option_count
//	option_detail option[option_count]
//}
package zero.swf.avm2{
	import zero.swf.avm2.Option_detail;
	import flash.utils.ByteArray;
	public class Option_info extends AVM2Obj{
		public var option_detailV:Vector.<Option_detail>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var option_detail_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							option_detail_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						option_detail_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					option_detail_count=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				option_detail_count=data[offset++];
			}
			//
			option_detailV=new Vector.<Option_detail>(option_detail_count);
			for(var i:int=0;i<option_detail_count;i++){
				//#offsetpp
			
				option_detailV[i]=new Option_detail();
				offset=option_detailV[i].initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var option_detail_count:int=option_detailV.length;
			//#offsetpp
			var offset:int=0;
			if(option_detail_count>>>7){
				if(option_detail_count>>>14){
					if(option_detail_count>>>21){
						if(option_detail_count>>>28){
							data[offset++]=(option_detail_count&0x7f)|0x80;
							data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;
							data[offset++]=((option_detail_count>>>14)&0x7f)|0x80;
							data[offset++]=((option_detail_count>>>21)&0x7f)|0x80;
							data[offset++]=option_detail_count>>>28;
						}else{
							data[offset++]=(option_detail_count&0x7f)|0x80;
							data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;
							data[offset++]=((option_detail_count>>>14)&0x7f)|0x80;
							data[offset++]=option_detail_count>>>21;
						}
					}else{
						data[offset++]=(option_detail_count&0x7f)|0x80;
						data[offset++]=((option_detail_count>>>7)&0x7f)|0x80;
						data[offset++]=option_detail_count>>>14;
					}
				}else{
					data[offset++]=(option_detail_count&0x7f)|0x80;
					data[offset++]=option_detail_count>>>7;
				}
			}else{
				data[offset++]=option_detail_count;
			}
			//
			//#offsetpp
			
			data.position=offset;
			for each(var option_detail:Option_detail in option_detailV){
				data.writeBytes(option_detail.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<Option_info>
				<list vNames="option_detailV" count={option_detailV.length}/>
			</Option_info>;
			var listXML:XML=xml.list[0];
			for each(var option_detail:Option_detail in option_detailV){
				var itemXML:XML=<option_detail/>;
				itemXML.appendChild(option_detail.toXML());
				listXML.appendChild(itemXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			var listXML:XML=xml.list[0];
			var option_detailXMLList:XMLList=listXML.option_detail;
			var i:int=-1;
			option_detailV=new Vector.<Option_detail>(option_detailXMLList.length());
			for each(var option_detailXML:XML in option_detailXMLList){
				i++;
				option_detailV[i]=new Option_detail();
				option_detailV[i].initByXML(option_detailXML.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
