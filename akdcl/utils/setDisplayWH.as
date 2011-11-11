package akdcl.utils {

	/**
	 * ...
	 * @author Akdcl
	 */

	public function setDisplayWH(_display:*, _width:uint=0, _height:uint=0, _wK:String = null, _hK:String = null):void {
		var _wOrg:Number = _wK ? _display[_wK] : _display.width;
		var _hOrg:Number = _hK ? _display[_hK] : _display.height;
		var _aspectRatioOrg:Number = _wOrg / _hOrg;
		var _aspectRatio:Number = _width / _height;
		if (_width * _height > 0 ? (_aspectRatio < _aspectRatioOrg) : (_width > 0)){
			if (_wK){
				_display[_wK] = _width <= 1 ? _wOrg * _width : _width;
				_display[_hK] = _display[_wK] / _aspectRatioOrg;
			} else {
				_display.width = _width <= 1 ? _wOrg * _width : _width;
				_display.scaleY = _display.scaleX;
				_display.height = Math.round(_display.height);
			}
		} else {
			if (_hK){
				_display[_hK] = _height <= 1 ? _hOrg * _height : _height;
				_display[_wK] = _display[_hK] * _aspectRatioOrg;
			} else {
				_display.height = _height <= 1 ? _hOrg * _height : _height;
				_display.scaleX = _display.scaleY;
				_display.width = Math.round(_display.width);
			}
		}
	}
}