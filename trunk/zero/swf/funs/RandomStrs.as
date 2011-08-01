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
	flash.utils.
	public class RandomStrs{
		private static var seedV:Vector.<String>;
		private static var mark:Object;
		private static var firstUseStrArr:Array;//优先使用的字符串, 不带空格或只带前后空格的, 或比较均匀好看的...
		public static function initSeed(seed:String):void{
			//设置种子，这样如果有人破解开则会看到大量的这个字符串
			mark=new Object();
			seedV=Vector.<String>(seed.split(""));
			var seed2:String=seedV.join(" ");
			firstUseStrArr=[seed,seed2];
			for(var totalSpace:int=1;totalSpace<5;totalSpace++){
				var i:int=totalSpace+1;
				while(--i>=0){
					var spaces1:String=getSpaces(i);
					var spaces2:String=getSpaces(totalSpace-i);
					firstUseStrArr[firstUseStrArr.length]=spaces1+seed+spaces2;
					firstUseStrArr[firstUseStrArr.length]=spaces1+seed2+spaces2;
				}
				//trace("firstUseStrArr="+firstUseStrArr.join("|"));
			}
			//disorderArr(firstUseStrArr);
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
			var i:int=len;
			while(--i>=0){
				ranArr[i]=getRan();
			}
			return ranArr;
		}
		//private static var testingId:int=0;
		public static function getRan():String{
			//if(testingId>=0){
			//	return "随机"+testingId++;
			//}
			if(mark){
			}else{
				throw new Error("请先调用 initSeed 设置种子");
			}
			var ran:String;
			if(firstUseStrArr.length>0){
				ran=firstUseStrArr.shift();
				mark[ran]=true;
				return ran;
			}
			var depth:int=10;
			while(--depth>=0){
				for(var totalSpace:int=0;totalSpace<100;totalSpace++){
					var i:int=totalSpace;
					var ranV:Vector.<String>=seedV.slice();
					while(--i>=0){
						ranV.splice(int(Math.random()*ranV.length),0," ");
					}
					ran=ranV.join("");
					if(mark[ran]){
					}else{
						mark[ran]=true;
						return ran;
					}
				}
			}
			throw new Error("循环太多, 可能是 getRan() 太多。");
		}
		
		/*
		//简单的等长随机字符组合
		private static var strArr:Array=getStrArr();
		private static var currId:int=0;
		
		public static function getRanArr(len:int):Array{
			var ranArr:Array=strArr.slice(currId,currId+len);
			currId+=len;
			if(currId>=strArr.length){
				throw new Error("currId>=strArr.length");
			}
			return ranArr;
		}
		public static function getRan():String{
			var ran:String=strArr[currId];
			if(++currId>=strArr.length){
				throw new Error("currId>=strArr.length");
			}
			return ran;
		}
		
		private static function getStrArr():Array{
			var strArr:Array=new Array();
			//var cArr:Array=["\b","\f","\n","\r","\t","\v"];
			var cArr:Array=["(",")","[","]","{","}"];
			var i:int,i1:int,i2:int,i3:int,i4:int,i5:int,L:int;
			L=cArr.length;
			i1=L;
			while(--i1>=0){
				var ci1:String=cArr[i1];
				i2=L;
				while(--i2>=0){
					var ci2:String=cArr[i2];
					i3=L;
					while(--i3>=0){
						var ci3:String=cArr[i3];
						i4=L;
						while(--i4>=0){
							var ci4:String=cArr[i4];
							i5=L;
							while(--i5>=0){
								strArr[strArr.length]=ci1+ci2+ci3+ci4+cArr[i5];
							}
						}
					}
				}
			}
			disorderArr(strArr);
			return strArr;
		}
		*/
		
		/*
		//比较让人困惑的
		public static var testing:Boolean=false;
		private static var testingId:int=0;
		private static var mark:Object;
		private static var interfaceNameV:Vector.<String>;
		private static var classNameV:Vector.<String>=getClassNameV();
		
		private static function getClassNameV():Vector.<String>{
			mark=new Object();
			interfaceNameV=new Vector.<String>();
			classNameV=new Vector.<String>();
			
			for each(var str:String in ReservedStrs.classStrV){
				if(str.indexOf("I")==0){
					interfaceNameV[interfaceNameV.length]=str;
				}else{
					classNameV[classNameV.length]=str;
				}
			}
			return classNameV;
		}
		
		public static function getRanArr(len:int):Array{
			var ranArr:Array=new Array();
			var i:int=len;
			while(--i>=0){
				ranArr[i]=getRan();
			}
			return ranArr;
		}
		public static function getRan():String{
			if(testing){
				return "简单混淆"+testingId++;
			}
			var str:String="";
			var depth:int;
			if(Math.random()<0.3){
				depth=10;
				do{
					var totalInterface:int=int(Math.random()*3)+1;
					var interfaceStr:String="";
					while(--totalInterface>=0){
						interfaceStr+=","+interfaceNameV[int(Math.random()*interfaceNameV.length)];
					}
					str=classNameV[int(Math.random()*classNameV.length)]+" implements "+interfaceStr.substr(1);
				}while(mark[str]&&(--depth>=0));
			}
			if(!str){
				//到了这里一定得取出一个 str 来
				do{
					str=classNameV[int(Math.random()*classNameV.length)]+" extends "+classNameV[int(Math.random()*classNameV.length)];
				}while(mark[str]);
			}
			
			if(str){
				if(ReservedStrs.checkIsReserved(str)){
					throw new Error("不能使用保留字");
				}
				if(str.indexOf(".")>=0){
					throw new Error("str不能有\".\": "+str);
				}
				
				mark[str]=true;
				if(Math.random()<0.1){
					switch(int(Math.random()*5)){
						case 0:
							return "/"+"*"+str;
						break;
						case 1:
							return "*"+"/"+str;
						break;
						case 2:
							return "//"+str;
						break;
						case 3:
							return "\""+str;
						break;
						case 4:
							return "'"+str;
						break;
					}
				}
				return str;
			}
			
			throw new Error("str="+str);
			return null;
		}
		*/
	}
}

