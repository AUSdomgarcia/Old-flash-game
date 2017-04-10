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
		private var _invArrValid:Array = [];
		
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
			testBtn.addEventListener(MouseEvent.CLICK, function ():void { setItemListSelection()  } );
			initDisplay();
			addGlobalListener();
			setItemListSelection();
		}
		/*@ map - map and lvlManager merge
		 * itemList - List of item ex: food,toy etc.
		 * _santaInv - santa's inventory
		 * lvlManager - house were initialize and add
		 * levelData - predefined data will sort
		 * lvlNum - default level of d user
		 * */
		private function initDisplay():void
		{
			_map = new MapDisplay();
			itemList = new ItemList();
			_santaInv = new Inventory();
			santa = new SantaClaus();
			lvlManager = new LevelManager();
			levelData = new LevelData();
			
			if( lvlNum == 0){
				lvlNum = 0;
			}
		}
		
		public function addGlobalListener():void {
			this.addEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.addEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.addEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.addEventListener(GameEvent.ON_INV_RESET, onInvReset);
			
			this.addEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
			
		}
		
		private function onInvReset(e:GameEvent):void 
		{
			_santaInv.resetInvData();
			_santaInv.gcImageInv();
		}
		
		public function removeGlobalListener():void {
			this.removeEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.removeEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.removeEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
			this.removeEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.removeEventListener(GameEvent.ON_INV_RESET, onInvReset);
		}
		
		public function setItemListSelection():void {
			lvlNum++;
			trace("lvlNum",lvlNum);
			
			_santaInv.isOnGamePlay = false;
			_santaInv.resetInvData();
			_santaInv.gcBtn();
			_santaInv.gcWhitebase();
			
			
			_santaInv.invAvailable = levelData.setLevelInvData(lvlNum);
			itemList.setrefList = levelData.setLevel(lvlNum);
			_map.x = -250;
			itemList.x = 10;
			itemList.y = 10;
			_santaInv.x = 10;
			_santaInv.y = stage.stageHeight - _santaInv.height + 10;
			
			if ( lvlManager.hasAtimer ) {
				lvlManager.hasAtimer = false;
				lvlManager.gameTimerStop();
			}
			addGUI();
		}
		private function addGUI():void
		{
			if( _map.contains(lvlManager)){//Garbage collect for houseMc inside doesn't exist
			_map.removeChild(lvlManager);
			}
			addChild(_map);
			addChild(itemList);
			addChild( _santaInv );
			addChild( testBtn );
		}
		private function onTriggerDoneBtn(e:GameEvent):void 
		{
			if ( _santaInv.refArr.length != _santaInv.limitHolderArr ) {
				trace("kulang pa inventory mo");
			} else if ( _santaInv.refArr.length != 0 ) {
				_santaInv.isOnGamePlay = true;
				_santaInv.addBtnOnInv();
				gameDisplayMove();
			} else {
				trace( "wew walang laman inventory mo" ); 
			}
			//lvlNum++; itemList.setrefList = levelData.setLevel(lvlNum); trace(e.params.str);
		}
		public function gameDisplayMove():void {
			lvlManager.setLevel(lvlNum, 6);
			_map.addChild( lvlManager );
			
			TweenLite.to( _map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
			
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv );
			}
		}
		public function addEventTohouse():void {
			if ( lvlManager != null && lvlManager.houseArray.length != 0 ) {
				for (var i:int = 0; i < lvlManager.houseArray.length; i++)
				{
				lvlManager.houseArray[i].addEventListener(MouseEvent.CLICK, onClickHouse);
				}
			}
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
			
			if ( lvlManager.hasAtimer ) {
				lvlManager.gameTimerStop();
			} else { trace("no timer to stop");  }
		}
		
		public function displaySantaInventory():void {
			addChild(_santaInv);
			_santaInv.x = 500;
			_santaInv.y = 50;
			TweenLite.to(_santaInv, .5, { x: 290 , y:50 } );
		}
		
		private function startTimerAfterJump(e:GameEvent):void 
		{
			addEventTohouse();
			if ( lvlManager.hasAtimer ) {
				trace("timer start again! ");
				lvlManager.gameTimerStart();
			} else { trace("level without timer "); }
		}
		
		private function onInviSelect(e:GameEvent):void
		{
			if ( _santaInv.isOnGamePlay ) {
				trace("InvGame.selected:",e.params.str);
				onSantaEventWalk();
			} else {
				return;
				trace("Just click");
			}
		}
		//level without timer 
		private function onSantaEventWalk():void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++)
			{
				lvlManager.houseArray[i].removeEventListener(MouseEvent.CLICK, onClickHouse);
			}
			this.addEventListener(Event.ENTER_FRAME, loop );
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
		}
		
		private function onAddingDataToInv(e:GameEvent):void 
		{
			_santaInv.invData = e.params.str;
		}
	//end
	}
}