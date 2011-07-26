/***
PlaceObject2
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:16（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//PlaceObject2
//Field 											Type 			Comment
//Header 											RECORDHEADER 	Tag type = 26
//PlaceFlagHasClipActions 							UB[1] 			SWF 5 and later: has clip actions (sprite characters only) Otherwise: always 0
//PlaceFlagHasClipDepth 							UB[1] 			Has clip depth
//PlaceFlagHasName 									UB[1] 			Has name
//PlaceFlagHasRatio(是否含有比例(补间))				UB[1] 			Has ratio
//PlaceFlagHasColorTransform 						UB[1] 			Has color transform
//PlaceFlagHasMatrix 								UB[1] 			Has matrix
//PlaceFlagHasCharacter 							UB[1] 			Places a character
//PlaceFlagMove 									UB[1] 			Defines a character to be moved

//PlaceFlagMove和PlaceFlagHasCharacter指出一个新的角色是否被添加入显示列表，或显示列表中的一个角色是否被修改。这两个标记的含义如下：
//• PlaceFlagMove = 0并且PlaceFlagHasCharacter = 1
//一个新的角色（带有ID或CharacterId）被指定具体的深度并且放置于显示列表。其他字段设置新角色的属性。
//• PlaceFlagMove = 1并且PlaceFlagHasCharacter = 0
//指定深度的角色被修改。其他字段修改这个角色的属性。因为一个深度只能含有一个角色，所以CharacterId为可选字段。
//• PlaceFlagMove = 1并且PlaceFlagHasCharacter = 1
//指定深度的角色被移除，同时新角色（带有ID或CharacterId）被放置于该深度。其他字段设置新角色的属性。

//Depth 											UI16 			Depth of character
//CharacterId If PlaceFlagHasCharacter				UI16			ID of character to place
//Matrix If PlaceFlagHasMatrix						MATRIX			Transform matrix data
//ColorTransform If PlaceFlagHasColorTransform		CXFORMWITHALPHA	Color transform data
//Ratio If PlaceFlagHasRatio 						UI16			
//Name If PlaceFlagHasName							STRING			Name of character
//ClipDepth If PlaceFlagHasClipDepth 				UI16 			Clip depth(see Clipping layers)
//ClipActions If PlaceFlagHasClipActions			CLIPACTIONS		SWF 5 and later:Clip Actions Data
package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import zero.swf.BytesData;
	import zero.swf.records.CXFORMWITHALPHA;
	import zero.swf.records.MATRIX;
	public class PlaceObject2{//implements I_zero_swf_CheckCodesRight{
		public var PlaceFlagMove:Boolean;
		public var Depth:int;							//UI16
		public var CharacterId:int;						//UI16
		public var Matrix:*;
		public var ColorTransform:*;
		public var Ratio:int;							//UI16
		public var Name:String;							//STRING
		public var ClipDepth:int;						//UI16
		public var ClipActions:*;
		//
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object/*zero_swf_InitByDataOptions*/):int{
			var flags:int=data[offset++];
			PlaceFlagMove=((flags&0x01)?true:false);						//00000001
			Depth=data[offset++]|(data[offset++]<<8);
			if(flags&0x02){//PlaceFlagHasCharacter					//00000010
				CharacterId=data[offset++]|(data[offset++]<<8);
			}else{
				CharacterId=-1;
			}
			if(flags&0x04){//PlaceFlagHasMatrix						//00000100
				var MatrixClass:Class;
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						MatrixClass=_initByDataOptions.classes["zero.swf.records.MATRIX"];
					}
				}
				Matrix=new (MatrixClass||MATRIX)();
				offset=Matrix.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				Matrix=null;
			}
			if(flags&0x08){//PlaceFlagHasColorTransform				//00001000
				var ColorTransformClass:Class;
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						ColorTransformClass=_initByDataOptions.classes["zero.swf.records.CXFORMWITHALPHA"];
					}
				}
				ColorTransform=new (ColorTransformClass||CXFORMWITHALPHA)();
				offset=ColorTransform.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ColorTransform=null;
			}
			if(flags&0x10){//PlaceFlagHasRatio						//00010000
				Ratio=data[offset++]|(data[offset++]<<8);
			}else{
				Ratio=-1;
			}
			if(flags&0x20){//PlaceFlagHasName						//00100000
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}else{
				Name=null;
			}
			if(flags&0x40){//PlaceFlagHasClipDepth					//01000000
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}else{
				ClipDepth=-1;
			}
			if(flags&0x80){//PlaceFlagHasClipActions				//10000000
				var ClipActionsClass:Class;
				if(_initByDataOptions){
					if(_initByDataOptions.classes){
						ClipActionsClass=_initByDataOptions.classes["zero.swf.BytesData"];
					}
					if(ClipActionsClass){
					}else{
						ClipActionsClass=_initByDataOptions.ClipActionsClass;
					}
				}
				ClipActions=new (ClipActionsClass||BytesData)();
				offset=ClipActions.initByData(data,offset,endOffset,_initByDataOptions);
			}else{
				ClipActions=null;
			}
			return offset;
		}
		public function toData(_toDataOptions:Object/*zero_swf_ToDataOptions*/):ByteArray{
			var data:ByteArray=new ByteArray();
			var flags:int=0;
			if(PlaceFlagMove){
				flags|=0x01;										//00000001
			}
			data[1]=Depth;
			data[2]=Depth>>8;
			var offset:int=3;
			if(CharacterId>-1){
				flags|=0x02;//PlaceFlagHasCharacter					//00000010
				data[offset++]=CharacterId;
				data[offset++]=CharacterId>>8;
			}
			if(Matrix){
				flags|=0x04;//PlaceFlagHasMatrix					//00000100
				data.position=offset;
				data.writeBytes(Matrix.toData(_toDataOptions));
				offset=data.length;
			}
			if(ColorTransform){
				flags|=0x08;//PlaceFlagHasColorTransform			//00001000
				data.position=offset;
				data.writeBytes(ColorTransform.toData(_toDataOptions));
				offset=data.length;
			}
			if(Ratio>-1){
				flags|=0x10;//PlaceFlagHasRatio						//00010000
				data[offset++]=Ratio;
				data[offset++]=Ratio>>8;
			}
			if(Name is String){
				flags|=0x20;//PlaceFlagHasName						//00100000
				data.position=offset;
				data.writeUTFBytes(Name+"\x00");
				offset=data.length;
			}
			if(ClipDepth>-1){
				flags|=0x40;//PlaceFlagHasClipDepth					//01000000
				data[offset++]=ClipDepth;
				data[offset++]=ClipDepth>>8;
			}
			if(ClipActions){
				flags|=0x80;//PlaceFlagHasClipActions				//10000000
				data.position=offset;
				data.writeBytes(ClipActions.toData(_toDataOptions));
				offset=data.length;
			}
			data[0]=flags;
			return data;
		}

		////
		CONFIG::USE_XML{
		public function toXML(xmlName:String,_toXMLOptions:Object/*zero_swf_ToXMLOptions*/):XML{
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.PlaceObject2"
				PlaceFlagMove={PlaceFlagMove}
				Depth={Depth}
			/>;
			if(CharacterId>-1){
				xml.@CharacterId=CharacterId;
			}
			if(Matrix){
				xml.appendChild(Matrix.toXML("Matrix",_toXMLOptions));
			}
			if(ColorTransform){
				xml.appendChild(ColorTransform.toXML("ColorTransform",_toXMLOptions));
			}
			if(Ratio>-1){
				xml.@Ratio=Ratio;
			}
			if(Name is String){
				xml.@Name=Name;
			}
			if(ClipDepth>-1){
				xml.@ClipDepth=ClipDepth;
			}
			if(ClipActions){
				xml.appendChild(ClipActions.toXML("ClipActions",_toXMLOptions));
			}
			return xml;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object/*zero_swf_InitByXMLOptions*/):void{
			PlaceFlagMove=(xml.@PlaceFlagMove.toString()=="true");
			Depth=int(xml.@Depth.toString());
			var CharacterIdXML:XML=xml.@CharacterId[0];
			if(CharacterIdXML){
				CharacterId=int(CharacterIdXML.toString());
			}else{
				CharacterId=-1;
			}
			var MatrixXML:XML=xml.Matrix[0];
			if(MatrixXML){
				Matrix=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[MatrixXML["@class"].toString()]||MATRIX)();
				Matrix.initByXML(MatrixXML,_initByXMLOptions);
			}else{
				Matrix=null;
			}
			var ColorTransformXML:XML=xml.ColorTransform[0];
			if(ColorTransformXML){
				ColorTransform=new (_initByXMLOptions&&_initByXMLOptions.customClasses&&_initByXMLOptions.customClasses[ColorTransformXML["@class"].toString()]||CXFORMWITHALPHA)();
				ColorTransform.initByXML(ColorTransformXML,_initByXMLOptions);
			}else{
				ColorTransform=null;
			}
			var RatioXML:XML=xml.@Ratio[0];
			if(RatioXML){
				Ratio=int(RatioXML.toString());
			}else{
				Ratio=-1;
			}
			var NameXML:XML=xml.@Name[0];
			if(NameXML){
				Name=NameXML.toString();
			}else{
				Name=null;
			}
			var ClipDepthXML:XML=xml.@ClipDepth[0];
			if(ClipDepthXML){
				ClipDepth=int(ClipDepthXML.toString());
			}else{
				ClipDepth=-1;
			}
			var ClipActionsXML:XML=xml.ClipActions[0];
			if(ClipActionsXML){
				var classStr:String=ClipActionsXML["@class"].toString();
				var ClipActionsClass:Class=null;
				if(_initByXMLOptions&&_initByXMLOptions.customClasses){
					ClipActionsClass=_initByXMLOptions.customClasses[classStr];
				}
				if(ClipActionsClass){
				}else{
					try{
						ClipActionsClass=getDefinitionByName(classStr) as Class;
					}catch(e:Error){
						ClipActionsClass=null;
					}
				}
				if(ClipActionsClass){
				}else{
					ClipActionsClass=BytesData;
				}
				ClipActions=new ClipActionsClass();
				ClipActions.initByXML(ClipActionsXML,_initByXMLOptions);
			}else{
				ClipActions=null;
			}
		}
		}//end of CONFIG::USE_XML
	}
}
