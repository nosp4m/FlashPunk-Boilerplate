package fputils.entities  
{
	import flash.display.BitmapData;
	import fputils.worlds.RotatableWorld;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;
	import net.flashpunk.utils.*;
	
	/**
	 * Core player movement and rotation logic.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class RotatablePlayerBase extends Entity 
	{
		protected var _angle:int;
		protected var _vx:Number;
		protected var _vy:Number;
		protected var _image:Image;
		protected var _speed:Number;
		protected var _aTween:AngleTween;
		protected var _rotationStep:int = 45;
		
		
		
		/** The angle the Player is facing. */
		public function get angle():Number { return _image.angle; }
		public function set angle(value:Number):void
		{
			_angle = value;
			updateRotation(false);
		}
		
		/** The speed of the Player. */
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		public function RotatablePlayerBase(x:Number=0, y:Number=0, angle:Number = 0, speed:Number = 100) 
		{
			// Set initial conditions.
			this.x = x;
			this.y = y;
			_angle = angle;
			_speed = speed;
			
			if (!_image)
			{
				// Set up the player's image.
				_image = new Image(new BitmapData(16,16,false,0xffffffff));
				_image.originX = 14;
				_image.originY = 16;
				
				// Set the hitbox for the player.
				setHitbox(16, 16, 8, 8);
			}
			
			// Place the Player on the topmost layer.
			layer = -1;			
			
			// Set the tween for smooth angle movement.
			_aTween = new AngleTween();
			_aTween.angle = _angle;
			addTween(_aTween, false);
			
			
			// Calculate the movement direction and image rotation without
			// tweening.
			updateRotation(false);
			
			super(x, y, _image);
		}
		
		override public function update():void 
		{
			super.update();
			
			handleInput();
			
			// Move the player based on the direction and speed.
			x += _vx * _speed * FP.elapsed;
			y += _vy * _speed * FP.elapsed;
			
			// Update the angle of the graphic based on the tween's current
			// angle.
			_image.angle = _aTween.angle;
		}
		
		
		/** Parse player input and apply it to the game. */
		protected function handleInput():void
		{
			// Check the left and right input and save the sum to n.
			// This way, if the user presses both rotations simultaneously,
			// he won't spin at all.
			var n:int = 0
			if (Input.pressed(Key.LEFT)) n--;
			if (Input.pressed(Key.RIGHT)) n++;
			// Based on n, determine if the player should spin.
			if (n != 0)
			{
				if (n < 0) spinLeft();
				else spinRight();
			}
		}
		
		
		
		/** Rotate the player left. */
		public function spinLeft():void
		{
			_angle += _rotationStep;
			updateRotation();
		}
		
		/** Rotate the player right. */
		public function spinRight():void
		{
			_angle -= _rotationStep;
			updateRotation();
		}
		
		/**
		 * Update the rotation of the player and kick off a tween to smooth the
		 * transition.
		 * 
		 * @param	doTween TRUE if the player should tween his angle, FALSE if
		 * he should snap.
		 */
		protected function updateRotation(doTween:Boolean = true):void
		{		
			// Normalize the player's angle from [0, 360).
			if(_angle >= 360 || _angle < 0) { _angle = RotatableWorld.normalizeAngle(_angle); }
			
			// Get the direction of travel based on _ang.
			trace(' _angle : ' + _angle  );
			
			_vx = Math.cos(FP.RAD * _angle);
			_vy = Math.sin(FP.RAD * _angle);
			
			trace(' _vx : ' + _vx +  ' _vy :  ' + _vy );
			
			if (doTween)
			{
				// Set up a tween from the current angle to the current _ang
				// and start it.
				_aTween.tween(_image.angle, _angle, 0.5, Ease.quintOut);
				_aTween.start();
			}
			else
			{
				// Snap the image and the tween to the desired angle.
				_image.angle = _angle;
				_aTween.angle = _angle;
			}
		}
		
	}

}