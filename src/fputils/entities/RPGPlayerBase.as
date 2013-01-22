package fputils.entities 
{
	import flash.geom.Point;
	import fputils.constants.Moves;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class RPGPlayerBase extends Entity 
	{		
		protected var _gridWidth:Number;
		protected var _gridHeight:Number;
		
		// if spritemap
		public var playerSpritemap:Spritemap;
		
		// Helper variables
		public var curAnimation:String = Moves.STAND_DOWN;
		public var angle:Number;
		
		// Speed
		public var speed:Number;
		
		// Velocity
		protected var _vel:Point ;
		
		
		public function RPGPlayerBase(x:Number=0, y:Number=0, angle:Number = 0, speed:Number = 250, gridWidth:Number=32, gridHeight:Number=32) 
		{
			_gridWidth = gridWidth;
			_gridHeight = gridHeight;
			
			this.angle = angle;
			this.speed = speed;
			
			this.x = x;
			this.y = y;
			_vel = new Point();
			
			// Keys setup
			Input.define(Moves.WALK_DOWN, Key.DOWN, Key.S);
			Input.define(Moves.WALK_UP, Key.UP, Key.W);
			Input.define(Moves.WALK_RIGHT, Key.RIGHT, Key.D);
			Input.define(Moves.WALK_LEFT, Key.LEFT, Key.A);
			
		}
		
		override public function update():void 
		{
			
			updateMovement();
			updateCollision();
			
			if(playerSpritemap) updateAnimations();
			
		}		
		
		private function updateMovement():void 
		{
			var mvt:Point = new Point();
			if (Input.check(Moves.WALK_RIGHT)) mvt.x++;
			else if (Input.check(Moves.WALK_LEFT)) mvt.x--;
			if (Input.check(Moves.WALK_DOWN)) mvt.y++;
			else if (Input.check(Moves.WALK_UP)) mvt.y--;
		
			_vel.x = speed * FP.elapsed * mvt.x;
			_vel.y = speed * FP.elapsed * mvt.y;
		}
		
		private function updateCollision():void 
		{
			x += _vel.x;
			if (collide("map", x, y)) {
				
				if (FP.sign(_vel.x) > 0) {
					// moving right
					_vel.x = 0;
					x = Math.floor( x / _gridWidth) * _gridWidth + _gridWidth - width;
				} else {
					_vel.x = 0;
					x = Math.floor( x / _gridWidth) * _gridWidth + _gridWidth;
					
				}
			}
		
			y += _vel.y;
			if (collide("map", x, y)) {
				
				if (FP.sign(_vel.y) > 0) {
					// moving right
					_vel.y = 0;
					y = Math.floor( y / _gridHeight) * _gridHeight+ _gridHeight- height;
				} else {
					_vel.y = 0;
					y = Math.floor( y / _gridHeight) * _gridHeight+ _gridHeight;
				}
			}
			
		}
		
		private function updateAnimations():void 
		{
			playerSpritemap.play(curAnimation);
			
			var moveH:Boolean = _vel.x != 0;
			var moveV:Boolean = _vel.y != 0;
			
			// Walk
			if (moveV)
			{
				if ( _vel.y > 0) curAnimation = Moves.WALK_DOWN;
				else curAnimation = Moves.WALK_UP;
			} 
			else if (moveH)
			{
				if ( _vel.x > 0) curAnimation = Moves.WALK_RIGHT;
				else curAnimation = Moves.WALK_LEFT;
			} 
			else
			{
				// Stand
				if (curAnimation.indexOf("walk") > -1) curAnimation = curAnimation.replace("walk", "stand");
			}
			
		}

		
	}

}