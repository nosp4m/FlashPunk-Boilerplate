package fputils.graphics 
{
	/**
	 * ...
	 * @author pop
	 */
	public class SpriteMapUtils 
	{
		
		/**
		 * Create a quick list of frames...
		 * @param	startIndex		The first frame in this strip. 
		 * @param	endIndex		The last frame in this strip.
		 */	
		static public function createFramesArray( startIndex:int, endIndex:int):Array
		{
			var frameList:Array = [];
			var i:int = startIndex
			while (i <= endIndex) {
				frameList.push(i);
				i++;
			}
			return frameList.slice();
		}
	}

}