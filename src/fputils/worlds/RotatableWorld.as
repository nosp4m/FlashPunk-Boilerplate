package fputils.worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	
	/**
	 * A world that can be easily rotated.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class RotatableWorld extends World 
	{
		protected var _ox:int;
		protected var _oy:int;
		protected var _angle:Number;
		
		
		public function get angle():Number { return _angle; }
		public function set angle(value:Number):void
		{
			// Update value to be [0, 360).
			_angle = normalizeAngle(value);
			
			// Set the world's rotation to this angle.
			FP.screen.angle = _angle;
		}
		
		/**
		 * Converts an angle to a corresponding angle from [0, 360).
		 * 
		 * @param	a The angle to normalize.
		 * @return	A normalized value of the angle between [0, 360).
		 */
		public static function normalizeAngle(a:Number):Number
		{
			while (a >= 360) { a -= 360; }
			while (a < 0) { a += 360; }
			return a;
		}
		
		public function RotatableWorld(initialAngle:Number = 0) 
		{
			
			
			angle = initialAngle;
			
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// Set our screen for rotation.
			FP.screen.x = (FP.width - FP.screen.width) * 0.5;
			FP.screen.y = (FP.height - FP.screen.height) * 0.5;
			FP.screen.originX = FP.screen.width * 0.5;
			FP.screen.originY = FP.screen.height * 0.5;
			FP.screen.smoothing = true;
			FP.screen.angle = angle;
			
			
		}
		
		protected function centerScreenAt(cx:int, cy:int):void
		{
			camera.x = cx - FP.screen.width * 0.5;
			camera.y = cy - FP.screen.height * 0.5;
		}
		
	}

}