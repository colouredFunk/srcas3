/***
Multiname 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 13:50:19 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//multiname_kind_Multiname
//{
//	u30 name
//	u30 ns_set
//}

//The name field is an index into the string array, and the ns_set field is an index into the ns_set array. A
//value of zero for the name field indicates the any ("*") name. The value of ns_set cannot be zero.
//name是在 constant_pool.string_v 中的id
//ns_set是在 constant_pool.ns_set_info_v 中的id
//name如果是 0 则表示 "*"
//ns_set不能是 0
package zero.swf.avm2.multiname{
	import flash.utils.ByteArray;
	public class Multiname extends Multiname_info{
		public var name:int;							//u30
		public var ns_set:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					name=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				name=data[offset++];
			}
			//
			//#offsetpp
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						ns_set=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					ns_set=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				ns_set=data[offset++];
			}
			//
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			//#offsetpp
			var offset:int=0;
			if(name>>>7){
				if(name>>>14){
					if(name>>>21){
						if(name>>>28){
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=((name>>>21)&0x7f)|0x80;
							data[offset++]=name>>>28;
						}else{
							data[offset++]=(name&0x7f)|0x80;
							data[offset++]=((name>>>7)&0x7f)|0x80;
							data[offset++]=((name>>>14)&0x7f)|0x80;
							data[offset++]=name>>>21;
						}
					}else{
						data[offset++]=(name&0x7f)|0x80;
						data[offset++]=((name>>>7)&0x7f)|0x80;
						data[offset++]=name>>>14;
					}
				}else{
					data[offset++]=(name&0x7f)|0x80;
					data[offset++]=name>>>7;
				}
			}else{
				data[offset++]=name;
			}
			//
			//#offsetpp
			
			if(ns_set>>>7){
				if(ns_set>>>14){
					if(ns_set>>>21){
						if(ns_set>>>28){
							data[offset++]=(ns_set&0x7f)|0x80;
							data[offset++]=((ns_set>>>7)&0x7f)|0x80;
							data[offset++]=((ns_set>>>14)&0x7f)|0x80;
							data[offset++]=((ns_set>>>21)&0x7f)|0x80;
							data[offset++]=ns_set>>>28;
						}else{
							data[offset++]=(ns_set&0x7f)|0x80;
							data[offset++]=((ns_set>>>7)&0x7f)|0x80;
							data[offset++]=((ns_set>>>14)&0x7f)|0x80;
							data[offset++]=ns_set>>>21;
						}
					}else{
						data[offset++]=(ns_set&0x7f)|0x80;
						data[offset++]=((ns_set>>>7)&0x7f)|0x80;
						data[offset++]=ns_set>>>14;
					}
				}else{
					data[offset++]=(ns_set&0x7f)|0x80;
					data[offset++]=ns_set>>>7;
				}
			}else{
				data[offset++]=ns_set;
			}
			//
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <Multiname
				name={name}
				ns_set={ns_set}
			/>;
		}
		override public function initByXML(xml:XML):void{
			name=int(xml.@name.toString());
			ns_set=int(xml.@ns_set.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
