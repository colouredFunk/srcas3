/***
QName 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月18日 13:50:19 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//multiname_kind_QName
//{
//	u30 ns
//	u30 name
//}

//The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry,
//respectively. A value of zero for the ns field indicates the any ("*") namespace, and a value of zero for the name
//field indicates the any ("*") name.
//ns是在 constant_pool.namespace_info_v 中的id
//name是在 constant_pool.string_v 中的id
//ns或name如果是 0 则表示 "*"
package zero.swf.avm2.multinames{
	import flash.utils.ByteArray;
	public class QName extends Multiname_info{
		public var ns:int;								//u30
		public var name:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			//#offsetpp
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						ns=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					ns=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				ns=data[offset++];
			}
			//
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
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			//#offsetpp
			var offset:int=0;
			if(ns>>>7){
				if(ns>>>14){
					if(ns>>>21){
						if(ns>>>28){
							data[offset++]=(ns&0x7f)|0x80;
							data[offset++]=((ns>>>7)&0x7f)|0x80;
							data[offset++]=((ns>>>14)&0x7f)|0x80;
							data[offset++]=((ns>>>21)&0x7f)|0x80;
							data[offset++]=ns>>>28;
						}else{
							data[offset++]=(ns&0x7f)|0x80;
							data[offset++]=((ns>>>7)&0x7f)|0x80;
							data[offset++]=((ns>>>14)&0x7f)|0x80;
							data[offset++]=ns>>>21;
						}
					}else{
						data[offset++]=(ns&0x7f)|0x80;
						data[offset++]=((ns>>>7)&0x7f)|0x80;
						data[offset++]=ns>>>14;
					}
				}else{
					data[offset++]=(ns&0x7f)|0x80;
					data[offset++]=ns>>>7;
				}
			}else{
				data[offset++]=ns;
			}
			//
			//#offsetpp
			
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
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			return <QName
				ns={ns}
				name={name}
			/>;
		}
		override public function initByXML(xml:XML):void{
			ns=int(xml.@ns.toString());
			name=int(xml.@name.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
