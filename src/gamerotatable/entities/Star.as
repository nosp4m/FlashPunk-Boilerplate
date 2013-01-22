package gamerotatable.entities 
{
	import gamerotatable.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A challenge star for the player to pick up in the level.
	 * There are three per level.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Star extends Entity 
	{
		
		protected var _image:Image;
		
		public function Star(x:Number, y:Number) 
		{
			_image = new Image(GData.assets.STAR);
			_image.x = -16;
			_image.y = -16;
			setHitbox(24, 24, 0, 0);
			
			type = "star";
			
			_image.color = 0xFDE06F;
			
			super(x, y, _image);
		}
		
	}

}