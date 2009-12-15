package cn.ronme.display 
{
	/**
	 * ...
	 * @author Ron Tian
	 */
	public class RonStageParams
	{
		public var align:String;
		public var scaleMode:String;
		public var showDefaultMenu:Boolean;
		public function RonStageParams(align:String="TL",scaleMode:String="noScale",showDefaultMenu:Boolean=false) 
		{
			this.align = align;
			this.scaleMode = scaleMode;
			this.showDefaultMenu = showDefaultMenu;
		}
		
	}

}