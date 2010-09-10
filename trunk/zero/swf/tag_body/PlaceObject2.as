/***
PlaceObject2 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月9日 23:25:14 (代码生成器: F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf) 
历次修改:未有修改
用法举例:这家伙很懒什么都没写
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
package zero.swf.tag_body{
	import zero.swf.record.MATRIX;
	import zero.swf.record.CXFORMWITHALPHA;
	import zero.swf.BytesData;
	import flash.utils.ByteArray;
	public class PlaceObject2 extends TagBody{
		public var PlaceFlagHasClipActions:int;
		public var PlaceFlagHasClipDepth:int;
		public var PlaceFlagHasName:int;
		public var PlaceFlagHasRatio:int;
		public var PlaceFlagHasColorTransform:int;
		public var PlaceFlagHasMatrix:int;
		public var PlaceFlagHasCharacter:int;
		public var PlaceFlagMove:int;
		public var Depth:int;							//UI16
		public var CharacterId:int;						//UI16
		public var Matrix:MATRIX;
		public var ColorTransform:CXFORMWITHALPHA;
		public var Ratio:int;							//UI16
		public var Name:String;							//STRING
		public var ClipDepth:int;						//UI16
		public var ClipActions:BytesData;
		//
		override public function initByData(data:ByteArray,offset:int,endOffset:int):int{
			var flags:int=data[offset];
			PlaceFlagHasClipActions=(flags<<24)>>>31;	//10000000
			PlaceFlagHasClipDepth=(flags<<25)>>>31;		//01000000
			PlaceFlagHasName=(flags<<26)>>>31;			//00100000
			PlaceFlagHasRatio=(flags<<27)>>>31;			//00010000
			PlaceFlagHasColorTransform=(flags<<28)>>>31;//00001000
			PlaceFlagHasMatrix=(flags<<29)>>>31;		//00000100
			PlaceFlagHasCharacter=(flags<<30)>>>31;		//00000010
			PlaceFlagMove=flags&0x01;					//00000001
			Depth=data[offset+1]|(data[offset+2]<<8);
			//#offsetpp
			offset+=3;
			if(PlaceFlagHasCharacter){
				CharacterId=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasMatrix){
				//#offsetpp
			
				Matrix=new MATRIX();
				offset=Matrix.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(PlaceFlagHasColorTransform){
				//#offsetpp
			
				ColorTransform=new CXFORMWITHALPHA();
				offset=ColorTransform.initByData(data,offset,endOffset);
			}
			//#offsetpp
			
			if(PlaceFlagHasRatio){
				Ratio=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasName){
				var get_str_size:int=0;
				while(data[offset+(get_str_size++)]){}
				data.position=offset;
				Name=data.readUTFBytes(get_str_size);
				offset+=get_str_size;
			}
			//#offsetpp
			
			if(PlaceFlagHasClipDepth){
				ClipDepth=data[offset++]|(data[offset++]<<8);
			}
			//#offsetpp
			
			if(PlaceFlagHasClipActions){
				//#offsetpp
			
				ClipActions=new BytesData();
				offset=ClipActions.initByData(data,offset,endOffset);
			}
			return offset;
		}
		override public function toData():ByteArray{
			var data:ByteArray=new ByteArray();
			//var offset:int=0;//测试
			var flags:int=0;
			flags|=PlaceFlagHasClipActions<<7;			//10000000
			flags|=PlaceFlagHasClipDepth<<6;			//01000000
			flags|=PlaceFlagHasName<<5;					//00100000
			flags|=PlaceFlagHasRatio<<4;				//00010000
			flags|=PlaceFlagHasColorTransform<<3;		//00001000
			flags|=PlaceFlagHasMatrix<<2;				//00000100
			flags|=PlaceFlagHasCharacter<<1;			//00000010
			flags|=PlaceFlagMove;						//00000001
			data[0]=flags;
			
			data[1]=Depth;
			data[2]=Depth>>8;
			//#offsetpp
			var offset:int=3;
			if(PlaceFlagHasCharacter){
				data[offset++]=CharacterId;
				data[offset++]=CharacterId>>8;
			}
			//#offsetpp
			
			if(PlaceFlagHasMatrix){
				data.position=offset;
				data.writeBytes(Matrix.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasColorTransform){
				data.position=offset;
				data.writeBytes(ColorTransform.toData());
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasRatio){
				data[offset++]=Ratio;
				data[offset++]=Ratio>>8;
			}
			//#offsetpp
			
			if(PlaceFlagHasName){
				data.position=offset;
				data.writeUTFBytes(Name+"\x00");
				offset=data.length;
			}
			//#offsetpp
			
			if(PlaceFlagHasClipDepth){
				data[offset++]=ClipDepth;
				data[offset++]=ClipDepth>>8;
			}
			if(PlaceFlagHasClipActions){
				data.position=offset;
				data.writeBytes(ClipActions.toData());
			}
			return data;
		}

		////
		CONFIG::toXMLAndInitByXML {
		override public function toXML():XML{
			var xml:XML=<PlaceObject2
				PlaceFlagHasClipActions={PlaceFlagHasClipActions}
				PlaceFlagHasClipDepth={PlaceFlagHasClipDepth}
				PlaceFlagHasName={PlaceFlagHasName}
				PlaceFlagHasRatio={PlaceFlagHasRatio}
				PlaceFlagHasColorTransform={PlaceFlagHasColorTransform}
				PlaceFlagHasMatrix={PlaceFlagHasMatrix}
				PlaceFlagHasCharacter={PlaceFlagHasCharacter}
				PlaceFlagMove={PlaceFlagMove}
				Depth={Depth}
				CharacterId={CharacterId}
				Ratio={Ratio}
				Name={Name}
				ClipDepth={ClipDepth}
			>
				<Matrix/>
				<ColorTransform/>
				<ClipActions/>
			</PlaceObject2>;
			if(PlaceFlagHasCharacter){
				
			}else{
				delete xml.@CharacterId;
			}
			if(PlaceFlagHasMatrix){
				xml.Matrix.appendChild(Matrix.toXML());
			}else{
				delete xml.Matrix;
			}
			if(PlaceFlagHasColorTransform){
				xml.ColorTransform.appendChild(ColorTransform.toXML());
			}else{
				delete xml.ColorTransform;
			}
			if(PlaceFlagHasRatio){
				
			}else{
				delete xml.@Ratio;
			}
			if(PlaceFlagHasName){
				
			}else{
				delete xml.@Name;
			}
			if(PlaceFlagHasClipDepth){
				
			}else{
				delete xml.@ClipDepth;
			}
			if(PlaceFlagHasClipActions){
				xml.ClipActions.appendChild(ClipActions.toXML());
			}else{
				delete xml.ClipActions;
			}
			return xml;
		}
		override public function initByXML(xml:XML):void{
			PlaceFlagHasClipActions=int(xml.@PlaceFlagHasClipActions.toString());
			PlaceFlagHasClipDepth=int(xml.@PlaceFlagHasClipDepth.toString());
			PlaceFlagHasName=int(xml.@PlaceFlagHasName.toString());
			PlaceFlagHasRatio=int(xml.@PlaceFlagHasRatio.toString());
			PlaceFlagHasColorTransform=int(xml.@PlaceFlagHasColorTransform.toString());
			PlaceFlagHasMatrix=int(xml.@PlaceFlagHasMatrix.toString());
			PlaceFlagHasCharacter=int(xml.@PlaceFlagHasCharacter.toString());
			PlaceFlagMove=int(xml.@PlaceFlagMove.toString());
			Depth=int(xml.@Depth.toString());
			if(PlaceFlagHasCharacter){
				CharacterId=int(xml.@CharacterId.toString());
			}
			if(PlaceFlagHasMatrix){
				Matrix=new MATRIX();
				Matrix.initByXML(xml.Matrix.children()[0]);
			}
			if(PlaceFlagHasColorTransform){
				ColorTransform=new CXFORMWITHALPHA();
				ColorTransform.initByXML(xml.ColorTransform.children()[0]);
			}
			if(PlaceFlagHasRatio){
				Ratio=int(xml.@Ratio.toString());
			}
			if(PlaceFlagHasName){
				Name=xml.@Name.toString();
			}
			if(PlaceFlagHasClipDepth){
				ClipDepth=int(xml.@ClipDepth.toString());
			}
			if(PlaceFlagHasClipActions){
				ClipActions=new BytesData();
				ClipActions.initByXML(xml.ClipActions.children()[0]);
			}
		}
		}//end of CONFIG::toXMLAndInitByXML
	}
}
