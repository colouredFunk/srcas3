package akdcl.net	{
	import flash.utils.ByteArray;
	
	public class FormVariables {
		private var variables:Object;
		private var _boundary:String;
		
		public function get length():int {
			var count:int = 0;
			for (var name:String in this.variables)
				count ++;
			return count;
		}
		
		public function get boundary():String {
			return "----------------------------7m" + this._boundary;	
		}
		
		public function get contentType():String {
			return "multipart/form-data; boundary=" + this.boundary;	
		}
		
		public function get data():ByteArray {
			var result:ByteArray = new ByteArray();
			var filename:String;
			
			if (this.length > 0) {
				for (var name:String in this.variables) {
					result.writeUTFBytes("--" + this.boundary + "\r\n");
					if (this.variables[name] is ByteArray) {
						filename = createRandomKey(8);
						result.writeUTFBytes("Content-Disposition: form-data; name=\"" + name + "\"; filename=\"\\" + filename + ".jpg\"\r\n");
						result.writeUTFBytes("Content-Type: application/octet-stream\r\n\r\n");
						result.writeBytes(this.variables[name]);
					} else {
						result.writeUTFBytes("Content-Disposition: form-data; name=\"" + name + "\"\r\n\r\n");
						result.writeUTFBytes(this.variables[name]);
					}
					result.writeUTFBytes("\r\n");
				}
				result.writeUTFBytes("--" + this.boundary + "--\r\n");
			}
			return result;
		}
		public function get dataGBK():ByteArray {
			var result:ByteArray = new ByteArray();
			var filename:String;
			
			if (this.length > 0) {
				for (var name:String in this.variables) {
					result.writeUTFBytes("--" + this.boundary + "\r\n");
					if (this.variables[name] is ByteArray) {
						filename = createRandomKey(8);
						result.writeMultiByte("Content-Disposition: form-data; name=\"" + name + "\"; filename=\"\\" + filename + ".jpg\"\r\n", 'gbk');
						result.writeUTFBytes("Content-Type: application/octet-stream\r\n\r\n");
						result.writeBytes(this.variables[name]);
					} else {
						result.writeMultiByte("Content-Disposition: form-data; name=\"" + name + "\"\r\n\r\n",'gbk');
						result.writeMultiByte(this.variables[name],'gbk');
					}
					result.writeUTFBytes("\r\n");
				}
				result.writeUTFBytes("--" + this.boundary + "--\r\n");
			}
			return result;
		}
		public function FormVariables(variables:Object = null) {
			if (variables)
				this.variables = variables;
			else
				this.variables = {};
			
			this._boundary = createBoundary();
		}
		
		public function decode(data:String):String {
			if (!data) return data;
			var urlInfo:Array = data.split("?");
			var url:String = urlInfo[0];
			
			if (urlInfo[1]) {
				var params:Array = urlInfo[1].split("&");
				for (var i:int = 0; i < params.length; i ++) {
					var param:Array = params[i].split("=");
					add(param[0], param[1]);
				}
			}
			
			return url;
		}
		
		public function add(name:String, value:*):void {
			if(!value){
				return;
			}
			if (typeof value == "string" || value is ByteArray)
				this.variables[name] = value;
			else
				this.variables[name] = value.toString();
		}
		
		public function addFile(name:String, value:*, charset:String = "UTF-8"):void {
			if (value is ByteArray) {
				this.add(name, value);
			} else {
				var fileBytes:ByteArray = new ByteArray();
				if (value is XML) {
					fileBytes.writeMultiByte("<?xml version=\"1.0\" encoding=\"" + charset.toUpperCase() + "\"?>\n", charset.toLowerCase());
					fileBytes.writeMultiByte(value.toString(), charset.toLowerCase());
				} else if (typeof value == "string") {
					fileBytes.writeMultiByte(value, charset.toLowerCase());
				} else {
					fileBytes.writeMultiByte(value.toString(), charset.toLowerCase());
				}
				this.add(name, fileBytes);
			}
		}
		
		public function remove(name:String):void {
			delete this.variables[name];
		}
		
		public function replace(name:String, value:*):void {
			add(name, value);
		}
		
		private function createBoundary():String {
			return createRandomKey(11);	
		}
		
		private function createRandomKey(length:int):String {
			var result:String = "";
			for (var i:int = 0; i < length; i ++)
				result += hex(randomInt(0, 15));
			return result;
		}
		private function randomInt(min:int, max:int):int {
			var result:int = Math.round(Math.random() * (max - min)) + min;
			if (result < min)
				result = min;
			if (result > max)
				result = max;
			return result;
		}
		
		private function hex(number:int):String {
			if (number < 10)
				return String(number);
			else
				return String.fromCharCode(String("a").charCodeAt() + number - 10);
		}
	}
}