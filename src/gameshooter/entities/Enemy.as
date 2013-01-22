package gameshooter.entities 
{
	import flash.display.BitmapData;
	import gameshooter.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class Enemy extends Entity 
	{
		public var life:Number;
		
		protected var explosion:Emitter;
		private var graphicList:Graphiclist;
		
		protected var body:Image;
		protected var value:int;
		
		protected var vel:Number;
		
		public function Enemy() 
		{
			
			super( FP.rand(FP.screen.width - 10), -10);
			
			body = new Image( GData.GFX_ENEMY);
			
			explosion = new Emitter(new BitmapData(2, 2), 2, 2);
			explosion.newType("boom", [0]);
			explosion.setAlpha("boom", 1);
			explosion.setColor("boom", 0xffffff, 0xff0000);
			explosion.setMotion("boom", 45, 30, 0.5, 90, -35, -0.2, Ease.quadOut);
					
			
			life = 1;
			graphicList = new Graphiclist(body, explosion);
			
			graphic = graphicList;
			
			setHitbox(25, 30);
			type = GData.TYPE_ENEMY;
			
			value = GData.ENNEMY_VALUE;
			vel = 1;
		}
		
		override public function update():void 
		{
			if (!collidable) checkExplodeComplete();
			
			y += FP.elapsed * GData.ennemySpeed * vel;
			if (y > FP.screen.height) world.remove(this);
			
			var b:Bullet = collideTypes([GData.TYPE_WHITE_BULLET, GData.TYPE_BLACK_BULLET], x, y) as Bullet;
			//var b:Bullet = collideWith(Bullet, x, y) as Bullet;
			
			if (b) {
				hit(b);
			}
			
			super.update();
		}
		
		private function checkExplodeComplete():void 
		{
			vel = vel > 0 ? vel -= 0.1 : 0;
			if (explosion.particleCount <= 0) // && vel <= 0) 
			{
				if (world) world.remove(this);
			}
		}
		
		protected function addScore(score:int = 0):void
		{
			GData.score += score ? score : value;
		}
		
		protected function hit(b:Bullet):void
		{
			// remove bullet
			world.remove(b);
		
			if (--life == 0)
			{
				
				addScore();
				
				explode()
				
			}
		}
		
		public function explode():void 
		{
			collidable = false;
			for (var i:int = 0; i < 50; i++) 
			{
				explosion.emit("boom", width * 0.5, height * 0.5);
			}
			
			body.visible = false;
		}
		
	}

}