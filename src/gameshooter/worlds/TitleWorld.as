package gameshooter.worlds
{
	import gameshooter.GData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Guillaume
	 */
	public class TitleWorld extends World 
	{
		private var topTitle:Entity;
		private var bottomTitle:Entity;
		private var isTitleComplete:Boolean;
		private var infoText:Text;
		
		public function TitleWorld() 
		{
			super();
			
		}
		
		override public function begin():void 
		{
			
			
			topTitle = addGraphic( new Image(GData.GFX_TITLE_TOP));
			topTitle.y =  -FP.screen.height * 0.5;
			
			bottomTitle = addGraphic( new Image(GData.GFX_TITLE_BOTTOM));
			bottomTitle.y = FP.screen.height;
			
			
			var topTween:VarTween =  new VarTween(onTitleReady);
			topTween.tween(topTitle, "y", 0, 1, Ease.bounceOut);
			
			var bottomTween:VarTween =  new VarTween();
			bottomTween.tween(bottomTitle, "y", int(FP.screen.height * 0.5), 1, Ease.bounceOut);
			
			addTween(topTween, true);
			addTween(bottomTween, true);
			
			
			super.begin();
		}
		
		private function onTitleReady():void 
		{
			infoText = new Text("PRESS ANY KEY TO START");
			infoText.x = FP.screen.width * 0.5 - infoText.width * 0.5;
			infoText.y = 450;
			infoText.color = 0;
			infoText.alpha = 0;
			
			addGraphic(infoText);
			
			var textTween:VarTween = new VarTween(onTextReady);
			textTween.tween(infoText, "alpha", 1, 0.5, Ease.quadIn);
			addTween( textTween, true);
		}
		
		private function onTextReady():void 
		{
			isTitleComplete = true;
		}
		
		
		override public function update():void 
		{
			if (Input.pressed(Key.ANY))
			{
				if(isTitleComplete) FP.world = new ShooterWorld();
			}
			
			super.update();
		}
		
	}

}