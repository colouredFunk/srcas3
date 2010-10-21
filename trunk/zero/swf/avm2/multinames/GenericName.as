/***
GenericName 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月20日 16:20:00 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/
//0x1D can be considered a GenericName multiname, and is declared as such: 

//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 

//Where 
//[TypeDefinition] is a U30 into the multiname table 
//[ParamCount] is a U8 (U30?) of how many parameters there are 
//[ParamX] is a U30 into the multiname table. 
package zero.swf.avm2.multinames{
	import flash.utils.ByteArray;
	public class GenericName extends Multiname_info{
		public var TypeDefinition:int;					//u30
		public var ParamV:Vector.<int>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						TypeDefinition=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					TypeDefinition=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				TypeDefinition=data[offset++];
			}
			//
			
			
			if(data[offset]>>>7){
				if(data[offset+1]>>>7){
					if(data[offset+2]>>>7){
						if(data[offset+3]>>>7){
							var ParamCount:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
						}else{
							ParamCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
						}
					}else{
						ParamCount=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
					}
				}else{
					ParamCount=(data[offset++]&0x7f)|(data[offset++]<<7);
				}
			}else{
				ParamCount=data[offset++];
			}
			//
			ParamV=new Vector.<int>(ParamCount);
			for(var i:int=0;i<ParamCount;i++){
			
				if(data[offset]>>>7){
					if(data[offset+1]>>>7){
						if(data[offset+2]>>>7){
							if(data[offset+3]>>>7){
								ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);
							}else{
								ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);
							}
						}else{
							ParamV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);
						}
					}else{
						ParamV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);
					}
				}else{
					ParamV[i]=data[offset++];
				}
				//
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			if(TypeDefinition>>>7){
				if(TypeDefinition>>>14){
					if(TypeDefinition>>>21){
						if(TypeDefinition>>>28){
							data[offset++]=(TypeDefinition&0x7f)|0x80;
							data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;
							data[offset++]=((TypeDefinition>>>14)&0x7f)|0x80;
							data[offset++]=((TypeDefinition>>>21)&0x7f)|0x80;
							data[offset++]=TypeDefinition>>>28;
						}else{
							data[offset++]=(TypeDefinition&0x7f)|0x80;
							data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;
							data[offset++]=((TypeDefinition>>>14)&0x7f)|0x80;
							data[offset++]=TypeDefinition>>>21;
						}
					}else{
						data[offset++]=(TypeDefinition&0x7f)|0x80;
						data[offset++]=((TypeDefinition>>>7)&0x7f)|0x80;
						data[offset++]=TypeDefinition>>>14;
					}
				}else{
					data[offset++]=(TypeDefinition&0x7f)|0x80;
					data[offset++]=TypeDefinition>>>7;
				}
			}else{
				data[offset++]=TypeDefinition;
			}
			//
			var ParamCount:int=ParamV.length;
			
			if(ParamCount>>>7){
				if(ParamCount>>>14){
					if(ParamCount>>>21){
						if(ParamCount>>>28){
							data[offset++]=(ParamCount&0x7f)|0x80;
							data[offset++]=((ParamCount>>>7)&0x7f)|0x80;
							data[offset++]=((ParamCount>>>14)&0x7f)|0x80;
							data[offset++]=((ParamCount>>>21)&0x7f)|0x80;
							data[offset++]=ParamCount>>>28;
						}else{
							data[offset++]=(ParamCount&0x7f)|0x80;
							data[offset++]=((ParamCount>>>7)&0x7f)|0x80;
							data[offset++]=((ParamCount>>>14)&0x7f)|0x80;
							data[offset++]=ParamCount>>>21;
						}
					}else{
						data[offset++]=(ParamCount&0x7f)|0x80;
						data[offset++]=((ParamCount>>>7)&0x7f)|0x80;
						data[offset++]=ParamCount>>>14;
					}
				}else{
					data[offset++]=(ParamCount&0x7f)|0x80;
					data[offset++]=ParamCount>>>7;
				}
			}else{
				data[offset++]=ParamCount;
			}
			//
			
			for each(var Param:int in ParamV){
			
				if(Param>>>7){
					if(Param>>>14){
						if(Param>>>21){
							if(Param>>>28){
								data[offset++]=(Param&0x7f)|0x80;
								data[offset++]=((Param>>>7)&0x7f)|0x80;
								data[offset++]=((Param>>>14)&0x7f)|0x80;
								data[offset++]=((Param>>>21)&0x7f)|0x80;
								data[offset++]=Param>>>28;
							}else{
								data[offset++]=(Param&0x7f)|0x80;
								data[offset++]=((Param>>>7)&0x7f)|0x80;
								data[offset++]=((Param>>>14)&0x7f)|0x80;
								data[offset++]=Param>>>21;
							}
						}else{
							data[offset++]=(Param&0x7f)|0x80;
							data[offset++]=((Param>>>7)&0x7f)|0x80;
							data[offset++]=Param>>>14;
						}
					}else{
						data[offset++]=(Param&0x7f)|0x80;
						data[offset++]=Param>>>7;
					}
				}else{
					data[offset++]=Param;
				}
				//
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<GenericName
				TypeDefinition={TypeDefinition}
			>
				<ParamList/>
			</GenericName>;
			if(ParamV.length){
				var listXML:XML=xml.ParamList[0];
				listXML.@count=ParamV.length;
				for each(var Param:int in ParamV){
					listXML.appendChild(<Param value={Param}/>);
				}
			}else{
				delete xml.ParamList;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			TypeDefinition=int(xml.@TypeDefinition.toString());
			if(xml.ParamList.length()){
				var listXML:XML=xml.ParamList[0];
				var ParamXMLList:XMLList=listXML.Param;
				var i:int=-1;
				ParamV=new Vector.<int>(ParamXMLList.length());
				for each(var ParamXML:XML in ParamXMLList){
					i++;
					ParamV[i]=int(ParamXML.@value.toString());
				}
			}else{
				ParamV=new Vector.<int>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
