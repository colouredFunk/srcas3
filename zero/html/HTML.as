/***
HTML 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月14日 18:11:11
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.html{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.DescribeTypes;
	
	public class HTML extends Sprite{
		public static function getStyle(xml:XML):StyleSheet{
			var style:StyleSheet=new StyleSheet();
			style.parseCSS(xml.toString().replace(/\s*[\r\n]\s*/g,""));
			return style;
		}
		private static const elementClasses:Object=function():Object{
			var elementClasses:Object=new Object();
			for each(var clazz:Class in [Label,Txt,Btn]){
				var className:String=getQualifiedClassName(clazz);
				className=className.substr(className.lastIndexOf(":")+1);
				className=className.charAt(0).toLowerCase()+className.substr(1);
				//trace("className="+className);
				elementClasses[className]=clazz;
			}
			return elementClasses;
		}();
		public static const defaultStyle:StyleSheet=getStyle(
			<style><![CDATA[
				body {
					font-family: _sans;
					font-size: 12px;
					color: #ff0000;
					margin-left: 0px;
					margin-top: 0px;
					margin-right: 0px;
					margin-bottom: 0px;
				}
				a {
					color: #2CB200;
					font-weight: bold;
				}
				a:hover {
					color: #ED4901;
				}
			]]></style>
		);
		private static function initByXMLAtts(parentObj:HTML,obj:Object,xml:XML):void{
			for each(var att:XML in xml.attributes()){
				var attName:String=att.name();
				if(attName){
					switch(attName){
						case "id":
							obj.id=att.toString();
							parentObj.elements[obj.id]=obj;
						break;
						default:
							DescribeTypes.setValueByStr(obj,attName,att.toString());
						break;
					}
				}
			}
		}
		
		private var onClick:Function;
		private var onChange:Function;
		public var id:String;
		public var elements:Object;
		
		public function HTML(){
		}
		public function init(xml:XML,_onClick:Function=null,_onChange:Function=null,style:StyleSheet=null):void{
			var rootHTML:HTML=this;
			while(rootHTML.parent){
				if(rootHTML.parent is HTML){
					rootHTML=rootHTML.parent as HTML;
				}else{
					break;
				}
			}
			if(rootHTML==this){
				elements=new Object();
			}
			
			var styleNode:XML=xml.style[0];
			if(styleNode){
				style=getStyle(styleNode);
			}else if(style){
			}else{
				style=defaultStyle;
			}
			onClick=_onClick;
			onChange=_onChange;
			for each(var node:XML in xml.children()){
				var nodeName:String=node.name();
				if(nodeName){
					if(nodeName=="html"){
						var html:HTML=new HTML();
						this.addChild(html);
						initByXMLAtts(rootHTML,html,node);
						html.init(node,onClick,onChange,style);
					}else{
						var htmlElement:HTMLElement=new (elementClasses[nodeName])();
						this.addChild(htmlElement);
						initByXMLAtts(rootHTML,htmlElement,node);
						
						switch(htmlElement["constructor"]){
							case Label:
								(htmlElement as Label).styleSheet=style;
							break;
							case Txt:
								var txt:Txt=htmlElement as Txt;
								if(txt.type==TextFieldType.INPUT){
									//- -
									//如果使用样式, 将无法编辑文本
									txt.addEventListener(Event.CHANGE,change);
								}else{
									txt.styleSheet=style;
								}
							break;
							case Btn:
								var btn:Btn=htmlElement as Btn;
								btn.styleSheet=style;
								btn.addEventListener(MouseEvent.CLICK,click);
							break;
							default:
								throw new Error("未知类型: "+htmlElement["constructor"]);
							break;
						}
					}
				}
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		public function added(event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		public function removed(event:Event):void{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removed);
			var i:int=this.numChildren;
			while(--i>=0){
				var child:DisplayObject=this.getChildAt(i);
				if(child is HTML){
				}else{
					switch(child["constructor"]){
						case Label:
						break;
						case Txt:
							(child as Txt).removeEventListener(Event.CHANGE,change);
						break;
						case Btn:
							(child as Btn).removeEventListener(MouseEvent.CLICK,click);
						break;
						default:
							throw new Error("未知类型: "+child["constructor"]);
						break;
					}
				}
			}
			onClick=null;
			onChange=null;
			elements=null;
		}
		private function click(event:MouseEvent):void{
			if(onClick==null){
			}else{
				onClick(event.target);
			}
		}
		private function change(event:Event):void{
			if(onChange==null){
			}else{
				onChange(event.target);
			}
		}
		
		///*
		public function set enabled(_enabled:Boolean):void{
			//Grey.setEnabled(this,_enabled);
			this.mouseEnabled=this.mouseChildren=_enabled;
			if(_enabled){
				this.alpha=1;
			}else{
				this.alpha=0.5;
			}
		}
		//*/
	}
}

