package fputils.entities 
{
	import flashpunkutils.Moves;
	import gameinfo.fputils;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class PlatformPlayerSprite extends PlatformPlayerBase
	{
		
		public function PlatformPlayerSprite(x:Number=0, y:Number=0, angle:Number = 0, speed:Number = 250) 
		{
			super(x, y, angle, speed);
			init();	
		}
		
		private function init():void 
		{
			// create the animations
			playerSpritemap = new Spritemap(fputils.assets.PLAYER_SPRITE, fputils.playerSpriteWidth, fputils.playerSpriteHeight);
			setupSpritesheet();	
			
			graphic = playerSpritemap;
			
			setHitbox(fputils.playerHitBoxWidth, fputils.playerSpriteHeight, fputils.hitOriginX, fputils.hitOriginY);
			
			playerSpritemap.play(curAnimation);	
		}
		
		
		protected function setupSpritesheet():void 
		{
			// default to first tile
			playerSpritemap.add( Moves.WALK_DOWN , [0], 0, false );
			playerSpritemap.add( Moves.WALK_UP , [0], 0, false );
			playerSpritemap.add( Moves.WALK_RIGHT , [0], 0, false );
			playerSpritemap.add( Moves.WALK_LEFT , [0], 0, false );
			
			playerSpritemap.add( Moves.STAND_DOWN , [0], 0, false );
			playerSpritemap.add( Moves.STAND_UP , [0], 0, false );
			playerSpritemap.add( Moves.STAND_RIGHT  , [0], 0, false );
			playerSpritemap.add( Moves.STAND_LEFT , [0], 0, false );
		}
		
		
	}

}