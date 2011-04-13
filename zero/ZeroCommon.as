/***
ZeroCommon 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2011年1月2日 17:15:43
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero{
	import flash.display.*;
	import flash.events.*;;
	import flash.utils.*;
	import flash.geom.*;
	import flash.external.*;
	import flash.filters.ColorMatrixFilter;
	import flash.system.Security
	
	public class ZeroCommon{
		public static function getTime():String{
			var date:Date=new Date();
			var month:int=date.getMonth()+1;
			var day:int=date.getDate();
			var hours:int=date.getHours();
			var minutes:int=date.getMinutes();
			var seconds:int=date.getSeconds();
			
			return date.getFullYear()+"年"
				+(month<10?"0":"")+"月"
				+(day<10?"0":"")+"日 "
				+(hours<10?"0":"")+hours+":"
				+(minutes<10?"0":"")+minutes+":"
				+(seconds<10?"0":"")+seconds;
		}
		
		public static const FileClass:Class=function():Class{//就是 File，可用作判断是否 air ... - -
			try{
				return getDefinitionByName("flash.filesystem.File") as Class;
			}catch(e:Error){}
			
			return null;
		}();
		
		public static const domain:String=function():String{
			var domain:String="zero.flashwing.net";
			//var domain:String="localhost/zero.flashwing.net";
			
			if(FileClass){
			}else{
				Security.allowDomain(domain);
				Security.allowInsecureDomain(domain);
			}
			
			return domain;
		}();
		
		public static const path_common:String="http://"+domain+"/common/";
		public static const path_ZeroPrevLoader:String=path_common+"ZeroPrevLoader.swf";
		public static const path_BottomBar:String=path_common+"BottomBar.swf";
		public static const path_Paihangbang:String=path_common+"Paihangbang.swf";
		//public static const path_SubmitScore:String=path_common+"SubmitScore.swf";
		public static const path_SubmitScore:String=path_common+"SubmitScore_encrypt.swf";
		public static const path_getMsg:String=path_common+"getMsg.php";
		public static const path_FlashPlayer_exe_compress:String=path_common+"FlashPlayer.exe.compress";
		
		public static const path_JigsawPuzzle:String="http://"+domain+"/JigsawPuzzle/";
		
		public static const path_ZeroSWFEncrypt:String="http://"+domain+"/ZeroSWFEncrypt/";
		//public static const path_ZeroSWFEncryptAIR:String=path_ZeroSWFEncrypt+"ZeroSWFEncryptAIR.rar";
		
		//public static const path_Card3D:String="http://"+domain+"/Card3D/";
		//public static const path_Card3D_CtrlPan:String=path_Card3D+"CtrlPan.swf";
		//public static const path_Card3D_motionList:String=path_Card3D+"motionList.xml";
		
		public static const path_photodiy:String="http://"+domain+"/photodiy/";
		
		public static const path_photodiy_album:String=path_photodiy+"album/";
		public static const path_photodiy_album_getlist:String=path_photodiy_album+"getlist.php";
		public static const path_photodiy_album_uploadFile:String=path_photodiy_album+"uploadFile.php";
		public static const path_photodiy_album_newFolder:String=path_photodiy_album+"newFolder.php";
		public static const path_photodiy_album_swf_PhotoDIY_Album:String=path_photodiy_album+"swf/PhotoDIY_Album.swf";
		//public static const path_photodiy_album_swf_PhotoDIY_Album:String="http://localhost/zero.flashwing.net/test.swf";
		//public static const path_photodiy_album_swf_PhotoDIY_SrcGetter:String=path_photodiy_album+"swf/PhotoDIY_SrcGetter.swf";
		
		public static const path_photodiy_Card2011:String=path_photodiy+"Card2011/";
		public static const path_photodiy_Card2011_Card_encrypt:String=path_photodiy_Card2011+"Card_encrypt.swf";
		public static const path_photodiy_Card2011_motionList:String=path_photodiy_Card2011+"motionList.xml";
		public static const path_photodiy_Card2011_uploadFiles:String=path_photodiy_Card2011+"uploadFiles.php";
		public static const path_photodiy_Card2011_online:String=path_photodiy_Card2011+"online.htm";
		
		public static const path_photodiy_tackfilm:String=path_photodiy+"tackfilm/";
		public static const path_photodiy_tackfilm_tackfilmmovie_encrypt:String=path_photodiy_tackfilm+"tackfilmmovie_encrypt.swf";
		public static const path_photodiy_tackfilm_online:String=path_photodiy_tackfilm+"online.htm";
		
		public static function removeAll(obj:DisplayObjectContainer):void{
			//清空一个容器
			var i:int=obj.numChildren;
			while(--i>=0){
				obj.removeChildAt(i);
			}
		}
		
		public static function stopAll(obj:DisplayObjectContainer):void{
			//停止一个容器里的所有 MovieClip 动画
			if(obj is MovieClip){
				(obj as MovieClip).stop();
			}
			var i:int=obj.numChildren;
			while(--i>=0){
				var child:DisplayObject=obj.getChildAt(i);
				if(child is DisplayObjectContainer){
					stopAll(child as DisplayObjectContainer);
				}
			}
		}
		
		public static function getURLValues():Object{
			var pageURL:String;
			try{
				pageURL=ExternalInterface.call("eval","top.location.href");
			}catch(e:Error){
				return null;
			}
			if(pageURL){
			}else{
				try{
					pageURL=ExternalInterface.call("eval","window.location.href");
				}catch(e:Error){
					return null;
				}
			}
			if(pageURL){
				var v_id:Number=pageURL.lastIndexOf("?");
				if(v_id>0){
					var valuesStr:String=pageURL.substr(v_id+1);
					var arr:Array=valuesStr.split("&");
					var i:Number=arr.length;
					var urlValues:Object=new Object();
					while(--i>=0){
						var nameAndValue:Array=arr[i].split("=");
						urlValues[nameAndValue[0]]=nameAndValue[1];
					}
					return urlValues;
				}
			}
			return null;
		}
		
		public static function setGrey(obj:InteractiveObject,enabled:Boolean):void{
			//禁用鼠标并让物体变成灰色
			
			if(enabled){
				obj.mouseEnabled=true;
				obj.filters=null;
			}else{
				obj.mouseEnabled=false;
				obj.filters=[new ColorMatrixFilter([0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0.3086000084877014,0.6093999743461609,0.0820000022649765,0,0,0,0,0,1,0])];
			}
		}
		
		public static function disorder(v:*):void{
			//打乱 Array 或 Vector
			var L:int=v.length;
			var i:int=L;
			while(--i>=0){
				var ran:int=int(Math.random()*L);
				var temp:*=v[i];
				v[i]=v[ran];
				v[ran]=temp;
			}
		}
		public static function getDisorderArr(L:int):Array{
			//获取一个长度为 L 的打乱数组
			var arr:Array=new Array();
			for(var i:int=0;i<L;i++){
				arr[i]=i;
			}
			disorder(arr);
			return arr;
		}
		
		public static function getContainBmd(bg:DisplayObject,obj:DisplayObject):BitmapData{
			//从obj"往外看",截到的bg的部分转成位图返回
			return getRectContainBmd(bg,obj,obj.getBounds(obj));
		}
		public static function getRectContainBmd(bg:DisplayObject,obj:DisplayObject,rect:Rectangle):BitmapData{
			var bmd:BitmapData=new BitmapData(rect.width,rect.height,true,0x00000000);
			var m:Matrix=bg.transform.concatenatedMatrix;
			var objM:Matrix=new Matrix(1,0,0,1,rect.x,rect.y);
			var m2:Matrix=obj.transform.concatenatedMatrix;
			objM.concat(m2);
			objM.invert();
			m.concat(objM);
			bmd.draw(bg,m);
			return bmd;
		}
		
		
		//////
		
		private static var xattr_stringXML:XML=<string/>;
		public static function esc_xattr(str:String):String{
			//顾名思义：escape xml attributes，google 翻译叫作：XML属性逃生
			// 当调用 {} 给 xml 设置字符串值时编译器会生成一个 esc_xattr 运算符，但在 as3 中却没有提供一个直接的这么一个函数（参考本帅哥机器上的一篇文章：AS3操作XML：F:\wamp\www\zero.flashwing.net\bg\AS3AndXML\AS3AndXML.php）
			if(str){
				xattr_stringXML.@value=str;
				str=xattr_stringXML.toXMLString().replace("<string value=\"","");
				return str.substr(0,str.length-3).replace(/>/g,"&gt;");
			}
			return str;
		}
		public static function unesc_xattr(str:String):String{
			//esc_xattr 的反向操作
			if(str){
				return new XML("<string value=\""+str+"\"/>").@value.toString();
			}
			return str;
		}
		
		//var stringXML:XML;
		//
		//stringXML=<string value="#"/>
		//trace(stringXML.toXMLString());//输出：<string value="#"/>
		//trace(stringXML.toXMLString().replace(/^<string value=(".*")\/>$/,"$1"));//输出："#"
		//
		//stringXML=<string value=""/>
		//trace(stringXML.toXMLString());//输出：<string value=""/>
		//trace(stringXML.toXMLString().replace(/^<string value=(".*")\/>$/,"$1"));//输出：<string value=""/> (出错)
		
		//////
		
		public static const zeroGIFData:ByteArray=function():ByteArray{//本帅哥的头像的 gif 文件的字节数据
			//如果使用 loader.loadBytes 加载此数据，并且发布设置里设置成仅访问网络，并且 SWF 文件直接放在本地打开，并且访问 loader.content，则会报错：
			//SecurityError: Error #2148: SWF 文件 file:///C|/Documents%20and%20Settings/Administrator/桌面/Test.swf 不能访问本地资源 file:///C|/Documents%20and%20Settings/Administrator/桌面/Test.swf/[[DYNAMIC]]/1。只有仅限于文件系统的 SWF 文件和可信的本地 SWF 文件可以访问本地资源。
			//at flash.display::Loader/get content()
			
			//如果仅仅是为获取 BitmapData，请直接使用 ZeroCommon.zeroGIFBmd
			
			var zeroGIFData:ByteArray=new ByteArray();
			zeroGIFData[0]=0x47;zeroGIFData[1]=0x49;zeroGIFData[2]=0x46;zeroGIFData[3]=0x38;zeroGIFData[4]=0x39;zeroGIFData[5]=0x61;zeroGIFData[6]=0x28;zeroGIFData[7]=0x00;
			zeroGIFData[8]=0x28;zeroGIFData[9]=0x00;zeroGIFData[10]=0xa2;zeroGIFData[11]=0x00;zeroGIFData[12]=0x00;zeroGIFData[13]=0x00;zeroGIFData[14]=0x00;zeroGIFData[15]=0x00;
			zeroGIFData[16]=0xff;zeroGIFData[17]=0xff;zeroGIFData[18]=0xff;zeroGIFData[19]=0xcc;zeroGIFData[20]=0xcc;zeroGIFData[21]=0xcc;zeroGIFData[22]=0x99;zeroGIFData[23]=0x99;
			zeroGIFData[24]=0x99;zeroGIFData[25]=0x66;zeroGIFData[26]=0x66;zeroGIFData[27]=0x66;zeroGIFData[28]=0x33;zeroGIFData[29]=0x33;zeroGIFData[30]=0x33;zeroGIFData[31]=0x00;
			zeroGIFData[32]=0x00;zeroGIFData[33]=0x00;zeroGIFData[34]=0x00;zeroGIFData[35]=0x00;zeroGIFData[36]=0x00;zeroGIFData[37]=0x2c;zeroGIFData[38]=0x00;zeroGIFData[39]=0x00;
			zeroGIFData[40]=0x00;zeroGIFData[41]=0x00;zeroGIFData[42]=0x28;zeroGIFData[43]=0x00;zeroGIFData[44]=0x28;zeroGIFData[45]=0x00;zeroGIFData[46]=0x00;zeroGIFData[47]=0x03;
			zeroGIFData[48]=0xff;zeroGIFData[49]=0x18;zeroGIFData[50]=0x21;zeroGIFData[51]=0xa2;zeroGIFData[52]=0xfe;zeroGIFData[53]=0x30;zeroGIFData[54]=0xca;zeroGIFData[55]=0xe9;
			zeroGIFData[56]=0x80;zeroGIFData[57]=0x2d;zeroGIFData[58]=0x83;zeroGIFData[59]=0xb1;zeroGIFData[60]=0x51;zeroGIFData[61]=0x0a;zeroGIFData[62]=0xa0;zeroGIFData[63]=0xe0;
			zeroGIFData[64]=0x64;zeroGIFData[65]=0x8d;zeroGIFData[66]=0xe4;zeroGIFData[67]=0x38;zeroGIFData[68]=0x84;zeroGIFData[69]=0xe8;zeroGIFData[70]=0xe3;zeroGIFData[71]=0x95;
			zeroGIFData[72]=0x65;zeroGIFData[73]=0x93;zeroGIFData[74]=0xa6;zeroGIFData[75]=0x1e;zeroGIFData[76]=0x11;zeroGIFData[77]=0xb0;zeroGIFData[78]=0xe3;zeroGIFData[79]=0x0b;
			zeroGIFData[80]=0x03;zeroGIFData[81]=0x2e;zeroGIFData[82]=0x6d;zeroGIFData[83]=0xb9;zeroGIFData[84]=0xf6;zeroGIFData[85]=0xe4;zeroGIFData[86]=0x09;zeroGIFData[87]=0xa7;
			zeroGIFData[88]=0x81;zeroGIFData[89]=0xce;zeroGIFData[90]=0x42;zeroGIFData[91]=0x38;zeroGIFData[92]=0xf5;zeroGIFData[93]=0x20;zeroGIFData[94]=0xbf;zeroGIFData[95]=0xdd;
			zeroGIFData[96]=0xb0;zeroGIFData[97]=0x54;zeroGIFData[98]=0x20;zeroGIFData[99]=0x30;zeroGIFData[100]=0x7a;zeroGIFData[101]=0x3f;zeroGIFData[102]=0xcf;zeroGIFData[103]=0x4c;
			zeroGIFData[104]=0x57;zeroGIFData[105]=0x84;zeroGIFData[106]=0x0c;zeroGIFData[107]=0x08;zeroGIFData[108]=0x80;zeroGIFData[109]=0x2a;zeroGIFData[110]=0x4a;zeroGIFData[111]=0x5a;
			zeroGIFData[112]=0x68;zeroGIFData[113]=0xb0;zeroGIFData[114]=0xba;zeroGIFData[115]=0x21;zeroGIFData[116]=0xc1;zeroGIFData[117]=0x2f;zeroGIFData[118]=0xb4;zeroGIFData[119]=0xc2;
			zeroGIFData[120]=0x4d;zeroGIFData[121]=0x47;zeroGIFData[122]=0xbc;zeroGIFData[123]=0x07;zeroGIFData[124]=0xa1;zeroGIFData[125]=0x68;zeroGIFData[126]=0x54;zeroGIFData[127]=0x08;
			zeroGIFData[128]=0x00;zeroGIFData[129]=0x05;zeroGIFData[130]=0xd0;zeroGIFData[131]=0x45;zeroGIFData[132]=0x81;zeroGIFData[133]=0xad;zeroGIFData[134]=0x49;zeroGIFData[135]=0x76;
			zeroGIFData[136]=0x6f;zeroGIFData[137]=0xb3;zeroGIFData[138]=0x03;zeroGIFData[139]=0x3b;zeroGIFData[140]=0x11;zeroGIFData[141]=0xc6;zeroGIFData[142]=0x15;zeroGIFData[143]=0x24;
			zeroGIFData[144]=0x32;zeroGIFData[145]=0x11;zeroGIFData[146]=0x65;zeroGIFData[147]=0x24;zeroGIFData[148]=0x48;zeroGIFData[149]=0x7f;zeroGIFData[150]=0x48;zeroGIFData[151]=0x6d;
			zeroGIFData[152]=0x84;zeroGIFData[153]=0x82;zeroGIFData[154]=0x10;zeroGIFData[155]=0x54;zeroGIFData[156]=0x8c;zeroGIFData[157]=0x87;zeroGIFData[158]=0x22;zeroGIFData[159]=0x81;
			zeroGIFData[160]=0x77;zeroGIFData[161]=0x34;zeroGIFData[162]=0x8b;zeroGIFData[163]=0x15;zeroGIFData[164]=0x69;zeroGIFData[165]=0x56;zeroGIFData[166]=0x2c;zeroGIFData[167]=0x12;
			zeroGIFData[168]=0x75;zeroGIFData[169]=0x25;zeroGIFData[170]=0x6d;zeroGIFData[171]=0x0e;zeroGIFData[172]=0x6f;zeroGIFData[173]=0x14;zeroGIFData[174]=0x84;zeroGIFData[175]=0x3b;
			zeroGIFData[176]=0x11;zeroGIFData[177]=0x79;zeroGIFData[178]=0x24;zeroGIFData[179]=0x8f;zeroGIFData[180]=0x0f;zeroGIFData[181]=0x59;zeroGIFData[182]=0x90;zeroGIFData[183]=0x25;
			zeroGIFData[184]=0x94;zeroGIFData[185]=0x0e;zeroGIFData[186]=0xa0;zeroGIFData[187]=0x14;zeroGIFData[188]=0x42;zeroGIFData[189]=0x12;zeroGIFData[190]=0xa3;zeroGIFData[191]=0x25;
			zeroGIFData[192]=0x7d;zeroGIFData[193]=0x6b;zeroGIFData[194]=0x9c;zeroGIFData[195]=0x77;zeroGIFData[196]=0xb4;zeroGIFData[197]=0x0b;zeroGIFData[198]=0x3a;zeroGIFData[199]=0x46;
			zeroGIFData[200]=0x04;zeroGIFData[201]=0x1d;zeroGIFData[202]=0x47;zeroGIFData[203]=0x4d;zeroGIFData[204]=0x83;zeroGIFData[205]=0x43;zeroGIFData[206]=0x42;zeroGIFData[207]=0x85;
			zeroGIFData[208]=0x36;zeroGIFData[209]=0x70;zeroGIFData[210]=0xbe;zeroGIFData[211]=0x68;zeroGIFData[212]=0xa0;zeroGIFData[213]=0x24;zeroGIFData[214]=0x96;zeroGIFData[215]=0x74;
			zeroGIFData[216]=0x60;zeroGIFData[217]=0x7b;zeroGIFData[218]=0x7a;zeroGIFData[219]=0x2a;zeroGIFData[220]=0x23;zeroGIFData[221]=0x18;zeroGIFData[222]=0x01;zeroGIFData[223]=0xc6;
			zeroGIFData[224]=0xa1;zeroGIFData[225]=0x8c;zeroGIFData[226]=0xce;zeroGIFData[227]=0x0a;zeroGIFData[228]=0xbb;zeroGIFData[229]=0x12;zeroGIFData[230]=0x2b;zeroGIFData[231]=0x6d;
			zeroGIFData[232]=0x9a;zeroGIFData[233]=0x2d;zeroGIFData[234]=0xd3;zeroGIFData[235]=0x38;zeroGIFData[236]=0xa3;zeroGIFData[237]=0xa5;zeroGIFData[238]=0xcd;zeroGIFData[239]=0xa7;
			zeroGIFData[240]=0xd5;zeroGIFData[241]=0x34;zeroGIFData[242]=0xb4;zeroGIFData[243]=0x26;zeroGIFData[244]=0x80;zeroGIFData[245]=0xc3;zeroGIFData[246]=0x9f;zeroGIFData[247]=0x68;
			zeroGIFData[248]=0x40;zeroGIFData[249]=0x5f;zeroGIFData[250]=0x96;zeroGIFData[251]=0x2b;zeroGIFData[252]=0x82;zeroGIFData[253]=0x16;zeroGIFData[254]=0xb6;zeroGIFData[255]=0x10;
			zeroGIFData[256]=0xda;zeroGIFData[257]=0x3a;zeroGIFData[258]=0xc4;zeroGIFData[259]=0x32;zeroGIFData[260]=0x79;zeroGIFData[261]=0x52;zeroGIFData[262]=0x20;zeroGIFData[263]=0xb0;
			zeroGIFData[264]=0xb8;zeroGIFData[265]=0xe0;zeroGIFData[266]=0x32;zeroGIFData[267]=0x58;zeroGIFData[268]=0x5d;zeroGIFData[269]=0x16;zeroGIFData[270]=0x28;zeroGIFData[271]=0x4b;
			zeroGIFData[272]=0xec;zeroGIFData[273]=0x00;zeroGIFData[274]=0x03;zeroGIFData[275]=0x70;zeroGIFData[276]=0x22;zeroGIFData[277]=0x46;zeroGIFData[278]=0x32;zeroGIFData[279]=0x14;
			zeroGIFData[280]=0xf2;zeroGIFData[281]=0x74;zeroGIFData[282]=0xac;zeroGIFData[283]=0x88;zeroGIFData[284]=0xe3;zeroGIFData[285]=0x8d;zeroGIFData[286]=0x5a;zeroGIFData[287]=0x98;
			zeroGIFData[288]=0x80;zeroGIFData[289]=0xce;zeroGIFData[290]=0x18;zeroGIFData[291]=0xd0;zeroGIFData[292]=0x70;zeroGIFData[293]=0x73;zeroGIFData[294]=0x63;zeroGIFData[295]=0x89;
			zeroGIFData[296]=0x13;zeroGIFData[297]=0x31;zeroGIFData[298]=0x43;zeroGIFData[299]=0x16;zeroGIFData[300]=0x38;zeroGIFData[301]=0x79;zeroGIFData[302]=0x38;zeroGIFData[303]=0xa9;
			zeroGIFData[304]=0x37;zeroGIFData[305]=0x01;zeroGIFData[306]=0xc6;zeroGIFData[307]=0x25;zeroGIFData[308]=0x2b;zeroGIFData[309]=0x52;zeroGIFData[310]=0xb0;zeroGIFData[311]=0xa8;
			zeroGIFData[312]=0xe7;zeroGIFData[313]=0x21;zeroGIFData[314]=0xda;zeroGIFData[315]=0x97;zeroGIFData[316]=0x0f;zeroGIFData[317]=0x22;zeroGIFData[318]=0x3b;zeroGIFData[319]=0xe6;
			zeroGIFData[320]=0xa3;zeroGIFData[321]=0x01;zeroGIFData[322]=0xa4;zeroGIFData[323]=0x09;zeroGIFData[324]=0x4a;zeroGIFData[325]=0x7c;zeroGIFData[326]=0x81;zeroGIFData[327]=0xf2;
			zeroGIFData[328]=0x48;zeroGIFData[329]=0x1c;zeroGIFData[330]=0xf2;zeroGIFData[331]=0xa7;zeroGIFData[332]=0x43;zeroGIFData[333]=0x07;zeroGIFData[334]=0x55;zeroGIFData[335]=0xad;
			zeroGIFData[336]=0xdc;zeroGIFData[337]=0x9c;zeroGIFData[338]=0x4a;zeroGIFData[339]=0x38;zeroGIFData[340]=0x02;zeroGIFData[341]=0xe7;zeroGIFData[342]=0x91;zeroGIFData[343]=0x3d;
			zeroGIFData[344]=0xed;zeroGIFData[345]=0x06;zeroGIFData[346]=0x5e;zeroGIFData[347]=0x40;zeroGIFData[348]=0xf6;zeroGIFData[349]=0x33;zeroGIFData[350]=0xc2;zeroGIFData[351]=0x89;
			zeroGIFData[352]=0x3c;zeroGIFData[353]=0x3e;zeroGIFData[354]=0x8b;zeroGIFData[355]=0x82;zeroGIFData[356]=0x08;zeroGIFData[357]=0xd9;zeroGIFData[358]=0x23;zeroGIFData[359]=0x01;
			zeroGIFData[360]=0x00;zeroGIFData[361]=0x3b;
			
			return zeroGIFData;
		}();
		
		public static const zeroGIFBmd:BitmapData=function():BitmapData{//本帅哥的头像的 BitmapData
			var zeroGIFBmd:BitmapData=new BitmapData(40,40,false,0xffffffff);
			
			var zeroGIFBmdData:ByteArray=zeroGIFBmd.getPixels(zeroGIFBmd.rect);
			
			zeroGIFBmdData[9]=zeroGIFBmdData[10]=zeroGIFBmdData[11]=0xcc;//{x:2,y:0}
			zeroGIFBmdData[13]=zeroGIFBmdData[14]=zeroGIFBmdData[15]=0xcc;//{x:3,y:0}
			
			zeroGIFBmdData[169]=zeroGIFBmdData[170]=zeroGIFBmdData[171]=0x00;//{x:2,y:1}
			zeroGIFBmdData[173]=zeroGIFBmdData[174]=zeroGIFBmdData[175]=0x00;//{x:3,y:1}
			zeroGIFBmdData[177]=zeroGIFBmdData[178]=zeroGIFBmdData[179]=0x00;//{x:4,y:1}
			zeroGIFBmdData[181]=zeroGIFBmdData[182]=zeroGIFBmdData[183]=0x33;//{x:5,y:1}
			zeroGIFBmdData[185]=zeroGIFBmdData[186]=zeroGIFBmdData[187]=0x99;//{x:6,y:1}
			zeroGIFBmdData[189]=zeroGIFBmdData[190]=zeroGIFBmdData[191]=0xcc;//{x:7,y:1}
			zeroGIFBmdData[193]=zeroGIFBmdData[194]=zeroGIFBmdData[195]=0xcc;//{x:8,y:1}
			zeroGIFBmdData[197]=zeroGIFBmdData[198]=zeroGIFBmdData[199]=0xcc;//{x:9,y:1}
			zeroGIFBmdData[201]=zeroGIFBmdData[202]=zeroGIFBmdData[203]=0xcc;//{x:10,y:1}
			zeroGIFBmdData[205]=zeroGIFBmdData[206]=zeroGIFBmdData[207]=0x99;//{x:11,y:1}
			zeroGIFBmdData[209]=zeroGIFBmdData[210]=zeroGIFBmdData[211]=0x33;//{x:12,y:1}
			zeroGIFBmdData[213]=zeroGIFBmdData[214]=zeroGIFBmdData[215]=0x33;//{x:13,y:1}
			zeroGIFBmdData[217]=zeroGIFBmdData[218]=zeroGIFBmdData[219]=0x00;//{x:14,y:1}
			
			zeroGIFBmdData[329]=zeroGIFBmdData[330]=zeroGIFBmdData[331]=0x00;//{x:2,y:2}
			zeroGIFBmdData[333]=zeroGIFBmdData[334]=zeroGIFBmdData[335]=0x00;//{x:3,y:2}
			zeroGIFBmdData[337]=zeroGIFBmdData[338]=zeroGIFBmdData[339]=0x00;//{x:4,y:2}
			zeroGIFBmdData[341]=zeroGIFBmdData[342]=zeroGIFBmdData[343]=0x00;//{x:5,y:2}
			zeroGIFBmdData[345]=zeroGIFBmdData[346]=zeroGIFBmdData[347]=0x00;//{x:6,y:2}
			zeroGIFBmdData[349]=zeroGIFBmdData[350]=zeroGIFBmdData[351]=0x00;//{x:7,y:2}
			zeroGIFBmdData[353]=zeroGIFBmdData[354]=zeroGIFBmdData[355]=0x00;//{x:8,y:2}
			zeroGIFBmdData[357]=zeroGIFBmdData[358]=zeroGIFBmdData[359]=0x00;//{x:9,y:2}
			zeroGIFBmdData[361]=zeroGIFBmdData[362]=zeroGIFBmdData[363]=0x00;//{x:10,y:2}
			zeroGIFBmdData[365]=zeroGIFBmdData[366]=zeroGIFBmdData[367]=0x00;//{x:11,y:2}
			zeroGIFBmdData[369]=zeroGIFBmdData[370]=zeroGIFBmdData[371]=0x00;//{x:12,y:2}
			zeroGIFBmdData[373]=zeroGIFBmdData[374]=zeroGIFBmdData[375]=0x00;//{x:13,y:2}
			zeroGIFBmdData[377]=zeroGIFBmdData[378]=zeroGIFBmdData[379]=0x99;//{x:14,y:2}
			
			zeroGIFBmdData[489]=zeroGIFBmdData[490]=zeroGIFBmdData[491]=0x33;//{x:2,y:3}
			zeroGIFBmdData[493]=zeroGIFBmdData[494]=zeroGIFBmdData[495]=0x00;//{x:3,y:3}
			zeroGIFBmdData[497]=zeroGIFBmdData[498]=zeroGIFBmdData[499]=0x00;//{x:4,y:3}
			zeroGIFBmdData[501]=zeroGIFBmdData[502]=zeroGIFBmdData[503]=0x00;//{x:5,y:3}
			zeroGIFBmdData[505]=zeroGIFBmdData[506]=zeroGIFBmdData[507]=0x00;//{x:6,y:3}
			zeroGIFBmdData[509]=zeroGIFBmdData[510]=zeroGIFBmdData[511]=0x00;//{x:7,y:3}
			zeroGIFBmdData[513]=zeroGIFBmdData[514]=zeroGIFBmdData[515]=0x00;//{x:8,y:3}
			zeroGIFBmdData[517]=zeroGIFBmdData[518]=zeroGIFBmdData[519]=0x00;//{x:9,y:3}
			zeroGIFBmdData[521]=zeroGIFBmdData[522]=zeroGIFBmdData[523]=0x00;//{x:10,y:3}
			zeroGIFBmdData[525]=zeroGIFBmdData[526]=zeroGIFBmdData[527]=0x00;//{x:11,y:3}
			zeroGIFBmdData[529]=zeroGIFBmdData[530]=zeroGIFBmdData[531]=0x00;//{x:12,y:3}
			zeroGIFBmdData[533]=zeroGIFBmdData[534]=zeroGIFBmdData[535]=0x00;//{x:13,y:3}
			zeroGIFBmdData[537]=zeroGIFBmdData[538]=zeroGIFBmdData[539]=0xcc;//{x:14,y:3}
			
			zeroGIFBmdData[649]=zeroGIFBmdData[650]=zeroGIFBmdData[651]=0x33;//{x:2,y:4}
			zeroGIFBmdData[653]=zeroGIFBmdData[654]=zeroGIFBmdData[655]=0x00;//{x:3,y:4}
			zeroGIFBmdData[657]=zeroGIFBmdData[658]=zeroGIFBmdData[659]=0x66;//{x:4,y:4}
			zeroGIFBmdData[665]=zeroGIFBmdData[666]=zeroGIFBmdData[667]=0x00;//{x:6,y:4}
			zeroGIFBmdData[669]=zeroGIFBmdData[670]=zeroGIFBmdData[671]=0x00;//{x:7,y:4}
			zeroGIFBmdData[673]=zeroGIFBmdData[674]=zeroGIFBmdData[675]=0x00;//{x:8,y:4}
			zeroGIFBmdData[677]=zeroGIFBmdData[678]=zeroGIFBmdData[679]=0x00;//{x:9,y:4}
			zeroGIFBmdData[681]=zeroGIFBmdData[682]=zeroGIFBmdData[683]=0x00;//{x:10,y:4}
			zeroGIFBmdData[685]=zeroGIFBmdData[686]=zeroGIFBmdData[687]=0x00;//{x:11,y:4}
			zeroGIFBmdData[689]=zeroGIFBmdData[690]=zeroGIFBmdData[691]=0x00;//{x:12,y:4}
			zeroGIFBmdData[693]=zeroGIFBmdData[694]=zeroGIFBmdData[695]=0x00;//{x:13,y:4}
			zeroGIFBmdData[697]=zeroGIFBmdData[698]=zeroGIFBmdData[699]=0x00;//{x:14,y:4}
			
			zeroGIFBmdData[809]=zeroGIFBmdData[810]=zeroGIFBmdData[811]=0x33;//{x:2,y:5}
			zeroGIFBmdData[813]=zeroGIFBmdData[814]=zeroGIFBmdData[815]=0x00;//{x:3,y:5}
			zeroGIFBmdData[817]=zeroGIFBmdData[818]=zeroGIFBmdData[819]=0xcc;//{x:4,y:5}
			zeroGIFBmdData[829]=zeroGIFBmdData[830]=zeroGIFBmdData[831]=0x00;//{x:7,y:5}
			zeroGIFBmdData[833]=zeroGIFBmdData[834]=zeroGIFBmdData[835]=0x00;//{x:8,y:5}
			zeroGIFBmdData[837]=zeroGIFBmdData[838]=zeroGIFBmdData[839]=0x00;//{x:9,y:5}
			zeroGIFBmdData[841]=zeroGIFBmdData[842]=zeroGIFBmdData[843]=0x00;//{x:10,y:5}
			zeroGIFBmdData[845]=zeroGIFBmdData[846]=zeroGIFBmdData[847]=0x00;//{x:11,y:5}
			zeroGIFBmdData[849]=zeroGIFBmdData[850]=zeroGIFBmdData[851]=0x00;//{x:12,y:5}
			zeroGIFBmdData[853]=zeroGIFBmdData[854]=zeroGIFBmdData[855]=0x00;//{x:13,y:5}
			zeroGIFBmdData[857]=zeroGIFBmdData[858]=zeroGIFBmdData[859]=0x00;//{x:14,y:5}
			zeroGIFBmdData[861]=zeroGIFBmdData[862]=zeroGIFBmdData[863]=0x00;//{x:15,y:5}
			zeroGIFBmdData[865]=zeroGIFBmdData[866]=zeroGIFBmdData[867]=0xcc;//{x:16,y:5}
			
			zeroGIFBmdData[969]=zeroGIFBmdData[970]=zeroGIFBmdData[971]=0x33;//{x:2,y:6}
			zeroGIFBmdData[973]=zeroGIFBmdData[974]=zeroGIFBmdData[975]=0x00;//{x:3,y:6}
			zeroGIFBmdData[977]=zeroGIFBmdData[978]=zeroGIFBmdData[979]=0xcc;//{x:4,y:6}
			zeroGIFBmdData[981]=zeroGIFBmdData[982]=zeroGIFBmdData[983]=0x99;//{x:5,y:6}
			zeroGIFBmdData[989]=zeroGIFBmdData[990]=zeroGIFBmdData[991]=0x99;//{x:7,y:6}
			zeroGIFBmdData[993]=zeroGIFBmdData[994]=zeroGIFBmdData[995]=0x00;//{x:8,y:6}
			zeroGIFBmdData[997]=zeroGIFBmdData[998]=zeroGIFBmdData[999]=0x00;//{x:9,y:6}
			zeroGIFBmdData[1001]=zeroGIFBmdData[1002]=zeroGIFBmdData[1003]=0x00;//{x:10,y:6}
			zeroGIFBmdData[1005]=zeroGIFBmdData[1006]=zeroGIFBmdData[1007]=0x00;//{x:11,y:6}
			zeroGIFBmdData[1009]=zeroGIFBmdData[1010]=zeroGIFBmdData[1011]=0x00;//{x:12,y:6}
			zeroGIFBmdData[1013]=zeroGIFBmdData[1014]=zeroGIFBmdData[1015]=0x00;//{x:13,y:6}
			zeroGIFBmdData[1017]=zeroGIFBmdData[1018]=zeroGIFBmdData[1019]=0x00;//{x:14,y:6}
			zeroGIFBmdData[1021]=zeroGIFBmdData[1022]=zeroGIFBmdData[1023]=0x00;//{x:15,y:6}
			zeroGIFBmdData[1025]=zeroGIFBmdData[1026]=zeroGIFBmdData[1027]=0x00;//{x:16,y:6}
			zeroGIFBmdData[1029]=zeroGIFBmdData[1030]=zeroGIFBmdData[1031]=0x00;//{x:17,y:6}
			zeroGIFBmdData[1033]=zeroGIFBmdData[1034]=zeroGIFBmdData[1035]=0x66;//{x:18,y:6}
			zeroGIFBmdData[1037]=zeroGIFBmdData[1038]=zeroGIFBmdData[1039]=0x99;//{x:19,y:6}
			
			zeroGIFBmdData[1129]=zeroGIFBmdData[1130]=zeroGIFBmdData[1131]=0x33;//{x:2,y:7}
			zeroGIFBmdData[1133]=zeroGIFBmdData[1134]=zeroGIFBmdData[1135]=0x00;//{x:3,y:7}
			zeroGIFBmdData[1137]=zeroGIFBmdData[1138]=zeroGIFBmdData[1139]=0xcc;//{x:4,y:7}
			zeroGIFBmdData[1141]=zeroGIFBmdData[1142]=zeroGIFBmdData[1143]=0x00;//{x:5,y:7}
			zeroGIFBmdData[1145]=zeroGIFBmdData[1146]=zeroGIFBmdData[1147]=0x00;//{x:6,y:7}
			zeroGIFBmdData[1149]=zeroGIFBmdData[1150]=zeroGIFBmdData[1151]=0xcc;//{x:7,y:7}
			zeroGIFBmdData[1153]=zeroGIFBmdData[1154]=zeroGIFBmdData[1155]=0x00;//{x:8,y:7}
			zeroGIFBmdData[1157]=zeroGIFBmdData[1158]=zeroGIFBmdData[1159]=0x00;//{x:9,y:7}
			zeroGIFBmdData[1161]=zeroGIFBmdData[1162]=zeroGIFBmdData[1163]=0x00;//{x:10,y:7}
			zeroGIFBmdData[1165]=zeroGIFBmdData[1166]=zeroGIFBmdData[1167]=0x00;//{x:11,y:7}
			zeroGIFBmdData[1169]=zeroGIFBmdData[1170]=zeroGIFBmdData[1171]=0x00;//{x:12,y:7}
			zeroGIFBmdData[1173]=zeroGIFBmdData[1174]=zeroGIFBmdData[1175]=0x00;//{x:13,y:7}
			zeroGIFBmdData[1177]=zeroGIFBmdData[1178]=zeroGIFBmdData[1179]=0x00;//{x:14,y:7}
			zeroGIFBmdData[1181]=zeroGIFBmdData[1182]=zeroGIFBmdData[1183]=0x00;//{x:15,y:7}
			zeroGIFBmdData[1185]=zeroGIFBmdData[1186]=zeroGIFBmdData[1187]=0x00;//{x:16,y:7}
			zeroGIFBmdData[1189]=zeroGIFBmdData[1190]=zeroGIFBmdData[1191]=0x00;//{x:17,y:7}
			zeroGIFBmdData[1193]=zeroGIFBmdData[1194]=zeroGIFBmdData[1195]=0x00;//{x:18,y:7}
			zeroGIFBmdData[1197]=zeroGIFBmdData[1198]=zeroGIFBmdData[1199]=0x00;//{x:19,y:7}
			zeroGIFBmdData[1201]=zeroGIFBmdData[1202]=zeroGIFBmdData[1203]=0x00;//{x:20,y:7}
			zeroGIFBmdData[1205]=zeroGIFBmdData[1206]=zeroGIFBmdData[1207]=0x00;//{x:21,y:7}
			zeroGIFBmdData[1209]=zeroGIFBmdData[1210]=zeroGIFBmdData[1211]=0x33;//{x:22,y:7}
			zeroGIFBmdData[1213]=zeroGIFBmdData[1214]=zeroGIFBmdData[1215]=0x66;//{x:23,y:7}
			zeroGIFBmdData[1217]=zeroGIFBmdData[1218]=zeroGIFBmdData[1219]=0xcc;//{x:24,y:7}
			zeroGIFBmdData[1221]=zeroGIFBmdData[1222]=zeroGIFBmdData[1223]=0xcc;//{x:25,y:7}
			
			zeroGIFBmdData[1289]=zeroGIFBmdData[1290]=zeroGIFBmdData[1291]=0x33;//{x:2,y:8}
			zeroGIFBmdData[1293]=zeroGIFBmdData[1294]=zeroGIFBmdData[1295]=0x00;//{x:3,y:8}
			zeroGIFBmdData[1297]=zeroGIFBmdData[1298]=zeroGIFBmdData[1299]=0xcc;//{x:4,y:8}
			zeroGIFBmdData[1301]=zeroGIFBmdData[1302]=zeroGIFBmdData[1303]=0x33;//{x:5,y:8}
			zeroGIFBmdData[1305]=zeroGIFBmdData[1306]=zeroGIFBmdData[1307]=0x00;//{x:6,y:8}
			zeroGIFBmdData[1313]=zeroGIFBmdData[1314]=zeroGIFBmdData[1315]=0x00;//{x:8,y:8}
			zeroGIFBmdData[1317]=zeroGIFBmdData[1318]=zeroGIFBmdData[1319]=0x00;//{x:9,y:8}
			zeroGIFBmdData[1321]=zeroGIFBmdData[1322]=zeroGIFBmdData[1323]=0x00;//{x:10,y:8}
			zeroGIFBmdData[1325]=zeroGIFBmdData[1326]=zeroGIFBmdData[1327]=0x00;//{x:11,y:8}
			zeroGIFBmdData[1329]=zeroGIFBmdData[1330]=zeroGIFBmdData[1331]=0x00;//{x:12,y:8}
			zeroGIFBmdData[1333]=zeroGIFBmdData[1334]=zeroGIFBmdData[1335]=0x00;//{x:13,y:8}
			zeroGIFBmdData[1337]=zeroGIFBmdData[1338]=zeroGIFBmdData[1339]=0x00;//{x:14,y:8}
			zeroGIFBmdData[1341]=zeroGIFBmdData[1342]=zeroGIFBmdData[1343]=0x00;//{x:15,y:8}
			zeroGIFBmdData[1345]=zeroGIFBmdData[1346]=zeroGIFBmdData[1347]=0x00;//{x:16,y:8}
			zeroGIFBmdData[1349]=zeroGIFBmdData[1350]=zeroGIFBmdData[1351]=0x66;//{x:17,y:8}
			zeroGIFBmdData[1353]=zeroGIFBmdData[1354]=zeroGIFBmdData[1355]=0x99;//{x:18,y:8}
			zeroGIFBmdData[1377]=zeroGIFBmdData[1378]=zeroGIFBmdData[1379]=0x99;//{x:24,y:8}
			zeroGIFBmdData[1381]=zeroGIFBmdData[1382]=zeroGIFBmdData[1383]=0x66;//{x:25,y:8}
			zeroGIFBmdData[1385]=zeroGIFBmdData[1386]=zeroGIFBmdData[1387]=0x00;//{x:26,y:8}
			zeroGIFBmdData[1389]=zeroGIFBmdData[1390]=zeroGIFBmdData[1391]=0x66;//{x:27,y:8}
			zeroGIFBmdData[1393]=zeroGIFBmdData[1394]=zeroGIFBmdData[1395]=0x99;//{x:28,y:8}
			
			zeroGIFBmdData[1449]=zeroGIFBmdData[1450]=zeroGIFBmdData[1451]=0x33;//{x:2,y:9}
			zeroGIFBmdData[1453]=zeroGIFBmdData[1454]=zeroGIFBmdData[1455]=0x00;//{x:3,y:9}
			zeroGIFBmdData[1461]=zeroGIFBmdData[1462]=zeroGIFBmdData[1463]=0x33;//{x:5,y:9}
			zeroGIFBmdData[1465]=zeroGIFBmdData[1466]=zeroGIFBmdData[1467]=0xcc;//{x:6,y:9}
			zeroGIFBmdData[1473]=zeroGIFBmdData[1474]=zeroGIFBmdData[1475]=0x00;//{x:8,y:9}
			zeroGIFBmdData[1477]=zeroGIFBmdData[1478]=zeroGIFBmdData[1479]=0x00;//{x:9,y:9}
			zeroGIFBmdData[1481]=zeroGIFBmdData[1482]=zeroGIFBmdData[1483]=0x00;//{x:10,y:9}
			zeroGIFBmdData[1485]=zeroGIFBmdData[1486]=zeroGIFBmdData[1487]=0x00;//{x:11,y:9}
			zeroGIFBmdData[1489]=zeroGIFBmdData[1490]=zeroGIFBmdData[1491]=0x00;//{x:12,y:9}
			zeroGIFBmdData[1493]=zeroGIFBmdData[1494]=zeroGIFBmdData[1495]=0x00;//{x:13,y:9}
			zeroGIFBmdData[1497]=zeroGIFBmdData[1498]=zeroGIFBmdData[1499]=0x33;//{x:14,y:9}
			zeroGIFBmdData[1501]=zeroGIFBmdData[1502]=zeroGIFBmdData[1503]=0xcc;//{x:15,y:9}
			zeroGIFBmdData[1549]=zeroGIFBmdData[1550]=zeroGIFBmdData[1551]=0xcc;//{x:27,y:9}
			zeroGIFBmdData[1553]=zeroGIFBmdData[1554]=zeroGIFBmdData[1555]=0x33;//{x:28,y:9}
			zeroGIFBmdData[1557]=zeroGIFBmdData[1558]=zeroGIFBmdData[1559]=0x00;//{x:29,y:9}
			zeroGIFBmdData[1561]=zeroGIFBmdData[1562]=zeroGIFBmdData[1563]=0xcc;//{x:30,y:9}
			
			zeroGIFBmdData[1609]=zeroGIFBmdData[1610]=zeroGIFBmdData[1611]=0x33;//{x:2,y:10}
			zeroGIFBmdData[1613]=zeroGIFBmdData[1614]=zeroGIFBmdData[1615]=0x00;//{x:3,y:10}
			zeroGIFBmdData[1617]=zeroGIFBmdData[1618]=zeroGIFBmdData[1619]=0x00;//{x:4,y:10}
			zeroGIFBmdData[1621]=zeroGIFBmdData[1622]=zeroGIFBmdData[1623]=0x00;//{x:5,y:10}
			zeroGIFBmdData[1625]=zeroGIFBmdData[1626]=zeroGIFBmdData[1627]=0xcc;//{x:6,y:10}
			zeroGIFBmdData[1633]=zeroGIFBmdData[1634]=zeroGIFBmdData[1635]=0x00;//{x:8,y:10}
			zeroGIFBmdData[1637]=zeroGIFBmdData[1638]=zeroGIFBmdData[1639]=0x00;//{x:9,y:10}
			zeroGIFBmdData[1641]=zeroGIFBmdData[1642]=zeroGIFBmdData[1643]=0x00;//{x:10,y:10}
			zeroGIFBmdData[1645]=zeroGIFBmdData[1646]=zeroGIFBmdData[1647]=0x00;//{x:11,y:10}
			zeroGIFBmdData[1649]=zeroGIFBmdData[1650]=zeroGIFBmdData[1651]=0x00;//{x:12,y:10}
			zeroGIFBmdData[1653]=zeroGIFBmdData[1654]=zeroGIFBmdData[1655]=0xcc;//{x:13,y:10}
			zeroGIFBmdData[1685]=zeroGIFBmdData[1686]=zeroGIFBmdData[1687]=0x66;//{x:21,y:10}
			zeroGIFBmdData[1689]=zeroGIFBmdData[1690]=zeroGIFBmdData[1691]=0x66;//{x:22,y:10}
			zeroGIFBmdData[1693]=zeroGIFBmdData[1694]=zeroGIFBmdData[1695]=0x99;//{x:23,y:10}
			zeroGIFBmdData[1697]=zeroGIFBmdData[1698]=zeroGIFBmdData[1699]=0x99;//{x:24,y:10}
			zeroGIFBmdData[1717]=zeroGIFBmdData[1718]=zeroGIFBmdData[1719]=0xcc;//{x:29,y:10}
			zeroGIFBmdData[1721]=zeroGIFBmdData[1722]=zeroGIFBmdData[1723]=0x00;//{x:30,y:10}
			zeroGIFBmdData[1725]=zeroGIFBmdData[1726]=zeroGIFBmdData[1727]=0x33;//{x:31,y:10}
			
			zeroGIFBmdData[1769]=zeroGIFBmdData[1770]=zeroGIFBmdData[1771]=0x00;//{x:2,y:11}
			zeroGIFBmdData[1773]=zeroGIFBmdData[1774]=zeroGIFBmdData[1775]=0x00;//{x:3,y:11}
			zeroGIFBmdData[1777]=zeroGIFBmdData[1778]=zeroGIFBmdData[1779]=0x33;//{x:4,y:11}
			zeroGIFBmdData[1789]=zeroGIFBmdData[1790]=zeroGIFBmdData[1791]=0x66;//{x:7,y:11}
			zeroGIFBmdData[1793]=zeroGIFBmdData[1794]=zeroGIFBmdData[1795]=0x00;//{x:8,y:11}
			zeroGIFBmdData[1797]=zeroGIFBmdData[1798]=zeroGIFBmdData[1799]=0x00;//{x:9,y:11}
			zeroGIFBmdData[1801]=zeroGIFBmdData[1802]=zeroGIFBmdData[1803]=0x00;//{x:10,y:11}
			zeroGIFBmdData[1805]=zeroGIFBmdData[1806]=zeroGIFBmdData[1807]=0x00;//{x:11,y:11}
			zeroGIFBmdData[1841]=zeroGIFBmdData[1842]=zeroGIFBmdData[1843]=0x00;//{x:20,y:11}
			zeroGIFBmdData[1845]=zeroGIFBmdData[1846]=zeroGIFBmdData[1847]=0x00;//{x:21,y:11}
			zeroGIFBmdData[1849]=zeroGIFBmdData[1850]=zeroGIFBmdData[1851]=0xcc;//{x:22,y:11}
			zeroGIFBmdData[1853]=zeroGIFBmdData[1854]=zeroGIFBmdData[1855]=0xcc;//{x:23,y:11}
			zeroGIFBmdData[1857]=zeroGIFBmdData[1858]=zeroGIFBmdData[1859]=0x00;//{x:24,y:11}
			zeroGIFBmdData[1861]=zeroGIFBmdData[1862]=zeroGIFBmdData[1863]=0x00;//{x:25,y:11}
			zeroGIFBmdData[1865]=zeroGIFBmdData[1866]=zeroGIFBmdData[1867]=0xcc;//{x:26,y:11}
			zeroGIFBmdData[1885]=zeroGIFBmdData[1886]=zeroGIFBmdData[1887]=0x66;//{x:31,y:11}
			zeroGIFBmdData[1889]=zeroGIFBmdData[1890]=zeroGIFBmdData[1891]=0x00;//{x:32,y:11}
			
			zeroGIFBmdData[1925]=zeroGIFBmdData[1926]=zeroGIFBmdData[1927]=0x99;//{x:1,y:12}
			zeroGIFBmdData[1929]=zeroGIFBmdData[1930]=zeroGIFBmdData[1931]=0x00;//{x:2,y:12}
			zeroGIFBmdData[1933]=zeroGIFBmdData[1934]=zeroGIFBmdData[1935]=0x33;//{x:3,y:12}
			zeroGIFBmdData[1949]=zeroGIFBmdData[1950]=zeroGIFBmdData[1951]=0x00;//{x:7,y:12}
			zeroGIFBmdData[1953]=zeroGIFBmdData[1954]=zeroGIFBmdData[1955]=0x00;//{x:8,y:12}
			zeroGIFBmdData[1957]=zeroGIFBmdData[1958]=zeroGIFBmdData[1959]=0x00;//{x:9,y:12}
			zeroGIFBmdData[1961]=zeroGIFBmdData[1962]=zeroGIFBmdData[1963]=0x00;//{x:10,y:12}
			zeroGIFBmdData[1965]=zeroGIFBmdData[1966]=zeroGIFBmdData[1967]=0x66;//{x:11,y:12}
			zeroGIFBmdData[1997]=zeroGIFBmdData[1998]=zeroGIFBmdData[1999]=0x33;//{x:19,y:12}
			zeroGIFBmdData[2001]=zeroGIFBmdData[2002]=zeroGIFBmdData[2003]=0x00;//{x:20,y:12}
			zeroGIFBmdData[2005]=zeroGIFBmdData[2006]=zeroGIFBmdData[2007]=0x00;//{x:21,y:12}
			zeroGIFBmdData[2009]=zeroGIFBmdData[2010]=zeroGIFBmdData[2011]=0x00;//{x:22,y:12}
			zeroGIFBmdData[2013]=zeroGIFBmdData[2014]=zeroGIFBmdData[2015]=0x00;//{x:23,y:12}
			zeroGIFBmdData[2017]=zeroGIFBmdData[2018]=zeroGIFBmdData[2019]=0x00;//{x:24,y:12}
			zeroGIFBmdData[2021]=zeroGIFBmdData[2022]=zeroGIFBmdData[2023]=0x00;//{x:25,y:12}
			zeroGIFBmdData[2025]=zeroGIFBmdData[2026]=zeroGIFBmdData[2027]=0x00;//{x:26,y:12}
			zeroGIFBmdData[2049]=zeroGIFBmdData[2050]=zeroGIFBmdData[2051]=0x33;//{x:32,y:12}
			zeroGIFBmdData[2053]=zeroGIFBmdData[2054]=zeroGIFBmdData[2055]=0x33;//{x:33,y:12}
			
			zeroGIFBmdData[2085]=zeroGIFBmdData[2086]=zeroGIFBmdData[2087]=0x33;//{x:1,y:13}
			zeroGIFBmdData[2089]=zeroGIFBmdData[2090]=zeroGIFBmdData[2091]=0x99;//{x:2,y:13}
			zeroGIFBmdData[2105]=zeroGIFBmdData[2106]=zeroGIFBmdData[2107]=0x33;//{x:6,y:13}
			zeroGIFBmdData[2109]=zeroGIFBmdData[2110]=zeroGIFBmdData[2111]=0x00;//{x:7,y:13}
			zeroGIFBmdData[2113]=zeroGIFBmdData[2114]=zeroGIFBmdData[2115]=0x00;//{x:8,y:13}
			zeroGIFBmdData[2117]=zeroGIFBmdData[2118]=zeroGIFBmdData[2119]=0x00;//{x:9,y:13}
			zeroGIFBmdData[2121]=zeroGIFBmdData[2122]=zeroGIFBmdData[2123]=0x00;//{x:10,y:13}
			zeroGIFBmdData[2125]=zeroGIFBmdData[2126]=zeroGIFBmdData[2127]=0x66;//{x:11,y:13}
			zeroGIFBmdData[2157]=zeroGIFBmdData[2158]=zeroGIFBmdData[2159]=0x00;//{x:19,y:13}
			zeroGIFBmdData[2161]=zeroGIFBmdData[2162]=zeroGIFBmdData[2163]=0x00;//{x:20,y:13}
			zeroGIFBmdData[2165]=zeroGIFBmdData[2166]=zeroGIFBmdData[2167]=0x00;//{x:21,y:13}
			zeroGIFBmdData[2169]=zeroGIFBmdData[2170]=zeroGIFBmdData[2171]=0x00;//{x:22,y:13}
			zeroGIFBmdData[2173]=zeroGIFBmdData[2174]=zeroGIFBmdData[2175]=0x00;//{x:23,y:13}
			zeroGIFBmdData[2177]=zeroGIFBmdData[2178]=zeroGIFBmdData[2179]=0x00;//{x:24,y:13}
			zeroGIFBmdData[2181]=zeroGIFBmdData[2182]=zeroGIFBmdData[2183]=0x00;//{x:25,y:13}
			zeroGIFBmdData[2185]=zeroGIFBmdData[2186]=zeroGIFBmdData[2187]=0x00;//{x:26,y:13}
			zeroGIFBmdData[2189]=zeroGIFBmdData[2190]=zeroGIFBmdData[2191]=0x66;//{x:27,y:13}
			zeroGIFBmdData[2213]=zeroGIFBmdData[2214]=zeroGIFBmdData[2215]=0x00;//{x:33,y:13}
			zeroGIFBmdData[2217]=zeroGIFBmdData[2218]=zeroGIFBmdData[2219]=0x33;//{x:34,y:13}
			
			zeroGIFBmdData[2265]=zeroGIFBmdData[2266]=zeroGIFBmdData[2267]=0x00;//{x:6,y:14}
			zeroGIFBmdData[2269]=zeroGIFBmdData[2270]=zeroGIFBmdData[2271]=0x00;//{x:7,y:14}
			zeroGIFBmdData[2273]=zeroGIFBmdData[2274]=zeroGIFBmdData[2275]=0x00;//{x:8,y:14}
			zeroGIFBmdData[2277]=zeroGIFBmdData[2278]=zeroGIFBmdData[2279]=0x00;//{x:9,y:14}
			zeroGIFBmdData[2281]=zeroGIFBmdData[2282]=zeroGIFBmdData[2283]=0x00;//{x:10,y:14}
			zeroGIFBmdData[2285]=zeroGIFBmdData[2286]=zeroGIFBmdData[2287]=0x66;//{x:11,y:14}
			zeroGIFBmdData[2317]=zeroGIFBmdData[2318]=zeroGIFBmdData[2319]=0x00;//{x:19,y:14}
			zeroGIFBmdData[2321]=zeroGIFBmdData[2322]=zeroGIFBmdData[2323]=0x00;//{x:20,y:14}
			zeroGIFBmdData[2325]=zeroGIFBmdData[2326]=zeroGIFBmdData[2327]=0x00;//{x:21,y:14}
			zeroGIFBmdData[2329]=zeroGIFBmdData[2330]=zeroGIFBmdData[2331]=0x00;//{x:22,y:14}
			zeroGIFBmdData[2333]=zeroGIFBmdData[2334]=zeroGIFBmdData[2335]=0x00;//{x:23,y:14}
			zeroGIFBmdData[2337]=zeroGIFBmdData[2338]=zeroGIFBmdData[2339]=0x00;//{x:24,y:14}
			zeroGIFBmdData[2341]=zeroGIFBmdData[2342]=zeroGIFBmdData[2343]=0x00;//{x:25,y:14}
			zeroGIFBmdData[2345]=zeroGIFBmdData[2346]=zeroGIFBmdData[2347]=0x00;//{x:26,y:14}
			zeroGIFBmdData[2349]=zeroGIFBmdData[2350]=zeroGIFBmdData[2351]=0x66;//{x:27,y:14}
			zeroGIFBmdData[2377]=zeroGIFBmdData[2378]=zeroGIFBmdData[2379]=0x00;//{x:34,y:14}
			zeroGIFBmdData[2381]=zeroGIFBmdData[2382]=zeroGIFBmdData[2383]=0xcc;//{x:35,y:14}
			
			zeroGIFBmdData[2421]=zeroGIFBmdData[2422]=zeroGIFBmdData[2423]=0x99;//{x:5,y:15}
			zeroGIFBmdData[2425]=zeroGIFBmdData[2426]=zeroGIFBmdData[2427]=0x00;//{x:6,y:15}
			zeroGIFBmdData[2429]=zeroGIFBmdData[2430]=zeroGIFBmdData[2431]=0x00;//{x:7,y:15}
			zeroGIFBmdData[2433]=zeroGIFBmdData[2434]=zeroGIFBmdData[2435]=0x00;//{x:8,y:15}
			zeroGIFBmdData[2437]=zeroGIFBmdData[2438]=zeroGIFBmdData[2439]=0x00;//{x:9,y:15}
			zeroGIFBmdData[2441]=zeroGIFBmdData[2442]=zeroGIFBmdData[2443]=0x00;//{x:10,y:15}
			zeroGIFBmdData[2445]=zeroGIFBmdData[2446]=zeroGIFBmdData[2447]=0x00;//{x:11,y:15}
			zeroGIFBmdData[2477]=zeroGIFBmdData[2478]=zeroGIFBmdData[2479]=0x66;//{x:19,y:15}
			zeroGIFBmdData[2481]=zeroGIFBmdData[2482]=zeroGIFBmdData[2483]=0x00;//{x:20,y:15}
			zeroGIFBmdData[2485]=zeroGIFBmdData[2486]=zeroGIFBmdData[2487]=0x00;//{x:21,y:15}
			zeroGIFBmdData[2489]=zeroGIFBmdData[2490]=zeroGIFBmdData[2491]=0x00;//{x:22,y:15}
			zeroGIFBmdData[2493]=zeroGIFBmdData[2494]=zeroGIFBmdData[2495]=0x00;//{x:23,y:15}
			zeroGIFBmdData[2497]=zeroGIFBmdData[2498]=zeroGIFBmdData[2499]=0x00;//{x:24,y:15}
			zeroGIFBmdData[2501]=zeroGIFBmdData[2502]=zeroGIFBmdData[2503]=0x00;//{x:25,y:15}
			zeroGIFBmdData[2505]=zeroGIFBmdData[2506]=zeroGIFBmdData[2507]=0x00;//{x:26,y:15}
			zeroGIFBmdData[2509]=zeroGIFBmdData[2510]=zeroGIFBmdData[2511]=0x99;//{x:27,y:15}
			zeroGIFBmdData[2537]=zeroGIFBmdData[2538]=zeroGIFBmdData[2539]=0xcc;//{x:34,y:15}
			zeroGIFBmdData[2541]=zeroGIFBmdData[2542]=zeroGIFBmdData[2543]=0x00;//{x:35,y:15}
			
			zeroGIFBmdData[2581]=zeroGIFBmdData[2582]=zeroGIFBmdData[2583]=0x33;//{x:5,y:16}
			zeroGIFBmdData[2585]=zeroGIFBmdData[2586]=zeroGIFBmdData[2587]=0x00;//{x:6,y:16}
			zeroGIFBmdData[2589]=zeroGIFBmdData[2590]=zeroGIFBmdData[2591]=0x00;//{x:7,y:16}
			zeroGIFBmdData[2593]=zeroGIFBmdData[2594]=zeroGIFBmdData[2595]=0x00;//{x:8,y:16}
			zeroGIFBmdData[2597]=zeroGIFBmdData[2598]=zeroGIFBmdData[2599]=0x00;//{x:9,y:16}
			zeroGIFBmdData[2601]=zeroGIFBmdData[2602]=zeroGIFBmdData[2603]=0x00;//{x:10,y:16}
			zeroGIFBmdData[2605]=zeroGIFBmdData[2606]=zeroGIFBmdData[2607]=0x00;//{x:11,y:16}
			zeroGIFBmdData[2609]=zeroGIFBmdData[2610]=zeroGIFBmdData[2611]=0xcc;//{x:12,y:16}
			zeroGIFBmdData[2637]=zeroGIFBmdData[2638]=zeroGIFBmdData[2639]=0xcc;//{x:19,y:16}
			zeroGIFBmdData[2641]=zeroGIFBmdData[2642]=zeroGIFBmdData[2643]=0x00;//{x:20,y:16}
			zeroGIFBmdData[2645]=zeroGIFBmdData[2646]=zeroGIFBmdData[2647]=0x00;//{x:21,y:16}
			zeroGIFBmdData[2649]=zeroGIFBmdData[2650]=zeroGIFBmdData[2651]=0x00;//{x:22,y:16}
			zeroGIFBmdData[2653]=zeroGIFBmdData[2654]=zeroGIFBmdData[2655]=0x00;//{x:23,y:16}
			zeroGIFBmdData[2657]=zeroGIFBmdData[2658]=zeroGIFBmdData[2659]=0x00;//{x:24,y:16}
			zeroGIFBmdData[2661]=zeroGIFBmdData[2662]=zeroGIFBmdData[2663]=0x00;//{x:25,y:16}
			zeroGIFBmdData[2665]=zeroGIFBmdData[2666]=zeroGIFBmdData[2667]=0x33;//{x:26,y:16}
			zeroGIFBmdData[2701]=zeroGIFBmdData[2702]=zeroGIFBmdData[2703]=0x00;//{x:35,y:16}
			zeroGIFBmdData[2705]=zeroGIFBmdData[2706]=zeroGIFBmdData[2707]=0x66;//{x:36,y:16}
			
			zeroGIFBmdData[2741]=zeroGIFBmdData[2742]=zeroGIFBmdData[2743]=0x00;//{x:5,y:17}
			zeroGIFBmdData[2745]=zeroGIFBmdData[2746]=zeroGIFBmdData[2747]=0x00;//{x:6,y:17}
			zeroGIFBmdData[2749]=zeroGIFBmdData[2750]=zeroGIFBmdData[2751]=0x00;//{x:7,y:17}
			zeroGIFBmdData[2753]=zeroGIFBmdData[2754]=zeroGIFBmdData[2755]=0x00;//{x:8,y:17}
			zeroGIFBmdData[2757]=zeroGIFBmdData[2758]=zeroGIFBmdData[2759]=0x00;//{x:9,y:17}
			zeroGIFBmdData[2761]=zeroGIFBmdData[2762]=zeroGIFBmdData[2763]=0x00;//{x:10,y:17}
			zeroGIFBmdData[2765]=zeroGIFBmdData[2766]=zeroGIFBmdData[2767]=0x00;//{x:11,y:17}
			zeroGIFBmdData[2769]=zeroGIFBmdData[2770]=zeroGIFBmdData[2771]=0x66;//{x:12,y:17}
			zeroGIFBmdData[2801]=zeroGIFBmdData[2802]=zeroGIFBmdData[2803]=0x33;//{x:20,y:17}
			zeroGIFBmdData[2805]=zeroGIFBmdData[2806]=zeroGIFBmdData[2807]=0x00;//{x:21,y:17}
			zeroGIFBmdData[2809]=zeroGIFBmdData[2810]=zeroGIFBmdData[2811]=0x00;//{x:22,y:17}
			zeroGIFBmdData[2813]=zeroGIFBmdData[2814]=zeroGIFBmdData[2815]=0x00;//{x:23,y:17}
			zeroGIFBmdData[2817]=zeroGIFBmdData[2818]=zeroGIFBmdData[2819]=0x00;//{x:24,y:17}
			zeroGIFBmdData[2821]=zeroGIFBmdData[2822]=zeroGIFBmdData[2823]=0x00;//{x:25,y:17}
			zeroGIFBmdData[2861]=zeroGIFBmdData[2862]=zeroGIFBmdData[2863]=0x99;//{x:35,y:17}
			zeroGIFBmdData[2865]=zeroGIFBmdData[2866]=zeroGIFBmdData[2867]=0x00;//{x:36,y:17}
			
			zeroGIFBmdData[2897]=zeroGIFBmdData[2898]=zeroGIFBmdData[2899]=0xcc;//{x:4,y:18}
			zeroGIFBmdData[2901]=zeroGIFBmdData[2902]=zeroGIFBmdData[2903]=0x00;//{x:5,y:18}
			zeroGIFBmdData[2905]=zeroGIFBmdData[2906]=zeroGIFBmdData[2907]=0x00;//{x:6,y:18}
			zeroGIFBmdData[2909]=zeroGIFBmdData[2910]=zeroGIFBmdData[2911]=0x00;//{x:7,y:18}
			zeroGIFBmdData[2913]=zeroGIFBmdData[2914]=zeroGIFBmdData[2915]=0x00;//{x:8,y:18}
			zeroGIFBmdData[2917]=zeroGIFBmdData[2918]=zeroGIFBmdData[2919]=0x00;//{x:9,y:18}
			zeroGIFBmdData[2921]=zeroGIFBmdData[2922]=zeroGIFBmdData[2923]=0x00;//{x:10,y:18}
			zeroGIFBmdData[2925]=zeroGIFBmdData[2926]=zeroGIFBmdData[2927]=0x00;//{x:11,y:18}
			zeroGIFBmdData[2929]=zeroGIFBmdData[2930]=zeroGIFBmdData[2931]=0x00;//{x:12,y:18}
			zeroGIFBmdData[2965]=zeroGIFBmdData[2966]=zeroGIFBmdData[2967]=0x99;//{x:21,y:18}
			zeroGIFBmdData[2969]=zeroGIFBmdData[2970]=zeroGIFBmdData[2971]=0x66;//{x:22,y:18}
			zeroGIFBmdData[2973]=zeroGIFBmdData[2974]=zeroGIFBmdData[2975]=0x66;//{x:23,y:18}
			zeroGIFBmdData[2977]=zeroGIFBmdData[2978]=zeroGIFBmdData[2979]=0x99;//{x:24,y:18}
			zeroGIFBmdData[3025]=zeroGIFBmdData[3026]=zeroGIFBmdData[3027]=0x00;//{x:36,y:18}
			zeroGIFBmdData[3029]=zeroGIFBmdData[3030]=zeroGIFBmdData[3031]=0x99;//{x:37,y:18}
			
			zeroGIFBmdData[3057]=zeroGIFBmdData[3058]=zeroGIFBmdData[3059]=0xcc;//{x:4,y:19}
			zeroGIFBmdData[3061]=zeroGIFBmdData[3062]=zeroGIFBmdData[3063]=0x00;//{x:5,y:19}
			zeroGIFBmdData[3065]=zeroGIFBmdData[3066]=zeroGIFBmdData[3067]=0x00;//{x:6,y:19}
			zeroGIFBmdData[3069]=zeroGIFBmdData[3070]=zeroGIFBmdData[3071]=0x00;//{x:7,y:19}
			zeroGIFBmdData[3073]=zeroGIFBmdData[3074]=zeroGIFBmdData[3075]=0x00;//{x:8,y:19}
			zeroGIFBmdData[3077]=zeroGIFBmdData[3078]=zeroGIFBmdData[3079]=0x00;//{x:9,y:19}
			zeroGIFBmdData[3081]=zeroGIFBmdData[3082]=zeroGIFBmdData[3083]=0x00;//{x:10,y:19}
			zeroGIFBmdData[3085]=zeroGIFBmdData[3086]=zeroGIFBmdData[3087]=0x00;//{x:11,y:19}
			zeroGIFBmdData[3089]=zeroGIFBmdData[3090]=zeroGIFBmdData[3091]=0x00;//{x:12,y:19}
			zeroGIFBmdData[3093]=zeroGIFBmdData[3094]=zeroGIFBmdData[3095]=0x99;//{x:13,y:19}
			zeroGIFBmdData[3105]=zeroGIFBmdData[3106]=zeroGIFBmdData[3107]=0x66;//{x:16,y:19}
			zeroGIFBmdData[3109]=zeroGIFBmdData[3110]=zeroGIFBmdData[3111]=0x33;//{x:17,y:19}
			zeroGIFBmdData[3113]=zeroGIFBmdData[3114]=zeroGIFBmdData[3115]=0x33;//{x:18,y:19}
			zeroGIFBmdData[3185]=zeroGIFBmdData[3186]=zeroGIFBmdData[3187]=0x33;//{x:36,y:19}
			zeroGIFBmdData[3189]=zeroGIFBmdData[3190]=zeroGIFBmdData[3191]=0x66;//{x:37,y:19}
			
			zeroGIFBmdData[3217]=zeroGIFBmdData[3218]=zeroGIFBmdData[3219]=0x33;//{x:4,y:20}
			zeroGIFBmdData[3221]=zeroGIFBmdData[3222]=zeroGIFBmdData[3223]=0x00;//{x:5,y:20}
			zeroGIFBmdData[3225]=zeroGIFBmdData[3226]=zeroGIFBmdData[3227]=0x00;//{x:6,y:20}
			zeroGIFBmdData[3229]=zeroGIFBmdData[3230]=zeroGIFBmdData[3231]=0x00;//{x:7,y:20}
			zeroGIFBmdData[3233]=zeroGIFBmdData[3234]=zeroGIFBmdData[3235]=0x00;//{x:8,y:20}
			zeroGIFBmdData[3237]=zeroGIFBmdData[3238]=zeroGIFBmdData[3239]=0x00;//{x:9,y:20}
			zeroGIFBmdData[3241]=zeroGIFBmdData[3242]=zeroGIFBmdData[3243]=0x00;//{x:10,y:20}
			zeroGIFBmdData[3245]=zeroGIFBmdData[3246]=zeroGIFBmdData[3247]=0x00;//{x:11,y:20}
			zeroGIFBmdData[3249]=zeroGIFBmdData[3250]=zeroGIFBmdData[3251]=0x00;//{x:12,y:20}
			zeroGIFBmdData[3253]=zeroGIFBmdData[3254]=zeroGIFBmdData[3255]=0x00;//{x:13,y:20}
			zeroGIFBmdData[3257]=zeroGIFBmdData[3258]=zeroGIFBmdData[3259]=0x99;//{x:14,y:20}
			zeroGIFBmdData[3261]=zeroGIFBmdData[3262]=zeroGIFBmdData[3263]=0x00;//{x:15,y:20}
			zeroGIFBmdData[3265]=zeroGIFBmdData[3266]=zeroGIFBmdData[3267]=0x00;//{x:16,y:20}
			zeroGIFBmdData[3269]=zeroGIFBmdData[3270]=zeroGIFBmdData[3271]=0x00;//{x:17,y:20}
			zeroGIFBmdData[3273]=zeroGIFBmdData[3274]=zeroGIFBmdData[3275]=0x00;//{x:18,y:20}
			zeroGIFBmdData[3277]=zeroGIFBmdData[3278]=zeroGIFBmdData[3279]=0x00;//{x:19,y:20}
			zeroGIFBmdData[3345]=zeroGIFBmdData[3346]=zeroGIFBmdData[3347]=0x00;//{x:36,y:20}
			zeroGIFBmdData[3349]=zeroGIFBmdData[3350]=zeroGIFBmdData[3351]=0x33;//{x:37,y:20}
			
			zeroGIFBmdData[3377]=zeroGIFBmdData[3378]=zeroGIFBmdData[3379]=0x33;//{x:4,y:21}
			zeroGIFBmdData[3381]=zeroGIFBmdData[3382]=zeroGIFBmdData[3383]=0x00;//{x:5,y:21}
			zeroGIFBmdData[3385]=zeroGIFBmdData[3386]=zeroGIFBmdData[3387]=0x00;//{x:6,y:21}
			zeroGIFBmdData[3389]=zeroGIFBmdData[3390]=zeroGIFBmdData[3391]=0x00;//{x:7,y:21}
			zeroGIFBmdData[3393]=zeroGIFBmdData[3394]=zeroGIFBmdData[3395]=0x00;//{x:8,y:21}
			zeroGIFBmdData[3397]=zeroGIFBmdData[3398]=zeroGIFBmdData[3399]=0xcc;//{x:9,y:21}
			zeroGIFBmdData[3401]=zeroGIFBmdData[3402]=zeroGIFBmdData[3403]=0x33;//{x:10,y:21}
			zeroGIFBmdData[3405]=zeroGIFBmdData[3406]=zeroGIFBmdData[3407]=0x00;//{x:11,y:21}
			zeroGIFBmdData[3409]=zeroGIFBmdData[3410]=zeroGIFBmdData[3411]=0x00;//{x:12,y:21}
			zeroGIFBmdData[3413]=zeroGIFBmdData[3414]=zeroGIFBmdData[3415]=0x00;//{x:13,y:21}
			zeroGIFBmdData[3417]=zeroGIFBmdData[3418]=zeroGIFBmdData[3419]=0x00;//{x:14,y:21}
			zeroGIFBmdData[3421]=zeroGIFBmdData[3422]=zeroGIFBmdData[3423]=0x00;//{x:15,y:21}
			zeroGIFBmdData[3425]=zeroGIFBmdData[3426]=zeroGIFBmdData[3427]=0x00;//{x:16,y:21}
			zeroGIFBmdData[3429]=zeroGIFBmdData[3430]=zeroGIFBmdData[3431]=0x00;//{x:17,y:21}
			zeroGIFBmdData[3433]=zeroGIFBmdData[3434]=zeroGIFBmdData[3435]=0x00;//{x:18,y:21}
			zeroGIFBmdData[3437]=zeroGIFBmdData[3438]=zeroGIFBmdData[3439]=0x00;//{x:19,y:21}
			zeroGIFBmdData[3441]=zeroGIFBmdData[3442]=zeroGIFBmdData[3443]=0xcc;//{x:20,y:21}
			zeroGIFBmdData[3473]=zeroGIFBmdData[3474]=zeroGIFBmdData[3475]=0x66;//{x:28,y:21}
			zeroGIFBmdData[3477]=zeroGIFBmdData[3478]=zeroGIFBmdData[3479]=0x33;//{x:29,y:21}
			zeroGIFBmdData[3481]=zeroGIFBmdData[3482]=zeroGIFBmdData[3483]=0xcc;//{x:30,y:21}
			zeroGIFBmdData[3501]=zeroGIFBmdData[3502]=zeroGIFBmdData[3503]=0x66;//{x:35,y:21}
			zeroGIFBmdData[3505]=zeroGIFBmdData[3506]=zeroGIFBmdData[3507]=0x00;//{x:36,y:21}
			zeroGIFBmdData[3509]=zeroGIFBmdData[3510]=zeroGIFBmdData[3511]=0xcc;//{x:37,y:21}
			
			zeroGIFBmdData[3537]=zeroGIFBmdData[3538]=zeroGIFBmdData[3539]=0x33;//{x:4,y:22}
			zeroGIFBmdData[3541]=zeroGIFBmdData[3542]=zeroGIFBmdData[3543]=0x00;//{x:5,y:22}
			zeroGIFBmdData[3545]=zeroGIFBmdData[3546]=zeroGIFBmdData[3547]=0x00;//{x:6,y:22}
			zeroGIFBmdData[3549]=zeroGIFBmdData[3550]=zeroGIFBmdData[3551]=0x00;//{x:7,y:22}
			zeroGIFBmdData[3553]=zeroGIFBmdData[3554]=zeroGIFBmdData[3555]=0x33;//{x:8,y:22}
			zeroGIFBmdData[3557]=zeroGIFBmdData[3558]=zeroGIFBmdData[3559]=0x99;//{x:9,y:22}
			zeroGIFBmdData[3565]=zeroGIFBmdData[3566]=zeroGIFBmdData[3567]=0x33;//{x:11,y:22}
			zeroGIFBmdData[3569]=zeroGIFBmdData[3570]=zeroGIFBmdData[3571]=0x00;//{x:12,y:22}
			zeroGIFBmdData[3573]=zeroGIFBmdData[3574]=zeroGIFBmdData[3575]=0x00;//{x:13,y:22}
			zeroGIFBmdData[3577]=zeroGIFBmdData[3578]=zeroGIFBmdData[3579]=0x00;//{x:14,y:22}
			zeroGIFBmdData[3581]=zeroGIFBmdData[3582]=zeroGIFBmdData[3583]=0x00;//{x:15,y:22}
			zeroGIFBmdData[3585]=zeroGIFBmdData[3586]=zeroGIFBmdData[3587]=0x00;//{x:16,y:22}
			zeroGIFBmdData[3589]=zeroGIFBmdData[3590]=zeroGIFBmdData[3591]=0x00;//{x:17,y:22}
			zeroGIFBmdData[3593]=zeroGIFBmdData[3594]=zeroGIFBmdData[3595]=0x00;//{x:18,y:22}
			zeroGIFBmdData[3597]=zeroGIFBmdData[3598]=zeroGIFBmdData[3599]=0x00;//{x:19,y:22}
			zeroGIFBmdData[3601]=zeroGIFBmdData[3602]=zeroGIFBmdData[3603]=0xcc;//{x:20,y:22}
			zeroGIFBmdData[3629]=zeroGIFBmdData[3630]=zeroGIFBmdData[3631]=0x00;//{x:27,y:22}
			zeroGIFBmdData[3633]=zeroGIFBmdData[3634]=zeroGIFBmdData[3635]=0x00;//{x:28,y:22}
			zeroGIFBmdData[3637]=zeroGIFBmdData[3638]=zeroGIFBmdData[3639]=0x00;//{x:29,y:22}
			zeroGIFBmdData[3641]=zeroGIFBmdData[3642]=zeroGIFBmdData[3643]=0x00;//{x:30,y:22}
			zeroGIFBmdData[3645]=zeroGIFBmdData[3646]=zeroGIFBmdData[3647]=0x33;//{x:31,y:22}
			zeroGIFBmdData[3657]=zeroGIFBmdData[3658]=zeroGIFBmdData[3659]=0x33;//{x:34,y:22}
			zeroGIFBmdData[3661]=zeroGIFBmdData[3662]=zeroGIFBmdData[3663]=0x33;//{x:35,y:22}
			
			zeroGIFBmdData[3697]=zeroGIFBmdData[3698]=zeroGIFBmdData[3699]=0x33;//{x:4,y:23}
			zeroGIFBmdData[3701]=zeroGIFBmdData[3702]=zeroGIFBmdData[3703]=0x00;//{x:5,y:23}
			zeroGIFBmdData[3705]=zeroGIFBmdData[3706]=zeroGIFBmdData[3707]=0x00;//{x:6,y:23}
			zeroGIFBmdData[3709]=zeroGIFBmdData[3710]=zeroGIFBmdData[3711]=0x99;//{x:7,y:23}
			zeroGIFBmdData[3725]=zeroGIFBmdData[3726]=zeroGIFBmdData[3727]=0x66;//{x:11,y:23}
			zeroGIFBmdData[3729]=zeroGIFBmdData[3730]=zeroGIFBmdData[3731]=0x00;//{x:12,y:23}
			zeroGIFBmdData[3733]=zeroGIFBmdData[3734]=zeroGIFBmdData[3735]=0x00;//{x:13,y:23}
			zeroGIFBmdData[3737]=zeroGIFBmdData[3738]=zeroGIFBmdData[3739]=0x00;//{x:14,y:23}
			zeroGIFBmdData[3741]=zeroGIFBmdData[3742]=zeroGIFBmdData[3743]=0x00;//{x:15,y:23}
			zeroGIFBmdData[3745]=zeroGIFBmdData[3746]=zeroGIFBmdData[3747]=0x00;//{x:16,y:23}
			zeroGIFBmdData[3749]=zeroGIFBmdData[3750]=zeroGIFBmdData[3751]=0x00;//{x:17,y:23}
			zeroGIFBmdData[3753]=zeroGIFBmdData[3754]=zeroGIFBmdData[3755]=0x00;//{x:18,y:23}
			zeroGIFBmdData[3757]=zeroGIFBmdData[3758]=zeroGIFBmdData[3759]=0x00;//{x:19,y:23}
			zeroGIFBmdData[3761]=zeroGIFBmdData[3762]=zeroGIFBmdData[3763]=0xcc;//{x:20,y:23}
			zeroGIFBmdData[3785]=zeroGIFBmdData[3786]=zeroGIFBmdData[3787]=0x00;//{x:26,y:23}
			zeroGIFBmdData[3789]=zeroGIFBmdData[3790]=zeroGIFBmdData[3791]=0x00;//{x:27,y:23}
			zeroGIFBmdData[3793]=zeroGIFBmdData[3794]=zeroGIFBmdData[3795]=0x00;//{x:28,y:23}
			zeroGIFBmdData[3797]=zeroGIFBmdData[3798]=zeroGIFBmdData[3799]=0xcc;//{x:29,y:23}
			zeroGIFBmdData[3801]=zeroGIFBmdData[3802]=zeroGIFBmdData[3803]=0xcc;//{x:30,y:23}
			zeroGIFBmdData[3805]=zeroGIFBmdData[3806]=zeroGIFBmdData[3807]=0x00;//{x:31,y:23}
			zeroGIFBmdData[3809]=zeroGIFBmdData[3810]=zeroGIFBmdData[3811]=0x00;//{x:32,y:23}
			zeroGIFBmdData[3813]=zeroGIFBmdData[3814]=zeroGIFBmdData[3815]=0x00;//{x:33,y:23}
			zeroGIFBmdData[3817]=zeroGIFBmdData[3818]=zeroGIFBmdData[3819]=0x33;//{x:34,y:23}
			
			zeroGIFBmdData[3857]=zeroGIFBmdData[3858]=zeroGIFBmdData[3859]=0x33;//{x:4,y:24}
			zeroGIFBmdData[3861]=zeroGIFBmdData[3862]=zeroGIFBmdData[3863]=0x00;//{x:5,y:24}
			zeroGIFBmdData[3865]=zeroGIFBmdData[3866]=zeroGIFBmdData[3867]=0x00;//{x:6,y:24}
			zeroGIFBmdData[3869]=zeroGIFBmdData[3870]=zeroGIFBmdData[3871]=0x66;//{x:7,y:24}
			zeroGIFBmdData[3885]=zeroGIFBmdData[3886]=zeroGIFBmdData[3887]=0x33;//{x:11,y:24}
			zeroGIFBmdData[3889]=zeroGIFBmdData[3890]=zeroGIFBmdData[3891]=0x00;//{x:12,y:24}
			zeroGIFBmdData[3893]=zeroGIFBmdData[3894]=zeroGIFBmdData[3895]=0x00;//{x:13,y:24}
			zeroGIFBmdData[3897]=zeroGIFBmdData[3898]=zeroGIFBmdData[3899]=0x00;//{x:14,y:24}
			zeroGIFBmdData[3901]=zeroGIFBmdData[3902]=zeroGIFBmdData[3903]=0x00;//{x:15,y:24}
			zeroGIFBmdData[3905]=zeroGIFBmdData[3906]=zeroGIFBmdData[3907]=0x00;//{x:16,y:24}
			zeroGIFBmdData[3909]=zeroGIFBmdData[3910]=zeroGIFBmdData[3911]=0x00;//{x:17,y:24}
			zeroGIFBmdData[3913]=zeroGIFBmdData[3914]=zeroGIFBmdData[3915]=0x00;//{x:18,y:24}
			zeroGIFBmdData[3917]=zeroGIFBmdData[3918]=zeroGIFBmdData[3919]=0x99;//{x:19,y:24}
			zeroGIFBmdData[3941]=zeroGIFBmdData[3942]=zeroGIFBmdData[3943]=0x00;//{x:25,y:24}
			zeroGIFBmdData[3945]=zeroGIFBmdData[3946]=zeroGIFBmdData[3947]=0x00;//{x:26,y:24}
			zeroGIFBmdData[3949]=zeroGIFBmdData[3950]=zeroGIFBmdData[3951]=0x00;//{x:27,y:24}
			zeroGIFBmdData[3953]=zeroGIFBmdData[3954]=zeroGIFBmdData[3955]=0x99;//{x:28,y:24}
			zeroGIFBmdData[3965]=zeroGIFBmdData[3966]=zeroGIFBmdData[3967]=0x00;//{x:31,y:24}
			zeroGIFBmdData[3969]=zeroGIFBmdData[3970]=zeroGIFBmdData[3971]=0x00;//{x:32,y:24}
			zeroGIFBmdData[3973]=zeroGIFBmdData[3974]=zeroGIFBmdData[3975]=0x33;//{x:33,y:24}
			
			zeroGIFBmdData[4017]=zeroGIFBmdData[4018]=zeroGIFBmdData[4019]=0x33;//{x:4,y:25}
			zeroGIFBmdData[4021]=zeroGIFBmdData[4022]=zeroGIFBmdData[4023]=0x00;//{x:5,y:25}
			zeroGIFBmdData[4025]=zeroGIFBmdData[4026]=zeroGIFBmdData[4027]=0x00;//{x:6,y:25}
			zeroGIFBmdData[4029]=zeroGIFBmdData[4030]=zeroGIFBmdData[4031]=0x00;//{x:7,y:25}
			zeroGIFBmdData[4033]=zeroGIFBmdData[4034]=zeroGIFBmdData[4035]=0xcc;//{x:8,y:25}
			zeroGIFBmdData[4037]=zeroGIFBmdData[4038]=zeroGIFBmdData[4039]=0xcc;//{x:9,y:25}
			zeroGIFBmdData[4041]=zeroGIFBmdData[4042]=zeroGIFBmdData[4043]=0x99;//{x:10,y:25}
			zeroGIFBmdData[4045]=zeroGIFBmdData[4046]=zeroGIFBmdData[4047]=0x00;//{x:11,y:25}
			zeroGIFBmdData[4049]=zeroGIFBmdData[4050]=zeroGIFBmdData[4051]=0x00;//{x:12,y:25}
			zeroGIFBmdData[4053]=zeroGIFBmdData[4054]=zeroGIFBmdData[4055]=0x00;//{x:13,y:25}
			zeroGIFBmdData[4057]=zeroGIFBmdData[4058]=zeroGIFBmdData[4059]=0x00;//{x:14,y:25}
			zeroGIFBmdData[4061]=zeroGIFBmdData[4062]=zeroGIFBmdData[4063]=0x00;//{x:15,y:25}
			zeroGIFBmdData[4065]=zeroGIFBmdData[4066]=zeroGIFBmdData[4067]=0x00;//{x:16,y:25}
			zeroGIFBmdData[4069]=zeroGIFBmdData[4070]=zeroGIFBmdData[4071]=0x33;//{x:17,y:25}
			zeroGIFBmdData[4073]=zeroGIFBmdData[4074]=zeroGIFBmdData[4075]=0xcc;//{x:18,y:25}
			zeroGIFBmdData[4097]=zeroGIFBmdData[4098]=zeroGIFBmdData[4099]=0x33;//{x:24,y:25}
			zeroGIFBmdData[4101]=zeroGIFBmdData[4102]=zeroGIFBmdData[4103]=0x00;//{x:25,y:25}
			zeroGIFBmdData[4105]=zeroGIFBmdData[4106]=zeroGIFBmdData[4107]=0x00;//{x:26,y:25}
			zeroGIFBmdData[4109]=zeroGIFBmdData[4110]=zeroGIFBmdData[4111]=0x66;//{x:27,y:25}
			zeroGIFBmdData[4121]=zeroGIFBmdData[4122]=zeroGIFBmdData[4123]=0x00;//{x:30,y:25}
			zeroGIFBmdData[4125]=zeroGIFBmdData[4126]=zeroGIFBmdData[4127]=0x00;//{x:31,y:25}
			zeroGIFBmdData[4129]=zeroGIFBmdData[4130]=zeroGIFBmdData[4131]=0x99;//{x:32,y:25}
			
			zeroGIFBmdData[4177]=zeroGIFBmdData[4178]=zeroGIFBmdData[4179]=0x66;//{x:4,y:26}
			zeroGIFBmdData[4181]=zeroGIFBmdData[4182]=zeroGIFBmdData[4183]=0x00;//{x:5,y:26}
			zeroGIFBmdData[4185]=zeroGIFBmdData[4186]=zeroGIFBmdData[4187]=0x00;//{x:6,y:26}
			zeroGIFBmdData[4189]=zeroGIFBmdData[4190]=zeroGIFBmdData[4191]=0x00;//{x:7,y:26}
			zeroGIFBmdData[4193]=zeroGIFBmdData[4194]=zeroGIFBmdData[4195]=0x00;//{x:8,y:26}
			zeroGIFBmdData[4197]=zeroGIFBmdData[4198]=zeroGIFBmdData[4199]=0x00;//{x:9,y:26}
			zeroGIFBmdData[4201]=zeroGIFBmdData[4202]=zeroGIFBmdData[4203]=0x00;//{x:10,y:26}
			zeroGIFBmdData[4205]=zeroGIFBmdData[4206]=zeroGIFBmdData[4207]=0x00;//{x:11,y:26}
			zeroGIFBmdData[4209]=zeroGIFBmdData[4210]=zeroGIFBmdData[4211]=0x00;//{x:12,y:26}
			zeroGIFBmdData[4213]=zeroGIFBmdData[4214]=zeroGIFBmdData[4215]=0x00;//{x:13,y:26}
			zeroGIFBmdData[4217]=zeroGIFBmdData[4218]=zeroGIFBmdData[4219]=0x00;//{x:14,y:26}
			zeroGIFBmdData[4221]=zeroGIFBmdData[4222]=zeroGIFBmdData[4223]=0x00;//{x:15,y:26}
			zeroGIFBmdData[4225]=zeroGIFBmdData[4226]=zeroGIFBmdData[4227]=0x00;//{x:16,y:26}
			zeroGIFBmdData[4253]=zeroGIFBmdData[4254]=zeroGIFBmdData[4255]=0x33;//{x:23,y:26}
			zeroGIFBmdData[4257]=zeroGIFBmdData[4258]=zeroGIFBmdData[4259]=0x00;//{x:24,y:26}
			zeroGIFBmdData[4261]=zeroGIFBmdData[4262]=zeroGIFBmdData[4263]=0x00;//{x:25,y:26}
			zeroGIFBmdData[4265]=zeroGIFBmdData[4266]=zeroGIFBmdData[4267]=0x66;//{x:26,y:26}
			zeroGIFBmdData[4273]=zeroGIFBmdData[4274]=zeroGIFBmdData[4275]=0xcc;//{x:28,y:26}
			zeroGIFBmdData[4277]=zeroGIFBmdData[4278]=zeroGIFBmdData[4279]=0x00;//{x:29,y:26}
			zeroGIFBmdData[4281]=zeroGIFBmdData[4282]=zeroGIFBmdData[4283]=0x00;//{x:30,y:26}
			zeroGIFBmdData[4285]=zeroGIFBmdData[4286]=zeroGIFBmdData[4287]=0x33;//{x:31,y:26}
			zeroGIFBmdData[4289]=zeroGIFBmdData[4290]=zeroGIFBmdData[4291]=0x00;//{x:32,y:26}
			
			zeroGIFBmdData[4337]=zeroGIFBmdData[4338]=zeroGIFBmdData[4339]=0xcc;//{x:4,y:27}
			zeroGIFBmdData[4341]=zeroGIFBmdData[4342]=zeroGIFBmdData[4343]=0x00;//{x:5,y:27}
			zeroGIFBmdData[4345]=zeroGIFBmdData[4346]=zeroGIFBmdData[4347]=0x00;//{x:6,y:27}
			zeroGIFBmdData[4349]=zeroGIFBmdData[4350]=zeroGIFBmdData[4351]=0x00;//{x:7,y:27}
			zeroGIFBmdData[4353]=zeroGIFBmdData[4354]=zeroGIFBmdData[4355]=0x00;//{x:8,y:27}
			zeroGIFBmdData[4357]=zeroGIFBmdData[4358]=zeroGIFBmdData[4359]=0x00;//{x:9,y:27}
			zeroGIFBmdData[4361]=zeroGIFBmdData[4362]=zeroGIFBmdData[4363]=0x00;//{x:10,y:27}
			zeroGIFBmdData[4365]=zeroGIFBmdData[4366]=zeroGIFBmdData[4367]=0x00;//{x:11,y:27}
			zeroGIFBmdData[4369]=zeroGIFBmdData[4370]=zeroGIFBmdData[4371]=0x00;//{x:12,y:27}
			zeroGIFBmdData[4373]=zeroGIFBmdData[4374]=zeroGIFBmdData[4375]=0x00;//{x:13,y:27}
			zeroGIFBmdData[4377]=zeroGIFBmdData[4378]=zeroGIFBmdData[4379]=0x00;//{x:14,y:27}
			zeroGIFBmdData[4381]=zeroGIFBmdData[4382]=zeroGIFBmdData[4383]=0x00;//{x:15,y:27}
			zeroGIFBmdData[4385]=zeroGIFBmdData[4386]=zeroGIFBmdData[4387]=0x00;//{x:16,y:27}
			zeroGIFBmdData[4389]=zeroGIFBmdData[4390]=zeroGIFBmdData[4391]=0x99;//{x:17,y:27}
			zeroGIFBmdData[4409]=zeroGIFBmdData[4410]=zeroGIFBmdData[4411]=0x33;//{x:22,y:27}
			zeroGIFBmdData[4413]=zeroGIFBmdData[4414]=zeroGIFBmdData[4415]=0x00;//{x:23,y:27}
			zeroGIFBmdData[4417]=zeroGIFBmdData[4418]=zeroGIFBmdData[4419]=0x00;//{x:24,y:27}
			zeroGIFBmdData[4421]=zeroGIFBmdData[4422]=zeroGIFBmdData[4423]=0x66;//{x:25,y:27}
			zeroGIFBmdData[4429]=zeroGIFBmdData[4430]=zeroGIFBmdData[4431]=0x66;//{x:27,y:27}
			zeroGIFBmdData[4433]=zeroGIFBmdData[4434]=zeroGIFBmdData[4435]=0x00;//{x:28,y:27}
			zeroGIFBmdData[4437]=zeroGIFBmdData[4438]=zeroGIFBmdData[4439]=0x33;//{x:29,y:27}
			zeroGIFBmdData[4441]=zeroGIFBmdData[4442]=zeroGIFBmdData[4443]=0xcc;//{x:30,y:27}
			zeroGIFBmdData[4445]=zeroGIFBmdData[4446]=zeroGIFBmdData[4447]=0x00;//{x:31,y:27}
			zeroGIFBmdData[4449]=zeroGIFBmdData[4450]=zeroGIFBmdData[4451]=0x00;//{x:32,y:27}
			
			zeroGIFBmdData[4501]=zeroGIFBmdData[4502]=zeroGIFBmdData[4503]=0x00;//{x:5,y:28}
			zeroGIFBmdData[4505]=zeroGIFBmdData[4506]=zeroGIFBmdData[4507]=0x00;//{x:6,y:28}
			zeroGIFBmdData[4509]=zeroGIFBmdData[4510]=zeroGIFBmdData[4511]=0x00;//{x:7,y:28}
			zeroGIFBmdData[4513]=zeroGIFBmdData[4514]=zeroGIFBmdData[4515]=0x00;//{x:8,y:28}
			zeroGIFBmdData[4517]=zeroGIFBmdData[4518]=zeroGIFBmdData[4519]=0x00;//{x:9,y:28}
			zeroGIFBmdData[4521]=zeroGIFBmdData[4522]=zeroGIFBmdData[4523]=0x00;//{x:10,y:28}
			zeroGIFBmdData[4525]=zeroGIFBmdData[4526]=zeroGIFBmdData[4527]=0x00;//{x:11,y:28}
			zeroGIFBmdData[4529]=zeroGIFBmdData[4530]=zeroGIFBmdData[4531]=0x00;//{x:12,y:28}
			zeroGIFBmdData[4533]=zeroGIFBmdData[4534]=zeroGIFBmdData[4535]=0x00;//{x:13,y:28}
			zeroGIFBmdData[4537]=zeroGIFBmdData[4538]=zeroGIFBmdData[4539]=0x00;//{x:14,y:28}
			zeroGIFBmdData[4541]=zeroGIFBmdData[4542]=zeroGIFBmdData[4543]=0x00;//{x:15,y:28}
			zeroGIFBmdData[4545]=zeroGIFBmdData[4546]=zeroGIFBmdData[4547]=0x00;//{x:16,y:28}
			zeroGIFBmdData[4549]=zeroGIFBmdData[4550]=zeroGIFBmdData[4551]=0x00;//{x:17,y:28}
			zeroGIFBmdData[4561]=zeroGIFBmdData[4562]=zeroGIFBmdData[4563]=0x99;//{x:20,y:28}
			zeroGIFBmdData[4565]=zeroGIFBmdData[4566]=zeroGIFBmdData[4567]=0x00;//{x:21,y:28}
			zeroGIFBmdData[4569]=zeroGIFBmdData[4570]=zeroGIFBmdData[4571]=0x00;//{x:22,y:28}
			zeroGIFBmdData[4573]=zeroGIFBmdData[4574]=zeroGIFBmdData[4575]=0x00;//{x:23,y:28}
			zeroGIFBmdData[4577]=zeroGIFBmdData[4578]=zeroGIFBmdData[4579]=0x99;//{x:24,y:28}
			zeroGIFBmdData[4585]=zeroGIFBmdData[4586]=zeroGIFBmdData[4587]=0x33;//{x:26,y:28}
			zeroGIFBmdData[4589]=zeroGIFBmdData[4590]=zeroGIFBmdData[4591]=0x00;//{x:27,y:28}
			zeroGIFBmdData[4593]=zeroGIFBmdData[4594]=zeroGIFBmdData[4595]=0x66;//{x:28,y:28}
			zeroGIFBmdData[4605]=zeroGIFBmdData[4606]=zeroGIFBmdData[4607]=0x66;//{x:31,y:28}
			zeroGIFBmdData[4609]=zeroGIFBmdData[4610]=zeroGIFBmdData[4611]=0x33;//{x:32,y:28}
			
			zeroGIFBmdData[4661]=zeroGIFBmdData[4662]=zeroGIFBmdData[4663]=0x66;//{x:5,y:29}
			zeroGIFBmdData[4665]=zeroGIFBmdData[4666]=zeroGIFBmdData[4667]=0x00;//{x:6,y:29}
			zeroGIFBmdData[4669]=zeroGIFBmdData[4670]=zeroGIFBmdData[4671]=0x00;//{x:7,y:29}
			zeroGIFBmdData[4673]=zeroGIFBmdData[4674]=zeroGIFBmdData[4675]=0x00;//{x:8,y:29}
			zeroGIFBmdData[4677]=zeroGIFBmdData[4678]=zeroGIFBmdData[4679]=0x00;//{x:9,y:29}
			zeroGIFBmdData[4681]=zeroGIFBmdData[4682]=zeroGIFBmdData[4683]=0x00;//{x:10,y:29}
			zeroGIFBmdData[4685]=zeroGIFBmdData[4686]=zeroGIFBmdData[4687]=0x00;//{x:11,y:29}
			zeroGIFBmdData[4689]=zeroGIFBmdData[4690]=zeroGIFBmdData[4691]=0x00;//{x:12,y:29}
			zeroGIFBmdData[4693]=zeroGIFBmdData[4694]=zeroGIFBmdData[4695]=0x00;//{x:13,y:29}
			zeroGIFBmdData[4697]=zeroGIFBmdData[4698]=zeroGIFBmdData[4699]=0x00;//{x:14,y:29}
			zeroGIFBmdData[4701]=zeroGIFBmdData[4702]=zeroGIFBmdData[4703]=0x00;//{x:15,y:29}
			zeroGIFBmdData[4705]=zeroGIFBmdData[4706]=zeroGIFBmdData[4707]=0x00;//{x:16,y:29}
			zeroGIFBmdData[4709]=zeroGIFBmdData[4710]=zeroGIFBmdData[4711]=0x00;//{x:17,y:29}
			zeroGIFBmdData[4713]=zeroGIFBmdData[4714]=zeroGIFBmdData[4715]=0x00;//{x:18,y:29}
			zeroGIFBmdData[4717]=zeroGIFBmdData[4718]=zeroGIFBmdData[4719]=0x33;//{x:19,y:29}
			zeroGIFBmdData[4721]=zeroGIFBmdData[4722]=zeroGIFBmdData[4723]=0x00;//{x:20,y:29}
			zeroGIFBmdData[4725]=zeroGIFBmdData[4726]=zeroGIFBmdData[4727]=0x00;//{x:21,y:29}
			zeroGIFBmdData[4729]=zeroGIFBmdData[4730]=zeroGIFBmdData[4731]=0x33;//{x:22,y:29}
			zeroGIFBmdData[4737]=zeroGIFBmdData[4738]=zeroGIFBmdData[4739]=0xcc;//{x:24,y:29}
			zeroGIFBmdData[4741]=zeroGIFBmdData[4742]=zeroGIFBmdData[4743]=0x00;//{x:25,y:29}
			zeroGIFBmdData[4745]=zeroGIFBmdData[4746]=zeroGIFBmdData[4747]=0x00;//{x:26,y:29}
			zeroGIFBmdData[4749]=zeroGIFBmdData[4750]=zeroGIFBmdData[4751]=0x00;//{x:27,y:29}
			zeroGIFBmdData[4753]=zeroGIFBmdData[4754]=zeroGIFBmdData[4755]=0x33;//{x:28,y:29}
			zeroGIFBmdData[4757]=zeroGIFBmdData[4758]=zeroGIFBmdData[4759]=0x00;//{x:29,y:29}
			zeroGIFBmdData[4761]=zeroGIFBmdData[4762]=zeroGIFBmdData[4763]=0x00;//{x:30,y:29}
			zeroGIFBmdData[4765]=zeroGIFBmdData[4766]=zeroGIFBmdData[4767]=0x00;//{x:31,y:29}
			zeroGIFBmdData[4769]=zeroGIFBmdData[4770]=zeroGIFBmdData[4771]=0x33;//{x:32,y:29}
			
			zeroGIFBmdData[4821]=zeroGIFBmdData[4822]=zeroGIFBmdData[4823]=0xcc;//{x:5,y:30}
			zeroGIFBmdData[4825]=zeroGIFBmdData[4826]=zeroGIFBmdData[4827]=0x00;//{x:6,y:30}
			zeroGIFBmdData[4829]=zeroGIFBmdData[4830]=zeroGIFBmdData[4831]=0x00;//{x:7,y:30}
			zeroGIFBmdData[4833]=zeroGIFBmdData[4834]=zeroGIFBmdData[4835]=0x00;//{x:8,y:30}
			zeroGIFBmdData[4837]=zeroGIFBmdData[4838]=zeroGIFBmdData[4839]=0x00;//{x:9,y:30}
			zeroGIFBmdData[4841]=zeroGIFBmdData[4842]=zeroGIFBmdData[4843]=0x00;//{x:10,y:30}
			zeroGIFBmdData[4845]=zeroGIFBmdData[4846]=zeroGIFBmdData[4847]=0x00;//{x:11,y:30}
			zeroGIFBmdData[4849]=zeroGIFBmdData[4850]=zeroGIFBmdData[4851]=0x00;//{x:12,y:30}
			zeroGIFBmdData[4853]=zeroGIFBmdData[4854]=zeroGIFBmdData[4855]=0x00;//{x:13,y:30}
			zeroGIFBmdData[4857]=zeroGIFBmdData[4858]=zeroGIFBmdData[4859]=0x00;//{x:14,y:30}
			zeroGIFBmdData[4861]=zeroGIFBmdData[4862]=zeroGIFBmdData[4863]=0x00;//{x:15,y:30}
			zeroGIFBmdData[4865]=zeroGIFBmdData[4866]=zeroGIFBmdData[4867]=0x00;//{x:16,y:30}
			zeroGIFBmdData[4869]=zeroGIFBmdData[4870]=zeroGIFBmdData[4871]=0x00;//{x:17,y:30}
			zeroGIFBmdData[4873]=zeroGIFBmdData[4874]=zeroGIFBmdData[4875]=0x00;//{x:18,y:30}
			zeroGIFBmdData[4877]=zeroGIFBmdData[4878]=zeroGIFBmdData[4879]=0x00;//{x:19,y:30}
			zeroGIFBmdData[4881]=zeroGIFBmdData[4882]=zeroGIFBmdData[4883]=0x33;//{x:20,y:30}
			zeroGIFBmdData[4885]=zeroGIFBmdData[4886]=zeroGIFBmdData[4887]=0xcc;//{x:21,y:30}
			zeroGIFBmdData[4889]=zeroGIFBmdData[4890]=zeroGIFBmdData[4891]=0xcc;//{x:22,y:30}
			zeroGIFBmdData[4893]=zeroGIFBmdData[4894]=zeroGIFBmdData[4895]=0x00;//{x:23,y:30}
			zeroGIFBmdData[4897]=zeroGIFBmdData[4898]=zeroGIFBmdData[4899]=0x00;//{x:24,y:30}
			zeroGIFBmdData[4901]=zeroGIFBmdData[4902]=zeroGIFBmdData[4903]=0x00;//{x:25,y:30}
			zeroGIFBmdData[4905]=zeroGIFBmdData[4906]=zeroGIFBmdData[4907]=0x00;//{x:26,y:30}
			zeroGIFBmdData[4909]=zeroGIFBmdData[4910]=zeroGIFBmdData[4911]=0x00;//{x:27,y:30}
			zeroGIFBmdData[4913]=zeroGIFBmdData[4914]=zeroGIFBmdData[4915]=0x00;//{x:28,y:30}
			zeroGIFBmdData[4917]=zeroGIFBmdData[4918]=zeroGIFBmdData[4919]=0x00;//{x:29,y:30}
			zeroGIFBmdData[4929]=zeroGIFBmdData[4930]=zeroGIFBmdData[4931]=0xcc;//{x:32,y:30}
			
			zeroGIFBmdData[4985]=zeroGIFBmdData[4986]=zeroGIFBmdData[4987]=0x33;//{x:6,y:31}
			zeroGIFBmdData[4989]=zeroGIFBmdData[4990]=zeroGIFBmdData[4991]=0x00;//{x:7,y:31}
			zeroGIFBmdData[4993]=zeroGIFBmdData[4994]=zeroGIFBmdData[4995]=0x00;//{x:8,y:31}
			zeroGIFBmdData[4997]=zeroGIFBmdData[4998]=zeroGIFBmdData[4999]=0x00;//{x:9,y:31}
			zeroGIFBmdData[5001]=zeroGIFBmdData[5002]=zeroGIFBmdData[5003]=0x00;//{x:10,y:31}
			zeroGIFBmdData[5005]=zeroGIFBmdData[5006]=zeroGIFBmdData[5007]=0x00;//{x:11,y:31}
			zeroGIFBmdData[5009]=zeroGIFBmdData[5010]=zeroGIFBmdData[5011]=0x00;//{x:12,y:31}
			zeroGIFBmdData[5013]=zeroGIFBmdData[5014]=zeroGIFBmdData[5015]=0x00;//{x:13,y:31}
			zeroGIFBmdData[5017]=zeroGIFBmdData[5018]=zeroGIFBmdData[5019]=0x00;//{x:14,y:31}
			zeroGIFBmdData[5021]=zeroGIFBmdData[5022]=zeroGIFBmdData[5023]=0x00;//{x:15,y:31}
			zeroGIFBmdData[5025]=zeroGIFBmdData[5026]=zeroGIFBmdData[5027]=0x00;//{x:16,y:31}
			zeroGIFBmdData[5029]=zeroGIFBmdData[5030]=zeroGIFBmdData[5031]=0x00;//{x:17,y:31}
			zeroGIFBmdData[5033]=zeroGIFBmdData[5034]=zeroGIFBmdData[5035]=0x66;//{x:18,y:31}
			zeroGIFBmdData[5037]=zeroGIFBmdData[5038]=zeroGIFBmdData[5039]=0xcc;//{x:19,y:31}
			zeroGIFBmdData[5041]=zeroGIFBmdData[5042]=zeroGIFBmdData[5043]=0xcc;//{x:20,y:31}
			zeroGIFBmdData[5045]=zeroGIFBmdData[5046]=zeroGIFBmdData[5047]=0x33;//{x:21,y:31}
			zeroGIFBmdData[5049]=zeroGIFBmdData[5050]=zeroGIFBmdData[5051]=0x00;//{x:22,y:31}
			zeroGIFBmdData[5053]=zeroGIFBmdData[5054]=zeroGIFBmdData[5055]=0x00;//{x:23,y:31}
			zeroGIFBmdData[5057]=zeroGIFBmdData[5058]=zeroGIFBmdData[5059]=0x00;//{x:24,y:31}
			zeroGIFBmdData[5061]=zeroGIFBmdData[5062]=zeroGIFBmdData[5063]=0x00;//{x:25,y:31}
			zeroGIFBmdData[5065]=zeroGIFBmdData[5066]=zeroGIFBmdData[5067]=0x00;//{x:26,y:31}
			zeroGIFBmdData[5069]=zeroGIFBmdData[5070]=zeroGIFBmdData[5071]=0x00;//{x:27,y:31}
			zeroGIFBmdData[5073]=zeroGIFBmdData[5074]=zeroGIFBmdData[5075]=0x00;//{x:28,y:31}
			zeroGIFBmdData[5077]=zeroGIFBmdData[5078]=zeroGIFBmdData[5079]=0x00;//{x:29,y:31}
			zeroGIFBmdData[5081]=zeroGIFBmdData[5082]=zeroGIFBmdData[5083]=0x00;//{x:30,y:31}
			zeroGIFBmdData[5089]=zeroGIFBmdData[5090]=zeroGIFBmdData[5091]=0xcc;//{x:32,y:31}
			zeroGIFBmdData[5093]=zeroGIFBmdData[5094]=zeroGIFBmdData[5095]=0x66;//{x:33,y:31}
			zeroGIFBmdData[5097]=zeroGIFBmdData[5098]=zeroGIFBmdData[5099]=0xcc;//{x:34,y:31}
			
			zeroGIFBmdData[5145]=zeroGIFBmdData[5146]=zeroGIFBmdData[5147]=0xcc;//{x:6,y:32}
			zeroGIFBmdData[5149]=zeroGIFBmdData[5150]=zeroGIFBmdData[5151]=0x00;//{x:7,y:32}
			zeroGIFBmdData[5153]=zeroGIFBmdData[5154]=zeroGIFBmdData[5155]=0x00;//{x:8,y:32}
			zeroGIFBmdData[5157]=zeroGIFBmdData[5158]=zeroGIFBmdData[5159]=0x00;//{x:9,y:32}
			zeroGIFBmdData[5161]=zeroGIFBmdData[5162]=zeroGIFBmdData[5163]=0x00;//{x:10,y:32}
			zeroGIFBmdData[5165]=zeroGIFBmdData[5166]=zeroGIFBmdData[5167]=0x00;//{x:11,y:32}
			zeroGIFBmdData[5169]=zeroGIFBmdData[5170]=zeroGIFBmdData[5171]=0x00;//{x:12,y:32}
			zeroGIFBmdData[5173]=zeroGIFBmdData[5174]=zeroGIFBmdData[5175]=0x00;//{x:13,y:32}
			zeroGIFBmdData[5177]=zeroGIFBmdData[5178]=zeroGIFBmdData[5179]=0x00;//{x:14,y:32}
			zeroGIFBmdData[5181]=zeroGIFBmdData[5182]=zeroGIFBmdData[5183]=0x66;//{x:15,y:32}
			zeroGIFBmdData[5185]=zeroGIFBmdData[5186]=zeroGIFBmdData[5187]=0xcc;//{x:16,y:32}
			zeroGIFBmdData[5193]=zeroGIFBmdData[5194]=zeroGIFBmdData[5195]=0xcc;//{x:18,y:32}
			zeroGIFBmdData[5197]=zeroGIFBmdData[5198]=zeroGIFBmdData[5199]=0x33;//{x:19,y:32}
			zeroGIFBmdData[5201]=zeroGIFBmdData[5202]=zeroGIFBmdData[5203]=0x00;//{x:20,y:32}
			zeroGIFBmdData[5205]=zeroGIFBmdData[5206]=zeroGIFBmdData[5207]=0x00;//{x:21,y:32}
			zeroGIFBmdData[5209]=zeroGIFBmdData[5210]=zeroGIFBmdData[5211]=0x00;//{x:22,y:32}
			zeroGIFBmdData[5213]=zeroGIFBmdData[5214]=zeroGIFBmdData[5215]=0x00;//{x:23,y:32}
			zeroGIFBmdData[5217]=zeroGIFBmdData[5218]=zeroGIFBmdData[5219]=0x00;//{x:24,y:32}
			zeroGIFBmdData[5221]=zeroGIFBmdData[5222]=zeroGIFBmdData[5223]=0x00;//{x:25,y:32}
			zeroGIFBmdData[5225]=zeroGIFBmdData[5226]=zeroGIFBmdData[5227]=0x00;//{x:26,y:32}
			zeroGIFBmdData[5229]=zeroGIFBmdData[5230]=zeroGIFBmdData[5231]=0x00;//{x:27,y:32}
			zeroGIFBmdData[5233]=zeroGIFBmdData[5234]=zeroGIFBmdData[5235]=0x00;//{x:28,y:32}
			zeroGIFBmdData[5237]=zeroGIFBmdData[5238]=zeroGIFBmdData[5239]=0x00;//{x:29,y:32}
			zeroGIFBmdData[5241]=zeroGIFBmdData[5242]=zeroGIFBmdData[5243]=0x00;//{x:30,y:32}
			zeroGIFBmdData[5245]=zeroGIFBmdData[5246]=zeroGIFBmdData[5247]=0x33;//{x:31,y:32}
			zeroGIFBmdData[5249]=zeroGIFBmdData[5250]=zeroGIFBmdData[5251]=0x00;//{x:32,y:32}
			zeroGIFBmdData[5253]=zeroGIFBmdData[5254]=zeroGIFBmdData[5255]=0x00;//{x:33,y:32}
			
			zeroGIFBmdData[5309]=zeroGIFBmdData[5310]=zeroGIFBmdData[5311]=0x00;//{x:7,y:33}
			zeroGIFBmdData[5313]=zeroGIFBmdData[5314]=zeroGIFBmdData[5315]=0x00;//{x:8,y:33}
			zeroGIFBmdData[5317]=zeroGIFBmdData[5318]=zeroGIFBmdData[5319]=0x00;//{x:9,y:33}
			zeroGIFBmdData[5321]=zeroGIFBmdData[5322]=zeroGIFBmdData[5323]=0x00;//{x:10,y:33}
			zeroGIFBmdData[5325]=zeroGIFBmdData[5326]=zeroGIFBmdData[5327]=0x00;//{x:11,y:33}
			zeroGIFBmdData[5329]=zeroGIFBmdData[5330]=zeroGIFBmdData[5331]=0x00;//{x:12,y:33}
			zeroGIFBmdData[5333]=zeroGIFBmdData[5334]=zeroGIFBmdData[5335]=0x66;//{x:13,y:33}
			zeroGIFBmdData[5341]=zeroGIFBmdData[5342]=zeroGIFBmdData[5343]=0xcc;//{x:15,y:33}
			zeroGIFBmdData[5345]=zeroGIFBmdData[5346]=zeroGIFBmdData[5347]=0x33;//{x:16,y:33}
			zeroGIFBmdData[5349]=zeroGIFBmdData[5350]=zeroGIFBmdData[5351]=0x00;//{x:17,y:33}
			zeroGIFBmdData[5353]=zeroGIFBmdData[5354]=zeroGIFBmdData[5355]=0x33;//{x:18,y:33}
			zeroGIFBmdData[5357]=zeroGIFBmdData[5358]=zeroGIFBmdData[5359]=0x00;//{x:19,y:33}
			zeroGIFBmdData[5361]=zeroGIFBmdData[5362]=zeroGIFBmdData[5363]=0x00;//{x:20,y:33}
			zeroGIFBmdData[5365]=zeroGIFBmdData[5366]=zeroGIFBmdData[5367]=0x00;//{x:21,y:33}
			zeroGIFBmdData[5369]=zeroGIFBmdData[5370]=zeroGIFBmdData[5371]=0x00;//{x:22,y:33}
			zeroGIFBmdData[5373]=zeroGIFBmdData[5374]=zeroGIFBmdData[5375]=0x00;//{x:23,y:33}
			zeroGIFBmdData[5377]=zeroGIFBmdData[5378]=zeroGIFBmdData[5379]=0x00;//{x:24,y:33}
			zeroGIFBmdData[5381]=zeroGIFBmdData[5382]=zeroGIFBmdData[5383]=0x00;//{x:25,y:33}
			zeroGIFBmdData[5385]=zeroGIFBmdData[5386]=zeroGIFBmdData[5387]=0x00;//{x:26,y:33}
			zeroGIFBmdData[5389]=zeroGIFBmdData[5390]=zeroGIFBmdData[5391]=0x00;//{x:27,y:33}
			zeroGIFBmdData[5393]=zeroGIFBmdData[5394]=zeroGIFBmdData[5395]=0x00;//{x:28,y:33}
			zeroGIFBmdData[5397]=zeroGIFBmdData[5398]=zeroGIFBmdData[5399]=0x00;//{x:29,y:33}
			zeroGIFBmdData[5401]=zeroGIFBmdData[5402]=zeroGIFBmdData[5403]=0x00;//{x:30,y:33}
			zeroGIFBmdData[5405]=zeroGIFBmdData[5406]=zeroGIFBmdData[5407]=0x00;//{x:31,y:33}
			zeroGIFBmdData[5409]=zeroGIFBmdData[5410]=zeroGIFBmdData[5411]=0x33;//{x:32,y:33}
			zeroGIFBmdData[5413]=zeroGIFBmdData[5414]=zeroGIFBmdData[5415]=0x00;//{x:33,y:33}
			
			zeroGIFBmdData[5473]=zeroGIFBmdData[5474]=zeroGIFBmdData[5475]=0x00;//{x:8,y:34}
			zeroGIFBmdData[5477]=zeroGIFBmdData[5478]=zeroGIFBmdData[5479]=0x00;//{x:9,y:34}
			zeroGIFBmdData[5481]=zeroGIFBmdData[5482]=zeroGIFBmdData[5483]=0x00;//{x:10,y:34}
			zeroGIFBmdData[5485]=zeroGIFBmdData[5486]=zeroGIFBmdData[5487]=0x00;//{x:11,y:34}
			zeroGIFBmdData[5489]=zeroGIFBmdData[5490]=zeroGIFBmdData[5491]=0x00;//{x:12,y:34}
			zeroGIFBmdData[5493]=zeroGIFBmdData[5494]=zeroGIFBmdData[5495]=0x00;//{x:13,y:34}
			zeroGIFBmdData[5497]=zeroGIFBmdData[5498]=zeroGIFBmdData[5499]=0x00;//{x:14,y:34}
			zeroGIFBmdData[5501]=zeroGIFBmdData[5502]=zeroGIFBmdData[5503]=0x00;//{x:15,y:34}
			zeroGIFBmdData[5505]=zeroGIFBmdData[5506]=zeroGIFBmdData[5507]=0x66;//{x:16,y:34}
			zeroGIFBmdData[5509]=zeroGIFBmdData[5510]=zeroGIFBmdData[5511]=0xcc;//{x:17,y:34}
			zeroGIFBmdData[5513]=zeroGIFBmdData[5514]=zeroGIFBmdData[5515]=0xcc;//{x:18,y:34}
			zeroGIFBmdData[5517]=zeroGIFBmdData[5518]=zeroGIFBmdData[5519]=0x00;//{x:19,y:34}
			zeroGIFBmdData[5521]=zeroGIFBmdData[5522]=zeroGIFBmdData[5523]=0x00;//{x:20,y:34}
			zeroGIFBmdData[5525]=zeroGIFBmdData[5526]=zeroGIFBmdData[5527]=0x00;//{x:21,y:34}
			zeroGIFBmdData[5529]=zeroGIFBmdData[5530]=zeroGIFBmdData[5531]=0x00;//{x:22,y:34}
			zeroGIFBmdData[5533]=zeroGIFBmdData[5534]=zeroGIFBmdData[5535]=0x00;//{x:23,y:34}
			zeroGIFBmdData[5537]=zeroGIFBmdData[5538]=zeroGIFBmdData[5539]=0x00;//{x:24,y:34}
			zeroGIFBmdData[5541]=zeroGIFBmdData[5542]=zeroGIFBmdData[5543]=0x00;//{x:25,y:34}
			zeroGIFBmdData[5545]=zeroGIFBmdData[5546]=zeroGIFBmdData[5547]=0x00;//{x:26,y:34}
			zeroGIFBmdData[5549]=zeroGIFBmdData[5550]=zeroGIFBmdData[5551]=0x00;//{x:27,y:34}
			zeroGIFBmdData[5553]=zeroGIFBmdData[5554]=zeroGIFBmdData[5555]=0x00;//{x:28,y:34}
			zeroGIFBmdData[5557]=zeroGIFBmdData[5558]=zeroGIFBmdData[5559]=0x00;//{x:29,y:34}
			zeroGIFBmdData[5561]=zeroGIFBmdData[5562]=zeroGIFBmdData[5563]=0x00;//{x:30,y:34}
			zeroGIFBmdData[5565]=zeroGIFBmdData[5566]=zeroGIFBmdData[5567]=0xcc;//{x:31,y:34}
			zeroGIFBmdData[5569]=zeroGIFBmdData[5570]=zeroGIFBmdData[5571]=0x99;//{x:32,y:34}
			zeroGIFBmdData[5573]=zeroGIFBmdData[5574]=zeroGIFBmdData[5575]=0x33;//{x:33,y:34}
			zeroGIFBmdData[5577]=zeroGIFBmdData[5578]=zeroGIFBmdData[5579]=0x66;//{x:34,y:34}
			zeroGIFBmdData[5581]=zeroGIFBmdData[5582]=zeroGIFBmdData[5583]=0x00;//{x:35,y:34}
			
			zeroGIFBmdData[5633]=zeroGIFBmdData[5634]=zeroGIFBmdData[5635]=0xcc;//{x:8,y:35}
			zeroGIFBmdData[5637]=zeroGIFBmdData[5638]=zeroGIFBmdData[5639]=0x00;//{x:9,y:35}
			zeroGIFBmdData[5641]=zeroGIFBmdData[5642]=zeroGIFBmdData[5643]=0x00;//{x:10,y:35}
			zeroGIFBmdData[5645]=zeroGIFBmdData[5646]=zeroGIFBmdData[5647]=0x00;//{x:11,y:35}
			zeroGIFBmdData[5649]=zeroGIFBmdData[5650]=zeroGIFBmdData[5651]=0x00;//{x:12,y:35}
			zeroGIFBmdData[5653]=zeroGIFBmdData[5654]=zeroGIFBmdData[5655]=0x66;//{x:13,y:35}
			zeroGIFBmdData[5657]=zeroGIFBmdData[5658]=zeroGIFBmdData[5659]=0xcc;//{x:14,y:35}
			zeroGIFBmdData[5661]=zeroGIFBmdData[5662]=zeroGIFBmdData[5663]=0x00;//{x:15,y:35}
			zeroGIFBmdData[5665]=zeroGIFBmdData[5666]=zeroGIFBmdData[5667]=0x00;//{x:16,y:35}
			zeroGIFBmdData[5669]=zeroGIFBmdData[5670]=zeroGIFBmdData[5671]=0xcc;//{x:17,y:35}
			zeroGIFBmdData[5673]=zeroGIFBmdData[5674]=zeroGIFBmdData[5675]=0xcc;//{x:18,y:35}
			zeroGIFBmdData[5677]=zeroGIFBmdData[5678]=zeroGIFBmdData[5679]=0x00;//{x:19,y:35}
			zeroGIFBmdData[5681]=zeroGIFBmdData[5682]=zeroGIFBmdData[5683]=0x00;//{x:20,y:35}
			zeroGIFBmdData[5685]=zeroGIFBmdData[5686]=zeroGIFBmdData[5687]=0x00;//{x:21,y:35}
			zeroGIFBmdData[5689]=zeroGIFBmdData[5690]=zeroGIFBmdData[5691]=0x00;//{x:22,y:35}
			zeroGIFBmdData[5693]=zeroGIFBmdData[5694]=zeroGIFBmdData[5695]=0x00;//{x:23,y:35}
			zeroGIFBmdData[5697]=zeroGIFBmdData[5698]=zeroGIFBmdData[5699]=0x00;//{x:24,y:35}
			zeroGIFBmdData[5701]=zeroGIFBmdData[5702]=zeroGIFBmdData[5703]=0x00;//{x:25,y:35}
			zeroGIFBmdData[5705]=zeroGIFBmdData[5706]=zeroGIFBmdData[5707]=0x00;//{x:26,y:35}
			zeroGIFBmdData[5709]=zeroGIFBmdData[5710]=zeroGIFBmdData[5711]=0x00;//{x:27,y:35}
			zeroGIFBmdData[5713]=zeroGIFBmdData[5714]=zeroGIFBmdData[5715]=0x00;//{x:28,y:35}
			zeroGIFBmdData[5717]=zeroGIFBmdData[5718]=zeroGIFBmdData[5719]=0x33;//{x:29,y:35}
			zeroGIFBmdData[5729]=zeroGIFBmdData[5730]=zeroGIFBmdData[5731]=0x33;//{x:32,y:35}
			zeroGIFBmdData[5733]=zeroGIFBmdData[5734]=zeroGIFBmdData[5735]=0x33;//{x:33,y:35}
			zeroGIFBmdData[5737]=zeroGIFBmdData[5738]=zeroGIFBmdData[5739]=0x33;//{x:34,y:35}
			zeroGIFBmdData[5741]=zeroGIFBmdData[5742]=zeroGIFBmdData[5743]=0x33;//{x:35,y:35}
			zeroGIFBmdData[5745]=zeroGIFBmdData[5746]=zeroGIFBmdData[5747]=0x66;//{x:36,y:35}
			
			zeroGIFBmdData[5805]=zeroGIFBmdData[5806]=zeroGIFBmdData[5807]=0x99;//{x:11,y:36}
			zeroGIFBmdData[5817]=zeroGIFBmdData[5818]=zeroGIFBmdData[5819]=0xcc;//{x:14,y:36}
			zeroGIFBmdData[5821]=zeroGIFBmdData[5822]=zeroGIFBmdData[5823]=0x00;//{x:15,y:36}
			zeroGIFBmdData[5825]=zeroGIFBmdData[5826]=zeroGIFBmdData[5827]=0x66;//{x:16,y:36}
			zeroGIFBmdData[5833]=zeroGIFBmdData[5834]=zeroGIFBmdData[5835]=0x66;//{x:18,y:36}
			zeroGIFBmdData[5837]=zeroGIFBmdData[5838]=zeroGIFBmdData[5839]=0x00;//{x:19,y:36}
			zeroGIFBmdData[5841]=zeroGIFBmdData[5842]=zeroGIFBmdData[5843]=0x00;//{x:20,y:36}
			zeroGIFBmdData[5845]=zeroGIFBmdData[5846]=zeroGIFBmdData[5847]=0x00;//{x:21,y:36}
			zeroGIFBmdData[5849]=zeroGIFBmdData[5850]=zeroGIFBmdData[5851]=0x00;//{x:22,y:36}
			zeroGIFBmdData[5853]=zeroGIFBmdData[5854]=zeroGIFBmdData[5855]=0x00;//{x:23,y:36}
			zeroGIFBmdData[5857]=zeroGIFBmdData[5858]=zeroGIFBmdData[5859]=0x00;//{x:24,y:36}
			zeroGIFBmdData[5861]=zeroGIFBmdData[5862]=zeroGIFBmdData[5863]=0x00;//{x:25,y:36}
			zeroGIFBmdData[5865]=zeroGIFBmdData[5866]=zeroGIFBmdData[5867]=0x00;//{x:26,y:36}
			zeroGIFBmdData[5869]=zeroGIFBmdData[5870]=zeroGIFBmdData[5871]=0x00;//{x:27,y:36}
			zeroGIFBmdData[5873]=zeroGIFBmdData[5874]=zeroGIFBmdData[5875]=0x66;//{x:28,y:36}
			
			zeroGIFBmdData[5981]=zeroGIFBmdData[5982]=zeroGIFBmdData[5983]=0x66;//{x:15,y:37}
			zeroGIFBmdData[5985]=zeroGIFBmdData[5986]=zeroGIFBmdData[5987]=0x33;//{x:16,y:37}
			zeroGIFBmdData[5989]=zeroGIFBmdData[5990]=zeroGIFBmdData[5991]=0x00;//{x:17,y:37}
			zeroGIFBmdData[5993]=zeroGIFBmdData[5994]=zeroGIFBmdData[5995]=0x00;//{x:18,y:37}
			zeroGIFBmdData[5997]=zeroGIFBmdData[5998]=zeroGIFBmdData[5999]=0x66;//{x:19,y:37}
			zeroGIFBmdData[6001]=zeroGIFBmdData[6002]=zeroGIFBmdData[6003]=0x99;//{x:20,y:37}
			zeroGIFBmdData[6005]=zeroGIFBmdData[6006]=zeroGIFBmdData[6007]=0x00;//{x:21,y:37}
			zeroGIFBmdData[6009]=zeroGIFBmdData[6010]=zeroGIFBmdData[6011]=0x00;//{x:22,y:37}
			zeroGIFBmdData[6013]=zeroGIFBmdData[6014]=zeroGIFBmdData[6015]=0x00;//{x:23,y:37}
			zeroGIFBmdData[6017]=zeroGIFBmdData[6018]=zeroGIFBmdData[6019]=0x00;//{x:24,y:37}
			zeroGIFBmdData[6021]=zeroGIFBmdData[6022]=zeroGIFBmdData[6023]=0x00;//{x:25,y:37}
			zeroGIFBmdData[6025]=zeroGIFBmdData[6026]=zeroGIFBmdData[6027]=0x33;//{x:26,y:37}
			zeroGIFBmdData[6029]=zeroGIFBmdData[6030]=zeroGIFBmdData[6031]=0xcc;//{x:27,y:37}
			
			zeroGIFBmdData[6153]=zeroGIFBmdData[6154]=zeroGIFBmdData[6155]=0x99;//{x:18,y:38}
			zeroGIFBmdData[6161]=zeroGIFBmdData[6162]=zeroGIFBmdData[6163]=0xcc;//{x:20,y:38}
			zeroGIFBmdData[6165]=zeroGIFBmdData[6166]=zeroGIFBmdData[6167]=0x00;//{x:21,y:38}
			zeroGIFBmdData[6169]=zeroGIFBmdData[6170]=zeroGIFBmdData[6171]=0x00;//{x:22,y:38}
			zeroGIFBmdData[6173]=zeroGIFBmdData[6174]=zeroGIFBmdData[6175]=0x66;//{x:23,y:38}
			
			zeroGIFBmdData[6321]=zeroGIFBmdData[6322]=zeroGIFBmdData[6323]=0x33;//{x:20,y:39}
			zeroGIFBmdData[6325]=zeroGIFBmdData[6326]=zeroGIFBmdData[6327]=0x00;//{x:21,y:39}
			zeroGIFBmdData[6329]=zeroGIFBmdData[6330]=zeroGIFBmdData[6331]=0x00;//{x:22,y:39}
			
			zeroGIFBmdData.position=0;
			zeroGIFBmd.setPixels(zeroGIFBmd.rect,zeroGIFBmdData);
			
			return zeroGIFBmd;
		}();
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