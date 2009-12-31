package akdcl.manager{
	import flash.media.*;
	import flash.utils.*;
	public class SoundManager{
		public static var isMusicPlay:Boolean=true;
		public static var isSoundPlay:Boolean=true;
		
		private static var soundList:Object;
		private static var musicList:Object;
		private static var initObj:Object = firstInit();
		public static function firstInit():Object {
			//初始化
			soundList = new Object();
			musicList = new Object();
			return null;
		}
		/*
		//给某音乐增加间隔时间，如果使用此方法操作main_s需要在次类文件构造方法里注释掉播放语句。
		//第一个参数为音乐连接名，第二个为秒数。第三个为帧频
		public static function addMusicOverTime(str:String, timeNo:Number, frameNo:Number)
		{
			var sndObj:SndObj = musicList[str];
			if (sndObj)
			{
				//sndObj.sound.soundManage = this;
				sndObj.sound.soundMc = sndObj.mc;
				sndObj.sound.soundMc.soundTimeMax = frameNo;
				//sndObj.sound.soundMc.soundTimeMax=timeNo*manage.GameManage.frameSpeed;
				sndObj.sound.onSoundComplete=function()
				{
					this.soundMc.soundObject = this;
					this.soundMc.soundTime = 0;
					this.soundMc.onEnterFrame=function()
					{
						this.soundTime++;
						//trace("this.soundTime="+this.soundTime);
						if (this.soundTime>=this.soundTimeMax)
						{
							this.soundObject.start(0, 1);
							delete this.onEnterFrame;
						}
					};
				};
			}
		}
		*/
		//function addSound(asd,asd)
		public static function addSound(...args)
		{
			//添加音效(字符串) 可以有两个参数 1，声音的字符串，声音默认为1 2，第一个为声音字符串 第二个为声音大小
			//addSound("snd1");
			//addSound("snd1","snd2");
			//addSound("snd1",0.9,"snd2","snd3",0.6);
			addSound2(soundList, args);
		}
		public static function addMusic(...args)
		{
			//添加音乐(字符串) 可以有两个参数 1，声音的字符串，声音默认为1 2，第一个为声音字符串 第二个为声音大小
			//addMusic("snd1");
			//addMusic("snd1","snd2");
			//addSMusic("snd1",0.9,"snd2","snd3",0.6);
			addSound2(musicList, args);
		}
		//function stopSound
		public static function stopSound(...agrs)
		{
			stopSound2(soundList, "volume", agrs);
		}
		public static function stopMusic(...agrs)
		{
			//关闭音乐
			stopSound2(musicList, "volume", agrs);
		}
		public static function returnSound()
		{
			//还原音效
			isSoundPlay = true;
			for (var i in soundList)
			{
				setChannelVolume(soundList[i].channel,soundList[i].vol);
			}
		}
		public static function returnMusic()
		{
			//还原音乐
			isMusicPlay = true;
			for (var i in musicList)
			{
				setChannelVolume(musicList[i].channel,musicList[i].vol);
			}
		}
		public static function playSound(...args)
		{
			//播放已加载的音效 可以有三个参数 1，让声音播放一次 2，第一个是声音字符串，第二个是播放次数 3，第三个参数为播放的临时音量。
			if (isSoundPlay)
			{
				playSound2(soundList, args);
			}
		}
		public static function playMusic(...args)
		{
			//播放已加载的音乐 可以有两个参数 1，让声音播放一次 2，第一个是声音字符串，第二个是播放次数
			if (isMusicPlay)
			{
				playSound2(musicList, args);
			}
		}
		public static function setSoundVol(...args)
		{
			//设置音效音量 可以有2个参数 1，第一个是音量 设置全部音量 2，第一个是音乐字符串，第二个是音量。
			setSoundVol2(soundList, args);
		}
		public static function setMusicVol(...args)
		{
			//设置音乐音量 可以有2个参数 1，第一个是音量 设置全部音量 2，第一个是音乐字符串，第二个是音量。
			setSoundVol2(musicList, args);
		}
		public static function isTrueStopSound(...args)
		{
			stopSound2(soundList, "stop", args);
		}
		public static function isTrueStopMusic(...args)
		{
			stopSound2(musicList, "stop", args);
		}
		public static function clearSoundAndMusic()
		{
			soundList = null;
			musicList = null;
			//delete soundList;
			//delete musicList;
		}
		private static function addSound2(list:Object, args:Array):void
		{
			
			var L:int = args.length;
			var i:int;
			var value;
			if(L==1){
				var str:String=args[0];
				if(str.indexOf(",")>=0){
					args=str.split(",");
				}
				i=0;
				for each(value in args){
					if(!isNaN(value)){
						args[i]=Number(value);
					}
					i++;
				}
				L=args.length;
			}
			i=-1;
			while (++i<L)
			{
				value = args[i];
				if (value is String)
				{
					//try{
						var SndClass:Class=getDefinitionByName(value) as Class;
					//}catch(e){
						//trace("addSound2.addSound2(),e="+e);
						//trace("找不到声音:"+value);
						//continue;
					//}
					var sndObj:SndObj = list[value]=new SndObj();
					
					sndObj.sound = new SndClass();
					sndObj.name = value;
					var value2 = args[i+1];
					//sndObj.sound.start();
					if (value2 is Number)
					{
						sndObj.vol = adjustVolume(value2);
						i++;
					}
					else
					{
						sndObj.vol = 1;
					}
					//trace("加入音效："+value+"音量为："+sndObj.vol);
				}
			}
		}
		private static function stopSound2(list:Object, action:String, args:Array):void
		{
			var i;
			switch (action)
			{
			case "stop" :
				if (args.length>0)
				{
					//关闭部分音效
					for (i in args)
					{
						if(list[args[i]].channel){
							list[args[i]].channel.stop();
						}
					}
				}
				else
				{
					//关闭所有音效
					for (i in list)
					{
						if(list[i].channel){
							list[i].channel.stop();
						}
					}
				}
				break;
			default :
				if (args.length>0)
				{
					//关闭部分音效
					for (i in args)
					{
						setChannelVolume(list[args[i]].channel,0);
					}
				}
				else
				{
					//关闭所有音效
					for (i in list)
					{
						setChannelVolume(list[i].channel,0);
					}
				}
				break;
			}
		}
		private static function adjustVolume(vol:Number):Number
		{
			if (isNaN(vol))
			{
				return 1;
			}
			if (vol>1)
			{
				//trace("小子又忘了音量不是0到100的了吧 vol="+vol);
				return 1;
			}
			if (vol<0)
			{
				return 0;
			}
			return vol;
		}
		private static function setSoundVol2(list:Object, args:Array):void
		{
			var L:int = args.length;
			if (L>0)
			{
				if (L == 1)
				{
					var vol:Number = adjustVolume(args[0]);
					for (var sndName:String in list)
					{
						list[sndName].vol = vol;
					}
				}
				else
				{
					var i:int = -1;
					while (++i<L)
					{
						var value = args[i];
						if (typeof (value) == "string")
						{
							var sndObj:SndObj = list[value];
							var value2 = args[i+1];
							if (typeof (value2) == "number")
							{
								sndObj.vol = adjustVolume(value2);
								i++;
							}
							else
							{
								sndObj.vol = 1;
							}
							setChannelVolume(sndObj.channel,sndObj.vol);
						}
					}
				}
			}
		}
		private static function sndListPlayAble(arg:Object):Boolean{
			var list;
			if(typeof(arg)=="string"){
				if(musicList[arg]){
					list=musicList;
				}else{
					list=soundList;
				}
			}else{
				list=arg;
			}
			if(list==musicList){
				return isMusicPlay;
			}
			if(list==soundList){
				return isSoundPlay;
			}
			return false;
		}
		private static function playSound2(list:Object, args:Array):void
		{
			if(!sndListPlayAble(list)){
				return;
			}
			var name:String = args[0];
			if(list[name]==null){
				return;
			}
			var times:int = args[1];
			if (isNaN(times))
			{
				times = 1;
			}
			var vol:Number = args[2];
			var sndObj:SndObj = list[name];
			sndObj.channel=sndObj.sound.play(0, times);
			if (isNaN(vol))
			{
				vol=sndObj.vol;
			}else{
				vol=adjustVolume(vol);
			}
			setChannelVolume(sndObj.channel,vol);
			//trace("播放音效: "+sndObj.sound+","+sndObj.name+",times="+times+",vol="+vol);
		}
		private static function setChannelVolume(channel:SoundChannel,vol:Number):void{
			if(channel){
				var stf:SoundTransform=channel.soundTransform;
				stf.volume=vol;
				channel.soundTransform=stf;
			}
		}
		//private var movSoundObj;
		//moveSound("hitSound",30,1,0.1);
		//moveSound("hitSound",30,1,0.1,2);
		//moveSound("hitSound",30,0.1,null,5);
		public static function moveSound(sndName:String, totalTime:int, startVol:Number, endVol:Number, playTimes:int):void
		{
			var sndObj:SndObj;
			sndObj = soundList[sndName];
			if (sndObj == null)
			{
				sndObj = musicList[sndName];
			}
			if (sndObj == null)
			{
				return;
			}
			if(!sndListPlayAble(sndName)){
				return;
			}
			//trace("sndObj="+sndObj); 
			if (isNaN(endVol))
			{
				//从startVol渐变到默认音量
				endVol = sndObj.vol;
			}
			sndObj.startVol = startVol>=0 ? startVol : 0;
			sndObj.endVol = endVol>=0 ? endVol : 0;
			sndObj.currTime = 0;
			sndObj.totalTime = totalTime>0 ? totalTime : 0;
			if (startVol<endVol)
			{
				if (soundList[sndName])
				{
					playSound(sndObj.name, playTimes);
				}
				else
				{	
					playMusic(sndObj.name, playTimes);
				}
			}
			setChannelVolume(sndObj.channel,startVol);
			sndObj.intervalId = setInterval(sndObj.setSound, 30);
		}
		private static function findObjBySnd(snd:Sound):Object
		{
			var i;
			for (i in soundList)
			{
				if (soundList[i].sound == snd)
				{
					return soundList[i];
				}
			}
			for (i in musicList)
			{
				if (musicList[i].music == snd)
				{
					return musicList[i];
				}
			}
			return null
		}
	}
}
import flash.media.*;
import flash.utils.*;
class SndObj{
	public var name:String;
	public var sound:Sound;
	private var __vol:Number;
	public var channel:SoundChannel;
	public var startVol:Number;
	public var endVol:Number;
	public var currTime:Number;
	public var totalTime:Number;
	public var intervalId:int;
	public function SndObj(){
	}
	public function get vol():Number {
		return __vol;
	}
	public function set vol(_vol:Number):void {
		__vol = _vol;
		//channel.soundTransform.volume = __vol;
	}
	public function setSound():void{
		/*
		if(sound.getVolume()<=0){
			if(this.startVol>this.endVol){
				//淡出的,已经音量为0,停掉
				clearInterval(this.intervalId);
				this.channel.stop();
				return;
			}
		}
		if (++this.currTime>=this.totalTime){
			clearInterval(this.intervalId);
		}
		sound.setxxxVolume(this.startVol+(this.endVol-this.startVol)*(this.currTime/this.totalTime));
		//trace("move:"+this.sound.getVolume());
		*/
	};
		
}