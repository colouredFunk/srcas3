/***
ShowImages
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年5月7日 10:16:07
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.ui{
	import akdcl.media.MediaPlayer;
	import akdcl.utils.addContextMenu;
	
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.net.ImgLoader;
	import zero.ui.*;
	
	public class ShowImages extends Sprite{
		
		public var xml:XML;
		
		public var btnPrev:Btn;
		public var btnNext:Btn;
		
		public var btnScrollPrev:Btn;
		public var btnScrollNext:Btn;
		
		public var img:Btn;
		private var player:MediaPlayer;
		public var skin:AutoFitMediaSkin;
		
		public var icons:Sprite;
		
		private var IconClass:Class;
		
		private var iconArea:Sprite;
		private var scrollMaskSp:Sprite;
		private var num:int;
		private var d:int;
		
		private var scrollId:int;
		private var currId:int;
		
		private var info:String;
		private var infoMenuItem:ContextMenuItem;
		
		public function ShowImages(){
			
			IconClass=icons.getChildAt(0)["constructor"];
			switch(IconClass){
				case Shape:
				case Bitmap:
				case Sprite:
				case MovieClip:
					throw new Error("需要 IconClass");
				break;
			}
			
			var menu:ContextMenu=img.contextMenu;
			if (menu&&menu.customItems) {
			}else{
				menu=new ContextMenu();
			}
			menu.hideBuiltInItems();
			info="大图："+Math.round(img.width)+"x"+Math.round(img.height)+"，小图："+Math.round(icons.getChildAt(0).width)+"x"+Math.round(icons.getChildAt(0).height);
			infoMenuItem=new ContextMenuItem(info);
			menu.customItems.push(infoMenuItem);
			infoMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,copyInfo);
			this.contextMenu=menu;
			
			player = new MediaPlayer();
			player.repeat = 0;
			skin.setPlayer(player);
			skin.setSize(Math.round(img.width),Math.round(img.height));
			
			d=icons.getChildAt(1).y-icons.getChildAt(0).y;
			
			var b:Rectangle=icons.getBounds(icons);
			b.inflate(4,4);
			
			num=icons.numChildren;
			
			var i:int=num;
			while(--i>=0){
				icons.removeChildAt(i);
			}
			
			iconArea=new Sprite();
			icons.addChild(iconArea);
			scrollMaskSp=new Sprite();
			icons.addChild(scrollMaskSp);
			scrollMaskSp.graphics.clear();
			scrollMaskSp.graphics.beginFill(0x000000);
			//scrollMaskSp.graphics.beginFill(0xff0000,0.3);trace("测试");
			scrollMaskSp.graphics.drawRect(b.x,b.y,b.width,b.height);
			scrollMaskSp.graphics.endFill();
			icons.mask=scrollMaskSp;
			
			btnScrollPrev.release=scrollPrev;
			btnScrollNext.release=scrollNext;
			
			btnPrev.release=prev;
			btnNext.release=next;
		}
		
		public function clear():void{
			clearIcons();
			
			IconClass=null;
			
			xml=null;
			
			(img["img"] as ImgLoader).clear();
			
			infoMenuItem.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,copyInfo);
			infoMenuItem=null;
			
			player.stop();
			player=null;
		}
		private function clearIcons():void{
			var i:int=iconArea.numChildren;
			while(--i>=0){
				iconArea.getChildAt(i)["clear"]();
				iconArea.removeChildAt(i);
			}
		}
		
		private function copyInfo(event:ContextMenuEvent):void{
			System.setClipboard(info);
		}
		
		public function init(_xml:XML):void{
			
			clearIcons();
			
			xml=_xml;
			
			//trace("xml="+xml.toXMLString());
			
			player.stop();
			iconArea.y=0
			scrollId=0;
			currId=0;
			skin.visible=false;
			img.visible=false;
			
			var y:int=0;
			var i:int=-1;
			for each(var imgXML:XML in xml.img){
				i++;
				var icon:Btn=new IconClass();
				iconArea.addChild(icon);
				icon.y=y;
				icon["initXML"](imgXML,imgXML.@icon.toString()||imgXML.@src.toString(),clickIcon);
				y+=d;
			}
			
			updateBtns();
			
			if(iconArea.numChildren){
				clickIcon(iconArea.getChildAt(0) as Btn);
			}
		}
		
		private function clickIcon(icon:Btn):void{
			
			imgXML=icon["xml"];
			
			(img["img"] as ImgLoader).clearLoader();
			if(/^.*\.flv$/i.test(imgXML.@src.toString())){
				player.load(imgXML.@src.toString());
				player.play();
				skin.visible=true;
				img.visible=false;
			}else{
				skin.visible=false;
				img.visible=true;
				(img["img"] as ImgLoader).load(imgXML.@src.toString());
			}
			
			if(imgXML.@href.toString()||imgXML.@js.toString()){
				img.href=imgXML;
				img.mouseEnabled=true;
			}else{
				img.mouseEnabled=false;
			}
			
			var i:int=-1;
			for each(var imgXML:XML in xml.img){
				i++;
				var _icon:Btn=iconArea.getChildAt(i) as Btn;
				_icon.selected=false;
				_icon.mouseEnabled=true;
			}
			icon.selected=true;
			icon.mouseEnabled=false;
			currId=iconArea.getChildIndex(icon);
			
			updateBtns();
		}
		
		private function updateBtns():void{
			if(scrollId>0){
				btnScrollPrev.alpha=1;
				btnScrollPrev.mouseEnabled=true;
			}else{
				btnScrollPrev.alpha=0.5;
				btnScrollPrev.mouseEnabled=false;
			}
			if(scrollId<xml.img.length()-num){
				btnScrollNext.alpha=1;
				btnScrollNext.mouseEnabled=true;
			}else{
				btnScrollNext.alpha=0.5;
				btnScrollNext.mouseEnabled=false;
			}
			if(currId>0){
				btnPrev.alpha=1;
				btnPrev.mouseEnabled=true;
			}else{
				btnPrev.alpha=0.5;
				btnPrev.mouseEnabled=false;
			}
			if(currId<xml.img.length()-1){
				btnNext.alpha=1;
				btnNext.mouseEnabled=true;
			}else{
				btnNext.alpha=0.5;
				btnNext.mouseEnabled=false;
			}
		}
		private function scrollPrev():void{
			scrollId--;
			TweenMax.to(iconArea,0.3,{y:-scrollId*d});
			
			updateBtns();
		}
		private function scrollNext():void{
			scrollId++;
			TweenMax.to(iconArea,0.3,{y:-scrollId*d});
			
			updateBtns();
		}
		private function prev():void{
			currId--;
			
			clickIcon(iconArea.getChildAt(currId) as Btn);
			
			while(currId<scrollId){
				scrollPrev();
			}
			while(currId+1>scrollId+num){
				scrollNext();
			}
			
			updateBtns();
		}
		private function next():void{
			currId++;
			
			clickIcon(iconArea.getChildAt(currId) as Btn);
			
			while(currId+1>scrollId+num){
				scrollNext();
			}
			while(currId<scrollId){
				scrollPrev();
			}
			
			updateBtns();
		}
	}
}