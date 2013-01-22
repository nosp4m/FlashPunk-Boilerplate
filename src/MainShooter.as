package  
{
	import gameshooter.worlds.ShooterWorld;
	import gameshooter.worlds.TitleWorld;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	
	
	 // The size of our SWF.
	[SWF(width = "320", height = "600")]
	
	// instanciate classes 

	
	/**
	 * ...
	 * @author Guillaume
	 */
	
	
	 
	 
	public class MainShooter extends Engine
	{

		public function MainShooter() 
		{
			super(320, 600);
			FP.console.enable();
			//FP.screen.scale = 2;
			FP.screen.color = 0x666666;
		}
		
		override public function init():void 
		{
			trace('[FullGame init] : '  );
			
			FP.world = new TitleWorld();
			//FP.world = new ShooterWorld();
			
		}
	}

}