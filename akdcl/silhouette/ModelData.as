package game.model
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Akdcl
	 */
		
	[Embed(source="../../source/xml/models.xml", mimeType="application/octet-stream")]
	public class ModelData extends ByteArray {
		public static var data:XML;
		public function ModelData() {
			data = new XML(readUTFBytes(length));
		}
	}
}