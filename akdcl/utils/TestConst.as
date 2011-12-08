package akdcl.utils{
	
	/**
	 * ...
	 * @author akdcl
	 */
	final public class TestConst {
		public static const TEST_IMAGES:Array = [
			"http://b33.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/539OF3JKbgbwZZLemCHb9T.3Ly6oI4M32zv3F9i1Yxo!/b/YXZHTxpTBgAAYkIZthNivQAAbw5mOxpMBgAA&a=44&b=33&o=44",
			"http://b43.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/3JHlVz23Mi8Dad9iGwQYvCHBgg*7NT1r65QzPjdYCAY!/b/YaGk3RdslgAAYkhYpBlGLgAAb2OrJBb.lQAA&a=40&b=43&o=37",
			"http://b43.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/.Svp8tc8xRrgXJHf9ydlnmIpajR4XQQx0bAk8JRh49M!/b/YRpE5RcSlgAAYtnrqBmWKgAAb6gVRhqLBgAA&a=40&b=43&o=44",
			"http://b37.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/dOZL2xB0qe9mHPPliBvV7U.JGHcgGF*zk*VYqJWews0!/b/YTY9vxPuuwAAYi*ZEBbvjQAAb1jSxgrAGgAA&a=33&b=37&o=18",
			"http://b40.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/W.BOcf1YqrDNwIFjKEmSapL9Pm0u19a8PyS563ZGk3c!/b/YTj7zwpjCwAAYreu4BeJjwAAb2xHxQoBDAAA&a=18&b=40&o=18",
			"http://b40.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/tk4AMkxuT1q3bOhw0OgGsC7aFNop0lpCIWwVD*eCeGM!/b/YbXEwwogEgAAYlgu3xf0YgAAb*gNRxT1LwAA&a=18&b=40&o=34",
			"http://b44.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/xQrJQaIY8pKY3slUuZhPT58T8cd7n3Tb6c0C4pGMUFU!/b/YcQ9Txp7BgAAYoSkRxo2BgAAb3EPQxogBgAA",
			"http://b40.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/D2FKgLUr7MBvdmSo26oCDlTTzJ9fryOa6eDjq6VnlbM!/b/YShL5RfYeQAAYo2m3ReMDAAAbxt1rhNqOAAA",
			"http://b44.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/9BCmAONvh6fHMPiRCWYUt*HJdKeCVzEqFa0rQ2jOQrM!/b/YXua2hcilgAAYpf5PxqBBgAAb9TpzArGGgAA&a=40&b=44&o=18",
			"http://b43.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/JOTyrknGCKwiAtqnX*K53OsQmv41sEE0a8dEayauIUE!/b/YWpc6xfZhQAAYuKbsxk5QgAAb1CcsxktQwAA&a=40&b=43&o=43",
			"http://b43.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/edyzyzIWmIjcaUqWej6RLq9Dtb3xAn5iilxAfGE19Mc!/b/YaLSohk5QgAAYtgftRk4QgAAb4lUEhY2hgAA",
			"http://b18.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/Ig.lmTHg1Bqk2t9NSyzqw2LKL6mIAjLkjlaZ2MzLIq8!/b/YYBF5ReAhgAAYnrayQrJGgAAbxOZRBoxBgAA&a=40&b=18&o=44",
			"http://b37.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/4gB0EQeu8yctlPv.gXM*7pcnDi3JGpmYwqfYPFnmNx8!/b/YfZepBmXQwAAYoDVEBYOhQAAbzz3qxncQwAA&a=43&b=37&o=43",
			"http://b43.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/xa96UglmaIjVYTg.Fr5tfi0Q30UlK687xlv*Vzb1u*U!/b/YTKcIRaxhAAAYlKnthnWMAAAby4k3BdOhAAA&a=37&b=43&o=40",
			"http://b40.photo.store.qq.com/psu?/4a564f59-c54b-43b7-8a66-dc1ddd092a94/GOz0b7By1QNZ7wDYXWLXtRt99BMDo9PEQ3ziEqqQ9.Y!/b/Ya1H5ReJhgAAYhri7BdkhQAAb.cUshkyQwAA"
		];
		public static function getImage(_id:int = -1):String {
			if (_id<0) {
				_id = int(Math.random() * TEST_IMAGES.length);
			}
			return TEST_IMAGES[_id];
		}
	}
}