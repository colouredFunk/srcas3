	public function getCorners(x:Number, y:Number):Boolean {
		var dx:Number = Math.floor(x/Tile.W);
		var dy:Number = Math.floor(y/Tile.H);
		if (game["t_"+dy+"_"+dx].walkable) {
			return true;
		} else {
			gethitdir(dx,dy);
			return false;
		}
	}
	public function gethitdir(x:Number, y:Number):Void {
		x = x*Tile.W;
		y = y*Tile.H;
		var bx:Number = Msf.dnum(speed.x);
		var by:Number = Msf.dnum(speed.y);
		if (bx != 0) {
			var tx:Number = x+(bx<0)*Tile.W;
			var dy:Number = speed.y/speed.x*(tx-curr.x)+curr.y-y;
			if (dy>0 && dy<Tile.H) {
				hitdir.x = bx;
			} else {
				hitdir.x = 0;
			}
		} else {
			hitdir.x = 0;
		}
		if (by != 0) {
			var ty:Number = y+(by<0)*Tile.H;
			var dx:Number = speed.x/speed.y*(ty-curr.y)+curr.x-x;
			if (dx>0 && dx<Tile.W) {
				hitdir.y = by;
			} else {
				hitdir.y = 0;
			}
		} else {
			hitdir.y = 0;
		}
	}
	public function isHitGround():Boolean {
		if (getCorners(curr.x+speed.x, curr.y+speed.y)) {
			curr.x += speed.x;
			curr.y += speed.y;
			return false;
		} else {
			if (hitdir.x != 0) {
				var xold:Number = curr.x;
				if (hitdir.x>0) {
					curr.x = Math.ceil(curr.x/Tile.W)*Tile.W;
				} else {
					curr.x = Math.floor(curr.x/Tile.W)*Tile.W;
				}
				curr.y += (curr.x-xold)/speed.x*speed.y;
			} else {
				var yold:Number = curr.y;
				if (hitdir.y>0) {
					curr.y = Math.ceil(curr.y/Tile.H)*Tile.H;
				} else {
					curr.y = Math.floor(curr.y/Tile.H)*Tile.H;
				}
				curr.x += (curr.y-yold)/speed.y*speed.x;
			}
			onHitGround();
			return true;
		}
	}