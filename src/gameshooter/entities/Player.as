package gameshooter.entities 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import gameshooter.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class Player extends Entity 
	{
		private var minX:Number;
		private var maxX:Number;
		private var minY:Number;
		private var maxY:Number;
		private var count:int;
		private var currentColor:int;
		private var explosionEmitter:Emitter;
		private var ship:Image;
		private var explosionSize:uint = 100;
		
		private var rafale:Number;
		private var swapComplete:Boolean;
		private var shield:Image;
		public var rafaleLength:Number = 5
		public var life:Number;
		
		protected var currentBullet:Class ;
		
		public function Player(x:Number=0, y:Number=0) 
		{
			super(x, y);
			ship = new Image(GData.GFX_PLAYER);
			ship.color = 0xffffff;
			ship.tinting = 0.5;
			
			shield = new Image(GData.GFX_SHIELD);			
			shield.x = -4;
			shield.y = -4;
			
			setHitbox(24, 24);
			
			minX = 0;
			maxX = FP.screen.width - width;
			
			minY = FP.screen.height * 0.5;
			maxY = FP.screen.height - height * 2;
			
			currentBullet = WhiteBullet;
			rafale = rafaleLength;
			swapComplete = true;
			
			explosionEmitter = new Emitter(new BitmapData(2, 2), 2, 2);
			explosionEmitter.newType("explode", [0]);
			explosionEmitter.setAlpha("explode", 1);
			explosionEmitter.setMotion("explode", 0, -50, 1.5, 180, 60, -0.5, Ease.quadOut);
			explosionEmitter.setColor("explode", ship.color, 0xff0000);
			explosionEmitter.relative = false;
			
			Input.define("swap", Key.C, Key.V, Key.B, Key.N);
			
			graphic = new Graphiclist(  ship, shield, explosionEmitter);
			
			life = 3;
		}
		
		override public function update():void 
		{
			
			updateMovement();
			updateShoot();
			
			super.update();
		}
		
		
		private function updateShoot():void 
		{
			
			if (Input.check(Key.SPACE) && collidable && GData.time%5 == 0  )
			{
				if(--rafale > 0) world.add(new currentBullet(x + 12, y - 2));
			}
			
			if (Input.released(Key.SPACE)) rafale = rafaleLength;
			
			if (Input.pressed("swap") && swapComplete )
			{
				swapComplete = false;
				FP.tween(ship, { scaleX: 0, x:12}, 0.1, { ease: Ease.quadInOut, complete: swapPlayer} );
					
				if (currentBullet == WhiteBullet) currentBullet = BlackBullet;
				else currentBullet = WhiteBullet; 
			}
		}
		
		private function swapPlayer():void 
		{
 			ship.color = currentBullet == WhiteBullet ? 0xffffff : 0;
			
			explosionEmitter.setColor("explode", ship.color, 0xff0000);
			FP.tween(ship, { scaleX: 1, x:0}, 0.2, { ease: Ease.quadInOut, complete: onSwapComplete } );
		}
		
		private function onSwapComplete():void 
		{
			swapComplete = true;
		}
		
		private function updateMovement():void 
		{
			var mvt:Point = new Point();
			if (Input.check(Key.RIGHT)) mvt.x++;
			else if (Input.check(Key.LEFT)) mvt.x--;
			
			if (Input.check(Key.DOWN)) mvt.y++;
			else if (Input.check(Key.UP)) mvt.y--;
			
			x += GData.playerSpeed * FP.elapsed * mvt.x;
			x = FP.clamp(x, minX, maxX); 
			
			y += GData.playerSpeed * FP.elapsed * mvt.y;
			y = FP.clamp(y, minY, maxY); 
		}
		
		public function hit():void
		{
			if (--life == 0)
			{
				collidable = false;
				ship.visible = false;
				
				for (var i:int = 0; i < explosionSize; i++) 
				{
					explosionEmitter.emit("explode", x + width * 0.5, y + height * 0.5);
				}
			}
			
			shield.alpha = (life-1) * 0.5;
		}
		
	}

}