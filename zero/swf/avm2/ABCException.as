/***
ABCException
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 21:38:26
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The exception_info entry is used to define the range of ActionScript 3.0 instructions over which a particular
//exception handler is engaged.
//exception_info
//{
//	u30 from
//	u30 to
//	u30 target
//	u30 exc_type
//	u30 var_name
//}
package zero.swf.avm2{
	import zero.swf.codes.LabelMark;
	import flash.utils.Dictionary;
	
	public class ABCException{
		public var from:LabelMark;
		public var to:LabelMark;
		public var target:LabelMark;
		public var exc_type:ABCMultiname;
		public var var_name:ABCMultiname;
		//
		public function initByInfo(
			exception_info:Exception_info,
			allMultinameV:Vector.<ABCMultiname>,
			_initByDataOptions:Object/*zero_swf_InitByDataOptions*/
		):void{
			
			//The starting position in the code field from which the exception is enabled.
			//由 AVM2Codes.initByInfo() 初始化
			
			//The ending position in the code field after which the exception is disabled.
			//由 AVM2Codes.initByInfo() 初始化
			
			//The position in the code field to which control should jump if an exception of type exc_type is
			//encountered while executing instructions that lie within the region [from, to] of the code field.
			//由 AVM2Codes.initByInfo() 初始化
			
			//An index into the string array of the constant pool that identifies the name of the type of exception that
			//is to be monitored during the reign of this handler. A value of zero means the any type ("*") and implies
			//that this exception handler will catch any type of exception thrown.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			exc_type=allMultinameV[exception_info.exc_type];//allMultinameV[0]==null
			
			//This index into the string array of the constant pool defines the name of the variable that is to receive
			//the exception object when the exception is thrown and control is transferred to target location. If the
			//value is zero then there is no name associated with the exception object.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			var_name=allMultinameV[exception_info.var_name];//allMultinameV[0]==null
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The starting position in the code field from which the exception is enabled.
			
			//The ending position in the code field after which the exception is disabled.
			
			//The position in the code field to which control should jump if an exception of type exc_type is
			//encountered while executing instructions that lie within the region [from, to] of the code field.
			
			//An index into the string array of the constant pool that identifies the name of the type of exception that
			//is to be monitored during the reign of this handler. A value of zero means the any type ("*") and implies
			//that this exception handler will catch any type of exception thrown.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			productMark.productMultiname(exc_type);
			
			//This index into the string array of the constant pool defines the name of the variable that is to receive
			//the exception object when the exception is thrown and control is transferred to target location. If the
			//value is zero then there is no name associated with the exception object.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			productMark.productMultiname(var_name);
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:Object/*zero_swf_ToDataOptions*/):Exception_info{
			
			var exception_info:Exception_info=new Exception_info();
			
			//The starting position in the code field from which the exception is enabled.
			//exception_info.from=from;
			
			//The ending position in the code field after which the exception is disabled.
			//exception_info.to=to;
			
			//The position in the code field to which control should jump if an exception of type exc_type is
			//encountered while executing instructions that lie within the region [from, to] of the code field.
			//exception_info.target=target;
			
			//An index into the string array of the constant pool that identifies the name of the type of exception that
			//is to be monitored during the reign of this handler. A value of zero means the any type ("*") and implies
			//that this exception handler will catch any type of exception thrown.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			exception_info.exc_type=productMark.getMultinameId(exc_type);
			
			//This index into the string array of the constant pool defines the name of the variable that is to receive
			//the exception object when the exception is thrown and control is transferred to target location. If the
			//value is zero then there is no name associated with the exception object.
			//文档里是错的...不是 string_v 而是 multiname_info_v
			exception_info.var_name=productMark.getMultinameId(var_name);
			
			return exception_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName}/>;
			
			xml.@from="label"+from.labelId;
			
			xml.@to="label"+to.labelId;
			
			xml.@target="label"+target.labelId;
			
			if(exc_type){
				xml.appendChild(exc_type.toXMLAndMark(markStrs,"exc_type",_toXMLOptions));
			}
			
			if(var_name){
				xml.appendChild(var_name.toXMLAndMark(markStrs,"var_name",_toXMLOptions));
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			
			//from=int(xml.@from.toString());
			
			//to=int(xml.@to.toString());
			
			//target=int(xml.@target.toString());
			
			var exc_typeXML:XML=xml.exc_type[0];
			if(exc_typeXML){
				exc_type=ABCMultiname.xml2multiname(markStrs,exc_typeXML,_initByXMLOptions);
			}else{
				exc_type=null;
			}
			
			var var_nameXML:XML=xml.var_name[0];
			if(var_nameXML){
				var_name=ABCMultiname.xml2multiname(markStrs,var_nameXML,_initByXMLOptions);
			}else{
				var_name=null;
			}
		}
		}//end of CONFIG::USE_XML
	}
}				