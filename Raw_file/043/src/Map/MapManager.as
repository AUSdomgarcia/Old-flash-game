package Map
{	
	import com.greensock.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	import Interactive.DreamListManager;
	
	import House.HouseComponent;
	import Interactive.Inventory;
	import Interactive.ItemList;
	import Interactive.SantaClaus;
	import Level.LevelData;
	import Level.LevelManager;
	/**
	 * ...
	 * @author dHOMZKIe 69hy6cek
	 */
	
	[SWF(width=640,height=480)]
	
	public class MapManager extends Sprite
	{
		//ItemList & Inventory
		public var itemList:ItemList;
		private var _santaInv:Inventory;
		private var _invTempArr:Array = [];
		private var _invArrValid:Array = [];
		
		//Character
		public var santa:SantaClaus;
		private var _charManager:CharHintManager;
		//Map
		private var _map:MapDisplay;
		
		//House & Level
		private var levelData:LevelData;
		private var houseArr:Array = [];
		private var lvlManager:LevelManager;
		private var ctr:Number = 1;
		private var currHouseIndex:Number = 0;
		private var lvlNum:Number = 0;
		
		// DreaamList
		private var generatedRandomItemForHouse:Array = [];
		private var dreamListManager:DreamListManager;
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
		 * santa - santa itself
		 * lvlManager - house were initialize and add
		 * levelData - predefined data will sort
		 * lvlNum - default level of d user
		 * 
		 * _charManager - generate children and random qty for each
		 * */
		private function initDisplay():void
		{
			_map = new MapDisplay();
			itemList = new ItemList();
			_santaInv = new Inventory();
			santa = new SantaClaus();
			lvlManager = new LevelManager();
			levelData = new LevelData();
			_charManager = new CharHintManager();
			dreamListManager = new DreamListManager();
			
			if( lvlNum == 0){
				lvlNum = 3;
			}
		}
		
		public function addGlobalListener():void {
			this.addEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.addEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.addEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.addEventListener(GameEvent.ON_INV_RESET, onInvReset);
			this.addEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
		}
		
		private function calllvlManagerHouse(e:GameEvent):void 
		{
			trace("ITEM_DISTRIBUTED TO HOUSE");
			//^^^^^^^
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].genCompToHouse();
				
			}
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
			this.removeEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
		}
		
		public function setItemListSelection():void {
			//lvlNum++;
			trace("lvlNum",lvlNum);
			
			//**Santa inventory
			_santaInv.isOnGamePlay = false;
			_santaInv.resetInvData();
			_santaInv.gcBtn();
			_santaInv.gcWhitebase();
			_santaInv.invAvailableSlot = levelData.setLevelInvData(lvlNum);
			_santaInv.x = 10;
			_santaInv.y = stage.stageHeight - _santaInv.height + 10;
			//ItemList
			itemList.setItemListRefArr = levelData.setLevel(lvlNum);
			itemList.x = 10;
			itemList.y = 10;
			//CharManager
			_charManager.setCharRefArr = levelData.setLevel(lvlNum);
			//LvlManager
			lvlManager.setLevel(lvlNum, 6);
			if ( lvlManager.hasAtimer ) {
				lvlManager.hasAtimer = false;
				lvlManager.gameTimerStop();
			}
			
			_map.x = -250;
			addGUI();
		}
		private function addGUI():void
		{
			if( _map.contains(lvlManager)){//Garbage collect for houseMc inside if existing or not
				_map.removeChild(lvlManager);
			}
			addChild(_map);
			addChild(itemList);
			addChild( _santaInv );
			addChild( testBtn );
			addChild(_charManager);
			addChild( dreamListManager );
		}
		
		private function onTriggerDoneBtn(e:GameEvent):void 
		{
			this.addEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
			if ( _santaInv.refArrForInvIcon.length != _santaInv.limitHolder ) {
				trace("kulang pa inventory mo");
			} else if ( _santaInv.refArrForInvIcon.length != 0 ) {
				_santaInv.isOnGamePlay = true;
				_santaInv.addBtnOnInv();
				processRandomNeeded();
				gameDisplayMove();
			} else {
				trace( "wew walang laman inventory mo" ); 
			}
		}
		
		public function processRandomNeeded():void
		{
			generatedRandomItemForHouse = new Array();
			var arr:Array = levelData.setLevel(lvlNum);
			var strHolder:String;
			
			for (var i:int = 0; i < _charManager.arrHolder.length; i++) 
			{
				var arrHoldLvl:Array = [];
				var strHeld:String;
				var numOfChildren:Number = 0;
				
				for (var j:int = 0; j < arr.length; j++) 
				{
					if (arr[j].state == 1)
					{
						if ( _charManager.arrHolder[i] == arr[j].label ) {
							numOfChildren = _charManager.charMcHolder[i].numChar
							strHeld = _charManager.arrHolder[i];
							arrHoldLvl.push(arr[j].lvl);
						}
					}
				}
				generateArrNeedForHouse( strHeld ,arrHoldLvl, numOfChildren);
			}
			applyDisplayTogeneratedNeedItem();
		}
		private function generateArrNeedForHouse( str:String, arr:Array , num:Number ):void {

			for (var i:int = 0; i < num; i++) 
			{
				if( str != "random"){
					var rand:Number = Math.floor(Math.random() * arr.length );
					generatedRandomItemForHouse.push( str+"_"+arr[rand]);
				} else { 
					var rand1:Number = Math.floor(Math.random() * generatedRandomItemForHouse.length );
					generatedRandomItemForHouse.push(generatedRandomItemForHouse[rand1]);
				}
			}//trace
		}
		private function applyDisplayTogeneratedNeedItem():void {
			// make icon here ******************************************************
			//trace(generatedRandomItemForHouse);
			//trace("dito muna");
			dreamListManager.setArrRef( lvlManager.houseArray, generatedRandomItemForHouse );
			dreamListManager.startTime();
		}
	
		public function gameDisplayMove():void {
			_map.addChild( lvlManager );
			
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv );
				removeChild( _charManager );
			}
			TweenLite.to( _map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
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
			//############
			trace( lvlManager.houseArray[currHouseIndex].heldDreamListArr.length );
			trace( lvlManager.houseArray[currHouseIndex].heldDreamListArr );
			
			
			lvlManager.houseArray[currHouseIndex].onTimerStop();
			
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
				trace("InvBtn.InGame> need:", e.params.need, "lvl:", e.params.lvl, "label:", e.params.label);
				//&&&&&&&&&&&&&&&&
				for (var i:int = 0; i < lvlManager.houseArray[currHouseIndex].heldDreamListArr.length; i++)
				{
					if ( e.params.need == lvlManager.houseArray[currHouseIndex].heldDreamListArr[i] ) {
						var strHolder:String = lvlManager.houseArray[currHouseIndex].heldDreamListArr[i];
						lvlManager.houseArray[currHouseIndex].spliceIndex( strHolder );
						
						lvlManager.houseArray[currHouseIndex].onTimerStart();
						onSantaEventWalk();
					} else { trace("not found"); }
				}
				
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
			var objHolder:Object = new Object();
			objHolder.str = e.params.str;
			objHolder.label = e.params.label;
			objHolder.lvl = e.params.lvl;
			
			_santaInv.invData = objHolder;
		}
	}
}