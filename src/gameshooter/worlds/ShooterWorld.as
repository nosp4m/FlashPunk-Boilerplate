package gameshooter.worlds 
{
	import gameshooter.entities.BlackEnemy;
	import gameshooter.entities.DifficultEnemy;
	import gameshooter.entities.Enemy;
	import gameshooter.entities.Player;
	import gameshooter.entities.WhiteEnemy;
	import gameshooter.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class ShooterWorld extends World 
	{
		private var isAlive:Boolean;
		
		protected var player:Player ;
		
		protected var scoreText:Text;
		
		public function ShooterWorld() 
		{
			super();
			
		}
		
		override public function begin():void 
		{
			
			scoreText = new Text("0");
			addGraphic(scoreText);
			
			reset();
			
			super.begin();
		}
		
		override public function update():void 
		{
			GData.time++;
			
			if (isAlive)
			{
				// Generate Enemies
				if ( this.typeCount(GData.TYPE_ENEMY) < 5 && GData.time % GData.ennemyBirthRate == 0)
				{
				
					switch(FP.rand(5)) 
					{
						case 0:
							add( new BlackEnemy());
							break;
						case 1:
							add( new DifficultEnemy());
							break;
						default:
							add( new WhiteEnemy());
							//add( new DifficultEnemy());
							break;
					}
					
				}
				
				// Die
				var en:Enemy= player.collide(GData.TYPE_ENEMY, player.x, player.y) as Enemy
				if (en)
				{
					en.explode();
					player.hit();
					if(player.life == 0) isAlive = false;
				}
			} 
			else 
			{
				GData.ennemySpeed += 2;
				
				if (this.typeCount(GData.TYPE_ENEMY) == 0)
				{
					remove(player);
					reset();
				}
				
			}
			
			scoreText.text = GData.score.toString();
			
			super.update();
		}
		
		private function reset():void 
		{
			isAlive = true;
			player = new Player(FP.screen.width*0.5, 500);
			add(player);
			GData.ennemySpeed = 100;
		}
		
	}

}