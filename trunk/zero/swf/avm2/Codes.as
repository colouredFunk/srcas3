/***
Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月9日 08:59:40 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import zero.swf.avm2.AVM2Ops;
	import zero.swf.avm2.codes.Code;
	import flash.utils.ByteArray;
	public class Codes extends AVM2Obj{
		public var codeV:Vector.<Code>;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var i:int=-1;
			codeV=new Vector.<Code>();
			while(offset<endOffset){
				i++;
				var op:int=data[offset++];
			
				codeV[i]=new AVM2Ops.classV[op]();
				offset=codeV[i].initByData(data,offset,endOffset);
				codeV[i].op=op;
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			for each(var code:Code in codeV){
				data[offset++]=code.op;
				data.position=offset;
				data.writeBytes(code.toData());
				offset=data.length;
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML(xmlName:String):XML{
			var xml:XML=<{xmlName} class="Codes"/>;
			if(codeV.length){
				var listXML:XML=<codeList count={codeV.length}/>
				for each(var code:Code in codeV){
					listXML.appendChild(code.toXML("code"));
				}
				xml.appendChild(listXML);
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			if(xml.codeList.length()){
				var listXML:XML=xml.codeList[0];
				var codeXMLList:XMLList=listXML.code;
				var i:int=-1;
				codeV=new Vector.<Code>(codeXMLList.length());
				for each(var codeXML:XML in codeXMLList){
					i++;
					var op:int=AVM2Ops[codeXML["@class"].toString()];
					codeV[i]=new AVM2Ops.classV[op]();
					codeV[i].initByXML(codeXML);
					codeV[i].op=op;
				}
			}else{
				codeV=new Vector.<Code>();
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
