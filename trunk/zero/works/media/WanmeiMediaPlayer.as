/***
WanmeiMediaPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年10月23日 09:36:59
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works.media{
	import akdcl.manager.ExternalInterfaceManager;
	
	import fl.video.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.clearTimeout;
	import flash.utils.describeType;
	import flash.utils.setTimeout;
	
	import ui.Btn;
	
	import zero.ui.ImgLoader;
	
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
				<bufferTime name="缓冲时间" default="10" description="指定开始播放视频流前要在内存中缓冲的秒数。"/>
				<playheadTime name="播放头位置" description="表示当前播放头的时间或位置（以秒为单位计算），可以是小数值。"/>
				<repeat name="循环播放" default="false" description="是否循环播放。"/>
				<scaleMode name="缩放模式" enum="exactFit|maintainAspectRatio|noScale" default="maintainAspectRatio" description="指定在视频加载后如何调整其大小。"/>
				<source name="视频地址" description="它指定要进行流式处理的 FLV 文件的 URL 以及如何对其进行流式处理。"/>
				<volume name="音量" default="1" description="介于 0 到 1 的范围内，指示音量控制设置。"/>
				
			</interfaces>
		;
		
		private var varNodeByNames:Object;
		
		private var currType:String;
		
		//public var player:VideoPlayer;
		//public var player:MP3Player;
		public var player:*;
		
		private var values:Object;
		
		public var bgBottomContainer:Sprite;
		public var bgLoader:ImgLoader;
		
		public var playerContainer:Sprite;
		
		public var btnPlay:Btn;
		public var btnPause:Btn;
		public var btnStop:Btn;
		public var btnVol:Btn;
		
		public var geci:Geci;
		
		private var timeoutId:int;
		
		private var currPlayheadTime:Number;
		
		public function WanmeiMediaPlayer(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(...args):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			
			VideoPlayer.iNCManagerClass=NCManager;
			
			if(bgBottomContainer){
				if(bgLoader){
					bgLoader.bottomContainer=bgBottomContainer;
				}
			}
			
			values=new Object();
			
			for(var valueName:String in this.loaderInfo.parameters){
				values[valueName]=this.loaderInfo.parameters[valueName];
			}
			
			if(values.hasOwnProperty("autoPlay")){
				setValue("autoPlay",values["autoPlay"]);
			}
			if(values.hasOwnProperty("source")){
				setValue("source",values["source"]);
			}
			
			setSize(320,240);
			
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
			
			initUI();
			
		}
		
		private function initUI():void{
			if(btnPlay){
				btnPlay.release=play;
			}
			if(btnPause){
				btnPause.release=pause;
			}
			if(btnStop){
				btnStop.release=stop;
			}
		}
		
		private function changePlayer(type:String):void{
			
			clearTimeout(timeoutId);//- -
			
			if(player){
				stop();
			}
			
			if(currType==type){
				return;
			}
			
			if(player){
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
			
			currType=type;
			
			switch(currType){
				case "mp3":
					player=new MP3Player();
				break;
				default:
					player=new VideoPlayer();
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
			
			player.addEventListener(VideoEvent.READY,playerEvents);
			player.addEventListener(VideoEvent.STATE_CHANGE,playerEvents);
			//player.addEventListener(SoundEvent.SOUND_UPDATE,playerEvents);
			player.addEventListener(VideoProgressEvent.PROGRESS,playerEvents);
			player.addEventListener(VideoEvent.COMPLETE,playerEvents);
			
			player.setSize(values["wid"],values["hei"]);
			
		}
		
		public function setSize(wid:int,hei:int):void{
			values["wid"]=wid;
			values["hei"]=hei;
			if(player){
				player.setSize(values["wid"],values["hei"]);
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
					if(eiM.eventParams[0]>0){
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
					eiM.dispatchSWFEvent(VideoEvent.STATE_CHANGE,player.state);
					switch(player.state){
						case VideoState.CONNECTION_ERROR:
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
				//	eiM.dispatchSWFEvent(SoundEvent.SOUND_UPDATE,player.volume);
				//break;
				case VideoProgressEvent.PROGRESS:
					if(player.bytesTotal>0){
						if(player.bytesLoaded==player.bytesTotal){
							eiM.dispatchSWFEvent("loadComplete");
						}
					}
				break;
				case VideoEvent.COMPLETE:
					eiM.dispatchSWFEvent("playComplete");
					if(values["repeat"]){
						setValue("source",values["source"]);
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
							switch(values["autoPlay"]){
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
							return values[valueName];
						break;
						
						case "bufferProgress":
							switch(player.state){
								case VideoState.BUFFERING:
								case VideoState.PAUSED:
								case VideoState.PLAYING:
									if(player.bytesTotal>0){
										var dTime:Number=player.totalTime*player.bytesLoaded/player.bytesTotal-player.playheadTime;
										if(dTime>0){
											if(dTime<player.bufferTime){
												return dTime/player.bufferTime;
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
					//var varNode:XML=varNodeByNames[valueName];
					//trace("varNode="+varNode.toXMLString());
					return player[valueName];
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
						
						case "bg":
							values[valueName]=value;
							if(bgLoader){
								if(bgLoader.xml&&bgLoader.xml.@src.toString()==value){
								}else{
									bgLoader.load(<img src={value} width={values["wid"]} height={values["hei"]}/>);
								}
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
		}
		public function play(startTime:Number=-1):void{
			if(btnPlay){
				btnPlay.visible=false;
			}
			if(btnPause){
				btnPause.visible=true;
			}
			if(player){
				if(currPlayheadTime>0){
					//trace("currPlayheadTime="+currPlayheadTime);
					player.play();
					player.playheadTime=currPlayheadTime;
				}else{
					try{
						player.play(values["source"].@src.toString());
					}catch(e:Error){
						trace("play()，e="+e);
					}
					initGeci();
					if(startTime>=0){
						player.playheadTime=startTime;
					}
				}
			}
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
				switch(values["autoPlay"]){
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
				currPlayheadTime=player.playheadTime;
				//trace("pause，currPlayheadTime="+currPlayheadTime);
				player.pause();
			}
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
		}
		public function reset():void{
			stop();
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
			geci.update(player.playheadTime/player.totalTime);
		}
		
	}
}