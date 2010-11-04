package ui.manager
{
	import fl.managers.StyleManager;
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	
	import fl.controls.listClasses.CellRenderer;
	
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import flash.text.TextFormat;
	
	
	/**
	 * ...
	 * @author Akdcl
	 */
	final public class FLManager
	{
		private static var textFormat:TextFormat = new TextFormat();
		public static function setTextFormat(_size:uint, _color:uint = 0x000000, _font:String = "宋体"):void {
			textFormat.font=_font;
			textFormat.size=_size;
			textFormat.color=_color;
			StyleManager.setComponentStyle(Button,"textFormat",textFormat);
			StyleManager.setComponentStyle(ComboBox,"textFormat",textFormat);
			StyleManager.setComponentStyle(Label, "textFormat", textFormat);
			
			StyleManager.setComponentStyle(CellRenderer, "textFormat", textFormat);
			
			StyleManager.setComponentStyle(TextArea,"textFormat",textFormat);
			StyleManager.setComponentStyle(TextInput,"textFormat",textFormat);
		}
	}
	
}