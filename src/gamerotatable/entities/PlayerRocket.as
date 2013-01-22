package gamerotatable.entities 
{
	import fputils.entities.RotatablePlayerBase;
	import gamerotatable.GData;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class PlayerRocket extends RotatablePlayerBase 
	{
		
		public function PlayerRocket(x:Number=0, y:Number=0, angle:Number=0, speed:Number=100) 
		{
			
			// Set up the player's image.
			_image = new Image(GData.assets.PLAYER);
			_image.originX = 14;
			_image.originY = 16;
			
			// Set the hitbox for the player.
			setHitbox(16, 16, 8, 8);
			
			super(x, y, angle, speed);
			
		}
		
	}

}