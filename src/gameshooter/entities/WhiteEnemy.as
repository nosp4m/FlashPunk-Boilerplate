package gameshooter.entities 
{
	import gameshooter.entities.Bullet;
	import gameshooter.GData;
	/**
	 * ...
	 * @author Guillaume
	 */
	public class WhiteEnemy extends Enemy 
	{
		
		public function WhiteEnemy() 
		{
			super();
			
		}
		
		override protected function hit(b:Bullet):void 
		{
			if (b.type == GData.TYPE_WHITE_BULLET)
			{
				super.hit(b);
			}else {
				world.remove(b);
			}
			 
			
		}
		
	}

}