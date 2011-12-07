package akdcl.layout {
	import flash.display.DisplayObject;
	import flash.display.Loader;

	/**
	 * ...
	 * @author ...
	 */
	public class DisplayProxy extends Rect {
		private var content:Object;

		private var aspectRatio:Number = 1;
		private var originalWidth:Number = 0;
		private var originalHeight:Number = 0;
		private var scaleX:Number = 0;
		private var scaleY:Number = 0;
		private var scaleWidth:Number = 0;
		private var scaleHeight:Number = 0;

		private var __scrollX:Number = 0;

		public function get scrollX():Number {
			return __scrollX;
		}

		public function set scrollX(_value:Number):void {
			if (_value < -scaleWidth){
				_value = -scaleWidth;
			} else if (_value > __width){
				_value = __width;
			}
			if (__width <= scaleWidth){
				if (_value < __width - scaleWidth){
					_value = (_value + __width - scaleWidth) * 0.5;
				} else if (_value < 0){
					_value = _value;
				} else {
					_value = _value * 0.5;
				}
			} else {
				if (_value < 0){
					_value = _value * 0.5;
				} else if (_value < __width - scaleWidth){
					_value = _value;
				} else {
					_value = (_value + __width - scaleWidth) * 0.5;
				}
			}
			__alignX = _value / (__width - scaleWidth);
			__scrollX = _value;
			if (autoUpdate) {
				updatePoint(true);
			}
		}

		private var __scrollY:Number = 0;

		public function get scrollY():Number {
			return __scrollY;
		}

		public function set scrollY(_value:Number):void {
			if (_value < -scaleHeight){
				_value = -scaleHeight;
			} else if (_value > __height){
				_value = __height;
			}
			if (__height <= scaleHeight){
				if (_value < __height - scaleHeight){
					_value = (_value + __height - scaleHeight) * 0.5;
				} else if (_value < 0){
					_value = _value;
				} else {
					_value = _value * 0.5;
				}
			} else {
				if (_value < 0){
					_value = _value * 0.5;
				} else if (_value < __height - scaleHeight){
					_value = _value;
				} else {
					_value = (_value + __height - scaleHeight) * 0.5;
				}
			}
			__alignY = _value / (__height - scaleHeight);
			__scrollY = _value;
			if (autoUpdate) {
				updatePoint(true);
			}
		}

		//alignX,alignY 0~1
		private var __alignX:Number = 0;

		public function get alignX():Number {
			return __alignX;
		}

		public function set alignX(_value:Number):void {
			if (__alignX == _value){
				return;
			}
			__alignX = _value;
			__scrollX = (__width - scaleWidth) * __alignX;
			if (autoUpdate) {
				updatePoint(true);
			}
		}

		private var __alignY:Number = 0;

		public function get alignY():Number {
			return __alignY;
		}

		public function set alignY(_value:Number):void {
			if (__alignY == _value){
				return;
			}
			__alignY = _value;
			__scrollY = (__height - scaleHeight) * __alignY;
			if (autoUpdate) {
				updatePoint(true);
			}
		}

		//-1:outside,0:noscale,1:inside;
		//>1||<-1:scale
		//NaN:stretch,10:onlywidth,-10:onlyheight;
		private var __scaleMode:Number = 1;

		public function get scaleMode():Number {
			return __scaleMode;
		}

		public function set scaleMode(_value:Number):void {
			if (__scaleMode == _value){
				return;
			}
			__scaleMode = _value;
			if (autoUpdate) {
				updateSize(true);
			}
		}

		public function DisplayProxy(_x:Number, _y:Number, _width:Number, _height:Number, _alignX:Number = 0, _alignY:Number = 0, _scaleMode:Number = 1):void {
			__alignX = _alignX;
			__alignY = _alignY;
			__scaleMode = _scaleMode;
			super(_x, _y, _width, _height);
		}

		override public function remove():void {
			super.remove();
			content = null;
		}

		override protected function updatePoint(_dispathEvent:Boolean = true):void {
			if (content){
				content.x = __x + __scrollX;
				content.y = __y + __scrollY;
			}
			super.updatePoint(_dispathEvent);
		}

		override protected function updateSize(_dispathEvent:Boolean = true):void {
			var _scaleABS:Number = Math.abs(__scaleMode);
			switch (_scaleABS){
				case NaN:
					scaleX = __width / originalWidth;
					scaleY = __height / originalHeight;

					scaleWidth = __width;
					scaleHeight = __height;
					break;
				case 10:
					if (__scaleMode > 0){
						scaleX = __width / originalWidth;

						scaleWidth = __width;
							//scaleHeight = originalHeight;
					} else {
						scaleY = __height / originalHeight;

						scaleHeight = __height;
							//scaleWidth = originalWidth;
					}
					break;
				default:
					var _scale:Number;
					if (__scaleMode < 0 ? (__width / __height > aspectRatio) : (__width / __height < aspectRatio)){
						_scale = __width / originalWidth;
						scaleWidth = __width;
					} else {
						_scale = __height / originalHeight;
					}
					if (_scaleABS <= 1){
						_scale = 1 + (_scale - 1) * _scaleABS;
					} else {
						_scale = (1 + (_scale - 1)) * _scaleABS;
					}
					scaleY = scaleX = _scale;

					scaleWidth = originalWidth * scaleX;
					scaleHeight = originalHeight * scaleY;
					break;
			}

			if (content){
				if ("scaleX" in content){
					content["scaleX"] = scaleX;
				} else {
					content.width = scaleWidth;
				}
				if ("scaleY" in content){
					content["scaleY"] = scaleY;
				} else {
					content.height = scaleHeight;
				}
			}

			__scrollX = (__width - scaleWidth) * __alignX;
			__scrollY = (__height - scaleHeight) * __alignY;
			updatePoint(true);
			super.updateSize(_dispathEvent);
		}

		public function setContent(_content:Object, _alignX:Number = 0.5, _alignY:Number = 0.5, _scaleMode:Number = 1):void {
			__alignX = _alignX;
			__alignY = _alignY;
			__scaleMode = _scaleMode;

			content = _content;
			if (content is Loader){
				originalWidth = content.contentLoaderInfo.width;
				originalHeight = content.contentLoaderInfo.height;
			} else if (content is DisplayObject){
				originalWidth = content.width / content.scaleX;
				originalHeight = content.height / content.scaleY;
			} else {
				originalWidth = 0;
				originalHeight = 0;
			}
			aspectRatio = originalWidth / originalHeight;
			updateSize(true);
		}
	}
}