/***
Station
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年08月27日 15:52:39
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.station{
	import akdcl.utils.addContextMenu;
	
	import assets.BtnImg;
	import assets.Main;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.codec.CRC32String;
	import zero.getfonts.GetFont;
	import zero.net.MultiLoader;
	import zero.ui.ImgLoader;
	import zero.utils.playAll;
	import zero.utils.stopAll;
	import zero.works.station.switchs.BaseSwitch;
	
	public class Station extends DocClass{
		
		protected var main:Main;
		private var bg:ImgLoader;
		private var bottom:ImgLoader;
		private var nav:Nav;
		
		private var btnSkip_dy:int;
		
		private var kaitouLoader:ImgLoader;
		
		private var prevloader:MultiLoader;
		private var prevloadPercent:Number;
		
		private var nav_layoutXML:XML;
		private var switch_layoutXML:XML;
		
		private var imgsSpV:Vector.<Sprite>;
		
		public function Station(_optionsXMLPath:String,switchClass:Class){
			optionsXMLPath=_optionsXMLPath;
			_switch=new switchClass();
			onLoaded=loaded;
		}
		override protected function onInitHandler(_evt:Event):void{super.onInitHandler(_evt);
			setStageAlignAndScale(-1, -1, 0);//左上角对齐，不缩放
			stage.addEventListener(Event.RESIZE,resize);
			resize();
		}
		private function loaded():void{
			
			addContextMenu(this, "XML CRC32：#"+(0x100000000+uint(CRC32String(optionsXML.toXMLString()))).toString(16).substr(1).toUpperCase(),openXMLPage);
			GetFont.initBySWFData(this.loaderInfo.bytes);
			
			SubXMLLoader.loadSubXMLs(optionsXML,loadSubXMLsComplete);
		}
		private function openXMLPage(...args):void{//右键 xml 版本，跳到 xml 页面
			navigateToURL(new URLRequest(optionsXMLPath),"_blank");
		}
		
		protected function loadSubXMLsComplete():void{
			
			this.addChild(main=new Main());
			if(main.fade_ani){
				main.fade_ani.stop();
				main.fade_ani.addFrameScript(int(main.fade_ani.totalFrames/2)-1,main.fade_ani.stop);
				main.fade_ani.addFrameScript(main.fade_ani.totalFrames-1,main.fade_ani.stop);
			}
			
			var i:int=main.numChildren;
			while(--i>=0){
				var child:DisplayObject=main.getChildAt(i);
				if(child.hasOwnProperty("mouseEnabled")){
					child["mouseEnabled"]=false;
				}
				if(child.hasOwnProperty("mouseChildren")){
					child["mouseChildren"]=false;
				}
			}
			
			main.loading=main.mainLoading;
			if(optionsXML.loading[0]){
				main.loading.style=optionsXML.loading[0].style[0];
			}
			
			nav=new Nav();
			
			nav.init(main.nav,optionsXML);
			nav.clip.mouseChildren=true;
			nav.clip.visible=false;
			nav_layoutXML=optionsXML.nav_layout[0];
			if(nav_layoutXML){
			}else{
				nav_layoutXML=getLayout(nav.clip,null,"center");
			}
			switch_layoutXML=optionsXML.switch_layout[0];
			if(switch_layoutXML){
			}else{
				switch_layoutXML=getLayout(_switch,null,"center middle");
			}
			
			main.mouseEnabled=false;
			main.container.mouseChildren=true;
			if(main.btnSkip){
				main.btnSkip.alpha=0;
				btnSkip_dy=main.btnSkip.y-main.loading.y;
			}
			
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					getLayout(main.btnBack,btnBackXML,"center middle");
					GetFont.initTxt(main.btnBack["label"].txt,btnBackXML.label[0]);
					main.btnBack.release=back;
					main.btnBack.alpha=0;
				}
			}
			
			var imgsXML:XML=optionsXML.imgs[0];
			if(imgsXML){
				if(main.imgs){
					imgsSpV=new Vector.<Sprite>();
					main.imgs.mouseChildren=true;
					for each(var subXML:XML in imgsXML.children()){
						
						var sp:Sprite=main.imgs[subXML.name().toString()];
						if(sp){
						}else{
							sp=new BtnImg();
							main.imgs.addChild(sp);
						}
						
						getLayout(sp,subXML);
						
						var btn:BtnImg=sp as BtnImg;
						if(btn){
							var img:ImgLoader=new ImgLoader();
							btn.container.addChild(img);
							img.load(subXML);
							if(subXML.@href.toString()||subXML.@js.toString()){
								btn.href=subXML;
								btn.mouseEnabled=true;
							}else{
								btn.href=null;
								btn.mouseEnabled=false;
							}
						}else{
							GetFont.initTxt(sp["txt"],subXML);
						}
						
						imgsSpV.push(sp);
					}
				}
			}
			
			var bgXML:XML=optionsXML.bg[0];
			if(bgXML){
				main.addChildAt(bg=new ImgLoader(),0);
				bg.load(bgXML);
				bg.mouseEnabled=bg.mouseChildren=false;
			}
			
			var bottomXML:XML=optionsXML.bottom[0];
			if(bottomXML){
				main.addChild(bottom=new ImgLoader());
				bottom.load(bottomXML);
				bottom.mouseEnabled=bottom.mouseChildren=false;
			}
			
			var prevloadsXML:XML=<prevloads/>;
			for each(var matchStr:String in optionsXML.toXMLString().match(/<[^<>]+\s+src=".*?"[^<>]+>/g)){
				try{
					var srcXML:XML=new XML(matchStr);
					if(srcXML.name().toString()){
					}else{
						srcXML=null;
					}
				}catch(e:Error){
					srcXML=null;
				}
				if(srcXML&&srcXML.@prevload.toString()=="true"){
					prevloadsXML.appendChild(<node src={srcXML.@src.toString()}/>);
				}
			}
			var nodeXMLList:XMLList=prevloadsXML.children();
			if(nodeXMLList.length()){
				//trace("预加载："+nodeXMLList.toXMLString());
				if(optionsXML.@prevloadPercent.toString()){
					prevloadPercent=Number(optionsXML.@prevloadPercent.toString());
				}else{
					prevloadPercent=0.2;
				}
				var kaitouXML:XML=optionsXML.kaitou[0];
				if(kaitouXML){
					if(kaitouXML.@skip.toString()=="true"){
						prevloadPercent=1;
					}
				}else{
					prevloadPercent=1;
				}
				prevloader=new MultiLoader();
				prevloader.onLoadProgress=prevloadProgress;
				prevloader.onLoadComplete=prevloadComplete;
				prevloader.load(nodeXMLList,MultiLoader.BINARY);
				main.loading.show();
				resize();
			}else{
				prevloadPercent=0;
				prevloadComplete();
			}
		}
		private function prevloadProgress(value:Number):void{
			main.loading.value=value*prevloadPercent;
		}
		private function prevloadComplete(...args):void{
			
			if(prevloader){
				prevloader.clear();
				prevloader=null;
			}
			
			var kaitouXML:XML=optionsXML.kaitou[0];
			if(kaitouXML){
				if(kaitouXML.@skip.toString()=="true"){
					trace("跳过开头动画");
					playKaitouComplete();
				}else{
					if(main.btnSkip){
						main.btnSkip.mouseEnabled=true;
						main.btnSkip.release=playKaitouComplete;
						TweenMax.to(main.btnSkip,12,{alpha:1,useFrames:true});
					}
					main.container.addChild(kaitouLoader=new ImgLoader());
					kaitouLoader.onLoadProgress=loadKaitouProgress;
					kaitouLoader.onLoadComplete=loadKaitouComplete;
					kaitouLoader.onPlayComplete=playKaitouComplete;
					kaitouLoader.load(kaitouXML.video[0]);
					main.loading.show();
				}
			}else{
				//trace("没有开头动画");
				playKaitouComplete();
			}
			
			resize();
		}
		
		private function loadKaitouProgress(value:Number):void{
			main.loading.value=prevloadPercent+value*(1-prevloadPercent);
		}
		protected function loadKaitouComplete():void{
			main.loading.hide();
			set_btnSkip_dy_1();
		}
		protected function set_btnSkip_dy_1():void{
			if(main.btnSkip){
				btnSkip_dy=-1;
			}
			resize();
		}
		protected function playKaitouComplete():void{
			if(main.btnSkip){
				main.btnSkip.mouseEnabled=false;
				TweenMax.to(main.btnSkip,12,{alpha:0,useFrames:true});
			}
			
			main.loading.hide();
			
			if(kaitouLoader){
				if(btnSkip_dy>-1){
					kaitouLoader.stopLoader();
				}
				kaitouLoader.pause();
			}
			
			showNav();
			
			if(main.subLoading){
				stopAll(main.loading);
				main.removeChild(main.loading);
				main.loading=main.subLoading;
				if(optionsXML.loading[0]){
					var style:XML=optionsXML.loading[0].style[1];
					if(style){
						main.loading.style=style;
					}
				}
				main.loading.visible=true;
			}
			
			main.container.addChild(_switch);
			_switch.init(optionsXML.nav,optionsXML.@simulateDownload.toString()=="true",loadPage,loadPageProgress,loadPageComplete,showingPage,pageFadeInComplete,pageFadeOutComplete);
			
			var prevloadsXML:XML=<prevloads/>;
			for each(var matchStr:String in optionsXML.toXMLString().match(/<[^<>]+\s+src=".*?"[^<>]+>/g)){
				try{
					var srcXML:XML=new XML(matchStr);
					if(srcXML.name().toString()){
					}else{
						srcXML=null;
					}
				}catch(e:Error){
					srcXML=null;
				}
				if(srcXML&&srcXML.@innerprevload.toString()=="true"){
					prevloadsXML.appendChild(<node src={srcXML.@src.toString()}/>);
				}
			}
			var nodeXMLList:XMLList=prevloadsXML.children();
			if(nodeXMLList.length()){
				//trace("内页预加载："+nodeXMLList.toXMLString());
				prevloader=new MultiLoader();
				//prevloader.onLoadProgress=innerprevloadProgress;
				//prevloader.onLoadComplete=innerPrevloadComplete;
				prevloader.load(nodeXMLList,MultiLoader.BINARY);
			}
		}
		protected function showNav():void{
			nav.clip.visible=true;
			TweenMax.killTweensOf(nav.clip);
			nav.clip.alpha=1;
			TweenMax.from(nav.clip,12,{alpha:0,useFrames:true});
		}
		
		private function back():void{
			for each(var navXML:XML in optionsXML.nav){
				if(navXML.@isIndex.toString()=="true"){
					navXML.@selected=true;
				}else{
					navXML.@selected=false;
				}
			}
		}
		private function loadPage():void{
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					main.btnBack.mouseEnabled=false;
					TweenMax.to(main.btnBack,12,{alpha:0,useFrames:true});
				}
			}
			if(main.fade_ani){
				main.fade_ani.gotoAndPlay(int(main.fade_ani.totalFrames/2)+1);
			}
			main.loading.show();
			for each(var navXML:XML in optionsXML.nav){
				if(navXML.@selected.toString()=="true"){
					nav.select(navXML);
					return;
				}
			}
		}
		private function loadPageProgress(value:Number):void{
			main.loading.value=value;
		}
		private function loadPageComplete():void{
			main.loading.hide();
			resize();
		}
		protected function showingPage():void{
			nav.clip.mouseChildren=false;
		}
		private function pageFadeInComplete():void{
			nav.clip.mouseChildren=true;
			if(kaitouLoader){
				kaitouLoader.clear();
				main.container.removeChild(kaitouLoader);
				kaitouLoader=null;
			}
			if(main.fade_ani){
				main.fade_ani.gotoAndPlay(2);
			}
			var btnBackXML:XML=optionsXML.btnBack[0];
			if(btnBackXML){
				if(main.btnBack){
					for each(var navXML:XML in optionsXML.nav){
						if(navXML.@selected.toString()=="true"){
							if(navXML.@isIndex.toString()=="true"){
								main.btnBack.mouseEnabled=false;
								TweenMax.to(main.btnBack,12,{alpha:0,useFrames:true});
							}else{
								main.btnBack.mouseEnabled=true;
								TweenMax.to(main.btnBack,12,{alpha:1,useFrames:true});
							}
						}
					}
				}
			}
		}
		private function pageFadeOutComplete():void{
			
		}
		
		private function getLayout(sp:Sprite,xml:XML,align:String="auto"):XML{
			var layoutXML:XML=xml?xml.layout[0]:null;
			if(layoutXML){
			}else{
				layoutXML=<layout/>;
				if(xml){
					xml.appendChild(layoutXML);
				}
				
				if(align=="auto"){
					
					//if(sp.x<1920/2){
					//	layoutXML.@left=int(sp.x);
					//}else{
					//	layoutXML.@right=int(1920-sp.x);
					//}
					layoutXML.@horizontalCenter=int(sp.x-1920/2);
					
					if(sp.y<854/2){
						layoutXML.@top=int(sp.y);
					}else{
						layoutXML.@bottom=int(854-sp.y);
					}
					//layoutXML.@verticalCenter=int(sp.y-845/2);
				}else{
					if(align.indexOf("center")>-1){
						layoutXML.@horizontalCenter=int(sp.x-1920/2);
					}
					if(align.indexOf("left")>-1){
						layoutXML.@left=int(sp.x);
					}
					if(align.indexOf("right")>-1){
						layoutXML.@right=int(1920-sp.x);
					}
					
					if(align.indexOf("middle")>-1){
						layoutXML.@verticalCenter=int(sp.y-845/2);
					}
					if(align.indexOf("top")>-1){
						layoutXML.@top=int(sp.y);
					}
					if(align.indexOf("bottom")>-1){
						layoutXML.@bottom=int(854-sp.y);
					}
				}
			}
			return layoutXML;
		}
		private function updateSpByLayout(sp:Sprite,layoutXML:XML):void{
			if(layoutXML.@horizontalCenter.toString()){
				sp.x=stage.stageWidth/2+int(layoutXML.@horizontalCenter.toString());
			}else if(layoutXML.@left.toString()){
				sp.x=int(layoutXML.@left.toString());
			}else if(layoutXML.@right.toString()){
				sp.x=stage.stageWidth-int(layoutXML.@right.toString());
			}
			if(layoutXML.@verticalCenter.toString()){
				sp.y=stage.stageHeight/2+int(layoutXML.@verticalCenter.toString());
			}else if(layoutXML.@top.toString()){
				sp.y=int(layoutXML.@top.toString());
			}else if(layoutXML.@bottom.toString()){
				sp.y=stage.stageHeight-int(layoutXML.@bottom.toString());
			}
			
			if(layoutXML.@max_x.toString()){
				var max_x:int=int(layoutXML.@max_x.toString());
				if(sp.x>max_x){
					sp.x=max_x;
				}
			}
			if(layoutXML.@min_x.toString()){
				var min_x:int=int(layoutXML.@min_x.toString());
				if(sp.x<min_x){
					sp.x=min_x;
				}
			}
		}
		protected function resize(...args):void{
			
			//trace(stage.stageWidth,stage.stageHeight);
			
			//this.graphics.clear();
			//this.graphics.beginFill(0x000000);
			//this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			//this.graphics.endFill();
			
			if(main){
				
				//trace("nav_layoutXML="+nav_layoutXML.toXMLString());
				updateSpByLayout(nav.clip,nav_layoutXML);
				
				var btnBackXML:XML=optionsXML.btnBack[0];
				if(btnBackXML){
					if(main.btnBack){
						updateSpByLayout(main.btnBack,btnBackXML.layout[0]);
					}
				}
				
				var imgsXML:XML=optionsXML.imgs[0];
				if(imgsXML){
					if(main.imgs){
						var i:int=-1;
						for each(var subXML:XML in imgsXML.children()){
							i++;
							updateSpByLayout(imgsSpV[i],subXML.layout[0]);
						}
					}
				}
				
				if(bg){
					bg.x=-(1920-stage.stageWidth)/2;
					bg.y=-(854-stage.stageHeight)/2;
				}
				
				if(bottom){
					bottom.y=stage.stageHeight;//底部左下角对齐
					var bottomXML:XML=optionsXML.bottom[0];
					if(bottomXML){
						if(bottomXML.@align.toString().indexOf("right")>-1){
							bottom.x=stage.stageWidth;
						}else if(bottomXML.@align.toString().indexOf("center")>-1){
							bottom.x=stage.stageWidth/2;
						}
					}
				}
				
				main.loading.x=-(1920-stage.stageWidth)/2;
				main.loading.y=-(854-stage.stageHeight)/2;
				
				if(main.btnSkip){
					main.btnSkip.x=stage.stageWidth/2;
					if(btnSkip_dy>-1){
						main.btnSkip.y=main.loading.y+btnSkip_dy;
					}else{
						var b:Rectangle=main.btnSkip.getBounds(main);
						main.btnSkip.y+=stage.stageHeight-20-b.bottom;
					}
				}
				
				if(kaitouLoader){
					var videoWid0:int=int(optionsXML.kaitou[0].video[0].@width.toString());
					var videoHei0:int=int(optionsXML.kaitou[0].video[0].@height.toString());
					if(videoWid0/videoHei0<stage.stageWidth/stage.stageHeight){
						kaitouLoader.scaleX=kaitouLoader.scaleY=stage.stageWidth/videoWid0;
					}else{
						kaitouLoader.scaleX=kaitouLoader.scaleY=stage.stageHeight/videoHei0;
					}
					kaitouLoader.x=(stage.stageWidth-videoWid0*kaitouLoader.scaleX)/2;
					kaitouLoader.y=(stage.stageHeight-videoHei0*kaitouLoader.scaleY)/2;
				}
				
				if(main.fade_ani){
					main.fade_ani.x=-(1920-stage.stageWidth)/2;
					main.fade_ani.y=-(854-stage.stageHeight)/2;
				}
				if(main.others){
					main.others.x=-(1920-stage.stageWidth)/2;
					main.others.y=-(854-stage.stageHeight)/2;
				}
				
				if(_switch){
					updateSpByLayout(_switch,switch_layoutXML);
					if(
						_switch.currLoader
						&&
						_switch.currLoader.content
						&&
						_switch.currLoader.content.hasOwnProperty("resize")
					){
						_switch.currLoader.content["resize"](stage.stageWidth,stage.stageHeight);
					}
				}
			}
		}
	}
}