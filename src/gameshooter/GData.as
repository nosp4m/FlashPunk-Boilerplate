package gameshooter 
{
	import net.flashpunk.Entity;

	/**
	 * Game variables.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class GData
	{
		
		// ASSETS
		
		[Embed(source='../../assets/gameshooter/assets/spaceship-icon-small.png')]
		public static const GFX_PLAYER:Class
		
		[Embed(source = '../../assets/gameshooter/assets/shield.png')]
		public static const GFX_SHIELD:Class
		
		[Embed(source = '../../assets/gameshooter/assets/enemy.png')]
		public static const GFX_ENEMY:Class
	
		[Embed(source = '../../assets/gameshooter/assets/title-top.png')]
		public static const GFX_TITLE_TOP:Class
		
		[Embed(source='../../assets/gameshooter/assets/title-bottom.png')]
		public static const GFX_TITLE_BOTTOM:Class
		
		[Embed(source = '../../assets/gameshooter/assets/bullet.png')]
		public static const GFX_BULLET:Class
		
		[Embed(source = '../../assets/gameshooter/assets/bomb.png')]
		public static const GFX_BOMB:Class
		
		// CONSTANTS
		
		static public const TYPE_WHITE_BULLET:String = "white_bullet";
		static public const TYPE_BLACK_BULLET:String = "black_bullet";
		static public const TYPE_ENEMY:String = "enemy";
		static public const ENNEMY_VALUE:Number = 100;
		
		
		
		
		
		
		
		// VARIABLES
		static public var bulletSpeed:Number = 300;
		static public var playerSpeed:Number = 250		
		static public var ennemySpeed:Number = 100;
		static public var ennemyBirthRate:Number = 40;
		
		
		static public var time:uint = 0;
		
		static public var score:uint = 0;
		
		
	}
}