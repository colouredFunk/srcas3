/***
Namespace_info 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月17日 12:55:43 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//A namespace_info entry defines a namespace. Namespaces have string names, represented by indices into the
//string array, and kinds. User-defined namespaces have kind CONSTANT_Namespace or
//CONSTANT_ExplicitNamespace and a non-empty name. System namespaces have empty names and one of the
//other kinds, and provides a means for the loader to map references to these namespaces onto internal entities.

//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
//The name field is an index into the string section of the constant pool.
//name是在 constant_pool.string_v 中的id
//A value of zero denotes an empty string.
//0 表示 ""
//The table below lists the legal values for kind.
//Namespace Kind 				Value
//CONSTANT_Namespace 			0x08
//CONSTANT_PackageNamespace 	0x16
//CONSTANT_PackageInternalNs 	0x17
//CONSTANT_ProtectedNamespace 	0x18
//CONSTANT_ExplicitNamespace 	0x19
//CONSTANT_StaticProtectedNs 	0x1A
//CONSTANT_PrivateNs 			0x05

//			namespace_info
//			{
//				u8 kind
//				u30 name
//			}
package zero.swf.avm2{
	import zero.swf.vmark.NamespaceKind;
	import flash.utils.ByteArray;
	public class Namespace_info extends AVM2Obj{
		public var kind:int;							//u8
		public var name:int;							//u30
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			kind=data[offset];
			//#offsetpp
			++offset;
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
			data[0]=kind;
			//#offsetpp
			var offset:int=1;
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
			return <Namespace_info
				kind={NamespaceKind.kindV[kind]}
				name={name}
			/>;
		}
		override public function initByXML(xml:XML):void{
			kind=NamespaceKind[xml.@kind.toString()];
			name=int(xml.@name.toString());
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
