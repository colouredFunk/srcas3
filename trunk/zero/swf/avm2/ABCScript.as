/***
ABCScript
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 20:10:27
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The script_info entry is used to define characteristics of an ActionScript 3.0 script.
//script_info
//{
//	u30 init
//	u30 trait_count
//	traits_info trait[trait_count]
//}

package zero.swf.avm2{
	import flash.utils.Dictionary;

	public class ABCScript{
		public var init:ABCMethod;
		public var traitV:Vector.<ABCTrait>;
		//
		public function initByInfo(
			script_info:Script_info,
			integerV:Vector.<int>,
			uintegerV:Vector.<int>,
			doubleV:Vector.<Number>,
			stringV:Vector.<String>,
			allNsV:Vector.<ABCNamespace>,
			allMultinameV:Vector.<ABCMultiname>,
			allMethodV:Vector.<ABCMethod>,
			allMetadataV:Vector.<ABCMetadata>,
			classV:Vector.<ABCClass>,
			_initByDataOptions:zero_swf_InitByDataOptions
		):void{
			var i:int;
			
			//The init field is an index into the method array of the abcFile. It identifies a function that is to be
			//invoked prior to any other code in this script.
			//它确定一个函数，要
			//调用任何其他代码之前在此脚本
			init=allMethodV[script_info.init];
			
			//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
			//defined by the script.
			i=-1;
			traitV=new Vector.<ABCTrait>();
			for each(var traits_info:Traits_info in script_info.traits_infoV){
				i++;
				traitV[i]=new ABCTrait();
				traitV[i].initByInfo(
					traits_info,
					integerV,
					uintegerV,
					doubleV,
					stringV,
					allNsV,
					allMultinameV,
					allMethodV,
					allMetadataV,
					classV,
					_initByDataOptions
				);
			}
		}
		public function getInfo_product(productMark:ProductMark):void{
			
			//The init field is an index into the method array of the abcFile. It identifies a function that is to be
			//invoked prior to any other code in this script.
			//它确定一个函数，要
			//调用任何其他代码之前在此脚本
			productMark.productMethod(init);
			
			//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
			//defined by the script.
			for each(var trait:ABCTrait in traitV){
				trait.getInfo_product(productMark);
			}
		}
		public function getInfo(productMark:ProductMark,_toDataOptions:zero_swf_ToDataOptions):Script_info{
			var i:int;
			
			var script_info:Script_info=new Script_info();
			
			//The init field is an index into the method array of the abcFile. It identifies a function that is to be
			//invoked prior to any other code in this script.
			//它确定一个函数，要
			//调用任何其他代码之前在此脚本
			script_info.init=productMark.getMethodId(init);
			
			//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
			//defined by the script.
			i=-1;
			script_info.traits_infoV=new Vector.<Traits_info>();
			for each(var trait:ABCTrait in traitV){
				i++;
				script_info.traits_infoV[i]=trait.getInfo(productMark,_toDataOptions);
			}
			
			return script_info;
		}
		
		////
		CONFIG::USE_XML{
		public function toXMLAndMark(markStrs:MarkStrs,xmlName:String,_toXMLOptions:zero_swf_ToXMLOptions):XML{
			var xml:XML=<{xmlName}/>;
			
			xml.appendChild(init.toXMLAndMark(markStrs,"","init",_toXMLOptions));
			
			if(traitV.length){
				var traitListXML:XML=<traitList count={traitV.length}/>
				for each(var trait:ABCTrait in traitV){
					traitListXML.appendChild(trait.toXMLAndMark(markStrs,"trait",_toXMLOptions));
				}
				xml.appendChild(traitListXML);
			}
			
			return xml;
		}
		public function initByXMLAndMark(markStrs:MarkStrs,xml:XML,_initByXMLOptions:zero_swf_InitByXMLOptions):void{
			var i:int;
			
			init=new ABCMethod();
			init.initByXMLAndMark(markStrs,xml.init[0],_initByXMLOptions);
			
			i=-1;
			traitV=new Vector.<ABCTrait>();
			for each(var traitXML:XML in xml.traitList.trait){
				i++;
				traitV[i]=new ABCTrait();
				traitV[i].initByXMLAndMark(markStrs,traitXML,_initByXMLOptions);
			}
		}
	}//end of CONFIG::USE_XML
	}
}		