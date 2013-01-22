package gamerpg.entities 
{
	import fputils.constants.Moves;
	import fputils.entities.RPGPlayerSprite;
	import fputils.graphics.SpriteMapUtils;
	import gamerpg.GData;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class ZeldaPlayer extends RPGPlayerSprite 
	{
		
		public function ZeldaPlayer(x:Number=0, y:Number=0, angle:Number=0, speed:Number = 250, gridWidth:Number=32, gridHeight:Number=32) 
		{
			super(x, y, angle, speed, gridWidth, gridHeight);
		}
		
		override protected function init():void 
		{
			// create the animations
			playerSpritemap = new Spritemap(GData.assets.PLAYER_SPRITE, 23, 28);
			setupSpritesheet();	
			
			graphic = playerSpritemap;
			
			setHitbox(23, 28, 0, 0);
			
			playerSpritemap.play(curAnimation);	
		}
		
		
		override protected function setupSpritesheet():void 
		{
			playerSpritemap.add( Moves.WALK_DOWN , SpriteMapUtils.createFramesArray(0,7), 9, true );
			playerSpritemap.add( Moves.WALK_UP , SpriteMapUtils.createFramesArray(8,15), 9, true );
			playerSpritemap.add( Moves.WALK_RIGHT , SpriteMapUtils.createFramesArray(16,21), 9, true );
			playerSpritemap.add( Moves.WALK_LEFT , SpriteMapUtils.createFramesArray(24,29), 9, true );
			
			playerSpritemap.add( Moves.STAND_DOWN , [0], 0, false );
			playerSpritemap.add( Moves.STAND_UP , [8], 0, false );
			playerSpritemap.add( Moves.STAND_RIGHT  , [16], 0, false );
			playerSpritemap.add( Moves.STAND_LEFT , [24], 0, false );
		}		
	}

}