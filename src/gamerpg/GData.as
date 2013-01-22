package gamerpg 
{
	import net.flashpunk.Entity;

	/**
	 * Game variables.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class GData
	{
		
		// Assets & Game Levels : Set up in Main
		public static var assets:Class;
		public static var levels:Class;	
		
		// World
		// TODO update when oel is loaded
		public static var worldClassReference:String;	
		public static var gridWidth:Number = 32;
		public static var gridHeight:Number = 32;
		
		// Player
		
		static public var playerSpeed:Number = 250;
		
		
		// Game State
		private static var _currentLevel:uint = 0;
		
		public static function get currentLevel():uint { return _currentLevel; }
		public static function set currentLevel(value:uint):void
		{
			_currentLevel = value;
			// TODO: Save game data.
		}
		
		
		
	}
}