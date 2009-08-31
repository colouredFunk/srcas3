package{
	import easybox2d.EasyBox2D;
	import ui_2.Slider;
	
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	import flash.events.Event;

	[SWF(width="900",height="500",frameRate="30")]
	public class TestApp extends MovieClip{
		private var easyBox:EasyBox2D;
		public var player:*;
		public var ball_0:*;
		public var ball_1:*;
		public function TestApp(){
			easyBox=new EasyBox2D(this);
			//easyBox.debugClip.mouseEnabled=false;
			//easyBox.debugClip.mouseChildren=false;
			createWall();
			createChildren();
		}
		private var wS:uint=900;
		private var hS:uint=500;
		public function createWall():void{
			//建立边框
			// Left
			easyBox.register(null,{x:-50+10,y:hS*0.5,width:100,height:hS+100});
			// Right
			easyBox.register(null,{x:wS+50-10,y:hS*0.5,width:100,height:hS+100});
			// Top
			easyBox.register(null,{x:wS*0.5,y:-50+10,width:wS+100,height:100});
			// Bottom
			easyBox.register(null,{x:wS*0.5,y:hS+50-10,width:wS+100,height:100});
		}
		protected function createChildren():void{
			var body:*;
			var prevBody:*;
			var bd:* = easyBox.createBodyDef();
			var cd:* = easyBox.createCircleDef();
			
			bd.position.Set(5,5);
			cd.radius = 5/3;
			cd.density = 1;
			body= easyBox.createBody(bd);
			body.CreateShape(cd);
			easyBox.register(player,body);
			prevBody=body;
			
			bd.position.Set(7.1,5);
			cd.radius = 0.4;
			cd.density = 5;
			body= easyBox.createBody(bd);
			body.CreateShape(cd);
			easyBox.register(ball_0,body);
			
			easyBox.createDistanceJoint(prevBody, body);
			
			body= easyBox.createBody(bd);
			body.CreateShape(cd);
			easyBox.register(ball_1,body);
			
			easyBox.createDistanceJoint(prevBody, body);
			/*var cd2:* = easyBox.CreateCircleDef();
			cd2.radius = 0.4;
			cd2.localPosition.Set(2.1, 0);
			*/
			
			//var cd1_:*=body.CreateShape(cd2);
			//var cd2_:*=body.CreateShape(cd2);
			//player.btn_vol.thumb.obTemp={shape0:cd2,body:body,shape:cd1_};
			//player.btn_progress.thumb.obTemp={shape0:cd2,body:body,shape:cd2_};
			//player.btn_vol.addEventListener(Slider.RELEASE,circleMove);
			//player.btn_progress.addEventListener(Slider.RELEASE,circleMove);
			
			
			
			//Common.urlLoader("xml/images.xml",xmlLoaded);
		}
		private function circleMove(_evt:Event):void{
			var _clip:*=_evt.target.thumb;
			_clip.obTemp.shape0.localPosition.Set(_clip.x*EasyBox2D.physToPixel,_clip.y*EasyBox2D.physToPixel);
			_clip.obTemp.body.DestroyShape(_clip.obTemp.shape);
			_clip.obTemp.shape=_clip.obTemp.body.CreateShape(_clip.obTemp.shape0);
		}
		private function xmlLoaded(_evt:Event):void{
			var _xml:XML=new XML(_evt.currentTarget.data);
			for each(var _e:* in _xml.images){
				Common.loader(_e.@image,imagesLoaded);
			}
		}
		private function imagesLoaded(_evt:Event):void{
			var _bmp:Bitmap=_evt.currentTarget.content as Bitmap;
			_bmp.x=-_bmp.width*0.5;
			_bmp.y=-_bmp.height*0.5;
			var _frame:*=new frame_0();
			_frame.clip.width=_bmp.width+10;
			_frame.clip.height=_bmp.height+10;
			_frame.clip.x=-_frame.clip.width*0.5;
			_frame.clip.y=-_frame.clip.height*0.5;
			_frame.addChild(_bmp);
			addChild(_frame);
			easyBox.register(_frame,{x:Common.random(800)+100,y:Common.random(400)+100,type:EasyBox2D.BOX,density:1.0,friction:0.4,restitution:0.3});
		}
	}
}