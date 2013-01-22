package gameshooter.entities 
{
	import gameshooter.entities.Bullet;
	import gameshooter.GData;
	/**
	 * ...
	 * @author Guillaume
	 */
	public class DifficultEnemy extends Enemy 
	{
		
		public function DifficultEnemy() 
		{
			super();
			
			life = 5;
			value *= 10;
			
			body.alpha = 0.5;
			body.scaleX = 2;
			
			
			setHitbox(50, 30);
		}
		
		override protected function hit(b:Bullet):void 
		{
			trace(' life : ' + life  );
			
			if (b.type == GData.TYPE_WHITE_BULLET)
			{
				body.alpha += 0.1;
				super.hit(b);
				
			}else {
				world.remove(b);
			}
			 
			
		}
		
	}

}