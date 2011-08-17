/***
Tag
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月30日 22:20:28
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import zero.BytesAndStr16;
	import zero.outputError;
	
	public class Tag{
		public var headOffset:int;
		public var bodyOffset:int;
		public var bodyLength:int;
		public var type:int;
		
		//public var test_isShort:Boolean;//测试
		
		public function Tag(_type:int=-1){
			type=_type;
		}
		
		public function initByData(data:ByteArray,offset:int):void{
			headOffset=offset;
			var temp:int=data[offset++];
			type=(temp>>>6)|(data[offset++]<<2);
			bodyLength=temp&0x3f;
			if(bodyLength==0x3f){//长tag
				bodyLength=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
				//test_isShort=false;
			}//else{
			//	test_isShort=true;
			//}
			bodyOffset=offset;
			
			__bodyData=data;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var bodyData:ByteArray;
			if(__body){
				bodyData=__body.toData(_toDataOptions);
				bodyLength=bodyData.length;
			}else{
				bodyData=new ByteArray();
				if(bodyLength>0){
					bodyData.writeBytes(__bodyData,bodyOffset,bodyLength);
				}
			}
			
			//trace("bodyData="+BytesAndStr16.bytes2str16(bodyData,0,bodyData.length));
			
			var data:ByteArray=new ByteArray();
			data[0]=type<<6;
			data[1]=type>>>2;
			
			if(
				bodyLength>=0x3f
				||
				type==TagTypes.DefineBits
				||
				type==TagTypes.DefineBitsJPEG2
				||
				type==TagTypes.DefineBitsJPEG3
				||
				type==TagTypes.DefineBitsJPEG4
				||
				type==TagTypes.DefineBitsLossless
				||
				type==TagTypes.DefineBitsLossless2
				||
				type==TagTypes.SoundStreamBlock//某天偶然发现的一些小图片变成短tag后出错(不知道还会不会有其它tag有这种现象)
				//||
				//!test_isShort
			){
				//长tag
				data[0]|=0x3f;
				data[2]=bodyLength;
				data[3]=bodyLength>>8;
				data[4]=bodyLength>>16;
				data[5]=bodyLength>>24;
				data.position=6;
			}else{
				data[0]|=bodyLength;
				data.position=2;
			}
			data.writeBytes(bodyData);
			return data;
		}
		
		private var __bodyData:ByteArray;
		public function getBodyData():ByteArray{
			if(__bodyData){
				return __bodyData;
			}
			throw new Error("__bodyData="+__bodyData);
			return null;
		}
		public function setBodyData(_bodyData:ByteArray):void{
			if(_bodyData){
				if(type<0){
					throw new Error("未设置 type");
				}
				setBody(null);
				__bodyData=_bodyData;
				headOffset=0;
				bodyOffset=0;
				bodyLength=__bodyData.length;
			}else{
				__bodyData=null;
				headOffset=-1;
				bodyOffset=-1;
				bodyLength=-1;
			}
		}
		
		private var __body:*;
		public function getBody(TagBodyClass:Class,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):*{
			if(__body){
			}else{
				if(__bodyData){
					__body=new TagBodyClass();
					var endOffset:int=bodyOffset+bodyLength;
					var offset:int=__body.initByData(__bodyData,bodyOffset,endOffset,_initByDataOptions);
					if(offset==endOffset){
					}else{
						outputError("type="+type+"，typeName="+TagTypes.typeNameV[type]+"，offset="+offset+"，endOffset="+endOffset);
					}
				}
			}
			//trace("__body="+__body);
			return __body;
		}
		public function setBody(_body:*):void{
			if(_body){
				//data=null;
				setBodyData(null);
				var typeName:String=getQualifiedClassName(_body).split(/\.|\:/).pop();
				type=TagTypes[typeName];
				if(TagTypes.typeNameV[type]==typeName){
					__body=_body;
				}else{
					throw new Error("未知 typeName："+typeName);
				}
			}else{
				__body=null;
			}
		}
		
		public function get UI16Id():int{//头两个字节组成的 UI16，例如 DefineButton2 的 id，或 DefineButtonSound 的 ButtonId
			if(__body){
				return __body["id"];
			}
			if(__bodyData){
				if(bodyLength<2){
					throw new Error("bodyLength="+bodyLength);
				}
				return __bodyData[bodyOffset]|(__bodyData[bodyOffset+1]<<8);
			}
			throw new Error("未处理");
			return -1;
		}
		public function set UI16Id(id:int):void{//头两个字节组成的 UI16，例如 DefineButton2 的 id，或 DefineButtonSound 的 ButtonId
			if(__body){
				__body["id"]=id;
			}else if(__bodyData){
				if(bodyLength<2){
					throw new Error("bodyLength="+bodyLength);
				}
				__bodyData[bodyOffset]=id;
				__bodyData[bodyOffset+1]=id>>8;
			}else{
				throw new Error("未处理");
			}
		}
		
		CONFIG::USE_XML{
		public function toXML(_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{//如果给出 src，表示 getPositionOnly
			/*
			var xml:XML=<tag
				typeName={TagTypes.typeNameV[type]}
				type={type}
				//test_isShort={test_isShort}
			/>;
			*/
			/*
			var xml:XML=<{TagTypes.typeNameV[type]}
				type={type}
				//test_isShort={test_isShort}
			/>;
			*/
			if(__body){
				return __body.toXML(TagTypes.typeNameV[type],_toXMLOptions);
			}
			if(__bodyData){
				if(bodyLength){
					var typeName:String=TagTypes.typeNameV[type];
					if(_toXMLOptions&&_toXMLOptions.optionV[type]=="仅位置"){
						if(typeName){
							return <{typeName}
								src={_toXMLOptions.src||_toXMLOptions.getSrcFun(__bodyData)}
								offset={bodyOffset}
								length={bodyLength}
								//test_isShort={test_isShort}
							/>
						}
						return <tag
							type={type}
							src={_toXMLOptions.src||_toXMLOptions.getSrcFun(__bodyData)}
							offset={bodyOffset}
							length={bodyLength}
							//test_isShort={test_isShort}
						/>
					}
					if(typeName){
						return <{typeName}
							length={bodyLength}
							value={BytesAndStr16.bytes2str16(__bodyData,bodyOffset,bodyLength)}
							//test_isShort={test_isShort}
						/>
					}
					return <tag
						type={type}
						length={bodyLength}
						value={BytesAndStr16.bytes2str16(__bodyData,bodyOffset,bodyLength)}
						//test_isShort={test_isShort}
					/>
				}
			}
			return <{TagTypes.typeNameV[type]}
				//test_isShort={test_isShort}
			/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			var xmlName:String=xml.name().toString();//20110618
			var typeName:String;
			if(TagTypes[xmlName]>-1){
				type=TagTypes[xmlName];
			}else{
				typeName=xml.@typeName.toString();
				if(TagTypes[typeName]>-1){
					type=TagTypes[typeName];
				}else{
					type=int(xml.@type.toString());
				}
			}
			
			//test_isShort=(xml.@test_isShort.toString()=="true");
			
			var classStr:String=xml["@class"].toString();
			if(classStr){
				//可用户自定义 class
				setBody(new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[classStr]||getDefinitionByName(classStr))());
				__body.initByXML(xml,_initByXMLOptions);
			}else{
				var valueStr:String=xml.@value.toString();
				if(valueStr){
					setBodyData(BytesAndStr16.str162bytes(valueStr));
				}else{
					var srcStr:String=xml.@src.toString();
					if(srcStr){
						if(_initByXMLOptions){
						}else{
							throw new Error("需要提供 _initByXMLOptions");
						}
						setBodyData(_initByXMLOptions.resData||_initByXMLOptions.getResDataFun(srcStr));
						bodyOffset=int(xml.@offset.toString());
						bodyLength=int(xml.@length.toString());
					}
				}
			}
		}
		}//end of CONFIG::USE_XML
	}
}
		