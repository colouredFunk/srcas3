package akdcl.net.action
{
	import akdcl.net.action.Field;
	
	import fl.controls.ComboBox;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ComboxField extends Field 
	{
		//>=0(selectedIndex),String(custom)
		override public function get data():* 
		{
			if (view.selectedItem){
				__data = view.selectedIndex;
			} else if (view.editable){
				if (stringToBoolean(view.text) && view.text != view.prompt){
					__data = view.text;
				}else {
					__data = VALUE_UNINPUT;
				}
			}else {
				__data = VALUE_UNSELECT;
			}
			return __data;
		}
		
		override public function setView():void 
		{
			super.setView();
			
			if (view){

			} else {
				view = new ComboBox();
			}
			view.removeAll();
			view.rowCount = int(_options.attribute(A_ROW_COUNT)) || view.rowCount;
			view.prompt = options.attribute(A_PROMPT)[0] || "请选择";
			for each (var _eachXML:XML in options.elements(RemoteAction.E_CASE)) {
				view.addItem( { label: _eachXML.attribute(RemoteAction.A_LABEL) } );
			}
		}
	}
	
}