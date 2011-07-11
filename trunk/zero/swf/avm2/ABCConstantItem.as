/***
ABCConstantItem
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 15:17:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	public class ABCConstantItem{
		public var kind:int;
		public var value:*;
		public function initByInfo(
			valueKind:int,
			valueIndex:int,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			kind=valueKind;
			switch(kind){
				case ConstantKinds.Int:
					if(valueIndex>0){
						value=integerV[valueIndex];
						//trace("initByInfo int value="+value);
					}else{
						throw new Error("valueIndex="+valueIndex);
					}
				break;
				case ConstantKinds.UInt:
					if(valueIndex>0){
						value=uintegerV[valueIndex];
						//trace("initByInfo uint value="+value);
					}else{
						throw new Error("valueIndex="+valueIndex);
					}
				break;
				case ConstantKinds.Double:
					if(valueIndex>0){
						value=doubleV[valueIndex];
						//trace("initByInfo double value="+value);//有时会传一个 uint 值过来，例如 4294967295
					}else{
						throw new Error("valueIndex="+valueIndex);
					}
				break;
				case ConstantKinds.Utf8:
					if(valueIndex>0){
						value=stringV[valueIndex];
					}else{
						throw new Error("valueIndex="+valueIndex);
					}
				break;
				case ConstantKinds.True:
					//value=true;
				break;
				case ConstantKinds.False:
					//value=false;
				break;
				case ConstantKinds.Null:
					//value=null;
				break;
				case ConstantKinds.Undefined:
					//value=undefined;
				break;
				case ConstantKinds.Namespace:
				case ConstantKinds.PackageNamespace:
				case ConstantKinds.PackageInternalNs:
				case ConstantKinds.ProtectedNamespace:
				case ConstantKinds.ExplicitNamespace:
				case ConstantKinds.StaticProtectedNs:
				case ConstantKinds.PrivateNs:
					if(valueIndex>0){
						value=allNsV[valueIndex];
					}else{
						throw new Error("valueIndex="+valueIndex);
					}
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			switch(kind){
				case ConstantKinds.Int:
					productMark.productInteger(value);
				break;
				case ConstantKinds.UInt:
					productMark.productUinteger(value);
				break;
				case ConstantKinds.Double:
					productMark.productDouble(value);
				break;
				case ConstantKinds.Utf8:
					productMark.productString(value);
				break;
				case ConstantKinds.True:
					//
				break;
				case ConstantKinds.False:
					//
				break;
				case ConstantKinds.Null:
					//
				break;
				case ConstantKinds.Undefined:
					//
				break;
				case ConstantKinds.Namespace:
				case ConstantKinds.PackageNamespace:
				case ConstantKinds.PackageInternalNs:
				case ConstantKinds.ProtectedNamespace:
				case ConstantKinds.ExplicitNamespace:
				case ConstantKinds.StaticProtectedNs:
				case ConstantKinds.PrivateNs:
					productMark.productNs(value);
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Array{
			switch(kind){
				case ConstantKinds.Int:
					return [ConstantKinds.Int,productMark.getIntegerId(value)];
				break;
				case ConstantKinds.UInt:
					return [ConstantKinds.UInt,productMark.getUintegerId(value)];
				break;
				case ConstantKinds.Double:
					return [ConstantKinds.Double,productMark.getDoubleId(value)];
				break;
				case ConstantKinds.Utf8:
					return [ConstantKinds.Utf8,productMark.getStringId(value)];
				break;
				case ConstantKinds.True:
					return [ConstantKinds.True,ConstantKinds.True];
				break;
				case ConstantKinds.False:
					return [ConstantKinds.False,ConstantKinds.False];
				break;
				case ConstantKinds.Null:
					return [ConstantKinds.Null,ConstantKinds.Null];
				break;
				case ConstantKinds.Undefined:
					return [ConstantKinds.Undefined,ConstantKinds.Undefined];
				break;
				case ConstantKinds.Namespace:
				case ConstantKinds.PackageNamespace:
				case ConstantKinds.PackageInternalNs:
				case ConstantKinds.ProtectedNamespace:
				case ConstantKinds.ExplicitNamespace:
				case ConstantKinds.StaticProtectedNs:
				case ConstantKinds.PrivateNs:
					var ns:ABCNamespace=value;
					return [ns.kind,productMark.getNsId(ns)];
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			return null;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			switch(kind){
				case ConstantKinds.Int:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.Int]} value={value}/>;
				break;
				case ConstantKinds.UInt:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.UInt]} value={value}/>;
				break;
				case ConstantKinds.Double:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.Double]} value={value}/>;
				break;
				case ConstantKinds.Utf8:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.Utf8]} value={value}/>;
				break;
				case ConstantKinds.True:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.True]}/>;
				break;
				case ConstantKinds.False:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.False]}/>;
				break;
				case ConstantKinds.Null:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.Null]}/>;
				break;
				case ConstantKinds.Undefined:
					return <{xmlName} kind={ConstantKinds.kindV[ConstantKinds.Undefined]}/>;
				break;
				case ConstantKinds.Namespace:
				case ConstantKinds.PackageNamespace:
				case ConstantKinds.PackageInternalNs:
				case ConstantKinds.ProtectedNamespace:
				case ConstantKinds.ExplicitNamespace:
				case ConstantKinds.StaticProtectedNs:
				case ConstantKinds.PrivateNs:
					return (value as ABCNamespace).toXMLAndMark(markStrs,xmlName,_toXMLOptions);
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
			return null;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			kind=ConstantKinds[xml.@kind.toString()];
			switch(kind){
				case ConstantKinds.Int:
					value=int(xml.@value.toString());
				break;
				case ConstantKinds.UInt:
					value=uint(xml.@value.toString());
				break;
				case ConstantKinds.Double:
					value=Number(xml.@value.toString());
				break;
				case ConstantKinds.Utf8:
					value=xml.@value.toString();
				break;
				case ConstantKinds.True:
					value=true;
				break;
				case ConstantKinds.False:
					value=false;
				break;
				case ConstantKinds.Null:
					value=null;
				break;
				case ConstantKinds.Undefined:
					value=undefined;
				break;
				case ConstantKinds.Namespace:
				case ConstantKinds.PackageNamespace:
				case ConstantKinds.PackageInternalNs:
				case ConstantKinds.ProtectedNamespace:
				case ConstantKinds.ExplicitNamespace:
				case ConstantKinds.StaticProtectedNs:
				case ConstantKinds.PrivateNs:
					value=ABCNamespace.xml2ns(markStrs,xml,_initByXMLOptions);
				break;
				default:
					throw new Error("未知 kind: "+kind);
				break;
			}
		}
		}//end of CONFIG::USE_XML
	}
}
		