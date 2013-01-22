package gameshooter.entities
{
	import flash.display.BitmapData;
	import gameshooter.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class Bullet extends Entity
	{
		protected var speed:Number;
	
		
		public function Bullet(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
			
			setHitbox(3, 3);
			graphic = new Image(GData.GFX_BULLET);
			
			speed = GData.bulletSpeed;
		}
		
		override public function update():void 
		{
			y -= FP.elapsed * speed;
			
			//if (y < -FP.screen.height) world.remove(this);
			if (y < 0) world.remove(this);
			
			super.update();
		}
	
		override public function removed():void 
		{
			super.removed();
		}
		
	}

}