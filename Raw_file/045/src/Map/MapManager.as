package Map
{	
	import com.greensock.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import House.HouseComponent;
	import Interactive.DreamListComponent;
	import Interactive.ImageList;
	import Interactive.SantaClaus;
	import Level.LevelData;
	import Level.LevelManager;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	
	[SWF(width=640,height=480)]
	
	public class MapManager extends Sprite
	{
		//List
		private var optionList:ImageList;
		private var dream:DreamListComponent;
		//Character santa
		public var santa:SantaClaus;
		//Map
		private var map:MapDisplay;
		
		//House & Level
		private var levelData:LevelData;
		private var houseArr:Array = [];
		private var lvlManager:LevelManager;
		private var ctr:Number = 0;
		private var currHouseIndex:Number = 0;
		private var lvlNum:Number = 0;
		private var _santaInv:SantaBag;
		//Tween
		
		
		private var testBtn:ButtonTester = new ButtonTester();
		
		public function MapManager()
		{
			trace("churva");
			initDisplay();
			addGUI();
			dreamTimer();
			testBtn.x = 450;
			testBtn.y = 450;
			addGlobalListener();
		}
		
		public function addGlobalListener():void {
			this.addEventListener("santaWalk", onSantaEventWalk);
			
		}
		
		private function onSantaEventWalk(e:Event):void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++)
			{
					lvlManager.houseArray[i].removeEventListener(MouseEvent.CLICK, onClickHouse);
			}
			this.addEventListener(Event.ENTER_FRAME, loop );
		}
		
		public function callOptionList():void {
			//optionList.setrefList = levelData.setLevel(lvlNum);
			addChild(_santaInv);
			_santaInv.x = 500;
			_santaInv.y = 50;
			TweenLite.to(_santaInv, .5, { x:310, y:50 } );
		}
		
		private function dreamTimer():void {
			
		}
		
		private function initDisplay():void
		{
			map = new MapDisplay();
			lvlManager = new LevelManager();
			levelData = new LevelData();
			santa = new SantaClaus();
			optionList = new ImageList();
			_santaInv = new SantaBag();
			
			
			lvlNum = 1;
			lvlManager.setLevel(lvlNum, 4);
			addEventTohouse();
		}
		
		public function addEventTohouse():void {
			for (var i:int = 0; i < lvlManager.houseArray.length; i++)
			{
				lvlManager.houseArray[i].addEventListener(MouseEvent.CLICK, onClickHouse);
			}
		}
		
		private function onClickHouse(e:Event):void 
		{
			currHouseIndex =  e.currentTarget.houseIndex
			//trace( currHouseIndex );
			//trace( e.currentTarget.isLightOn );
			//trace( e.currentTarget.isChimneyOn );	
			
			
			if ( !e.currentTarget.isLightOn && !e.currentTarget.isChimneyOn ) {
				if ( this.hasEventListener( Event.ENTER_FRAME )) {
					this.removeEventListener(Event.ENTER_FRAME, loop );
					trace("loop has been stop temporarily ");
				}
				
			} else if ( e.currentTarget.isLightOn || e.currentTarget.isChimneyOn ) {
				if ( this.hasEventListener(Event.ENTER_FRAME )) {
					this.removeEventListener(Event.ENTER_FRAME, loop );
					trace("loop has been stop temporarily ");
				}
			}
		
			
			ctr = 0;
			santa.x = e.currentTarget.x + 90;
			santa.y = e.currentTarget.y + 19;
			santa.santaIdle();
			addChild(santa);
			callOptionList();
		}
		
		private function loop( e:Event ):void {
			ctr++;
			
			if ( ctr >= 20 ) {
				santa.santaWalk();
				santa.x-= 2;
			}
			if ( lvlManager.houseArray[currHouseIndex].x + 50 >= santa.x ) {
				this.removeEventListener(Event.ENTER_FRAME, loop );
				trace("loop has stop! ");
				santa.santaJump();
				ctr = 0;
				//addEventTohouse();
			}
			/*if ( ctr >= 140 ) {
				
			}*/
			trace("counter:",ctr);
		}
		
		private function addGUI():void
		{
			addChild(map);
			addChild(lvlManager);
		}
		//end	
	}
}