package gameshooter.entities 
{
	import flash.display.BitmapData;
	import gameshooter.GData;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Guillaume
	 */
	public class BlackBullet extends Bullet 
	{
		
		public function BlackBullet(x:Number=0, y:Number=0) 
		{
			super(x, y);
			
			type = GData.TYPE_BLACK_BULLET
			
			setHitbox(6, 6);
			graphic = new Image(GData.GFX_BOMB);
			
			//Image(graphic).color = 0;
			
			speed *= 0.5;
			
		}
		
	}

}