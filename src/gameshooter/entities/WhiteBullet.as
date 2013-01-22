package gameshooter.entities 
{
	import gameshooter.GData;
	/**
	 * ...
	 * @author Guillaume
	 */
	public class WhiteBullet extends Bullet 
	{
		
		public function WhiteBullet(x:Number = 0, y:Number = 0)
		{
			super(x, y);
			
			type = GData.TYPE_WHITE_BULLET;
		}
		
	}

}