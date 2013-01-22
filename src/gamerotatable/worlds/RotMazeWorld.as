package gamerotatable.worlds 
{

	import fputils.entities.RotatablePlayerBase;
	import fputils.worlds.RotatableWorld;
	import gamerotatable.entities.FinishArea;
	import gamerotatable.entities.PlayerRocket;
	import gamerotatable.entities.Star;
	import gamerotatable.GData;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
	
	/**
	 * Core game world logic.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class RotMazeWorld extends RotatableWorld 
	{
		protected var player:Entity;
		protected var map:Entity;
		
		protected var _mapGrid:Grid;
		protected var _mapImage:Graphic;
		protected var _mapData:Class;
		protected var _gameState:uint;
		
		protected const STATE_RUNNING:uint = 0;
		protected const STATE_FAILURE:uint = 1;
		protected const STATE_SUCCESS:uint = 2;
		
		protected var background:Backdrop;
		
		
		public function RotMazeWorld(mapData:Class = null) 
		{
			super();
			
			//
			// Create tiled background for movement reference.
			background = new Backdrop(GData.assets.BACKGROUND, true, true);
			
			// Save our data.
			_mapData = mapData;
			
			// Set initial conditions.
			_gameState = STATE_RUNNING;
			
			if (mapData != null)
			{
				// Load the provided map file.
				loadMap(_mapData);
			}
			else
			{
				
				// Create a debug map.
				_mapGrid = new Grid(1280, 1280, 32, 32, 0, 0);
				_mapGrid.usePositions = true;
				_mapGrid.setRect(0, 0, 1280, 1280, true);
				_mapGrid.setRect(32, 32, 1216, 1216, false);
				
				player = new PlayerRocket(640, 640) as Entity;
				player.type = "player";
				
			}
			
			// Create an image based on the map's data and scale it accordingly
			// if no tilemap exists.
			if (_mapImage == null)
			{
				// create debug map
				var mi:Image = new Image(_mapGrid.data);
				mi.scale = 32;
				// set the map image
				_mapImage= mi;
			}
			
			// Create a map entity to render and check collision with.
			map = new Entity(0, 0, _mapImage, _mapGrid);
			map.type = "map";
			map.layer = 10;
			
			
		}
		
		/** Called when World is switch to, and set to the currently active world. */
		override public function begin():void 
		{
			super.begin();
			
			// Add reference background.
			addGraphic(background, 100);
			
			// Add the game entities to GameWorld.
			add(player);
			
			// No need to reference these entities again.
			add(map);
		}
		
		/** Performed by the game loop, updates all contained Entities. */
		override public function update():void 
		{
			super.update();
			
			// Let the user quit at any time.
			if (Input.pressed(Key.ESCAPE)) FP.world = new MenuWorld();
			
			// Check the current state of the game and update accordingly.
			switch (_gameState)
			{
				case STATE_RUNNING:
					updateRunningState();
					break;
				case STATE_FAILURE:
					updateFailureState();
					break;
				case STATE_SUCCESS:
					updateSuccessState();
					break;
				default: break;
			}
		} 
		
		/** The main update loop. Handles player input and checks for collision. */
		protected function updateRunningState():void
		{
			// Update the camera and screen to match the player and keep him
			// facing forward.
			centerScreenAt(player.x, player.y);
			//angle = 90 - player.angle;
			angle = 90 - player["angle"];
			
			
			// Check to see if the player ran into a wall.
			handleWallCollision();
			
			// Check to see if the player collected a star.
			handleStarCollision();
			
			// Check to see if the player reached the finish.
			handleFinishCollision();
		}
		
		/** When the player has failed, slowly rotate the screen and wait for a restart command. */
		protected function updateFailureState():void
		{
			// Slowly rotate the screen.
			angle += 45 * FP.elapsed;
			
			// When space is pressed, create a new GameWorld with the
			// current map.
			if (Input.pressed(Key.SPACE))
			{
				FP.world = new RotMazeWorld(_mapData);
			}
		}
		
		/** When the player has won, slowly rotate the screen and wait for a confirmation command. */
		protected function updateSuccessState():void
		{
			// Slowly rotate the screen.
			angle += 45 * FP.elapsed;
			
			// When space is pressed, create a new MenuWorld with the
			// next map selected.
			if (Input.pressed(Key.SPACE))
			{
				GData.currentLevel++;
				FP.world = new MenuWorld();
			}
		}
		
		/**
		 * Switches the current state of the game and updates required properties.
		 * @param	state The game state to switch to.
		 */
		protected function setGameState(state:uint):void
		{
			_gameState = state;
			
			switch (_gameState)
			{
				case STATE_RUNNING:
					// Nothing required when switching to the running state.
					break;
				case STATE_FAILURE:
					// Remove the player.
					remove(player);
					
					// TODO: Display restart or menu prompt.
					// TODO: Update level attempts.
					break;
				case STATE_SUCCESS:
					// Slow the player down.
					var slowDown:VarTween = new VarTween();
					slowDown.tween(player, "speed", 0, 1, Ease.quintOut);
					addTween(slowDown, true);
					
					// TODO: Display success screen.
					// TODO: Update level completion.
					break;
				default: break;
			}
		}
		
		
		/** If the player collides with the map, remove him and wait for the player to respawn. */
		protected function handleWallCollision():void
		{
			if (map.collideWith(player, 0, 0))
			{
				setGameState(STATE_FAILURE);
			}
		}
		
		/** If the player collides with a star, remove the star and increment his map score. */
		protected function handleStarCollision():void
		{
			var star:Star = Star(player.collide("star", player.x, player.y));
			if (star != null)
			{
				remove(star);
				// TODO: Update player's star count.
				// TODO: Play collection animation.
			}
		}
		
		/** If the player collides with a finish line, the player has completed the level. */
		protected function handleFinishCollision():void
		{
			var finish:FinishArea = FinishArea(player.collide("finish", player.x, player.y));
			if (finish != null)
			{
				// Handle finishing and saving the player's progress.
				setGameState(STATE_SUCCESS);
			}
		}
		
		/**
		 * Loads a map from provided map data.
		 * @param	mapData The map data to load.
		 */
		protected function loadMap(mapData:Class):void
		{
			var mapXML:XML = FP.getXML(mapData);
			var node:XML;
			
			// Create our map grid.
			_mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 32, 32, 0, 0);
			_mapGrid.loadFromString(String(mapXML.Grid), "", "\n");
			
			// Create a player at the player start.
			player = new PlayerRocket(int(mapXML.Entities.PlayerStart.@x), int(mapXML.Entities.PlayerStart.@y), int(mapXML.Entities.PlayerStart.@angle));
			player.type = "player";
			
			// Pre-align our world to prevent view snapping.
			//angle = player.angle;
			angle = player["angle"];
			
			// Add code for stars.
			for each (node in mapXML.Entities.Star)
			{
				add(new Star(int(node.@x), int(node.@y)));
			}
			
			// Add code for finish.
			for each (node in mapXML.Entities.Finish)
			{
				add(new FinishArea(int(node.@x), int(node.@y), int(node.@width), int(node.@height)));
			}
			
			// Add code for the tilesheet.
			if (String(mapXML.Tiles).length > 0)
			{
				var tm:Tilemap = new Tilemap(GData.assets.TILESHEET, _mapGrid.width, _mapGrid.height, 16, 16);
				tm.loadFromString(mapXML.Tiles, ",", "\n");
				
				_mapImage = tm;
			}
			
		}
		
	}

}