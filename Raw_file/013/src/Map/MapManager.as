package Map
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import House.HouseComponent;
	import Interactive.SantaClaus;
	import Level.LevelManager;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	[SWF(width=640,height=480)]
	
	public class MapManager extends Sprite
	{
		public var santa:SantaClaus;
		private var map:MapDisplay;
		private var houseArr:Array = [];
		private var lvlManager:LevelManager;
		private var ctr:Number = 0;
		private var currHouseIndex:Number = 0;
		
		public function MapManager()
		{
			initSanta();
			initDisplay();
			addAssets();
		}
		
		private function initSanta():void
		{
		
		}
		
		private function initDisplay():void
		{
			map = new MapDisplay();
			lvlManager = new LevelManager();
			santa = new SantaClaus();
			
			lvlManager.setLevel(4, 6);
			
			for (var i:int = 0; i < lvlManager.houseArray.length; i++)
			{
				lvlManager.houseArray[i].addEventListener(MouseEvent.CLICK, onClick);
			}
			
			map.init();
			map.addMap();
			
		}
		
		private function onClick(e:Event):void 
		{
			currHouseIndex =  e.currentTarget.houseIndex
			trace( currHouseIndex );
			trace( e.currentTarget.isLightOn );
			trace( e.currentTarget.isChimneyOn );	
			
			
			if ( !e.currentTarget.isLightOn && !e.currentTarget.isChimneyOn ) {
				santa.x = e.currentTarget.x + 90;
				santa.y = e.currentTarget.y + 19;
				addChild(santa);
				santa.santaIdle();
				
				if ( this.hasEventListener(Event.ENTER_FRAME )) {
					this.removeEventListener(Event.ENTER_FRAME, loop );
				}
				addListner();
				ctr = 0;
				
			} else if ( e.currentTarget.isLightOn || e.currentTarget.isChimneyOn ){
				santa.x = e.currentTarget.x + 90;
				santa.y = e.currentTarget.y + 19;
				addChild(santa);
				santa.santaIdle();
				
				if ( this.hasEventListener(Event.ENTER_FRAME )) {
					this.removeEventListener(Event.ENTER_FRAME, loop );
				}
				addListner();
				ctr = 0;
				trace("run but something wrong! ");
			}
			
			/*if ( e.currentTarget.isLightOn || e.currentTarget.isChimneyOn ){
				if ( santa.parent != null ) {
					santa.removeSanta();
				}
			}*/
		}
		
		public function addListner():void {
			this.addEventListener(Event.ENTER_FRAME, loop );
		}
		
		private function loop( e:Event ):void {
			ctr++;
			if ( ctr >= 50 ) {
				santa.santaWalk();
				santa.x--;
			}
			if ( lvlManager.houseArray[currHouseIndex].x + 50 >= santa.x ) {
				this.removeEventListener(Event.ENTER_FRAME, loop );
				santa.santaJump();
			}
			
		}
		
		private function addAssets():void
		{
			addChild(map);
			addChild(lvlManager);	
		}
		//end	
	}
}