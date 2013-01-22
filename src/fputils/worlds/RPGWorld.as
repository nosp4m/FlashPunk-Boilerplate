package fputils.worlds  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * A world that can be easily rotated.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class RPGWorld extends World 
	{
		protected var _ox:int;
		protected var _oy:int;
		
		
		public function RPGWorld(initialAngle:Number = 0) 
		{
			
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// Set our screen for rotation.
			FP.screen.x = (FP.width - FP.screen.width) * 0.5;
			FP.screen.y = (FP.height - FP.screen.height) * 0.5;
			FP.screen.originX = FP.screen.width * 0.5;
			FP.screen.originY = FP.screen.height * 0.5;
			//FP.screen.smoothing = true;
			//FP.screen.angle = angle;
			
			
		}
		
		protected function centerScreenAt(cx:int, cy:int):void
		{
			camera.x = cx - FP.screen.width * 0.5;
			camera.y = cy - FP.screen.height * 0.5;
		}
		
	}

}