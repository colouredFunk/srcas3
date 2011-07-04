/***
JunkTagsAdder 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月12日 19:37:18
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.funs{
	import flash.utils.ByteArray;
	
	import zero.*;
	import zero.swf.*;
	import zero.swf.tagBodys.*;
	
	import zero.ZeroCommon;
	
	public class JunkTagsAdder{
		private static const TYPE_LoopPlaceObject2:int=1;
		private static const TYPE_LoopAction:int=2;
		private static const TYPE_EmptySoundStreamBlock:int=3;
		
		public static function addJunkTags(swf:SWF,total:int=10):void{
			//挂 ASV:
			//total个插入到 JunkSprite 中的 loopPlaceObject2
			//total个插入到正常 DefineSprite 中的 loopPlaceObject2
			
			//挂 ASV:
			//total个单独的 loopAction
			//total个插入到 JunkSprite 中的 loopAction
			//total个插入到正常 DefineSprite 中的 loopAction
			
			//挂 闪客精灵:
			//total个插入到 JunkSprite 中的 emptySoundStreamBlock
			
			var pos:Pos,subPos:Pos,tag:Tag,subTag:Tag,tagOrPos:*,subTagOrPos:*;
			
			var posV:Vector.<Pos>=new Vector.<Pos>();
			var in_normal_sprite_loopPlaceObject2PosV:Vector.<Pos>=new Vector.<Pos>();
			var in_normal_sprite_posV:Vector.<Pos>=new Vector.<Pos>();
			
			var avalibleDefineObjIdV:Vector.<int>=getAvalibleDefineObjIdV(swf.tagV);
			
			var tagAndPosArr:Array=new Array();
			for each(tag in swf.tagV){
				switch(tag.type){
					case TagTypes.FileAttributes:
					case TagTypes.Metadata:
					case TagTypes.SetBackgroundColor:
					case TagTypes.EnableDebugger:
					case TagTypes.EnableDebugger2:
					case TagTypes.DebugID:
					case TagTypes.ScriptLimits:
					case TagTypes.ProductInfo:
					case TagTypes.DefineSceneAndFrameLabelData:
					case TagTypes.End:
						//这些 tag 前面不能有 pos
						tagAndPosArr.push(tag);
					break;
					default:
						pos=new Pos();
						posV.push(pos);
						tagAndPosArr.push(pos);
						if(tag.type==TagTypes.DefineSprite){
							pos.id=tag.getDefId();
							var subTagAndPosArr:Array=new Array();
							var placeObject2:PlaceObject2=null;
							for each(subTag in (tag.getBody(null) as DefineSprite).tagV){
								switch(subTag.type){
									case TagTypes.End:
										//这些 tag 前面不能有 pos
										subTagAndPosArr.push(subTag);
									break;
									default:
										subPos=new Pos();
										in_normal_sprite_posV.push(subPos);
										subTagAndPosArr.push(subPos);
										if(placeObject2){
											//上一个 tag 是符合条件的 PlaceObject2
											subPos.parentId=pos.id;
											subPos.placeObject2=placeObject2;
											in_normal_sprite_loopPlaceObject2PosV.push(subPos);
											placeObject2=null;
										}
										subTagAndPosArr.push(subTag);
										if(subTag.type==TagTypes.PlaceObject2){
											placeObject2=subTag.getBody({swf_Version:swf.Version}) as PlaceObject2;
											if(placeObject2.PlaceFlagHasCharacter&&placeObject2.CharacterId){
											}else{
												placeObject2=null;
											}
										}
									break;
								}
							}
							pos.tagAndPosArr=subTagAndPosArr;
						}else{
							tagAndPosArr.push(tag);
						}
					break;
				}
			}
			//
			
			/////////////////////////////////////////////////////////////////////
			var id:int;
			
			//挂 ASV:
			///*
			//total个插入到 JunkSprite 中的 loopPlaceObject2
			for each(id in ZeroCommon.getIdV(total,posV.length)){
				posV[id].tagV.push(
					getJunkSpriteTag(
						avalibleDefineObjIdV.shift(),
						TYPE_LoopPlaceObject2
					)
				);
			}
			//*/
			///*
			//total个插入到正常 DefineSprite 中的 loopPlaceObject2
			for each(id in ZeroCommon.getIdV(total,in_normal_sprite_loopPlaceObject2PosV.length)){
				subPos=in_normal_sprite_loopPlaceObject2PosV[id];
				subPos.tagV.push(
					getPlaceObject2Tag(subPos.parentId,subPos.placeObject2.Depth)
				);
			}
			//*/
			
			//挂 ASV:
			///*
			//total个单独的 loopAction
			for each(id in ZeroCommon.getIdV(total,posV.length)){
				posV[id].tagV.push(getActionLoopTag());
			}
			//*/
			///*
			//total个插入到 JunkSprite 中的 loopAction
			for each(id in ZeroCommon.getIdV(total,posV.length)){
				posV[id].tagV.push(
					getJunkSpriteTag(
						avalibleDefineObjIdV.shift(),
						TYPE_LoopAction
					)
				);
			}
			//*/
			///*
			//total个插入到正常 DefineSprite 中的 loopAction
			for each(id in ZeroCommon.getIdV(total,in_normal_sprite_posV.length)){
				in_normal_sprite_posV[id].tagV.push(getActionLoopTag());
			}
			//*/
			
			//挂 闪客精灵:
			///*
			//total个插入到 JunkSprite 中的 emptySoundStreamBlock
			for each(id in ZeroCommon.getIdV(total,posV.length)){
				posV[id].tagV.push(
					getJunkSpriteTag(
						avalibleDefineObjIdV.shift(),
						TYPE_EmptySoundStreamBlock
					)
				);
			}
			//*/
			/////////////////////////////////////////////////////////////////////
			
			//
			swf.tagV.length=0;//清空 tagV
			for each(tagOrPos in tagAndPosArr){
				if(tagOrPos is Tag){
					tag=tagOrPos;
					swf.tagV.push(tag);
				}else{
					pos=tagOrPos;
					if(pos.tagV.length){
						for each(tag in pos.tagV){
							swf.tagV.push(tag);
						}
					}
					if(pos.tagAndPosArr){
						var defineSprite:DefineSprite=new DefineSprite();
						defineSprite.id=pos.id;
						defineSprite.tagV=new Vector.<Tag>();
						for each(subTagOrPos in pos.tagAndPosArr){
							if(subTagOrPos is Tag){
								subTag=subTagOrPos;
								defineSprite.tagV.push(subTag);
							}else{
								subPos=subTagOrPos;
								if(subPos.tagV.length){
									for each(subTag in subPos.tagV){
										defineSprite.tagV.push(subTag);
									}
								}
							}
						}
						var defineSpriteTag:Tag=new Tag();
						defineSpriteTag.setBody(defineSprite);
						swf.tagV.push(defineSpriteTag);
					}
				}
			}
		}
		
		private static function getJunkSpriteTag(defId:int,type:int):Tag{
			//ASV 会挂掉
			//一个循环引用的DefineSprite:
			
			var defineSprite:DefineSprite=new DefineSprite();
			defineSprite.id=defId;
			defineSprite.tagV=new Vector.<Tag>();
			
			var i:int=int(Math.random()*3);//随便给几帧
			while(--i>=0){
				defineSprite.tagV.push(new Tag(TagTypes.ShowFrame));
			}
			
			if(type==TYPE_LoopPlaceObject2||Math.random()<0.3){
				defineSprite.tagV.push(getPlaceObject2Tag(defId));
			}
			if(type==TYPE_LoopAction||Math.random()<0.3){
				defineSprite.tagV.push(getActionLoopTag());
			}
			if(type==TYPE_EmptySoundStreamBlock||Math.random()<0.3){
				defineSprite.tagV.push(new Tag(TagTypes.SoundStreamBlock));
			}
			
			ZeroCommon.disorder(defineSprite.tagV);
			defineSprite.tagV.push(new Tag(TagTypes.ShowFrame));
			defineSprite.tagV.push(new Tag(TagTypes.End));
			
			var defineSpriteTag:Tag=new Tag();
			defineSpriteTag.setBody(defineSprite);
			return defineSpriteTag;
		}
		private static function getPlaceObject2Tag(CharacterId:int,Depth:int=0):Tag{
			var placeObject2:PlaceObject2;
			placeObject2=new PlaceObject2();
			placeObject2.Depth=Depth>0?Depth:int(Math.random()*5)+1;//随便给个深度
			
			placeObject2.PlaceFlagHasCharacter=1;
			placeObject2.CharacterId=CharacterId;
			
			var placeObjectTag:Tag=new Tag();
			placeObjectTag.setBody(placeObject2);
			return placeObjectTag;
		}
		
		private static function getActionLoopTag():Tag{
			var doActionTag:Tag=new Tag(TagTypes.DoAction);
			
			var data:ByteArray=new ByteArray();
			
			//ASV 会卡住
			//一个无限循环的DoAction:
			
			//return
			//label1:
			//branch label1
			
			data[0]=0x3e;
			data[1]=0x99;
			data[2]=0x02;
			data[3]=0x00;
			data[4]=0xfb;
			data[5]=0xff;
			data[6]=0x00;
			
			doActionTag.setBodyData(data);
			
			return doActionTag;
		}
		
	}
}

import zero.swf.Tag;
import zero.swf.tagBodys.PlaceObject2;
class Pos{
	public var parentId:int;
	public var id:int;
	public var tagV:Vector.<Tag>=new Vector.<Tag>();
	public var placeObject2:PlaceObject2;
	public var tagAndPosArr:Array;
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