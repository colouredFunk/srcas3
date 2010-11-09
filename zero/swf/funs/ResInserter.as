/***
ResInserter 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年9月29日 13:45:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.swf.BytesData;
	import zero.swf.Tag;
	import zero.swf.TagType;
	import zero.swf.tagBodys.DefineBinaryData;
	import zero.swf.tagBodys.DefineBitsJPEG2;
	import zero.swf.tagBodys.SymbolClass;
	
	public class ResInserter{
		public static const BITMAP:String="bmd";
		//public static const SOUND:String="snd";
		public static const DATA:String="dat";
		//public static const types:Array=[
		//	{label:"图片",data:BITMAP},
			//{label:"声音",data:SOUND},
		//	{label:"数据",data:DATA}
		//];
		
		private var swfTagV:Vector.<Tag>;
		private var avalibleDefineObjIdV:Vector.<int>;
		private var frameObjs:Object;
		
		
		public function ResInserter(_swfTagV:Vector.<Tag>){
			swfTagV=_swfTagV;
			avalibleDefineObjIdV=GetAvalibleDefineObjIdV.getAvalibleDefineObjIdV(swfTagV);
			//trace("avalibleDefineObjIdV="+avalibleDefineObjIdV);
			frameObjs=new Object();
		}
		public function insert(
			resData:ByteArray,
			className:String,
			type:String,
			frameId:int=-1,//如果要插入到原 swf 的最后一帧，则用 -1；如果要插入到某一特定帧，则输入 frameId
			addDoABC:Boolean=false,//如果原 swf 里已经有写好的类，则用 false；如果要使用默认的类，则用 true
			addSymbolClass:Boolean=false//如果要紧跟着 资源tag 创建 SymbolClassTag，则用 true；否则将在 getTagVAndReset() 时生成一个共用的 SymbolClassTag
		):BytesData{
			var frameObj:FrameObj=frameObjs["~"+frameId];
			if(frameObj){
			}else{
				frameObjs["~"+frameId]=frameObj=new FrameObj();
			}
			
			//trace("resData.length="+resData.length);
			var defId:int=avalibleDefineObjIdV.shift();
			var tag:Tag;
			
			if(addDoABC){
				frameObj.tagV.push(SimpleDoABC.getDoABCTag(className,type));
			}
			
			tag=new Tag();
			var resBytesData:BytesData=null;
			switch(type){
				case BITMAP:
					var defineBitsJPEG2:DefineBitsJPEG2=new DefineBitsJPEG2();
					defineBitsJPEG2.id=defId;
					defineBitsJPEG2.ImageData=resBytesData=new BytesData();
					//defineBitsJPEG2.ImageData.initByData(resData,0,resData.length);
					tag.setBody(defineBitsJPEG2);
				break;
				/*
				case SOUND:
				break;
				*/
				case DATA:
					var defineBinaryData:DefineBinaryData=new DefineBinaryData();
					defineBinaryData.id=defId;
					defineBinaryData.Data=resBytesData=new BytesData();
					//defineBinaryData.Data.initByData(resData,0,resData.length);
					tag.setBody(defineBinaryData);
				break;
				default:
					throw new Error("不支持的 type: "+type);
				break;
			}
			
			if(resData){
				resBytesData.initByData(resData,0,resData.length);
			}else{
				//可暂缓插入数据
			}
			
			frameObj.tagV.push(tag);
			
			if(addSymbolClass){
				var symbolClass:SymbolClass=new SymbolClass();
				symbolClass.NameV=new Vector.<String>();
				symbolClass.NameV[0]=className;
				symbolClass.TagV=new Vector.<int>();
				symbolClass.TagV[0]=defId;
				tag=new Tag();
				tag.setBody(symbolClass);
				frameObj.tagV.push(tag);
			}else{
				frameObj.classNameV.push(className);
				frameObj.defIdV.push(defId);
			}
			return resBytesData;
		}
		public function getTagVAndReset():void{
			//把插入的 resTag 们放到对应的帧里
			var swfTag:Tag;
			var frameObj:FrameObj;
			var frameId:int=0;
			for each(swfTag in swfTagV){
				if(swfTag.type==TagType.ShowFrame){
					frameId++;
				}
			}
			
			
			if(frameObjs["~-1"]){
				frameObj=frameObjs["~"+(frameId-1)];//最后一帧的 frameObj
				if(frameObj){
					frameObj.concat(frameObjs["~-1"]);
				}else{
					frameObjs["~"+(frameId-1)]=frameObjs["~-1"];
				}
			}
			
			var swfTagId:int=swfTagV.length;
			while(--swfTagId>=0){
				swfTag=swfTagV[swfTagId];
				if(swfTag.type==TagType.ShowFrame){
					frameId--;
					//trace("frameId="+frameId);
					frameObj=frameObjs["~"+frameId];
					//trace("frameObj="+frameObj);
					if(frameObj){
						var symbolClass:SymbolClass=new SymbolClass();
						symbolClass.NameV=frameObj.classNameV;
						symbolClass.TagV=frameObj.defIdV;
						var symbolClassTag:Tag=new Tag();
						symbolClassTag.setBody(symbolClass);
						var tagId:int=frameObj.tagV.length;
						swfTagV.splice(swfTagId,0,symbolClassTag);
						while(--tagId>=0){
							swfTagV.splice(swfTagId,0,frameObj.tagV[tagId]);
						}
					}
				}
			}
			frameObjs=new Object();
		}
	}
}

import zero.swf.Tag;
class FrameObj{
	public var classNameV:Vector.<String>;
	public var defIdV:Vector.<int>;
	public var tagV:Vector.<Tag>;
	public function FrameObj(){
		classNameV=new Vector.<String>();
		defIdV=new Vector.<int>();
		tagV=new Vector.<Tag>();
	}
	public function concat(frameObj:FrameObj):void{
		classNameV.concat(frameObj.classNameV);
		defIdV.concat(frameObj.defIdV);
		tagV.concat(frameObj.tagV);
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