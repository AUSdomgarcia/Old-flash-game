package Map
{
	import flash.display.Sprite;
	import House.HouseComponent;
	import Level.LevelManager;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	 [SWF( width = 640, height = 480 )]
	 
	public class MapManager extends Sprite
	{
		private var map:MapDisplay;
		private var houseArr:Array = [];
		private var lvlManager:LevelManager;

		
		public function MapManager()
		{
			initDisplay();
			addAssets();
		}
		
		private function initDisplay():void {
			map = new MapDisplay();
			lvlManager = new LevelManager();
			lvlManager.initTimer(1000);
			lvlManager.setLevel( 2, 3 );
			
			map.init();
			map.addMap();
		}
		private function addAssets():void {
			addChild(map);
			addChild(lvlManager);
		}
		
		
	//end	
	}
}