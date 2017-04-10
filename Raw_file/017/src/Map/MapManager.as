package Map
{	
	import com.greensock.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	
	import House.HouseComponent;
	import Interactive.DreamListComponent;
	import Interactive.Inventory;
	import Interactive.ItemList;
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
		//ItemList & Inventory
		public var itemList:ItemList;
		private var _santaInv:Inventory;
		private var _invTempArr:Array = [];
		
		//Character santa
		public var santa:SantaClaus;
		//Map
		private var _map:MapDisplay;
		
		//House & Level
		private var levelData:LevelData;
		private var houseArr:Array = [];
		private var lvlManager:LevelManager;
		private var ctr:Number = 1;
		private var currHouseIndex:Number = 0;
		private var lvlNum:Number = 0;
		
		
		private var testBtn:ButtonTester = new ButtonTester();
	
		public function MapManager()
		{
			initDisplay();
			addGlobalListener();
			dreamTimer();
			addGUI();
			setItemListSelection();
		}
		
			private function initDisplay():void
		{
			// Map class
			_map = new MapDisplay();
			// Player will choose item
			itemList = new ItemList();
			// Santa Inventory
			_santaInv = new Inventory();
			// Santa UI
			santa = new SantaClaus();
			// Default Level
			if( lvlNum == 0){
				lvlNum = 1;
			}
			// Handle level Display
			lvlManager = new LevelManager();
			//lvlManager.setLevel(3,6);
			levelData = new LevelData();
		}
		
		public function addEventTohouse():void {
			if ( lvlManager != null && lvlManager.houseArray.length != 0 ) {
				for (var i:int = 0; i < lvlManager.houseArray.length; i++)
				{
				lvlManager.houseArray[i].addEventListener(MouseEvent.CLICK, onClickHouse);
				}
			}
		}
		
		public function setItemListSelection():void {
			_santaInv.invAvailable = levelData.setLevelInvData(1);
			itemList.setrefList = levelData.setLevel(lvlNum);
			_map.x = -250;
			itemList.x = 10;
			itemList.y = 10;
			_santaInv.x = 10;
			_santaInv.y = stage.height - _santaInv.height - 15;
			addGUI();
		}
		
		public function addGlobalListener():void {
			addEventTohouse();
			this.addEventListener(GameEvent.ON_DONE, onTriggerDoneBtn);
			this.addEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.addEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerForHouseSequence);
			this.addEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
		}
		
		private function onAddingDataToInv(e:GameEvent):void 
		{
			trace(e.params.str);
			_invTempArr.push(  );
			
			_santaInv.invData = _invTempArr;
			//trace(_invTempArr.length);
		}
		public function removeGlobalListener():void {
			this.removeEventListener(GameEvent.ON_DONE, onTriggerDoneBtn);
			this.removeEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.removeEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerForHouseSequence);
		}
		
		private function startTimerForHouseSequence(e:GameEvent):void 
		{
			trace("able to click the house");
			lvlManager.gameTimerStart();
			addEventTohouse();
		}
		
		private function onInviSelect(e:GameEvent):void 
		{
			onSantaEventWalk();
			trace("select one ");
		}
		
		private function onTriggerDoneBtn(e:GameEvent):void 
		{
			gameDisplayMove();
			//lvlNum++;
			//itemList.setrefList = levelData.setLevel(lvlNum);
			//trace(e.params.str);
		}
	
		private function onSantaEventWalk():void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++)
			{
				lvlManager.houseArray[i].removeEventListener(MouseEvent.CLICK, onClickHouse);
			}
			this.addEventListener(Event.ENTER_FRAME, loop );
		}
		
		public function displaySantaInventory():void {
			addChild(_santaInv);
			_santaInv.x = 500;
			_santaInv.y = 50;
			TweenLite.to(_santaInv, .5, { x: 290 , y:50 } );
		}
		
		private function dreamTimer():void {
			
		}
		
		private function onClickHouse(e:Event):void 
		{
			currHouseIndex =  e.currentTarget.houseIndex;
			
			if ( !e.currentTarget.isLightOn && !e.currentTarget.isChimneyOn ) {
				if ( this.hasEventListener( Event.ENTER_FRAME )) {
					this.removeEventListener(Event.ENTER_FRAME, loop );
					trace(" loop has been stop temporarily ");
					trace(" CORRECT ");
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
			displaySantaInventory();
			lvlManager.gameTimerStop();
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
			}
			//trace("counter:",ctr);
		}
		
		private function addGUI():void
		{
			addChild(_map);
			_map.addChild(lvlManager);
			addChild(itemList);
			if ( _santaInv.x != 0 ) {
				addChild( _santaInv );
			}
		}
		public function gameDisplayMove():void {
			lvlManager.setLevel(4, 6);
			itemList.setrefList = levelData.setLevel(lvlNum);
			addGUI();
			
			TweenLite.to(_map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv ); 
			}
		}
		//end
	}
}

/* @TRACER
 * //trace( currHouseIndex );
			//trace( e.currentTarget.isLightOn );
			//trace( e.currentTarget.isChimneyOn );	
 * */