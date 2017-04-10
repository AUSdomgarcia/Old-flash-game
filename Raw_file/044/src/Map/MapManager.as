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
		//Character
		public var santa:SantaClaus;
		private var _charManager:CharHintManager;
		//Map
		private var _map:MapDisplay;
		//House & Level
		private var levelData:LevelData;
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
			//Character Data default
			if( lvlNum == 0){
				lvlNum = 3;
			}
		}
		// LLL - Listeners
		public function addGlobalListener():void {
			this.addEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.addEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.addEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.addEventListener(GameEvent.ON_INV_RESET, onInvReset);
			this.addEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
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
			trace(this,"Set Level:",lvlNum);
			//Santa inventory
			_santaInv.isOnGamePlay = false;
			_santaInv.resetInvData();
			_santaInv.gcBtn(); _santaInv.gcWhitebase();
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
			if ( lvlManager.hasAtimer ) {      //*
				lvlManager.hasAtimer = false;  //*
				lvlManager.gameTimerStop();    //* DELETE
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
		//=================================== #1 ON INV SELECTION ==============================================================
		private function onAddingDataToInv(e:GameEvent):void 
		{
			var objHolder:Object = new Object();
			objHolder.str = e.params.str;
			objHolder.label = e.params.label;
			objHolder.lvl = e.params.lvl;	
			_santaInv.invData = objHolder;
		}
		//=================================== #2 ON ITEM LIST DONE & RESET ====================================================
		private function onTriggerDoneBtn(e:GameEvent):void 
		{
			if ( _santaInv.refArrForInvIcon.length != _santaInv.limitHolder ) {
				trace(this," [INVENTORY NOT COMPLETE]");
			} else if ( _santaInv.refArrForInvIcon.length != 0 ) {
				this.addEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
				_santaInv.isOnGamePlay = true;
				_santaInv.addBtnOnInv();
				processRandomNeeded();
				gameDisplayMove();
			} else {
				trace( this, "NO ITEM IN INVENTORY" ); 
			}
		}
		private function onInvReset(e:GameEvent):void 
		{
			_santaInv.resetInvData();
			_santaInv.gcImageInv();
		}
		//================================== #3 HOUSE MOVEMENT  ==============================================================
		public function gameDisplayMove():void {
			_map.addChild( lvlManager );	
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv );
				removeChild( _charManager );
			}
			TweenLite.to( _map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
		}
		//================================== #4 PLAYER CLICK HOUSE =============================================================
		public function addEventTohouse():void {
			if ( lvlManager != null && lvlManager.houseArray.length != 0 ) {
				for (var i:int = 0; i < lvlManager.houseArray.length; i++)
				{
					lvlManager.houseArray[i].addEventListener(MouseEvent.CLICK, onClickHouse);
				}
			}
		}
		public function removeEventToHouse():void {
			if ( lvlManager != null && lvlManager.houseArray.length != 0 ) {
				for (var i:int = 0; i < lvlManager.houseArray.length; i++)
				{
					lvlManager.houseArray[i].removeEventListener(MouseEvent.CLICK, onClickHouse);
				}
			}
		}
		private function onClickHouse(e:Event):void 
		{
			//Just to back the timer of other house
			addListenerToDreamList();
			
			currHouseIndex =  e.currentTarget.houseIndex;
			trace( this, lvlManager.houseArray[currHouseIndex].heldDreamListArr,"currLen", lvlManager.houseArray[currHouseIndex].heldDreamListArr.length );
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
			} else { trace(this,"for lvlmanager timer");  }
		}
		
		private function addListenerToDreamList():void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].onTimerStart();//splice str
			}
		}
		//======================================= #5 Display of Inventory ===========================================================
		public function displaySantaInventory():void {
			addChild(_santaInv);
			_santaInv.x = 500;
			_santaInv.y = 250;
			TweenLite.to(_santaInv, .5, { x: 290 , y:250 } );
		}
		// ====================================== #6 SANTA MOVEMENT MANAGER =========================================================
		private function startTimerAfterJump(e:GameEvent):void 
		{
			addEventTohouse();
			if ( lvlManager.hasAtimer ) {
				trace("timer start again! ");
				lvlManager.gameTimerStart(); // for loop current bahay lang mawalan ng timer
			} else { trace("ready to click"); }
		}
		private function onSantaEventWalk():void 
		{
			removeEventToHouse();
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
		//======================================== #7 GENERATE HOUSE RANDOM ITEM ================[ MASAKIT SA ULONG PART ]====================
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
			}
		}
		private function applyDisplayTogeneratedNeedItem():void {
			trace(this, generatedRandomItemForHouse);
			dreamListManager.setArrRef( lvlManager.houseArray, generatedRandomItemForHouse );
			dreamListManager.startTime();
		}
		//================================ #8 CALL OF HOUSE LVLMANAGER - house have arrays now ==============================
		private function calllvlManagerHouse(e:GameEvent):void 
		{
			trace(this,"ITEM_DISTRIBUTED TO HOUSE");
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].genCompToHouse();		
			}
		}
		//================================ #9 CHECKING OF ITEM between inv from houseItem =====================================
		private function onInviSelect(e:GameEvent):void
		{
			if ( _santaInv.isOnGamePlay ) {
				trace("IC > need:", e.params.need, "lvl:", e.params.lvl, "label:", e.params.label);
				for (var i:int = 0; i < lvlManager.houseArray[currHouseIndex].heldDreamListArr.length; i++)
				{
					var strHolder:String;
					if ( e.params.need == lvlManager.houseArray[currHouseIndex].heldDreamListArr[i] && lvlManager.houseArray[currHouseIndex].dreamListHolderpArr[i].isVisible != false ) {
						strHolder = lvlManager.houseArray[currHouseIndex].heldDreamListArr[i];
						lvlManager.houseArray[currHouseIndex].spliceIndex( strHolder );
						onSantaEventWalk();
						trace(this,"================================ SPLICE STR", strHolder);
					} else { 
							trace(this, "not found");
					}
				}
				lvlManager.houseArray[currHouseIndex].onTimerStart();
			} else { trace(this," INVENTORY MODE "); }
		}
	//end Engine
	}
}