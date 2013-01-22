package gameshooter.entities 
{
	import gameshooter.GData;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Guillaume
	 */
	public class BlackEnemy extends Enemy 
	{
		
		public function BlackEnemy() 
		{
			super();
			
			body.color = 0;
			body.tinting = 0.75;
			
			
			value *= 2;
			vel *= 0.5;
		}
		
		override protected function hit(b:Bullet):void 
		{
			if (b.type == GData.TYPE_BLACK_BULLET)
			{
				super.hit(b);
			}else {
				world.remove(b);
			}			
		}
	}

}