package gamerotatable 
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