/***
getProductInfo
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年0月日 21:16:02
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.utils.ByteArray;
	
	import zero.codec.getSWFTagBodyData;

	public function getProductInfo(swfData:ByteArray):XML{
		var productInfoData:ByteArray=getSWFTagBodyData(
			swfData,
			41//ProductInfo
		);
		
		if(productInfoData){
			
			var ProductID:uint=productInfoData[0]|(productInfoData[1]<<8)|(productInfoData[2]<<16)|(productInfoData[3]<<24);//UI32
			
			var Edition:uint=productInfoData[4]|(productInfoData[5]<<8)|(productInfoData[6]<<16)|(productInfoData[7]<<24);//UI32
			
			var MajorVersion:int=productInfoData[8];//UI8
			
			var MinorVersion:int=productInfoData[9];//UI8
			
			var BuildLow:uint=productInfoData[10]|(productInfoData[11]<<8)|(productInfoData[12]<<16)|(productInfoData[13]<<24);//UI32
			
			var BuildHigh:uint=productInfoData[14]|(productInfoData[15]<<8)|(productInfoData[16]<<16)|(productInfoData[17]<<24);//UI32
			
			var CompilationDate:Number=//UI64
				(
					productInfoData[18]|
					(productInfoData[19]<<8)|
					(productInfoData[20]<<16)
				)
				+productInfoData[21]*16777216
				+productInfoData[22]*4294967296
				+productInfoData[23]*1099511627776
				+productInfoData[24]*281474976710656
				+productInfoData[25]*72057594037927940;
			
			var date:Date=new Date(CompilationDate);
			
			return <ProductInfo
				ProductID={productIDV[ProductID]}
				Edition={editionV[Edition]}
				MajorVersion={MajorVersion}
				MinorVersion={MinorVersion}
				BuildLow={BuildLow}
				BuildHigh={BuildHigh}
				CompilationDate={
					date.fullYear+"年"+
					(100+(date.month+1)).toString().substr(1)+"月"+
					(date.date<10?("0"+date.date):date.date)+"日 "+
					(date.hours<10?("0"+date.hours):date.hours)+":"+
					(date.minutes<10?("0"+date.minutes):date.minutes)+":"+
					(date.seconds<10?("0"+date.seconds):date.seconds)+"."+
					date.milliseconds
				}
			/>;
		}
		//trace("获取 productInfoData 失败");
		return null;
	}
}

//const Unknown:int=0;//0x00
//const Macromedia_Flex_for_J2EE:int=1;//0x01
//const Macromedia_Flex_for_dotNET:int=2;//0x02
//const Adobe_Flex:int=3;//0x03

const productIDV:Vector.<String>=new <String>[
	"Unknown",//0x00
	"Macromedia_Flex_for_J2EE",//0x01
	"Macromedia_Flex_for_dotNET",//0x02
	"Adobe_Flex",//0x03
];
////
//const Developer_Edition:int=0;//0x00
//const Full_Commercial_Edition:int=1;//0x01
//const Non_Commercial_Edition:int=2;//0x02
//const Educational_Edition:int=3;//0x03
//const Not_For_Resale__NFR__Edition:int=4;//0x04
//const Trial_Edition:int=5;//0x05
//const None:int=6;//0x06

const editionV:Vector.<String>=new <String>[
	"Developer_Edition",//0x00
	"Full_Commercial_Edition",//0x01
	"Non_Commercial_Edition",//0x02
	"Educational_Edition",//0x03
	"Not_For_Resale__NFR__Edition",//0x04
	"Trial_Edition",//0x05
	"None",//0x06
];
////
//