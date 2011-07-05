/***
OptionsGetter
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月8日 13:19:36
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.funs{
	import zero.swf.TagTypes;
	import flash.utils.getQualifiedClassName;
	
	public class OptionsGetter{
		public static function getInitByDataOptions(_options:*=null):Object/*zero_swf_InitByDataOptions*/{
			var initByDataOptions:Object/*zero_swf_InitByDataOptions*/=new Object/*zero_swf_InitByDataOptions*/();
			
			initByDataOptions.classes=_options.classes;//20110705
			
			initByDataOptions.optionV=options2OptionV(_options);
			
			
			
			/*
			if(initByDataOptions.optionV.indexOf("字节码")>-1){
				throw new Error("只在 zero_swf_InitByDataOptions 中支持此值：“字节码”");//20110608
			}
			if(initByDataOptions.optionV.indexOf("仅位置")>-1){
				throw new Error("只在 zero_swf_InitByDataOptions 中支持此值：“仅位置”");//20110608
			}
			if(initByDataOptions.optionV.indexOf("数据块（字节码）")>-1){
				throw new Error("只在 zero_swf_InitByDataOptions 中支持此值：“数据块（字节码）”");//20110608
			}
			if(initByDataOptions.optionV.indexOf("数据块（仅位置）")>-1){
				throw new Error("只在 zero_swf_InitByDataOptions 中支持此值：“数据块（仅位置）”");//20110608
			}
			*/
			
			if(_options){
				if(
					_options is Vector.<String>
					||
					_options is XML
				){
				}else{
					initByDataOptions.ActionsClass=_options.ActionsClass;//20110609
					initByDataOptions.ActionsGetHexArr=_options.ActionsGetHexArr;//20110609
					
					initByDataOptions.ABCFileClass=_options.ABCFileClass;//20110615
					initByDataOptions.ABCFileGetHexArr=_options.ABCFileGetHexArr;//20110615
				}
			}
			
			return initByDataOptions;
		}
		public static function getToXMLOptions(_options:*=null):Object/*zero_swf_ToXMLOptions*/{
			var toXMLOptions:Object/*zero_swf_ToXMLOptions*/=new Object/*zero_swf_ToXMLOptions*/();
			
			toXMLOptions.optionV=options2OptionV(_options);
			
			//if(toXMLOptions.optionV.indexOf("结构")>-1){
			//	throw new Error("只在 zero_swf_InitByDataOptions 中支持此值：“结构”");//20110608
			//}
			
			if(_options){
				if(
					_options is Vector.<String>
					||
					_options is XML
				){
				}else{
					if(_options.src){
						toXMLOptions.src=_options.src;
					}else if(_options.getSrcFun){
						toXMLOptions.getSrcFun=_options.getSrcFun;
					}
					if(_options.BytesDataToXMLOption){
						toXMLOptions.BytesDataToXMLOption=_options.BytesDataToXMLOption;
					}
					
					toXMLOptions.AVM2UseMarkStr=_options.AVM2UseMarkStr;//20110616
				}
			}
			
			if(
				toXMLOptions.src
				||
				!(toXMLOptions.getSrcFun==null)
			){
			}else if(
				toXMLOptions.optionV.indexOf("仅位置")>-1
				||
				toXMLOptions.optionV.indexOf("数据块（仅位置）")>-1
				||
				toXMLOptions.BytesDataToXMLOption=="数据块（仅位置）"
			){
				trace("不提供 src 或 getSrcFun 将可能会出问题");
			}
			
			return toXMLOptions;
		}
		private static function options2OptionV(options:*):Vector.<String>{
			if(options){
				if(options is Vector.<String>){
					return options;
				}
				if(options is XML){
					return optionXML2OptionV(options,"字节码");
				}
				if(options.optionV){
					return options.optionV;
				}
				if(options.optionXML){
					return optionXML2OptionV(options.optionXML,options.rest||"字节码");
				}
				if(options.optionArr){
					return optionArr2OptionV(options.optionArr,options.rest||"字节码");
				}
				if(options is Array){
					return optionArr2OptionV(options,options.rest||"字节码");
				}
				return optionsObj2OptionV(options,options.rest||"字节码");
			}
			return getOptionV("字节码");
		}
		private static function optionsObj2OptionV(optionsObj:Object,rest:String):Vector.<String>{
			var optionV:Vector.<String>=getOptionV(rest);
			
			var tagType:int=256;
			while(--tagType>=0){
				if(TagTypes.typeNameV[tagType]){
					if(optionsObj[TagTypes.typeNameV[tagType]]){
						optionV[tagType]=optionsObj[TagTypes.typeNameV[tagType]];
					}
				}
			}
			
			for each(tagType in optionsObj["数据块（仅位置）"]){
				optionV[tagType]="数据块（仅位置）";
			}
			for each(tagType in optionsObj["数据块（字节码）"]){
				optionV[tagType]="数据块（字节码）";
			}
			for each(tagType in optionsObj["仅位置"]){
				optionV[tagType]="仅位置";
			}
			for each(tagType in optionsObj["字节码"]){
				optionV[tagType]="字节码";
			}
			for each(tagType in optionsObj["结构"]){
				optionV[tagType]="结构";
			}
			
			for each(var TagBodyClass:Class in optionsObj["结构"]){
				var typeName:String=getQualifiedClassName(TagBodyClass).split(/\.|\:/).pop();
				tagType=TagTypes[typeName];
				if(TagTypes.typeNameV[tagType]==typeName){
					optionV[tagType]="结构";
				}else{
					throw new Error("未知 typeName："+typeName);
				}
			}
			
			return optionV;
		}
		private static function optionArr2OptionV(optionArr:Array,rest:String):Vector.<String>{
			var optionV:Vector.<String>=getOptionV(rest);
			
			var tagType:int=256;
			while(--tagType>=0){
				if(optionArr[tagType]){
					if(optionArr[tagType] is Class){
						optionV[tagType]="结构";
					}else{
						optionV[tagType]=optionArr[tagType];
					}
				}
			}
			
			return optionV;
		}
		private static function optionXML2OptionV(optionXML:XML,rest:String):Vector.<String>{
			var optionV:Vector.<String>=getOptionV(rest);
			
			for each(var tagXML:XML in optionXML.tag){
				optionV[int(tagXML.@type.toString())]=tagXML.@option.toString();
			}
			
			return optionV;
		}
		private static function getOptionV(rest:String):Vector.<String>{
			var optionV:Vector.<String>=new Vector.<String>(256);
			optionV.fixed=true;
			
			rest="字节码";
			var tagType:int=256;
			while(--tagType>=0){
				optionV[tagType]=rest;
			}
			
			return optionV;
		}
	}
}
		