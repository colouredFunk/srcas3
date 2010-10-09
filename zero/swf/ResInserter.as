/***
ResInserter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月29日 13:45:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.tag_body.DefineBinaryData;
	import zero.swf.tag_body.DefineBitsJPEG2;
	import zero.swf.tag_body.SymbolClass;
	
	public class ResInserter{
		public static const BITMAP:String="Bmd";
		//public static const SOUND:String="Snd";
		public static const DATA:String="Dat";
		public static const types:Array=[
			{label:"图片",data:BITMAP},
			//{label:"声音",data:SOUND},
			{label:"数据",data:DATA}
		];
		
		private var classNameV:Vector.<String>;
		private var defIdV:Vector.<int>;
		private var avalibleDefineObjIdV:Vector.<int>;
		private var tagV:Vector.<Tag>;
		
		public function ResInserter(swfTagV:Vector.<Tag>){
			avalibleDefineObjIdV=GetAvalibleDefineObjIdV.getAvalibleDefineObjIdV(swfTagV);
			//trace("avalibleDefineObjIdV="+avalibleDefineObjIdV);
			clearTags();
		}
		public function insert(
			resData:ByteArray,
			className:String,
			type:String,
			addSymbolClass:Boolean=false
		):void{
			//trace("resData.length="+resData.length);
			var defId:int=avalibleDefineObjIdV.shift();
			var tag:Tag=new Tag();
			switch(type){
				case BITMAP:
					var defineBitsJPEG2:DefineBitsJPEG2=new DefineBitsJPEG2();
					defineBitsJPEG2.id=defId;
					defineBitsJPEG2.ImageData=new BytesData();
					defineBitsJPEG2.ImageData.initByData(resData,0,resData.length);
					tag.tagBody=defineBitsJPEG2;
				break;
				/*
				case SOUND:
				break;
				*/
				case DATA:
					var defineBinaryData:DefineBinaryData=new DefineBinaryData();
					defineBinaryData.id=defId;
					defineBinaryData.Data=new BytesData();
					defineBinaryData.Data.initByData(resData,0,resData.length);
					tag.tagBody=defineBinaryData;
				break;
				default:
					throw new Error("不支持的 type: "+type);
				break;
			}
			
			tagV[tagV.length]=tag;
			
			if(addSymbolClass){
				var symbolClass:SymbolClass=new SymbolClass();
				symbolClass.NameV=new Vector.<String>();
				symbolClass.NameV[0]=className;
				symbolClass.TagV=new Vector.<int>();
				symbolClass.TagV[0]=defId;
				tag=new Tag();
				tag.tagBody=symbolClass;
				tagV[tagV.length]=tag;
			}else{
				classNameV[classNameV.length]=className;
				defIdV[defIdV.length]=defId;
			}
		}
		public function getTagVAndReset():Vector.<Tag>{
			var symbolClass:SymbolClass=new SymbolClass();
			for each(var className:String in classNameV){
				symbolClass.NameV=classNameV;
				symbolClass.TagV=defIdV;
			}
			var tag:Tag=new Tag();
			tag.tagBody=symbolClass;
			tagV[tagV.length]=tag;
			var _tagV:Vector.<Tag>=tagV;
			clearTags();
			return _tagV;
		}
		private function clearTags():void{
			classNameV=new Vector.<String>();
			defIdV=new Vector.<int>();
			tagV=new Vector.<Tag>();
		}
	}
}

//

// 常忘正则表达式
// /^\s*|\s*$/					//前后空白						"\nabc d  e 哈 哈\t \r".replace(/^\s*|\s*$/g,"") === "abc d  e 哈 哈"
// /[\\\/:*?\"<>|]/				//不合法的windows文件名字符集		"\\\/:*?\"<>|\\\/:*哈 哈?\"<>|\\哈 \/:*?\"<>|".replace(/[\\\/:*?\"<>|]/g,"") === "哈 哈哈 "
// /[a-zA-Z_][a-zA-Z0-9_]*/		//合法的变量名(不考虑中文)
// value=value.replace(/[^a-zA-Z0-9_]/g,"").replace(/^[0-9]*/,"");//替换不合法的变量名
// 先把除字母数字下划线的字符去掉,再把开头的数字去掉
// 想不到怎样能用一个正则表达式搞定...

//正则表达式30分钟入门教程		http://www.unibetter.com/deerchao/zhengzhe-biaodashi-jiaocheng-se.htm
//正则表达式用法及实例			http://eskimo.blogbus.com/logs/29095458.html
//常用正则表达式					http://www.williamlong.info/archives/433.html

/*

//常用值

//常用语句块

*/