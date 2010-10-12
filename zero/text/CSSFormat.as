/***
CSSFormat 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月11日 21:47:07
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.text{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flashx.textLayout.container.*;
	import flashx.textLayout.conversion.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.*;
	
	public class CSSFormat implements ITextLayoutFormat{
		/*
		public static function getCode():void{
			var cssNames:Vector.<String>=Vector.<String>(["behavior","direction","direction","font","font-family","font-size","font-style","font-variant","font-weight","ime-mode","layout-grid","layout-grid-char","layout-grid-line","layout-grid-mode","layout-grid-type","letter-spacing","line-break","line-height","min-height","ruby-align","ruby-overhang","ruby-position","text-align","text-autospace","text-decoration","text-indent","text-justify","text-kashida-space","text-overflow","text-transform","text-underline-position","unicode-bidi","vertical-align","white-space","word-break","word-spacing","word-wrap","writing-mode","background-attachment","background-color","background-image","background-position","background-position-x","background-position-y","background-repeat","color","border","border-bottom","border-bottom-color","border-bottom-style","border-bottom-width","border-collapse","border-color","border-left","border-left-color","border-left-style","border-left-width","border-right","border-right-color","border-right-style","border-right-width","border-style","border-top","border-top-color","border-top-style","border-top-width","border-width","clear","float","layout-flow","margin","margin-bottom","margin-left","margin-right","margin-top","padding","padding-bottom","padding-left","padding-right","padding-top","scrollbar-3dlight-color","scrollbar-arrow-color","scrollbar-base-color","scrollbar-darkshadow-color","scrollbar-face-color","scrollbar-highlight-color","scrollbar-shadow-color","table-layout","zoom","display","list-style","list-style-image","list-style-position","list-style-type","bottom","clip","height","left","overflow","overflow-x","overflow-y","position","right","top","visibility","width","z-index","page","pageBreakAfter","pageBreakBefore","filter",":active","@charset","cursor",":first-letter",":first-line","@font-face",":hover","@import","!important",":link","@media","@page",":visited"]);
			var itemNames:Vector.<String>=Vector.<String>(["color","backgroundColor","lineThrough","textAlpha","backgroundAlpha","fontSize","baselineShift","trackingLeft","trackingRight","lineHeight","breakOpportunity","digitCase","digitWidth","dominantBaseline","kerning","ligatureLevel","alignmentBaseline","locale","typographicCase","fontFamily","textDecoration","fontWeight","fontStyle","whiteSpaceCollapse","renderingMode","cffHinting","fontLookup","textRotation","textIndent","paragraphStartIndent","paragraphEndIndent","paragraphSpaceBefore","paragraphSpaceAfter","textAlign","textAlignLast","textJustify","justificationRule","justificationStyle","direction","tabStops","leadingModel","columnGap","paddingLeft","paddingTop","paddingRight","paddingBottom","columnCount","columnWidth","firstBaselineOffset","verticalAlign","blockProgression","lineBreak"]);
			var itemName:String;
			var cssName:String;
			
			var itemNameMark:Object=new Object();
			for each(itemName in itemNames){
				itemNameMark[itemName]=true;
			}
			
			var css2itemV:Vector.<Array>=new Vector.<Array>();
			for each(cssName in cssNames){
				if(itemNameMark[cssName]){
					itemName=cssName;
					delete itemNameMark[itemName];
					css2itemV.push([cssName,itemName]);
					continue;
				}else{
					var cssNameArr:Array=cssName.split("-");
					if(cssNameArr.length==2){
						itemName=cssNameArr[0]+cssNameArr[1].charAt(0).toUpperCase()+cssNameArr[1].substr(1);
						if(itemNameMark[itemName]){
							delete itemNameMark[itemName];
							css2itemV.push([cssName,itemName]);
							continue;
						}
					}
					if(cssNameArr.length==3){
						itemName=cssNameArr[0]+cssNameArr[1].charAt(0).toUpperCase()+cssNameArr[1].substr(1)+cssNameArr[2].charAt(0).toUpperCase()+cssNameArr[2].substr(1);
						if(itemNameMark[itemName]){
							delete itemNameMark[itemName];
							css2itemV.push([cssName,itemName]);
							continue;
						}
					}
				}
				trace("不支持的 CSS 属性: "+cssName);
			}
			for(itemName in itemNameMark){
				if(itemNameMark[itemName]){
					trace("找不到对应的 cssName 的 itemName: "+itemName);
				}
			}
			trace("----------------------------------------");
			trace(css2itemV.join("\n"));
			trace("\n\n\n");
			
			var css2item:Array;
			for each(css2item in css2itemV){
				trace("public static const "+css2item[1]+":String=\""+css2item[0]+"\";");
			}
			trace("\nprivate static const itemNameMark:Object=getItemNameMark();");
			trace("private static function getItemNameMark():Object{");
			trace("\tvar itemNameMark:Object=new Object();");
			for each(css2item in css2itemV){
				trace("\titemNameMark[\""+css2item[0]+"\"]=\""+css2item[1]+"\";");
			}
			trace("\treturn itemNameMark;");
			trace("}\n");
			for each(css2item in css2itemV){
				trace("private var __"+css2item[1]+":String;");
			}
			for each(itemName in itemNames){
				trace("public function get "+itemName+"():*{");
				if(itemNameMark[itemName]){
					trace("\treturn null;");
				}else{
					trace("\treturn __"+itemName+";");
				}
				trace("}");
			}
		}
		//*/
		
		/*
		不支持的 CSS 属性: behavior
		不支持的 CSS 属性: direction
		不支持的 CSS 属性: font
		不支持的 CSS 属性: font-variant
		不支持的 CSS 属性: ime-mode
		不支持的 CSS 属性: layout-grid
		不支持的 CSS 属性: layout-grid-char
		不支持的 CSS 属性: layout-grid-line
		不支持的 CSS 属性: layout-grid-mode
		不支持的 CSS 属性: layout-grid-type
		不支持的 CSS 属性: letter-spacing
		不支持的 CSS 属性: min-height
		不支持的 CSS 属性: ruby-align
		不支持的 CSS 属性: ruby-overhang
		不支持的 CSS 属性: ruby-position
		不支持的 CSS 属性: text-autospace
		不支持的 CSS 属性: text-kashida-space
		不支持的 CSS 属性: text-overflow
		不支持的 CSS 属性: text-transform
		不支持的 CSS 属性: text-underline-position
		不支持的 CSS 属性: unicode-bidi
		不支持的 CSS 属性: white-space
		不支持的 CSS 属性: word-break
		不支持的 CSS 属性: word-spacing
		不支持的 CSS 属性: word-wrap
		不支持的 CSS 属性: writing-mode
		不支持的 CSS 属性: background-attachment
		不支持的 CSS 属性: background-image
		不支持的 CSS 属性: background-position
		不支持的 CSS 属性: background-position-x
		不支持的 CSS 属性: background-position-y
		不支持的 CSS 属性: background-repeat
		不支持的 CSS 属性: border
		不支持的 CSS 属性: border-bottom
		不支持的 CSS 属性: border-bottom-color
		不支持的 CSS 属性: border-bottom-style
		不支持的 CSS 属性: border-bottom-width
		不支持的 CSS 属性: border-collapse
		不支持的 CSS 属性: border-color
		不支持的 CSS 属性: border-left
		不支持的 CSS 属性: border-left-color
		不支持的 CSS 属性: border-left-style
		不支持的 CSS 属性: border-left-width
		不支持的 CSS 属性: border-right
		不支持的 CSS 属性: border-right-color
		不支持的 CSS 属性: border-right-style
		不支持的 CSS 属性: border-right-width
		不支持的 CSS 属性: border-style
		不支持的 CSS 属性: border-top
		不支持的 CSS 属性: border-top-color
		不支持的 CSS 属性: border-top-style
		不支持的 CSS 属性: border-top-width
		不支持的 CSS 属性: border-width
		不支持的 CSS 属性: clear
		不支持的 CSS 属性: float
		不支持的 CSS 属性: layout-flow
		不支持的 CSS 属性: margin
		不支持的 CSS 属性: margin-bottom
		不支持的 CSS 属性: margin-left
		不支持的 CSS 属性: margin-right
		不支持的 CSS 属性: margin-top
		不支持的 CSS 属性: padding
		不支持的 CSS 属性: scrollbar-3dlight-color
		不支持的 CSS 属性: scrollbar-arrow-color
		不支持的 CSS 属性: scrollbar-base-color
		不支持的 CSS 属性: scrollbar-darkshadow-color
		不支持的 CSS 属性: scrollbar-face-color
		不支持的 CSS 属性: scrollbar-highlight-color
		不支持的 CSS 属性: scrollbar-shadow-color
		不支持的 CSS 属性: table-layout
		不支持的 CSS 属性: zoom
		不支持的 CSS 属性: display
		不支持的 CSS 属性: list-style
		不支持的 CSS 属性: list-style-image
		不支持的 CSS 属性: list-style-position
		不支持的 CSS 属性: list-style-type
		不支持的 CSS 属性: bottom
		不支持的 CSS 属性: clip
		不支持的 CSS 属性: height
		不支持的 CSS 属性: left
		不支持的 CSS 属性: overflow
		不支持的 CSS 属性: overflow-x
		不支持的 CSS 属性: overflow-y
		不支持的 CSS 属性: position
		不支持的 CSS 属性: right
		不支持的 CSS 属性: top
		不支持的 CSS 属性: visibility
		不支持的 CSS 属性: width
		不支持的 CSS 属性: z-index
		不支持的 CSS 属性: page
		不支持的 CSS 属性: pageBreakAfter
		不支持的 CSS 属性: pageBreakBefore
		不支持的 CSS 属性: filter
		不支持的 CSS 属性: :active
		不支持的 CSS 属性: @charset
		不支持的 CSS 属性: cursor
		不支持的 CSS 属性: :first-letter
		不支持的 CSS 属性: :first-line
		不支持的 CSS 属性: @font-face
		不支持的 CSS 属性: :hover
		不支持的 CSS 属性: @import
		不支持的 CSS 属性: !important
		不支持的 CSS 属性: :link
		不支持的 CSS 属性: @media
		不支持的 CSS 属性: @page
		不支持的 CSS 属性: :visited
		找不到对应的 cssName 的 itemName: dominantBaseline
		找不到对应的 cssName 的 itemName: whiteSpaceCollapse
		找不到对应的 cssName 的 itemName: alignmentBaseline
		找不到对应的 cssName 的 itemName: baselineShift
		找不到对应的 cssName 的 itemName: trackingRight
		找不到对应的 cssName 的 itemName: trackingLeft
		找不到对应的 cssName 的 itemName: locale
		找不到对应的 cssName 的 itemName: paragraphStartIndent
		找不到对应的 cssName 的 itemName: digitCase
		找不到对应的 cssName 的 itemName: paragraphEndIndent
		找不到对应的 cssName 的 itemName: digitWidth
		找不到对应的 cssName 的 itemName: paragraphSpaceBefore
		找不到对应的 cssName 的 itemName: breakOpportunity
		找不到对应的 cssName 的 itemName: ligatureLevel
		找不到对应的 cssName 的 itemName: paragraphSpaceAfter
		找不到对应的 cssName 的 itemName: typographicCase
		找不到对应的 cssName 的 itemName: kerning
		找不到对应的 cssName 的 itemName: textAlignLast
		找不到对应的 cssName 的 itemName: justificationStyle
		找不到对应的 cssName 的 itemName: tabStops
		找不到对应的 cssName 的 itemName: justificationRule
		找不到对应的 cssName 的 itemName: leadingModel
		找不到对应的 cssName 的 itemName: columnGap
		找不到对应的 cssName 的 itemName: lineThrough
		找不到对应的 cssName 的 itemName: columnCount
		找不到对应的 cssName 的 itemName: renderingMode
		找不到对应的 cssName 的 itemName: columnWidth
		找不到对应的 cssName 的 itemName: backgroundAlpha
		找不到对应的 cssName 的 itemName: firstBaselineOffset
		找不到对应的 cssName 的 itemName: fontLookup
		找不到对应的 cssName 的 itemName: blockProgression
		找不到对应的 cssName 的 itemName: cffHinting
		找不到对应的 cssName 的 itemName: textRotation
		找不到对应的 cssName 的 itemName: textAlpha
		----------------------------------------
		direction,direction
		font-family,fontFamily
		font-size,fontSize
		font-style,fontStyle
		font-weight,fontWeight
		line-break,lineBreak
		line-height,lineHeight
		text-align,textAlign
		text-decoration,textDecoration
		text-indent,textIndent
		text-justify,textJustify
		vertical-align,verticalAlign
		background-color,backgroundColor
		color,color
		padding-bottom,paddingBottom
		padding-left,paddingLeft
		padding-right,paddingRight
		padding-top,paddingTop
		*/
		
		
		
		public static const direction:String="direction";
		public static const fontFamily:String="font-family";
		public static const fontSize:String="font-size";
		public static const fontStyle:String="font-style";
		public static const fontWeight:String="font-weight";
		public static const lineBreak:String="line-break";
		public static const lineHeight:String="line-height";
		public static const textAlign:String="text-align";
		public static const textDecoration:String="text-decoration";
		public static const textIndent:String="text-indent";
		public static const textJustify:String="text-justify";
		public static const verticalAlign:String="vertical-align";
		public static const backgroundColor:String="background-color";
		public static const color:String="color";
		public static const paddingBottom:String="padding-bottom";
		public static const paddingLeft:String="padding-left";
		public static const paddingRight:String="padding-right";
		public static const paddingTop:String="padding-top";
		
		private static const itemNameMark:Object=getItemNameMark();
		private static function getItemNameMark():Object{
			var itemNameMark:Object=new Object();
			itemNameMark["direction"]="direction";
			itemNameMark["font-family"]="fontFamily";
			itemNameMark["font-size"]="fontSize";
			itemNameMark["font-style"]="fontStyle";
			itemNameMark["font-weight"]="fontWeight";
			itemNameMark["line-break"]="lineBreak";
			itemNameMark["line-height"]="lineHeight";
			itemNameMark["text-align"]="textAlign";
			itemNameMark["text-decoration"]="textDecoration";
			itemNameMark["text-indent"]="textIndent";
			itemNameMark["text-justify"]="textJustify";
			itemNameMark["vertical-align"]="verticalAlign";
			itemNameMark["background-color"]="backgroundColor";
			itemNameMark["color"]="color";
			itemNameMark["padding-bottom"]="paddingBottom";
			itemNameMark["padding-left"]="paddingLeft";
			itemNameMark["padding-right"]="paddingRight";
			itemNameMark["padding-top"]="paddingTop";
			return itemNameMark;
		}
		
		private var __direction:String;
		private var __fontFamily:String;
		private var __fontSize:String;
		private var __fontStyle:String;
		private var __fontWeight:String;
		private var __lineBreak:String;
		private var __lineHeight:String;
		private var __textAlign:String;
		private var __textDecoration:String;
		private var __textIndent:String;
		private var __textJustify:String;
		private var __verticalAlign:String;
		private var __backgroundColor:String;
		private var __color:String;
		private var __paddingBottom:String;
		private var __paddingLeft:String;
		private var __paddingRight:String;
		private var __paddingTop:String;
		public function get color():*{
			return __color;
		}
		public function get backgroundColor():*{
			return __backgroundColor;
		}
		public function get lineThrough():*{
			return null;
		}
		public function get textAlpha():*{
			return null;
		}
		public function get backgroundAlpha():*{
			return null;
		}
		public function get fontSize():*{
			return __fontSize;
		}
		public function get baselineShift():*{
			return null;
		}
		public function get trackingLeft():*{
			return null;
		}
		public function get trackingRight():*{
			return null;
		}
		public function get lineHeight():*{
			return __lineHeight;
		}
		public function get breakOpportunity():*{
			return null;
		}
		public function get digitCase():*{
			return null;
		}
		public function get digitWidth():*{
			return null;
		}
		public function get dominantBaseline():*{
			return null;
		}
		public function get kerning():*{
			return null;
		}
		public function get ligatureLevel():*{
			return null;
		}
		public function get alignmentBaseline():*{
			return null;
		}
		public function get locale():*{
			return null;
		}
		public function get typographicCase():*{
			return null;
		}
		public function get fontFamily():*{
			return __fontFamily;
		}
		public function get textDecoration():*{
			return __textDecoration;
		}
		public function get fontWeight():*{
			return __fontWeight;
		}
		public function get fontStyle():*{
			return __fontStyle;
		}
		public function get whiteSpaceCollapse():*{
			return null;
		}
		public function get renderingMode():*{
			return null;
		}
		public function get cffHinting():*{
			return null;
		}
		public function get fontLookup():*{
			return null;
		}
		public function get textRotation():*{
			return null;
		}
		public function get textIndent():*{
			return __textIndent;
		}
		public function get paragraphStartIndent():*{
			return null;
		}
		public function get paragraphEndIndent():*{
			return null;
		}
		public function get paragraphSpaceBefore():*{
			return null;
		}
		public function get paragraphSpaceAfter():*{
			return null;
		}
		public function get textAlign():*{
			return __textAlign;
		}
		public function get textAlignLast():*{
			return null;
		}
		public function get textJustify():*{
			return __textJustify;
		}
		public function get justificationRule():*{
			return null;
		}
		public function get justificationStyle():*{
			return null;
		}
		public function get direction():*{
			return __direction;
		}
		public function get tabStops():*{
			return null;
		}
		public function get leadingModel():*{
			return null;
		}
		public function get columnGap():*{
			return null;
		}
		public function get paddingLeft():*{
			return __paddingLeft;
		}
		public function get paddingTop():*{
			return __paddingTop;
		}
		public function get paddingRight():*{
			return __paddingRight;
		}
		public function get paddingBottom():*{
			return __paddingBottom;
		}
		public function get columnCount():*{
			return null;
		}
		public function get columnWidth():*{
			return null;
		}
		public function get firstBaselineOffset():*{
			return null;
		}
		public function get verticalAlign():*{
			return __verticalAlign;
		}
		public function get blockProgression():*{
			return null;
		}
		public function get lineBreak():*{
			return __lineBreak;
		}
		
		public function CSSFormat(cssElementsStr:String){
			//用 \n 或 \r 或 ; 分离然后去掉前后空白
			for each(var cssElementStr:String in cssElementsStr.split(/[\r\n;]+/)){
				var cssElement:String=cssElementStr.replace(/^\s*|\s*$/g,"");
				if(cssElement){
					var cssElementArr:Array=cssElement.split(/\s*:\s*/);
					if(cssElementArr.length==2){
						var cssName:String=cssElementArr[0].toLowerCase();
						var itemName:String=itemNameMark[cssName];
						if(itemName){
							var itemValue:String=cssElementArr[1];
							switch(itemName){
								case CSSFormat.backgroundColor:
								case CSSFormat.color:
									if(/#[0-9a-fA-F]{6}/.test(itemValue)){
										
									}else{
										trace("可能支持的不太好的颜色值: "+itemValue);
									}
								break;
							}
							this["__"+itemName]=itemValue;
							//trace("__"+itemName+"="+itemValue);
						}else{
							trace("不支持的 CSS 属性: "+cssName);
						}
					}
				}
			}
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