package fputils.entities 
{
	import flash.display.BitmapData;
	import fputils.constants.Moves;
	import fputils.entities.RPGPlayerBase;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class RPGPlayerSprite extends RPGPlayerBase
	{
		
		public function RPGPlayerSprite(x:Number=0, y:Number=0, angle:Number = 0, speed:Number = 250, gridWidth:Number=32, gridHeight:Number=32) 
		{
			super(x, y, angle, speed, gridWidth, gridHeight);
			init();	
		}
		
		protected function init():void 
		{
			// create the animations
			playerSpritemap = new Spritemap(new BitmapData(20,20), 20, 20);
			setupSpritesheet();	
			
			graphic = playerSpritemap;
			
			setHitbox(20, 20, 0, 0);
			
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