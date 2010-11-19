﻿/***
TextLayout 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年10月11日 16:46:14
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.text{
	import flash.display.*;
	import flash.events.*;
	import flash.text.engine.*;
	import flash.utils.*;
	
	import flashx.textLayout.container.*;
	import flashx.textLayout.conversion.*;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.*;
	
	//非官方的 Table 类:
	//http://code.google.com/p/tlfx/source/browse/trunk/tlf/src/main/flex/flashx/textLayout/?r=97#textLayout/elements/table%3Fstate%3Dclosed
	
	public class TextLayout extends Sprite{
		private static const childrenTree:Object={
			TextFlow:["div","p"],
			div:["div","p"],
			p:["a","tcy","span","img","tab","br"],
			a:["tcy","span","img","tab","br"],
			tcy:["a","span","img","tab","br"],
			span:[],
			img:[],
			tab:[],
			br:[]
		}
		public function TextLayout(
			width:int,
			height:int,
			xml:XML,
			styleXML:XML
		){
			
			var xmlName:String=xml.name();
			if(xmlName==="TextFlow"){
			}else{
				//第一个节点必须是 TextFlow
				if(xmlName.toLowerCase()==="textflow"){
					xml.setName("TextFlow");
				}else{
					var newXML:XML=<TextFlow/>;
					newXML.appendChild(xml);
					xml=newXML;
				}
			}
			
			for each(var node:XML in xml.children()){
				normalizeNodes(node,childrenTree.TextFlow);
			}
			
			//如果不设置命名空间, 将无法正常使用下面的 TextConverter
			if(xml.namespace().uri=="http://ns.adobe.com/textLayout/2008"){
			}else{
				xml.setNamespace(new Namespace(null,"http://ns.adobe.com/textLayout/2008"));
			}
			
			
			trace(xml.toXMLString());
			
			var textFlow:TextFlow = new TextFlow();
            textFlow = TextConverter.importToFlow(xml.toXMLString(), TextConverter.TEXT_LAYOUT_FORMAT);
			textFlow.formatResolver=new CSSFormatResolver(styleXML);
            textFlow.flowComposer.addController(new ContainerController(this,width,height));
            textFlow.flowComposer.updateAllControllers();
		}
		private function normalizeNodes(xml:XML,parentChildrenArr:Array):void{
			//尝试标准化成可正常显示
			var xmlName:String=xml.name();
			if(xmlName){
				var newName:String;
				var childrenArr:Array=childrenTree[xmlName];
				if(childrenArr){
					newName=xmlName;
				}else{
					newName=xmlName.toLowerCase();
					childrenArr=childrenTree[newName];
				}
				if(childrenArr){
					if(xmlName===newName){
						
					}else{
						xml.setName(newName);
						trace("不太正常的节点名: "+xmlName+" 已自动转换成: "+newName);
					}
					
					if(parentChildrenArr.length==0){
						if(xml.children().length()==0){
						}else{
							trace(xml.parent().name()+" 不支持任何子标签");
						}
					}else{
						if(parentChildrenArr.indexOf(newName)==-1){
							trace(xml.parent().name()+" 不支持子标签: "+xmlName+", 请选用下列标签: "+parentChildrenArr);
						}else{
							for each(var node:XML in xml.children()){
								normalizeNodes(node,childrenArr);
							}
						}
					}
					
					switch(newName){
						case "img":
							
							//src --> source
							var srcStr:String=xml.@src.toString();
							if(srcStr){
								delete xml.@src;
								xml.@source=srcStr;
							}
							
							var widthStr:String=xml.@width.toString();
							if(widthStr){
								var heightStr:String=xml.@height.toString();
								if(heightStr){
									
								}else{
									trace("暂不支持不带 height 的 img: "+xml.toXMLString());
								}
							}else{
								trace("暂不支持不带 width 的 img: "+xml.toXMLString());
							}
						break;
					}
				}else{
					trace("无法识别的节点名: "+xmlName);
				}
			}
		}
		
		/*
		//例子1:
		public function TextFlowExample()
        {
            var config:Configuration = new Configuration();
            var textLayoutFormat:TextLayoutFormat = new TextLayoutFormat();
            textLayoutFormat.color = 0xFF0000;
            textLayoutFormat.fontFamily = "Arial, Helvetica, _sans";
            textLayoutFormat.fontSize = 48;
            textLayoutFormat.kerning = Kerning.ON;
            textLayoutFormat.fontStyle = FontPosture.ITALIC;
            textLayoutFormat.textAlign = TextAlign.CENTER;
            config.textFlowInitialFormat = textLayoutFormat;
            var textFlow:TextFlow = new TextFlow(config);
            var p:ParagraphElement = new ParagraphElement();
            var span:SpanElement = new SpanElement();
            span.text = "Hello, World!";
            p.addChild(span);
            textFlow.addChild(p);
            textFlow.flowComposer.addController(new ContainerController(this,500,200));
            textFlow.flowComposer.updateAllControllers(); 
        }
		//*/
		
		/*
		//例子2:
		public function TextFlow_getElementByIDExample()
        {    
            // create the TextFlow object
            var textFlow:TextFlow = new TextFlow();
            
            // xml markup that defines the attributes and contents of a text flow
            var simpleText:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>" +
            "<flow:TextFlow xmlns:flow=\"http://ns.adobe.com/textLayout/2008\" verticalScrollPolicy=\"auto\" horizontalScrollPolicy=\"auto\" editingMode=\"readWrite\" fontSize=\"14\" textIndent=\"15\" marginBottom=\"15\" paddingTop=\"4\" paddingLeft=\"4\">"+
                "<flow:p>"+
                    "<flow:span id='span1'>In the first paragraph of the </flow:span>"+
                    "<flow:span id='span2' fontStyle=\"italic\">cheap</flow:span>"+
                    "<flow:span id='span3'>Western novel, a cowboy meets a saloon girl.</flow:span>"+
                "</flow:p>"+
            "</flow:TextFlow>";
            var s:SpanElement = new SpanElement();
            var s2:SpanElement = new SpanElement();
            var p:ParagraphElement = new ParagraphElement();
            // import the xml markup into a TextFlow object and display it on the stage
            textFlow = TextConverter.importToFlow(simpleText, TextConverter.TEXT_LAYOUT_FORMAT);
            // get element with ID of span3, make a copy of it
            textFlow.getElementByID("span3").setStyle("color", 0xFF0000); 
            textFlow.flowComposer.addController(new ContainerController(this, 200, 800));
            textFlow.flowComposer.updateAllControllers();
        }
		//*/
		
		/*
		public function TextLayout(xml:XML){
			config=new Configuration();
			textLayoutFormat=new TextLayoutFormat();
            textLayoutFormat.color = 0xFF0000;
            textLayoutFormat.fontFamily = "Arial, Helvetica, _sans";
            textLayoutFormat.fontSize = 48;
            textLayoutFormat.kerning = Kerning.ON;
            textLayoutFormat.fontStyle = FontPosture.ITALIC;
            textLayoutFormat.textAlign = TextAlign.CENTER;
            config.textFlowInitialFormat=textLayoutFormat;
            var textFlow:TextFlow=new TextFlow(config);
			for each(var node:XML in xml.children()){
				var nodeName:String=node.name();
				if(nodeName){
            		textFlow.addChild(getElementTreeByXML(node,nodeName));
				}
			}
            textFlow.flowComposer.addController(new ContainerController(this,500,200));
            textFlow.flowComposer.updateAllControllers();
		}
		
		private function getElementTreeByXML(xml:XML,xmlName:String):FlowElement{
			var nodes:XMLList=xml.children();
			
			var element:FlowElement;
			switch(xmlName){
				case "span":
					element=new SpanElement();
				break;
				case "p":
					element=new ParagraphElement();
				break;
				default:
					throw new Error("暂不支持: "+xmlName);
				break;
			}
			
			if(nodes.length()){
				var groupElement:FlowGroupElement=element as FlowGroupElement;
				for each(var node:XML in nodes){
					var nodeName:String=node.name();
					if(nodeName){
						var nodeElement:FlowElement=getElementTreeByXML(node,nodeName);
						groupElement.addChild(nodeElement);
					}
				}
			}else{
				element["text"]=xml.toString();
			}
			
			trace("element="+element);
			
			return element;
		}
		*/
		
		/*
		//例子3:
		public function InlineGraphicElement_sourceExample(){
			// create a container and a controller for it
			var container:Sprite = new Sprite();
			this.addChild(container);
			// create the TextFlow, ParagraphElement, SpanElement, and InlineGraphicElement objects    
			var textFlow:TextFlow = new TextFlow();
			var p:ParagraphElement = new ParagraphElement();
			var inlineGraphicElement:InlineGraphicElement = new InlineGraphicElement();
			var span:SpanElement = new SpanElement();
			// add the graphic
			inlineGraphicElement.source = drawRect();
			// add text to the spans, spans and graphic to paragraph        
			span.text = "Too much depends upon a ";
			span.fontSize = 48;
			p.addChild(span); 
			p.addChild(inlineGraphicElement);
			// add paragraph to text flow and update controller to display
			textFlow.addChild(p);
			var controller:ContainerController = new ContainerController(container, 400, 300 );
			textFlow.flowComposer.addController(controller);
			textFlow.flowComposer.updateAllControllers(); 
		}
		
		private function drawRect():Sprite
		{
			var redRect:Sprite = new Sprite();
			redRect.graphics.beginFill(0xff0000);    // red
			redRect.graphics.drawRect(0,0,30, 30);
			redRect.graphics.endFill();
			return redRect;
		}
		*/
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