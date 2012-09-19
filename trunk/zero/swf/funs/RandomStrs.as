/***
RandomStrs 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年6月13日 16:25:29
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import zero.utils.arrangement;
	import zero.utils.disorder;

	public class RandomStrs{
		
		private static const valueArr:Array=[
			"*","void","null","Infinity","NaN","undefined","false","true","this",
			"a","b","c","i","j","k",
			"accessibilityProperties","alpha","blendMode","blendShader","buttonMode","cacheAsBitmap","constructor","contextMenu","currentFrame","currentFrameLabel","currentLabel","currentLabels","currentScene","doubleClickEnabled","dropTarget","enabled","filters","focusRect","framesLoaded","graphics","height","hitArea","loaderInfo","mask","mouseChildren","mouseEnabled","mouseX","mouseY","name","numChildren","opaqueBackground","parent","prototype","root","rotation","rotationX","rotationY","rotationZ","scale9Grid","scaleX","scaleY","scaleZ","scenes","scrollRect","soundTransform","stage","tabChildren","tabEnabled","tabIndex","textSnapshot","totalFrames","trackAsMenu","transform","useHandCursor","visible","width","x","y","z"
		];
		private static const funArr:Array=[
			"Array","Boolean","decodeURI","decodeURIComponent","encodeURI","encodeURIComponent","escape","int","isFinite","isNaN","isXMLName","Number","Object","parseFloat","parseInt","String","trace","uint","unescape","Vector","XML","XMLList",
			"clearInterval","clearTimeout","describeType","escapeMultiByte","getDefinitionByName","getQualifiedClassName","getQualifiedSuperclassName","getTimer","setInterval","setTimeout","unescapeMultiByte",
			"MovieClip","addChild","addChildAt","addEventListener","areInaccessibleObjectsUnderPoint","contains","dispatchEvent","getBounds","getChildAt","getChildByName","getChildIndex","getObjectsUnderPoint","getRect","globalToLocal","globalToLocal3D","gotoAndPlay","gotoAndStop","hasEventListener","hasOwnProperty","hitTestObject","hitTestPoint","isPrototypeOf","local3DToGlobal","localToGlobal","nextFrame","nextScene","play","prevFrame","prevScene","propertyIsEnumerable","removeChild","removeChildAt","removeEventListener","setChildIndex","setPropertyIsEnumerable","startDrag","stop","stopDrag","swapChildren","swapChildrenAt","toLocaleString","toString","valueOf","willTrigger"
		];
		
		private static const key0Arr:Array=["var","const","function"];
		private static const key1Arr:Array=["public","private","protected","internal","native"];
		private static const key2Arr:Array=["dynamic","final","override","static"];
		private static const key3Arr:Array=["break","case","switch","continue","default","do","while","else","for","each","in","if","label","return","super","switch","throw","try","catch","finally","while","with"];
		
		private static const op1_1Arr:Array=["-","++","--","~","!"];
		private static const op1_2Arr:Array=["++","--"];
		private static const op2_1Arr:Array=["+","-","*","/","%","&","|","^","<<",">>",">>>","&&","||"];
		private static const op2_2Arr:Array=["==","!=","===","!==",">",">=","<","<="];
		
		private static const junkUTFStrArr:Array=["\xff","\xfe","\xfb","\xfc","\xfd","\xfa","\xf9","\xf8"];
		
		private static var strV:Vector.<String>;
		private static var mark:Object;
		
		public static function init(seed:String):void{
			//设置种子，这样如果有人破解开则会看到大量的这个字符串
			
			//trace("AS3 不能使用 :: 或 .");
			//trace("AS2 不能使用 : 或 .");
			
			mark=new Object();
			
			strV=
				getSeedStrV(seed)
				.concat(Vector.<String>(arrangement("\b\f\n\r\t\v",4)))
				.concat(Vector.<String>(arrangement("+-*/&|^~",4)))
				.concat(Vector.<String>(arrangement("!@#$",4)))
				.concat(Vector.<String>(arrangement("()[]{}",4)))
				.concat(Vector.<String>(arrangement("'\",;",4)));
			
			normalizeStrV(strV);
			
			disorder(strV);
		}
		private static function normalizeStrV(strV:Vector.<String>):void{
			//去掉重复的
			var i:int=strV.length;
			while(--i>=0){
				var str:String=strV[i];
				if(str){
					if(mark["~"+str]){
						strV.splice(i,1);
					}else{
						mark["~"+str]=true;
					}
				}
			}
		}
		private static function getSeedStrV(seed:String):Vector.<String>{
			if(seed){
				seed="@"+seed+"\n["+new Date()+"]\n";
				seed=seed.replace(/\:/g,";");
				seed=seed.replace(/\./g,",");
				var seed2:String=seed.split("").join(" ");
				var seedStrV:Vector.<String>=new Vector.<String>();
				seedStrV[0]=seed;
				seedStrV[1]=seed2;
				for(var totalSpace:int=1;totalSpace<10;totalSpace++){
					var i:int=totalSpace+1;
					while(--i>=0){
						var spaces1:String=getSpaces(i);
						var spaces2:String=getSpaces(totalSpace-i);
						seedStrV.push(
							spaces1+seed+spaces2,
							spaces1+seed2+spaces2
						);
					}
				}
				
				return seedStrV;
				
			}
			throw new Error("seed="+seed);
		}
		private static function getSpaces(totalSpace:int):String{
			var spaces:String="";
			while(--totalSpace>=0){
				spaces+=" ";
			}
			return spaces;
		}
		public static function getRanArr(len:int):Array{
			var ranArr:Array=new Array();
			for(var i:int=0;i<len;i++){
				ranArr[i]=getRan();
			}
			return ranArr;
		}
		
		/*
		trace("测试");
		private static var testId:int=-1;
		public static function getRan():String{
			return "测试"+(++testId);
		}
		//*/
		///*
		public static function getRan():String{
			if(strV){
				if(strV.length==0||Math.random()<0.8){
					if(Math.random()<0.5){
						var str:String=getCodeRan();
					}else{
						str=getClassRan();
					}
				}else{
					str=strV.pop();
				}
				if(str.search(/[\:\.]/)>-1){
					throw new Error("不合法的 str："+str);
				}
				
				//20110912
				var arr:Array=str.split("");
				var i:int=3+int(Math.random()*3);
				while(--i>=0){
					arr.splice(int(arr.length*Math.random()),0,junkUTFStrArr[int(junkUTFStrArr.length*Math.random())]);
				}
				str=arr.join("");
				
				//trace("str="+str);
				return str;
			}
			throw new Error("请先 init");
		}
		//*/
		private static function getCodeRan():String{
			do{
				switch(int(Math.random()*9)){
					case 0:
						var codeStr:String=getSimpleCode();
					break;
					case 1:
						codeStr="if("+getSimpleCode()+"){\n\t"+getSimpleCode()+";\n}";
						if(Math.random()<0.2){
							codeStr+="else{\n\t"+getSimpleCode()+";\n}";
						}
					break;
					case 2:
						codeStr="with("+valueArr[int(valueArr.length*Math.random())]+"){\n\t"+getSimpleCode()+";\n}";
					break;
					case 3:
						codeStr="while("+getSimpleCode()+"){\n\t"+getSimpleCode()+";\n}";
					break;
					case 4:
						codeStr="do{\n\t"+getSimpleCode()+";\n}while("+getSimpleCode()+")";
					break;
					case 5:
						codeStr="switch("+getSimpleCode()+"){\n";
						var i:int=int(Math.random()*3)+2;
						while(--i>=0){
							codeStr+=
								"\tcase "+getSimpleCode()+";\n"+
								"\t\t"+getSimpleCode()+";\n"+
								"\tbreak;\n";
						}
						if(Math.random()<0.7){
							codeStr+=
								"\tdefault;\n"+
								"\t\t"+getSimpleCode()+";\n"+
								"\tbreak;\n";
						}
						codeStr+="\n}";
					break;
					case 6:
						codeStr="for(var "+valueArr[int(valueArr.length*Math.random())]+";String in "+valueArr[int(valueArr.length*Math.random())]+"){\n\t"+getSimpleCode()+";\n}";
					break;
					case 7:
						codeStr="for each(var "+valueArr[int(valueArr.length*Math.random())]+";"+flash_classNameV[int(flash_classNameV.length*Math.random())]+" in "+valueArr[int(valueArr.length*Math.random())]+"){\n\t"+getSimpleCode()+";\n}";
					break;
					default:
						codeStr="try{\n\t"+getSimpleCode()+";\n}catch(e;Error){\n\t"+getSimpleCode()+";\n}";
						if(Math.random()<0.3){
							codeStr+="finally{\n\t"+getSimpleCode()+";\n}";
						}
					break;
				}
			}while(mark["~"+codeStr]);
			mark["~"+codeStr]=true;
			
			return codeStr;
		}
		private static function getSimpleCode():String{
			if(Math.random()<0.9){
				switch(int(Math.random()*4)){
					case 0:
						if(Math.random()<0.5){
							return op1_1Arr[int(op1_1Arr.length*Math.random())]+valueArr[int(valueArr.length*Math.random())];
						}
						return valueArr[int(valueArr.length*Math.random())]+op1_2Arr[int(op1_2Arr.length*Math.random())];
					break;
					case 1:
						if(Math.random()<0.7){
							return valueArr[int(valueArr.length*Math.random())]+" "+op2_1Arr[int(op2_1Arr.length*Math.random())]+" "+valueArr[int(valueArr.length*Math.random())];
						}
						return valueArr[int(valueArr.length*Math.random())]+" "+op2_1Arr[int(op2_1Arr.length*Math.random())]+"= "+valueArr[int(valueArr.length*Math.random())];
					break;
					case 2:	
						return valueArr[int(valueArr.length*Math.random())]+" "+op2_2Arr[int(op2_2Arr.length*Math.random())]+" "+valueArr[int(valueArr.length*Math.random())];
					break;
					default:
						return key3Arr[int(key3Arr.length*Math.random())];
					break;
				}
			}
			return getClassRan();
		}
		private static function getClassRan():String{
			do{
				var codeStr:String="";
				var classStr:String="";
				var className:String=flash_classNameV[int(flash_classNameV.length*Math.random())];
				if(Math.random()<0.5){
					if(Math.random()<0.2){
						classStr+=key1Arr[int(key1Arr.length*Math.random())]+" ";
					}
					if(Math.random()<0.2){
						classStr+=key2Arr[int(key2Arr.length*Math.random())]+" ";
					}
					classStr+="class "+className;
					if(Math.random()<0.2){
						classStr+=" extends "+flash_classNameV[int(flash_classNameV.length*Math.random())];
					}
					if(Math.random()<0.2){
						classStr+=" implements "+flash_interfaceNameV[int(flash_interfaceNameV.length*Math.random())];
						var i:int=int(Math.random()*3);
						while(--i>=0){
							classStr+=", "+flash_interfaceNameV[int(flash_interfaceNameV.length*Math.random())];
						}
					}
				}else{
					if(Math.random()<0.2){
						classStr+=key1Arr[int(key1Arr.length*Math.random())]+" ";
					}
					if(Math.random()<0.2){
						classStr+=key2Arr[int(key2Arr.length*Math.random())]+" ";
					}
					classStr+=key0Arr[int(key0Arr.length*Math.random())]+" "+valueArr[int(valueArr.length*Math.random())]+";"+className;
					if(Math.random()<0.2){
						if(Math.random()<0.3){
							classStr+=" = "+funArr[int(funArr.length*Math.random())]+"(new "+className+"())";
						}else{
							classStr+=" = new "+className+"()";
							if(Math.random()<0.3){
								classStr+=","+funArr[int(funArr.length*Math.random())]+"()";
							}
						}
					}
					//classStr+=";";
				}
				
				if(Math.random()<0.1){
					switch(int(Math.random()*5)){
						case 0:
							classStr="/*"+classStr;
						break;
						case 1:
							classStr=classStr+"*/";
						break;
						case 2:
							classStr="//"+classStr;
						break;
						case 3:
							classStr="\""+classStr;
						break;
						case 4:
							classStr=classStr+"\"";
						break;
						case 5:
							classStr="'"+classStr;
						break;
						case 6:
							classStr=classStr+"'";
						break;
					}
				}
				
			}while(mark["~"+classStr]);
			mark["~"+classStr]=true;
			
			return classStr;
		}
	}
}

