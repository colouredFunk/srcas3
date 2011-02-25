package ui.manager {
	import fl.managers.StyleManager;

	import fl.controls.listClasses.CellRenderer;
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.controls.RadioButton;
	import fl.controls.TextArea;
	import fl.controls.TextInput;

	import flash.text.TextFormat;

	/**
	 * ...
	 * @author Akdcl
	 */
	final public class FLManager {
		private static const TEXT_FORMAT:String = "textFormat";
		private static var textFormat:TextFormat = new TextFormat();

		public static function setTextFormat(_size:uint, _color:uint = 0x000000, _font:String = "宋体"):void {
			textFormat.font = _font;
			textFormat.size = _size;
			textFormat.color = _color;

			StyleManager.setComponentStyle(CellRenderer, TEXT_FORMAT, textFormat);
			
			StyleManager.setComponentStyle(Button, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(CheckBox, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(ComboBox, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(Label, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(RadioButton, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(TextArea, TEXT_FORMAT, textFormat);
			StyleManager.setComponentStyle(TextInput, TEXT_FORMAT, textFormat);
		}
	}

}