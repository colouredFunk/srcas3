/***
WanmeiMediaPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月23日 09:36:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.media{
	import akdcl.manager.ExternalInterfaceManager;
	
	import com.greensock.TweenMax;
	
	import fl.video.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.text.TextFieldAutoSize;
	import flash.utils.clearTimeout;
	import flash.utils.describeType;
	import flash.utils.setTimeout;
	
	import ui.Btn;
	
	import zero.ui.ImgLoader;
	import zero.ui.Slider;
	
	public class WanmeiMediaPlayer extends Sprite{
		
		private static const interfacesXML:XML=
			<interfaces>
				
				<bg name="背景图" description="背景图。"/>
				
				<!-- 只读 -->
				<bufferProgress name="缓冲进度" description="缓冲进度。"/>
				<loadProgress name="加载进度" description="加载进度。"/>
				<state name="状态" enum="buffering|connectionError|disconnected|loading|paused|playing|rewinding|seeking|stopped" description="指定组件的状态。"/>
				<totalTime name="总播放时间" description="表示视频的总播放时间，以秒为单位。"/>
				
				<!-- 读写 -->
				<autoPlay name="自动播放" default="null" description="如果设置为 true，则在设置 source 属性后自动开始播放 FLV 文件。"/>
				<autoRewind name="自动倒带" default="true" description="如果为 true，则播放停止时（由于播放器到达流的末端或调用了 stop() 方法），会使 FLV 文件后退到第 1 帧。"/>
				<blackBtnVisible name="黑按钮" default="false" description="黑按钮。"/>
				<blackBtnAlpha name="黑按钮透明度" default="1" description="黑按钮透明度。"/>
				<bufferTime name="缓冲时间" default="10" description="指定开始播放视频流前要在内存中缓冲的秒数。"/>
				<gridVisible name="显示网格" default="false" description="显示网格。"/>
				<gridAlpha name="网格透明度" default="1" description="网格透明度。"/>
				<playheadTime name="播放头位置" description="表示当前播放头的时间或位置（以秒为单位计算），可以是小数值。"/>
				<repeat name="循环播放" default="false" description="是否循环播放。"/>
				<scaleMode name="缩放模式" enum="exactFit|maintainAspectRatio|noScale" default="maintainAspectRatio" description="指定在视频加载后如何调整其大小。"/>
				<skinAutoHide name="自动隐藏皮肤" default="true" description="自动隐藏皮肤。"/>
				<source name="视频地址" description="它指定要进行流式处理的 FLV 文件的 URL 以及如何对其进行流式处理。"/>
				<volume name="音量" default="0.8" description="介于 0 到 1 的范围内，指示音量控制设置。"/>
				
			</interfaces>
		;
		
		/**
		 * 固定；初始，调整窗口，全屏，退出全屏时都为初始布局 ，适用于音乐播放器
		 */		
		public static const LAYOUT_MODE_FIXED:int=0;
		
		/**
		 * 嵌入；初始，调整窗口时为初始布局 ，全屏时撑满屏幕，退出全屏时为初始布局，适用于嵌入到其它项目中的视频播放器
		 */		
		public static const LAYOUT_MODE_EMBEDDED:int=1;
		
		/**
		 * 独立；初始，调整窗口，全屏，退出全屏时都撑满屏幕 ，适用于独立播放器
		 */		
		public static const LAYOUT_MODE_STAND_ALONE:int=2;
		
		private var layoutMode:int;
		
		private var varNodeByNames:Object;
		
		private var currType:String;
		
		//public var player:VideoPlayer;
		//public var player:MP3Player;
		public var player:*;
		
		private var values:Object;
		
		public var skin:Sprite;
		private var hideSkinDelayTime:int;
		
		public var bottom:Sprite;
		
		public var bgBottomContainer:Sprite;
		public var bgLoader:ImgLoader;
		
		public var playerContainer:Sprite;
		
		public var grid:Grid;
		
		public var coverBtn:Sprite;
		public var middleBtn:Sprite;
		
		public var skinBottom:Sprite;
		
		public var nameTxt:Sprite;
		public var timeTxt:Sprite;
		
		public var slider:Slider;
		
		public var btnPlay:Btn;
		public var btnPause:Btn;
		public var btnStop:Btn;
		public var volCtrl:VolCtrl;
		
		public var btnFullScreen:Btn;
		
		public var btnPrev:Btn;
		public var btnNext:Btn;
		
		public var items:Sprite;
		
		public var geci:Geci;
		
		public var blackBtn:Btn;
		
		private var timeoutId:int;
		
		private var wid0:int;
		private var hei0:int;
		
		private var wid:int;
		private var hei:int;
		
		private var currPlayheadTime:Number;
		
		private var __list:XML;
		private var currId:int;
		
		private var styleXML:XML=
			<style>
				<head>
					<time><font color="#686868">$&#x7b;time&#x7d;/$&#x7b;totalTime&#x7d;</font></time>
				</head>
			</style>
		;
		
		private var listLoader:URLLoader;
		
		public function set list(_list:*):void{
			__list=_list;
			if(_list){
				if(_list is XML){
					__list=_list;
				}else{
					var xmlStr:String=_list;
					xmlStr=xmlStr.replace(/^\s*|\s*$/g,"");
					if(xmlStr){
						if(xmlStr.indexOf("<")==0){
							try{
								__list=new XML(xmlStr);
								if(__list.name().toString()){
								}else{
									__list=null;
								}
							}catch(e:Error){
								__list=null;
							}
						}else{
							listLoader=new URLLoader();
							listLoader.addEventListener(Event.COMPLETE,loadListComplete);
							listLoader.load(new URLRequest(xmlStr));
							return;
						}
					}
				}
				
			}
			
			if(__list){
				__list=_list.copy();
				styleXML=__list.style[0];
				if(styleXML){
					delete __list.style;
				}
				//initUI();
				select(0);
			}else{
				throw new Error("list格式不正确："+_list);
			}
			
		}
		
		private function loadListComplete(...args):void{
			var xmlStr:String=listLoader.data;
			listLoader.removeEventListener(Event.COMPLETE,loadListComplete);
			listLoader=null;
			list=xmlStr;
		}
		
		public function WanmeiMediaPlayer(){
			this.visible=false;
		}
		
		public function init(
			_layoutMode:int=LAYOUT_MODE_FIXED,
			_wid0:int=-1,_hei0:int=-1
		):void{
			
			layoutMode=_layoutMode;
			
			VideoPlayer.iNCManagerClass=NCManager;
			
			initSkin();
			
			if(bgBottomContainer){
				if(bgLoader){
					bgLoader.bottomContainer=bgBottomContainer;
				}
			}
			
			values=new Object();
			
			if(ExternalInterface.available){
				var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
				eiM.addEventListener(ExternalInterfaceManager.CALL,jsCallThis);
				//ExternalInterface.addCallback("getValue",getValue);
				//ExternalInterface.addCallback("setValue",setValue);
				//ExternalInterface.addCallback("load",load);
				//ExternalInterface.addCallback("play",play);
				//ExternalInterface.addCallback("pause",pause);
				//ExternalInterface.addCallback("stop",stop);
				//ExternalInterface.addCallback("reset",reset);
			}
			
			if(bottom){
				wid0=bottom.width;
				hei0=bottom.height;
			}else{
				if(_wid0>-1){
					wid0=_wid0;
				}
				if(_hei0>-1){
					hei0=_hei0;
				}
				//trace("bottom="+bottom);
			}
			
			wid=wid0;
			hei=hei0;
			
			switch(layoutMode){
				case LAYOUT_MODE_FIXED:
					//
				break;
				case LAYOUT_MODE_EMBEDDED:
					//
				break;
				case LAYOUT_MODE_STAND_ALONE:
					resize();
					stage.addEventListener(Event.RESIZE,resize);
				break;
			}
			
			for each(var interfaceXML:XML in interfacesXML.children()){
				var valueName:String=interfaceXML.name().toString();
				if(this.loaderInfo.parameters.hasOwnProperty(valueName)){
					setValue(valueName,this.loaderInfo.parameters[valueName]);
				}
			}
			
			this.visible=true;
			
		}
		
		private function initSkin():void{
			if(skin){
				skin.mouseEnabled=false;
				skinBottom=skin["skinBottom"];
				nameTxt=skin["nameTxt"];
				timeTxt=skin["timeTxt"];
				slider=skin["slider"];
				btnPlay=skin["btnPlay"];
				btnPause=skin["btnPause"];
				btnStop=skin["btnStop"];
				volCtrl=skin["volCtrl"];
				btnFullScreen=skin["btnFullScreen"];
				btnPrev=skin["btnPrev"];
				btnNext=skin["btnNext"];
			}
		}
		
		private function clearPlayer():void{
			if(player){
				this.removeEventListener(Event.ENTER_FRAME,enterFrame);
				player.close();
				player.removeEventListener(VideoEvent.STATE_CHANGE,playerEvents);
				//player.removeEventListener(SoundEvent.SOUND_UPDATE,playerEvents);
				player.removeEventListener(VideoProgressEvent.PROGRESS,playerEvents);
				player.removeEventListener(VideoEvent.COMPLETE,playerEvents);
				if(playerContainer){
					playerContainer.removeChild(player);
				}
				player=null;
			}
		}
		public function clear():void{
			
			varNodeByNames=null;
			
			if(player){
				player.stop();
				clearPlayer();
			}
			
			if(ExternalInterface.available){
				var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
				eiM.removeEventListener(ExternalInterfaceManager.CALL,jsCallThis);
				//ExternalInterface.addCallback("getValue",null);
				//ExternalInterface.addCallback("setValue",null);
				//ExternalInterface.addCallback("load",null);
				//ExternalInterface.addCallback("play",null);
				//ExternalInterface.addCallback("pause",null);
				//ExternalInterface.addCallback("stop",null);
				//ExternalInterface.addCallback("reset",null);
			}
			
			values=null;
			
			if(bgLoader){
				bgLoader.clear();
			}
			
			if(slider){
				slider.clear();
			}
			
			if(coverBtn){
				coverBtn.removeEventListener(MouseEvent.MOUSE_OVER,rollOverCoverBtn);
				coverBtn.removeEventListener(MouseEvent.MOUSE_OUT,rollOutCoverBtn);
				coverBtn.removeEventListener(MouseEvent.CLICK,clickCoverBtn);
				coverBtn.removeEventListener(MouseEvent.DOUBLE_CLICK,doubleClickCoverBtn);
			}
			
			if(volCtrl){
				volCtrl.clear();
			}
			
			stage.removeEventListener(FullScreenEvent.FULL_SCREEN,changeFullScreen);
			
			clearGeci();
			
			clearTimeout(timeoutId);
			
			__list=null;
			
			stage.removeEventListener(Event.RESIZE,resize);
			
			
			this.removeEventListener(MouseEvent.MOUSE_MOVE,resetHideSkinDelayTime);
			this.removeEventListener(Event.ENTER_FRAME,checkHideSkin);
			
			stage.removeEventListener(Event.MOUSE_LEAVE,hideSkin);
			
		}
		
		private function initUI():void{
			
			initSkin();
			
			if(coverBtn){
				coverBtn.buttonMode=true;
				coverBtn.addEventListener(MouseEvent.MOUSE_OVER,rollOverCoverBtn);
				coverBtn.addEventListener(MouseEvent.MOUSE_OUT,rollOutCoverBtn);
				coverBtn.addEventListener(MouseEvent.CLICK,clickCoverBtn);
				coverBtn.doubleClickEnabled=true;
				coverBtn.addEventListener(MouseEvent.DOUBLE_CLICK,doubleClickCoverBtn);
			}
			if(middleBtn){
				middleBtn.mouseEnabled=middleBtn.mouseChildren=false;
				middleBtn.alpha=0;
			}
			
			if(volCtrl){
				volCtrl.clear();
			}
			
			if(nameTxt){
				nameTxt["txt"].autoSize=TextFieldAutoSize.LEFT;
			}
			if(timeTxt){
				timeTxt["txt"].autoSize=TextFieldAutoSize.RIGHT;
			}
			
			if(slider){
				slider.onUpdate=update;
			}
			if(btnPlay){
				btnPlay.release=play;
			}
			if(btnPause){
				btnPause.release=pause;
			}
			if(btnStop){
				btnStop.release=stop;
			}
			
			if(btnPrev){
				btnPrev.release=prev;
			}
			if(btnNext){
				btnNext.release=next;
			}
			
			if(blackBtn){
				blackBtn.release=clickBlackBtn;
			}
			
			if(volCtrl){
				volCtrl.init(getValue("volume"),updateVol);
			}
			
			if(btnFullScreen){
				changeFullScreen();
				stage.addEventListener(FullScreenEvent.FULL_SCREEN,changeFullScreen);
				btnFullScreen.release=switchFullScreen;
			}
			
			if(__list){
				if(items){
					var i:int=-1;
					while(items.hasOwnProperty("item"+(++i))){
						var item:Btn=items["item"+i];
						var node:XML=__list.children()[i];
						if(node){
							item.visible=true;
							item["nameTxt"]["txt"].autoSize=TextFieldAutoSize.LEFT;
							item["timeTxt"]["txt"].autoSize=TextFieldAutoSize.RIGHT;
							if(styleXML){
								item["nameTxt"]["txt"].htmlText=styleXML.list[0].name[0].children().toXMLString().replace(/\$\{name\}/g,node.@name.toString());
								item["timeTxt"]["txt"].htmlText=styleXML.list[0].time[0].children().toXMLString().replace(/\$\{time\}/g,node.@time.toString());
							}
							item.release=clickItem;
						}else{
							item.visible=false;
						}
					}
				}
			}
			
		}
		
		private function updateVol(volume:Number):void{
			setValue("volume",volume);
		}
		
		private function rollOverCoverBtn(...args):void{
			if(getValue("state")==VideoState.PLAYING){
			}else{
				if(middleBtn){
					TweenMax.to(middleBtn,8,{alpha:1,useFrames:true});
				}
			}
		}
		private function rollOutCoverBtn(...args):void{
			if(middleBtn){
				TweenMax.to(middleBtn,8,{alpha:0,useFrames:true});
			}
		}
		private function resetHideSkinDelayTime(...args):void{
			hideSkinDelayTime=1000;
			TweenMax.killTweensOf(skin);
			TweenMax.to(skin,8,{alpha:1,useFrames:true});
			skin.mouseChildren=true;
			this.addEventListener(Event.ENTER_FRAME,checkHideSkin);
		}
		private function checkHideSkin(...args):void{
			if((hideSkinDelayTime-=30)<0){
				if(skin.hitTestPoint(stage.mouseX,stage.mouseY,false)){
				}else{
					hideSkin();
				}
			}
		}
		private function hideSkin(...args):void{
			TweenMax.killTweensOf(skin);
			TweenMax.to(skin,8,{alpha:0,useFrames:true});
			skin.mouseChildren=false;
			this.removeEventListener(Event.ENTER_FRAME,checkHideSkin);	
		}
		
		private function clickCoverBtn(...args):void{
			if(getValue("state")==VideoState.PLAYING){
				if(middleBtn){
					TweenMax.to(middleBtn,8,{alpha:1,useFrames:true});
				}
				pause();
			}else{
				if(middleBtn){
					TweenMax.to(middleBtn,8,{alpha:0,useFrames:true});
				}
				play();
			}
		}
		private function doubleClickCoverBtn(...args):void{
			switchFullScreen();
			clickCoverBtn();//消除双击的第一击的clickCoverBtn()
		}
		
		private function clickItem():void{
			var i:int=-1;
			for each(var node:XML in __list.children()){
				i++;
				var item:Btn=items["item"+i];
				if(item.hitTestPoint(stage.mouseX,stage.mouseY,false)){
					select(i);
					break;
				}
			}
		}
		
		public function prev():void{
			if(__list&&__list.children().length()){
				if(--currId<0){
					currId=__list.children().length()-1;
				}
				select(currId);
			}
		}
		public function next():void{
			if(__list&&__list.children().length()){
				if(++currId>=__list.children().length()){
					currId=0;
				}
				select(currId);
			}
		}
		private function select(id:int):void{
			currId=id;
			setValue("source",__list.children()[currId]);
			if(items){
				var i:int=-1;
				for each(var node:XML in __list.children()){
					i++;
					var item:Btn=items["item"+i];
					if(currId==i){
						item.selected=true;
						item.mouseEnabled=false;
					}else{
						item.selected=false;
						item.mouseEnabled=true;
					}
				}
			}
		}
		
		private function clickBlackBtn():void{
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("clickBlackBtn");
		}
		
		private function changePlayer(type:String):void{
			
			clearTimeout(timeoutId);//- -
			
			if(player){
				stop();
			}
			
			if(currType==type){
				return;
			}
			
			clearPlayer();
			
			currType=type;
			
			switch(currType){
				case "mp3":
					player=new MP3Player();
					//if(slider){
					//	slider.immediately=true;
					//}
				break;
				default:
					player=new VideoPlayer();
					//if(slider){
					//	slider.immediately=false;
					//}
				break;
			}
			if(playerContainer){
				playerContainer.addChild(player);
			}
			
			varNodeByNames=new Object();
			for each(var node:XML in describeType(player).children()){
				switch(node.name().toString()){
					case "variable":
					case "accessor":
						varNodeByNames[node.@name.toString()]=node;
					break;
				}
			}
			
			for each(var interfaceXML:XML in interfacesXML.children()){
				var valueName:String=interfaceXML.name().toString();
				if(values.hasOwnProperty(valueName)){
					setValue(valueName,values[valueName]);
				}else{
					var defaultXML:XML=interfaceXML.@default[0];
					if(defaultXML){
						setValue(valueName,defaultXML.toString());
					}
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			
			player.addEventListener(VideoEvent.READY,playerEvents);
			player.addEventListener(VideoEvent.STATE_CHANGE,playerEvents);
			//player.addEventListener(SoundEvent.SOUND_UPDATE,playerEvents);
			player.addEventListener(VideoProgressEvent.PROGRESS,playerEvents);
			player.addEventListener(VideoEvent.COMPLETE,playerEvents);
			
			player.setSize(wid,hei);
			
			initUI();
			
		}
		
		public function setSize(_wid:int,_hei:int):void{
			
			//trace(wid,hei,"=>",_wid,_hei);
			
			if(bottom){
				bottom.width=_wid;
				bottom.height=_hei;
			}
			if(coverBtn){
				coverBtn.width=_wid;
				coverBtn.height=_hei;
			}
			if(middleBtn){
				middleBtn.x=int(_wid/2);
				middleBtn.y=int(_hei/2);
			}
			if(grid){
				grid.resize(_wid,_hei);
			}
			if(blackBtn){
				blackBtn.x=int(_wid/2);
				blackBtn.y=int(_hei/2);
				blackBtn["black"].width=_wid;
				blackBtn["black"].height=_hei;
			}
			
			if(skin){
				skin.y=_hei;
				if(skinBottom){
					skinBottom.width=_wid;
				}
				if(timeTxt){
					timeTxt.x+=_wid-wid;
				}
				if(volCtrl){
					volCtrl.x+=_wid-wid;
				}
				if(btnFullScreen){
					btnFullScreen.x+=_wid-wid;
				}
				if(slider){
					slider.setWid(slider.getWid()+_wid-wid);
				}
			}
			
			wid=_wid;
			hei=_hei;
			
			if(player){
				player.setSize(wid,hei);
			}
		}
		
		private function jsCallThis(_e:Event):void {
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			switch(eiM.eventType){
				case "setValue":
					setValue(eiM.eventParams[0],eiM.eventParams[1]);
				break;
				case "getValue":
					if(eiM.eventParams[0]=="source"){
						ExternalInterfaceManager.callResult=getValue(eiM.eventParams[0]).@src.toString();
					}else{
						ExternalInterfaceManager.callResult=getValue(eiM.eventParams[0]);
					}
				break;
				case "load":
					load(eiM.eventParams[0]);
				break;
				case "play":
					if(eiM.eventParams&&eiM.eventParams[0]>0){
						play(eiM.eventParams[0]);
					}else{
						play();
					}
				break;
				case "pause":
					pause();
				break;
				case "stop":
					stop();
				break;
				case "reset":
					reset();
				break;
			}
		}
		
		private function playerEvents(event:Event):void{
			//trace(event.type,player.state);
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			switch(event.type){
				case VideoEvent.READY:
					player.visible=true;
					//player.autoRewind=values["autoRewind"];//不能写这
				break;
				case VideoEvent.STATE_CHANGE:
					eiM.dispatchSWFEvent(VideoEvent.STATE_CHANGE,getValue("state"));
					switch(getValue("state")){
						case VideoState.CONNECTION_ERROR:
							trace("加载失败："+values["source"].@src.toString());
							eiM.dispatchSWFEvent("loadError");
						break;
						case VideoState.PLAYING:
							if(player.autoRewind==values["autoRewind"]){
							}else{
								player.autoRewind=values["autoRewind"];
							}
						break;
					}
				break;
				//case SoundEvent.SOUND_UPDATE:
				//	eiM.dispatchSWFEvent(SoundEvent.SOUND_UPDATE,getValue("volume"));
				//break;
				case VideoProgressEvent.PROGRESS:
					if(player.bytesTotal>0){
						slider.value2=player.bytesLoaded/player.bytesTotal;
						if(player.bytesLoaded==player.bytesTotal){
							eiM.dispatchSWFEvent("loadComplete");
						}
					}else{
						slider.value2=0;
					}
				break;
				case VideoEvent.COMPLETE:
					eiM.dispatchSWFEvent("playComplete");
					if(getValue("repeat")){
						setValue("source",values["source"]);
					}else{
						if(__list&&__list.children().length()){
							next();
						}
					}
				break;
			}
		}
		
		public function getValue(valueName:String):*{
			if(valueName){
				var interfaceXML:XML=interfacesXML[valueName][0];
				if(interfaceXML){
					switch(valueName){
						
						case "autoPlay":
							switch(values[valueName]){
								case true:
								case "true":
									return true;
								break;
								case false:
								case "false":
									return false;
								break;
								default:
									return null;
								break;
							}
						break;
						case "source":
						
						case "repeat":
						case "bg":
							
						case "gridVisible":
						case "gridAlpha":
						
						case "blackBtnVisible":
						case "blackBtnAlpha":
							
							return values[valueName];
						break;
						
						case "skinAutoHide":
							switch(values[valueName]){
								case true:
								case "true":
									return true;
								break;
								case false:
								case "false":
									return false;
								break;
								default:
									return null;
								break;
							}
						break;
						
						case "bufferProgress":
							switch(getValue("state")){
								case VideoState.BUFFERING:
								case VideoState.PAUSED:
								case VideoState.PLAYING:
									if(player.bytesTotal>0){
										var dTime:Number=getValue("totalTime")*player.bytesLoaded/player.bytesTotal-getValue("playheadTime");
										if(dTime>0){
											if(dTime<getValue("bufferTime")){
												return dTime/getValue("bufferTime");
											}
											return 1;
										}
									}
									return 0;
								break;
								default:
									return 0;
								break;
							}
						break;
						case "loadProgress":
							if(player.bytesTotal>0){
								return player.bytesLoaded/player.bytesTotal;
							}
							return 0;
						break;
					}
					if(player){
						return player[valueName];
					}
					return values[valueName];
				}
			}
		}
		public function setValue(valueName:String,value:*):void{
			if(valueName){
				var interfaceXML:XML=interfacesXML[valueName][0];
				if(interfaceXML){
					
					switch(valueName){
						
						case "autoPlay":
							switch(value){
								case true:
								case "true":
									values[valueName]=true;
								break;
								case false:
								case "false":
									values[valueName]=false;
								break;
								default:
									values[valueName]=null;
								break;
							}
							startDelay();
						break;
						case "source":
							if(value is XML){
							}else{
								if(/^\s*<[\s\S]+>\s*$/.test(value)){
									value=new XML(value);
								}else{
									value=<media src={value}/>;
								}
							}
							if(styleXML){
								if(nameTxt){
									nameTxt["txt"].htmlText=styleXML.head[0].name[0].children().toXMLString().replace(/\$\{name\}/g,value.@name.toString());
								}
							}
							values[valueName]=value;
							startDelay();
						break;
						
						case "repeat":
							switch(value){
								case true:
								case "true":
									values[valueName]=true;
								break;
								default:
									values[valueName]=false;
								break;
							}
						break;
						
						case "gridVisible":
							switch(value){
								case true:
								case "true":
									values[valueName]=true;
								break;
								default:
									values[valueName]=false;
								break;
							}
							if(grid){
								grid.visible=values[valueName];
							}
						break;
						case "gridAlpha":
							values[valueName]=Number(value);
							if(grid){
								grid.alpha=values[valueName];
							}
						break;
						case "blackBtnVisible":
							switch(value){
								case true:
								case "true":
									values[valueName]=true;
								break;
								default:
									values[valueName]=false;
								break;
							}
							if(blackBtn){
								blackBtn.visible=values[valueName];
							}
							if(skin){
								skin.visible=!values[valueName];
							}
						break;
						case "blackBtnAlpha":
							values[valueName]=Number(value);
							if(blackBtn){
								blackBtn["black"].alpha=values[valueName];
							}
						break;
						
						case "bg":
							values[valueName]=value;
							if(bgLoader){
								if(bgLoader.xml&&bgLoader.xml.@src.toString()==value){
								}else{
									bgLoader.load(<img src={value} width={wid} height={hei}/>);
								}
							}
						break;
						
						case "skinAutoHide":
							switch(value){
								case true:
								case "true":
									values[valueName]=true;
									if(skin){
										skin.mouseChildren=false;
										skin.alpha=0;
										this.addEventListener(MouseEvent.MOUSE_MOVE,resetHideSkinDelayTime);
										stage.addEventListener(Event.MOUSE_LEAVE,hideSkin);
									}
								break;
								case false:
								case "false":
									values[valueName]=false;
									if(skin){
										skin.mouseChildren=true;
										skin.alpha=1;
									}
								break;
								default:
									values[valueName]=null;
									if(skin){
										skin.mouseChildren=false;
										skin.alpha=0;
									}
								break;
							}
						break;
						
						default:
							var varNode:XML=varNodeByNames[valueName];
							switch(varNode.@type.toString()){
								case "Boolean":
									switch(value){
										case true:
										case "true":
											player[valueName]=true;
										break;
										default:
											player[valueName]=false;
										break;
									}
								break;
								case "Number":
									player[valueName]=Number(value);
								break;
								case "int":
									player[valueName]=int(value);
								break;
								case "uint":
									player[valueName]=uint(value);
								break;
								case "String":
									player[valueName]=value;
								break;
							}
							values[valueName]=player[valueName];
						break;
						
					}
					
				}
			}
		}
		
		public function load(source:String):void{
			setValue("source",source);
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("load");
		}
		public function play(startTime:Number=-1):void{
			if(btnPlay){
				btnPlay.visible=false;
			}
			if(btnPause){
				btnPause.visible=true;
			}
			if(player){
				initGeci();
				if(currPlayheadTime>0){
					//trace("currPlayheadTime="+currPlayheadTime);
					player.play();
					if(startTime>=0){
						setValue("playheadTime",startTime);
					}else{
						setValue("playheadTime",currPlayheadTime);
					}
				}else{
					try{
						player.play(values["source"].@src.toString());
					}catch(e:Error){
						trace("play()，e="+e);
					}
					if(startTime>=0){
						setValue("playheadTime",startTime);
					}
				}
			}
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("play");
		}
		private function startDelay():void{
			if(player){
				player.visible=false;
			}
			if(values["source"]){
				clearTimeout(timeoutId);
				timeoutId=setTimeout(start,100);
			}
		}
		private function start():void{
			clearTimeout(timeoutId);
			if(values["source"]){
				stop();
				if(/^.*\.mp3$/i.test(values["source"].@src.toString())){
					var type:String="mp3";
				}else{
					type="video";
				}
				if(type==currType){
				}else{
					changePlayer(type);
					clearTimeout(timeoutId);//- -
				}
				player.visible=false;
				player.autoRewind=false;
				switch(getValue("autoPlay")){
					case true:
						play();
					break;
					case false:
						player.load(values["source"].@src.toString());
						initGeci();
					break;
					default:
						//
					break;
				}
			}
		}
		public function pause():void{
			if(btnPlay){
				btnPlay.visible=true;
			}
			if(btnPause){
				btnPause.visible=false;
			}
			if(player){
				currPlayheadTime=getValue("playheadTime");
				//trace("pause，currPlayheadTime="+currPlayheadTime);
				player.pause();
			}
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("pause");
		}
		public function stop():void{
			currPlayheadTime=0;
			if(btnPlay){
				btnPlay.visible=true;
			}
			if(btnPause){
				btnPause.visible=false;
			}
			if(player){
				try{
					player.stop();
				}catch(e:Error){
					trace("stop()，e="+e);
				}
			}
			clearGeci();
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("stop");
		}
		public function reset():void{
			stop();
			var eiM:ExternalInterfaceManager=ExternalInterfaceManager.getInstance();
			eiM.dispatchSWFEvent("reset");
		}
		
		private function update(isRelease:Boolean):void{
			clearTimeout(timeoutId);
			currPlayheadTime=slider.value*getValue("totalTime");
			if(isRelease){
				setValue("playheadTime",currPlayheadTime);
			}
			updateTimeStr(currPlayheadTime);
		}
		
		private function enterFrame(...args):void{
			if(player){
				if(slider){
					//trace("slider.ctrling="+slider.ctrling);
					if(slider.ctrling){
					}else{
						slider.value=getValue("playheadTime")/getValue("totalTime");
					}
				}
				updateTimeStr(getValue("playheadTime"));
			}
		}
		private function updateTimeStr(_playheadTime:Number):void{
			if(styleXML){
				if(timeTxt){
					timeTxt["txt"].htmlText=styleXML.head[0].time[0].children().toXMLString().replace(/\$\{time\}/g,getTimeStr(_playheadTime)).replace(/\$\{totalTime\}/g,getTimeStr(getValue("totalTime")));
				}
			}
		}
		private static function getTimeStr(time:int):String{
			return (100+int(time/60)).toString().substr(1)+":"+(100+(time%60)).toString().substr(1);
		}
		
		private function initGeci():void{
			clearGeci();
			if(geci){
				if(values["source"].geci[0]){
					geci.init(values["source"].geci[0]);
					this.addEventListener(Event.ENTER_FRAME,scrollGeci);
				}
			}
		}
		private function clearGeci():void{
			if(geci){
				this.removeEventListener(Event.ENTER_FRAME,scrollGeci);
				geci.clear();
			}
		}
		private function scrollGeci(...args):void{
			if(getValue("totalTime")>0){
				geci.update(getValue("playheadTime")/getValue("totalTime"));
			}else{
				geci.update(0);
			}
		}
		
		private function switchFullScreen():void{
			switch(stage.displayState){
				case StageDisplayState.FULL_SCREEN:
				//case StageDisplayState.FULL_SCREEN_INTERACTIVE:
					stage.displayState=StageDisplayState.NORMAL;
				break;
				default:
					switch(layoutMode){
						case LAYOUT_MODE_FIXED:
							//
						break;
						case LAYOUT_MODE_EMBEDDED:
							var p:Point=this.localToGlobal(new Point(0,0));
							stage.fullScreenSourceRect=new Rectangle(p.x,p.y,Capabilities.screenResolutionX,Capabilities.screenResolutionY);
						break;
						case LAYOUT_MODE_STAND_ALONE:
							//
						break;
					}
					stage.displayState=StageDisplayState.FULL_SCREEN;
				break;
			}
			changeFullScreen();
		}
		private function changeFullScreen(...args):void{
			switch(stage.displayState){
				case StageDisplayState.FULL_SCREEN:
				//case StageDisplayState.FULL_SCREEN_INTERACTIVE:
					btnFullScreen["gra"].gotoAndStop(2);
				break;
				default:
					btnFullScreen["gra"].gotoAndStop(1);
				break;
			}
			switch(layoutMode){
				case LAYOUT_MODE_FIXED:
					//
				break;
				case LAYOUT_MODE_EMBEDDED:
					switch(stage.displayState){
						case StageDisplayState.FULL_SCREEN:
							//case StageDisplayState.FULL_SCREEN_INTERACTIVE:
							setSize(stage.stageWidth,stage.stageHeight);
						break;
						default:
							setSize(wid0,hei0);
						break;
					}
				break;
				case LAYOUT_MODE_STAND_ALONE:
					//交给 resize()
				break;
			}
		}
		
		private function resize(...args):void{
			switch(layoutMode){
				case LAYOUT_MODE_FIXED:
					//
				break;
				case LAYOUT_MODE_EMBEDDED:
					//
				break;
				case LAYOUT_MODE_STAND_ALONE:
					setSize(stage.stageWidth,stage.stageHeight);
				break;
			}
		}
		
	}
}