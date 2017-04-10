package Map  
{
	import flash.display.Sprite
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	public class MapDisplay extends Sprite
	{
		private var mapBg:BackGroundMc;
		
		public function MapDisplay() 
		{
			init();
			addMap();
		}
		public function init():void {
			mapBg = new BackGroundMc();
		}
		
		public function addMap():void {
			addChild( mapBg );
		}
		
		public function removeMap():void {
			if ( this.parent != null ) {
				removeChild( mapBg );
			}
		}
	}
}