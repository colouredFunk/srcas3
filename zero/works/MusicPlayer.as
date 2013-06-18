/***
MusicPlayer
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年11月02日 11:44:41
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.works{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.geom.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import ui.Btn;
	
	import zero.getfonts.GetFont;
	import zero.ui.Slider;
	import zero.works.station.bgMusicOff;
	import zero.works.station.bgMusicOn;
	
	public class MusicPlayer extends BaseCom{
		
		public var defaultXMLStr:String=
<musics autoPlay="true">

    <label text="${label}" color="#8E3000" size="14" autoSize="left"/>
    <time text="${time}" color="#8E3000" size="14" autoSize="left"/>

    <music src="http://media101.wanmei.com/media/mhsd/201206/cover0606/mp3120606/xikuang.mp3">
      <label text="·西狂-杨过" color="#F8EB03" size="12" autoSize="left"/>
      <time text="04:20"/>
      <geci color="#8E3000" size="12" autoSize="left" html="true">　
 
 
《西狂》

重剑无锋隐真面
两鬓霜 心只为一人眷恋
任凭风烟嚣 尘世渺 
独步天下 半生狂唯一笑

少年傲 逆世俗何惧天道
情至深 十六载黯然神销
相思苦煎熬 心如绞
挥剑破天 只为与你重圆

寻你千度浪淘沙
历尽沧桑悲白发
名动天下 又怎及你温柔一眼
冰雪都融化

自狂笑 世间也颠倒
哪管岁月不轻饶
自在不羁 与你厮守到老

第二段主歌：

双剑合璧影飘逸
任轻狂 行江湖只愿随性
任凭风雨急 临绝地
依然桀骜 偏要冲破荆棘

就算是 一生被俗世所弃
心似铁 只可为你永不移
一刻不曾忘 别离句
相见之期 却竟无语凝噎



     　</geci>
    </music>
    <music src="http://media101.wanmei.com/media/mhsd/201206/cover0606/mp3120606/zhongnan.mp3">
      <label text="·终南-小龙女" color="#F8EB03" size="12" autoSize="left"/>
      <time text="03:56"/>
      <geci color="#8E3000" size="12" autoSize="left" html="true">　
 
 
终南

终南山下心如止水
那一滴泪却为谁
白衣胜雪不沾凡尘
云鬓花容世绝伦
踏迹江湖 世事不问
只愿你伴今生

至情不渝
生死与你相随
痴狂爱到天荒地老
此情不渝
生死也要相随
这份爱一生无悔

世外幽谷 落英缤纷
临湖对剑不知年
轻舞若蝶 琴声悠远
情已深种犹未觉
聚散离合 几经磨折
终相见泪双落




     　</geci>
    </music>
    <music src="http://media101.wanmei.com/media/mhsd/201206/cover0606/mp3120606/wenshijian.mp3">
      <label text="·问世间-李莫愁" color="#F8EB03" size="12" autoSize="left"/>
      <time text="05:00"/>
      <geci color="#8E3000" size="12" autoSize="left" html="true">　
 
 
问世间

千山暮雪对空寂
雁双飞 渺万里层云
天南地北几回寒暑更迭
独留只影向谁去

尤念昔日欢乐趣
离别苦 君可曾相记
问情是何物教生死相许
就中更有痴儿女

残月凄冷 旧人哭有谁问
薄情分飞难抒离恨 
鸳侣梦已断 锦帕绣成 痴意化泪痕

惜当初 陆郎负佳人误
恨难释如鸠毒 渐迷归途
为情缚 爱怨深积寒澈骨 
韶光易逝 回身已日暮

执拂尘 拂不尽红尘土
夜凋落花千树 人归何处
幽歌诉 焚尽此生化烟幕
倾泪千斛 再世已陌路 皆为情苦




     　</geci>
    </music>
    <music src="http://media101.wanmei.com/media/mhsd/201206/cover0606/mp3120606/bihai.mp3">
      <label text="·碧海潮生-黄药师" color="#F8EB03" size="12" autoSize="left"/>
      <time text="04:46"/>
      <geci color="#8E3000" size="12" autoSize="left" html="true">　
 
 
碧海潮生

纵横这一生有几人
亦正亦邪不论
多想能有你在身边
共赏这碧海潮生

一颦一笑总不能忘
永离之苦穿肠
唯有你 
从没有谁可以在心上

如果能够用我生命
换你回生 
也在所不惜

只要能够和你一起
化成灰也甘心

一缕箫声 一种落寞
除了你这浊世还有谁懂我
世人皆知东邪狂
何人可解心中痛

一缕箫声 一种寂寞
有我深藏的眷恋想你听到
月光如愁相隔如天遥




     　</geci>
    </music>
    <music src="http://media101.wanmei.com/media/mhsd/201206/cover0606/mp3120606/emei.mp3">
      <label text="·峨眉-郭襄" color="#F8EB03" size="12" autoSize="left"/>
      <time text="05:52"/>
      <geci color="#8E3000" size="12" autoSize="left" html="true">　
 
 
峨眉

飞雪似舞风陵渡
与你相识的最初
情窦初开印在心深处
从此一世倾慕

金针之愿许梦圆
难忘初见的容颜
你的身影渐行如风远
从此将一生思念

众里千度也寻遍
别去终难见
此时此夜为何泪盈面
闲淡度芳年
牵绊总藏心间
何如当初莫相识

清秋落叶聚还散
谁知相思难
点点祈盼化作星缀满
华山留长忆
意绵绵无穷极
心事幻梦已随你而去




      　</geci>
    </music>

</musics>.toXMLString();
		
		public var items:Sprite;
		
		public var btnPause:Btn;
		public var btnPlay:Btn;
		public var btnNext:Btn;
		public var btnPrev:Btn;
		public var btnStop:Btn;
		public var btnVol:Btn;
		public var volSlider:Slider;
		
		public var label:Sprite;
		public var time:Sprite;
		
		public var slider:Slider;
		
		public var geci:Sprite;
		public var maskShape:Sprite;
		
		private var sndV:Vector.<Sound>;
		private var sndChannel:SoundChannel;
		
		private var currId:int;
		private var currPos:int;
		private var vol:Number;
		
		public function MusicPlayer(){
			this.mouseEnabled=this.mouseChildren=false;
		}
		
		public function initComplete():void{
			if(xml.time[0]){
			}else{
				xml.time=<time text="${time}/${totalTime}" color="#000000" size="12" autoSize="left"/>;
			}
			//trace("xml="+xml.toXMLString());
			if(items){
				var i:int=-1;
				while(items.hasOwnProperty("item"+(++i))){
					var item:MusicPlayer_Item=items["item"+i];
					var musicML:XML=xml.music[i];
					if(musicML){
						item.initXML(musicML,clickItem);
					}else{
						item.visible=false;
					}
				}
			}
			sndV=new Vector.<Sound>(xml.music.length());
			
			if(btnPrev){
				btnPrev.release=prev;
			}
			if(btnNext){
				btnNext.release=next;
			}
			if(btnStop){
				btnStop.release=stop;
			}
			if(btnPlay){
				btnPlay.release=play;
			}
			if(btnPause){
				btnPause.release=pause;
			}
			
			vol=1;
			
			if(btnVol){
				btnVol["maskShape"].width=vol*24;
				btnVol.addEventListener(MouseEvent.MOUSE_DOWN,startCtrlVol);
			}
			if(volSlider){
				volSlider.value=vol;
				volSlider.onUpdate=slidVol;
			}
			
			this.addEventListener(Event.ENTER_FRAME,enterFrame);
			
			if(items){
				item=items["item0"];
				item.selected=false;
				item.mouseEnabled=true;
			}
			
			if(slider){
				slider.onUpdate=update;
				slider.mouseChildren=false;
			}
			
			if(geci){
				if(maskShape){
					geci.mask=maskShape;
				}
			}
			
			playSnd(0);
			if(xml.@autoPlay.toString()=="true"){
			}else{
				stop();
			}
			
			if(xml.music.length()){
				this.mouseChildren=true;
			}else{
				this.mouseChildren=false;
			}
			
			if(ExternalInterface.available){
				if(xml.@play.toString()){
					ExternalInterface.addCallback(xml.@play.toString(),play);
				}
				if(xml.@stop.toString()){
					ExternalInterface.addCallback(xml.@stop.toString(),stop);
				}
				if(xml.@prev.toString()){
					ExternalInterface.addCallback(xml.@prev.toString(),prev);
				}
				if(xml.@next.toString()){
					ExternalInterface.addCallback(xml.@next.toString(),next);
				}
			}
			
		}
		private function startCtrlVol(...args):void{
			stage.addEventListener(MouseEvent.MOUSE_UP,stopCtrlVol);
			this.addEventListener(Event.ENTER_FRAME,ctrlVol);
		}
		private function ctrlVol(...args):void{
			if(btnVol){
				var _wid:int=btnVol.mouseX-btnVol["maskShape"].x;
				if(_wid>1){
					if(_wid>24){
						_wid=24;
					}
					vol=_wid/24;
				}else{
					_wid=1;
					vol=0;
				}
				btnVol["maskShape"].width=_wid;
				updateVol();
			}
		}
		private function stopCtrlVol(...args):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,stopCtrlVol);
			this.removeEventListener(Event.ENTER_FRAME,ctrlVol);
		}
		private function slidVol():void{
			if(volSlider){
				vol=volSlider.value;
				updateVol();
			}
		}
		private function updateVol():void{
			if(sndChannel){
				var stf:SoundTransform=sndChannel.soundTransform;
				stf.volume=vol;
				sndChannel.soundTransform=stf;
			}
		}
		public function clear():void{
			if(btnVol){
				btnVol.removeEventListener(MouseEvent.MOUSE_DOWN,startCtrlVol);
			}
			clearSndChannel();
			this.removeEventListener(Event.ENTER_FRAME,enterFrame);
			var i:int=-1;
			for each(var musicXML:XML in xml.music){
				i++;
				if(items){
					var item:MusicPlayer_Item=items["item"+i];
					item.clear();
				}
				if(sndV[i]){
					try{
						sndV[i].removeEventListener(ProgressEvent.PROGRESS,loadSndProgress);
						sndV[i].close();
					}catch(e:Error){}
				}
			}
			sndV.length=0;
			sndV=null;
			xml=null;
		}
		private function clickItem(item:MusicPlayer_Item):void{
			if(items){
				playSnd(items.getChildIndex(item));
			}
		}
		private function playSnd(i:int):void{
			
			stop();
			
			currId=i;
			
			if(currId>=xml.music.length()){
				currId-=xml.music.length();
			}else if(currId<0){
				currId+=xml.music.length();
			}
			
			/*
			if(btnPrev){
				if(currId>0){
					btnPrev.mouseEnabled=true;
					btnPrev.alpha=1;
				}else{
					btnPrev.mouseEnabled=false;
					btnPrev.alpha=0.3;
				}
			}
			if(btnNext){
				if(currId<xml.music.length()-1){
					btnNext.mouseEnabled=true;
					btnNext.alpha=1;
				}else{
					btnNext.mouseEnabled=false;
					btnNext.alpha=0.3;
				}
			}
			*/
			
			i=-1;
			for each(var musicXML:XML in xml.music){
				i++;
				if(items){
					var item:MusicPlayer_Item=items["item"+i];
				}
				if(i==currId){
					if(item){
						item.selected=true;
						item.mouseEnabled=false;
					}
					if(label){
						if(xml.label[0]){
							GetFont.initTxt(label["txt"],new XML(xml.label[0].toXMLString().replace(/\$\{label\}/g,musicXML.label[0].@text.toString())));
						}
					}
					updateTime();
					if(sndV[currId]){
					}else{
						sndV[currId]=new Sound(new URLRequest(musicXML.@src.toString()));
						sndV[currId].addEventListener(ProgressEvent.PROGRESS,loadSndProgress);
					}
					
					if(geci){
						var geciXML:XML=musicXML.geci[0];
						if(geciXML){
							geciXML=geciXML.copy();
							geci.visible=true;
							geci["txt"].y=0;
							geci["txt"].autoSize=TextFieldAutoSize.LEFT;
							geciXML.setChildren(new XMLList(geciXML.children().toXMLString().replace(/\r\n/g,"\n").replace(/\n/g,"<br/>")));
							GetFont.initTxt(geci["txt"],geciXML);
						}else{
							geci.visible=false;
						}
					}
					
					play();
					enterFrame();
					
				}else{
					if(item){
						item.selected=false;
						item.mouseEnabled=true;
					}
				}
			}
		}
		private function clearSndChannel():void{
			if(sndChannel){
				sndChannel.removeEventListener(Event.SOUND_COMPLETE,sndComplete);
				sndChannel.stop();
				sndChannel=null;
			}
		}
		private function sndComplete(...args):void{
			playSnd(currId+1);
		}
		private function loadSndProgress(event:ProgressEvent):void{
			if(event.bytesLoaded>0&&event.bytesTotal>0){
				var snd:Sound=event.target as Sound;
				var id:int=sndV.indexOf(snd);
				if(id==currId){
					updateTime();
				}
			}
		}
		private function enterFrame(...args):void{
			if(sndChannel){
				updateTime();
				if(slider){
					if(slider.ctrling){
					}else{
						slider.value=sndChannel.position/1000/getTotalTime();
						updateGeci();
					}
				}else{
					updateGeci();
				}
			}
		}
		private function updateTime():void{
			if(time){
				if(xml.time[0]){
					GetFont.initTxt(time["txt"],new XML(
						xml.time[0].toXMLString()
						.replace(/\$\{time\}/g,getTimeStr(
							sndChannel
							?
							int(sndChannel.position/1000)
							:
							getTotalTime()
						))
						.replace(/\$\{totalTime\}/g,getTimeStr(getTotalTime()))
					));
				}
			}
		}
		private function getTotalTime():int{
			if(xml.music[currId].time[0]){
				var arr:Array=xml.music[currId].time[0].@text.replace(/\s+/g,"").split(/\D+/);
				return int(arr[0])*60+int(arr[1]);
			}
			var currSnd:Sound=sndV[currId];
			if(currSnd){
				if(currSnd.bytesLoaded>0&&currSnd.bytesTotal>0){
					return Math.round(currSnd.length/1000/(currSnd.bytesLoaded/currSnd.bytesTotal));
				}
			}
			return 0; 
		}
		private function getTimeStr(sec:int):String{
			return (100+int(sec/60)).toString().substr(1)+":"+(100+(sec%60)).toString().substr(1);
		}
		
		private function prev():void{
			if(ExternalInterface.available){
				if(xml.@ctrl_prev.toString()){
					ExternalInterface.call("eval",xml.@ctrl_prev.toString());
					return;
				}
			}
			playSnd(currId-1);
		}
		private function next():void{
			if(ExternalInterface.available){
				if(xml.@ctrl_next.toString()){
					ExternalInterface.call("eval",xml.@ctrl_next.toString());
					return;
				}
			}
			playSnd(currId+1);
		}
		
		private function stop():void{
			if(ExternalInterface.available){
				if(xml.@ctrl_stop.toString()){
					ExternalInterface.call("eval",xml.@ctrl_stop.toString());
					return;
				}
			}
			currPos=-1;
			clearSndChannel();
			if(btnPause){
				btnPause.visible=false;
			}
			if(btnPlay){
				btnPlay.visible=true;
			}
			
			if(bgMusicOn==null){
			}else{
				bgMusicOn();
			}
			
			if(slider){
				slider.mouseChildren=false;
			}
		}
		private function play():void{
			if(ExternalInterface.available){
				if(xml.@ctrl_play.toString()){
					ExternalInterface.call("eval",xml.@ctrl_play.toString());
					return;
				}
			}
			if(items){
				var i:int=-1;
				for each(var musicXML:XML in xml.music){
					i++;
					var item:MusicPlayer_Item=items["item"+i];
					if(i==currId){
						item.selected=true;
						item.mouseEnabled=false;
					}else{
						item.selected=false;
						item.mouseEnabled=true;
					}
				}
			}
			
			clearSndChannel();
			sndChannel=sndV[currId].play(currPos>0?currPos:0);
			sndChannel.addEventListener(Event.SOUND_COMPLETE,sndComplete);
			if(btnPause){
				btnPause.visible=true;
			}
			if(btnPlay){
				btnPlay.visible=false;
			}
			updateVol();
			
			if(bgMusicOff==null){
			}else{
				bgMusicOff();
			}
			
			if(slider){
				slider.mouseChildren=true;
			}
		}
		private function pause():void{
			if(sndChannel){
				currPos=sndChannel.position;
				clearSndChannel();
			}
			if(btnPause){
				btnPause.visible=false;
			}
			if(btnPlay){
				btnPlay.visible=true;
			}
		}
		
		private function update():void{
			pause();
			if(slider){
				currPos=slider.value*getTotalTime()*1000;
			}
			play();
			updateGeci();
		}
		
		private function updateGeci():void{
			if(geci){
				if(sndChannel){
					geci["txt"].y=-sndChannel.position/(getTotalTime()*1000)*geci.height;
				}else{
					geci["txt"].y=0;
				}
			}
		}
		
	}
}