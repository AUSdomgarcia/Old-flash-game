package Map
{	
	import com.greensock.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	import Interactive.DreamListManager;
	import Interactive.RewardManager;
	import Interactive.SantaMeter;
	
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
		//RewardManager
		private var rManager:RewardManager;
		
		//ItemList & Inventory
		private var pickMC:PickSantaMC;
		//Meter
		private var meter:SantaMeter;
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
		private var hasPoints:Boolean = false;
		private var randItemCopy:Array = []
		
		private var scoreCtr:Number = 0;

		public function MapManager()
		{
			//var mem:MemoryProfiler = new MemoryProfiler();
			//addChild(mem);
			//mem.x = GameConfig.GAME_WIDTH - mem.width;
			//var frame:FrameRateViewer = new FrameRateViewer();
			//addChild(frame);
			
			testBtn.addEventListener(MouseEvent.CLICK, function ():void { setItemListSelection()  } );
			init();
			addGlobalListener();
			setItemListSelection();

		}
		public function init():void
		{
			rManager = new RewardManager();
			pickMC = new PickSantaMC();
			_map = new MapDisplay();
			itemList = new ItemList();
			_santaInv = new Inventory();
			santa = new SantaClaus();
			lvlManager = new LevelManager();
			levelData = new LevelData();
			_charManager = new CharHintManager();
			dreamListManager = new DreamListManager();
			
			itemList.x = 10;
			itemList.y = 10;
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
			this.addEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
		}
		//=========================================================[ ITEM SELECTION ]=============================================================
		
		private function setValues():void {
			//Inventory
			_santaInv.invAvailableSlot = levelData.setLevelInvData(lvlNum);
			_santaInv.x = 10;
			_santaInv.y = stage.stageHeight - _santaInv.height + 10;
			//ItemList
			itemList.setItemListRefArr = levelData.setLevel(lvlNum);
			//CharManager
			_charManager.setCharRefArr = levelData.setLevel(lvlNum);
			//lvlManager
			lvlManager.setLevel(lvlNum);
			_map.x = -250;
			santa.x = - 20;
			santa.y = - 20;
		}
		
		
		public function setItemListSelection():void {
			//lvlNum++;
			trace(this,"Set Level:",lvlNum);
			gcRemoveAll();
			init();
			addGlobalListener();
			setValues();
			addGUI();
			
			/*removeInventory();
			_santaInv.invAvailableSlot = levelData.setLevelInvData(lvlNum);
			_santaInv.x = 10;
			_santaInv.y = stage.stageHeight - _santaInv.height + 10;
			//ItemList
			itemList.clearAll();
			itemList.setItemListRefArr = levelData.setLevel(lvlNum);
			//CharManager
			removeCharacter();
			_charManager.setCharRefArr = levelData.setLevel(lvlNum);
			//LvlManager
			removelvlManager();
			lvlManager.setLevel(lvlNum);
			_map.x = -250;
			// Pick santa display
			removePickSanta();
			//Santa
			removeSanta();
			addGUI();*/
		}
		private function addGUI():void
		{	
			addChild(_map);
			addChild(itemList);
			addChild( _santaInv );
			addChild( testBtn );
			addChild(_charManager);
			addChild( dreamListManager );
			addChild(santa);
		}
		private function addSantaPickListener():void {
			if( pickMC != null ){
			pickMC.addEventListener(MouseEvent.ROLL_OVER, onPickSantOver );
			pickMC.addEventListener(MouseEvent.ROLL_OUT, onPickSantOut );
			pickMC.addEventListener(MouseEvent.CLICK, onPickSantClick);
			}
		}
		
		private function onPickSantClick(e:MouseEvent):void 
		{
			if ( santa != null && santa.x != 0 ) {
				removeChild( santa );
				_santaInv.removeInv();
				addListenerToDreamList();
				addListenerToHouseLight();
				santa.x = 0;
				
			} else { trace(this, "santa not set");  }
		}
		
		private function onPickSantOut(e:MouseEvent):void 
		{
			pickMC.gotoAndStop(1);
		}
		
		private function onPickSantOver(e:MouseEvent):void 
		{
			pickMC.gotoAndStop(2);
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
			
			trace( " INVENTORY ", _santaInv.refArrForInvIcon );
			if ( _santaInv.refArrForInvIcon.length != _santaInv.limitHolder ) {
				trace(this," [INVENTORY NOT COMPLETE]");
			} else if ( _santaInv.refArrForInvIcon.length != 0 ) {
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
			setSantaMeter();
			setSantaPick();
			
			
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv );
				removeChild( _charManager );
			}
			TweenLite.to( _map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
			
		}
		private function setSantaMeter():void {
			meter = new SantaMeter();
			meter.x = stage.x + 20;
			meter.y = ( stage.stageHeight - meter.height ) - 10 ;
			addChild(meter);
		}
		private function setSantaPick():void {
			pickMC.x = stage.stageWidth - pickMC.width;
			pickMC.y = 90;
			addChild(pickMC);
			addSantaPickListener();
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
		private function onClickHouse(e:Event):void 
		{	
			currHouseIndex = 0;
			//Just to back the timer of other house
			currHouseIndex =  e.currentTarget.houseIndex;
			trace( this, lvlManager.houseArray[currHouseIndex].heldDreamListArr, "currLen", lvlManager.houseArray[currHouseIndex].heldDreamListArr.length );
			trace("@@@@@========================== isLightON:", lvlManager.houseArray[currHouseIndex].lightIsOn );
			trace("@@@@@======================== isChimneyON:", lvlManager.houseArray[currHouseIndex].chimneyIsOn );
			
			
			lvlManager.houseArray[currHouseIndex].stopHouseLightTimer();
			
			if (lvlManager.houseArray[currHouseIndex].heldDreamListArr == 0 && lvlManager.houseArray[currHouseIndex].isComplete != true ) {
				ctr = 0;
				santa.x = e.currentTarget.x + 90;
				santa.y = e.currentTarget.y + 19;
				santa.santaIdle();
				if ( _santaInv != null ) {
					if (this.contains(_santaInv)) {
						_santaInv.removeInv();
						addListenerToDreamList();
					}
				}
			} else if ( lvlManager.houseArray[currHouseIndex].isComplete ) {
				trace(this,"TAPOS MO NA WAG KANG MAKULET"); //ready to click
			} else {
				ctr = 0;
				santa.x = e.currentTarget.x + 90;
				santa.y = e.currentTarget.y + 19;
				santa.santaIdle();
				addChild(santa);
				displaySantaInventory();
				addListenerToDreamList();
				lvlManager.houseArray[currHouseIndex].onTimerStop();
			
			}
		}
		
		private function addListenerToDreamList():void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].onTimerStart();//splice str
			}
		}
		private function addListenerToHouseLight():void {
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				if( lvlManager.houseArray[i].hasLSequence ){
				lvlManager.houseArray[i].startHouseLightTimer();
				} else { trace(this,"no light sequence"); }
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
			addSantaPickListener();
			addListenerToHouseLight();
			
			rManager.checkCurrScoreState();
			allComplete();
			
			if( hasPoints ){
			meter.animationStop();
				hasPoints = false;
			}
			if ( lvlManager.houseArray[currHouseIndex].heldDreamListArr.length == 0 && santa.x != 0 ) {
				lvlManager.houseArray[currHouseIndex].houseComplete();
			} else {
				trace("ready to click");
				lvlManager.houseArray[currHouseIndex].onTimerStart();
			}
		}
		private function onSantaEventWalk():void 
		{
			removeEventToHouse();
			this.addEventListener(Event.ENTER_FRAME, loop );
		}
		private function loop( e:Event ):void {
			ctr++;	
			if ( ctr >= 15 ) {
				santa.santaWalk();
				santa.x-= 3;
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
				generateArrNeedForHouse( strHeld , arrHoldLvl, numOfChildren);
			}
			
			rManager.setInvQtyAndGeneRandItem( _santaInv.refArrForInvIcon , generatedRandomItemForHouse );
			trace("COMPARISON,   INV ITEM:", _santaInv.refArrForInvIcon ,"    RAND ITEM:", generatedRandomItemForHouse );
			
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
			dreamListManager.setArrRef( lvlManager.houseArray, generatedRandomItemForHouse );
		}
		//================================ #8 CALL OF HOUSE LVLMANAGER - house have arrays now ==============================
		private function calllvlManagerHouse(e:GameEvent):void 
		{
			trace(this, "ITEM_DISTRIBUTED TO HOUSE");
			if( lvlManager.houseArray.length !=0 ){
				for (var i:int = 0; i < lvlManager.houseArray.length; i++) {
				lvlManager.houseArray[i].genCompToHouse();
				lvlManager.houseArray[i].onTimerStart();
				}
			}
		}
		//================================ #9 CHECKING OF ITEM between inv from houseItem =====================================
		private function onInviSelect(e:GameEvent):void
		{
			removeSantaPickListener();
			if ( _santaInv.isOnGamePlay ) {
				trace("IC > need:", e.params.need, "lvl:", e.params.lvl, "label:", e.params.label);
				for (var i:int = 0; i < lvlManager.houseArray[currHouseIndex].heldDreamListArr.length; i++)
				{
					if ( e.params.need == lvlManager.houseArray[currHouseIndex].heldDreamListArr[i] && lvlManager.houseArray[currHouseIndex].dreamListHolderpArr[i].isVisible != false
					&& !lvlManager.houseArray[currHouseIndex].lightIsOn && !lvlManager.houseArray[currHouseIndex].chimneyIsOn  ) {
						var strHolder:String;
						strHolder = lvlManager.houseArray[currHouseIndex].heldDreamListArr[i];
						lvlManager.houseArray[currHouseIndex].spliceIndex( i );
						onSantaEventWalk();
						hasPoints = true;
						meter.scoceUp();
						rManager.addPoints();
						
						trace(this, i, "===============================$$= SPLICE STR", strHolder);
						
					} else if ( lvlManager.houseArray[currHouseIndex].lightIsOn && !lvlManager.houseArray[currHouseIndex].chimneyIsOn ) {
						if ( i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
							trace(this, "H U L I  K A  S A N T A");
							onSantaEventWalk();
						}
					} else if ( lvlManager.houseArray[currHouseIndex].chimneyIsOn && !lvlManager.houseArray[currHouseIndex].lightIsOn ) {
						if ( i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
						trace(this, "S U N O G  K A  S A N T A");
						onSantaEventWalk();
						}
					} else { //if ( lvlManager.houseArray[currHouseIndex].lightIsOn && lvlManager.houseArray[currHouseIndex].chimneyIsOn ) {
						if ( i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
						trace(this, "M I N U S  T W O");
						onSantaEventWalk();
						}
					}
					
					/*else { 
							trace(this, "not found");
							//*****
							onSantaEventWalk();
					}*/
				}
			} else { trace(this," INVENTORY MODE "); } //timerJump:
		}
		//================================ [ #10 ALL HOUSE COMPLETE ] =====================================================
		private function allComplete():void {
			scoreCtr = 0;
			for (var i:int = 0; i < lvlManager.houseArray.length ; i++) 
			{
					if ( lvlManager.houseArray[i].heldDreamListArr.length == 0 ) {
						scoreCtr++;
					}
			}
			if ( scoreCtr ==  lvlManager.houseArray.length) {
				trace(this, "==%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%==", "ALL COMPLETE!!");
			}
		}
		
		//============================================================== [ GARBAGE COLLECT ] =====================================================================================
		public function gcRemoveAll():void {
			removeListener();
			removeDisplay();	
		}
		// LISTENER
		private function removeListener():void
		{
			removeSantaPickListener();
			removeEventToHouse();
			this.removeEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.removeEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.removeEventListener(GameEvent.TIMER_CALL_TO_ACTIVATE, startTimerAfterJump);
			this.removeEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.removeEventListener(GameEvent.ON_INV_RESET, onInvReset);
			this.removeEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
		}
		private function removeSantaPickListener():void {
			if( pickMC != null ){
			pickMC.removeEventListener(MouseEvent.ROLL_OVER, onPickSantOver );
			pickMC.removeEventListener(MouseEvent.ROLL_OUT, onPickSantOut );
			pickMC.removeEventListener(MouseEvent.CLICK, onPickSantClick);
			}
		}
		// DISPLAY
		private function removeDisplay():void {
			removeSanta(); // SANTA
			removePickSanta(); // PICK SANT ICON
			lvlManager.removeHouse(); // HOUSE COMPONENT
			removeCharacter(); // CHARACTER
			removeInventory(); // INVENTORY
			itemList.clearAll(); // ITEM LIST
			removelvlManager(); // LVL MANAGER
			removeMap(); // MAP
		}
		private function removeMap():void {
			if ( _map != null ) {
				if (this.contains(_map)) {
				removeChild( _map );
				_map = null;
				}
			}
		}
		private function removeCharacter():void{
			_charManager.removeChar();
			if ( _charManager!= null ) {
				if ( this.contains(_charManager)) {
					removeChild(_charManager);
				}	
			}
		}
		private function removelvlManager():void {
			removeEventToHouse();
			if( _map.contains(lvlManager)){
				_map.removeChild(lvlManager);
				lvlManager = null;
			}
		}
		public function removeInventory():void {
			_santaInv.isOnGamePlay = false;
			_santaInv.resetInvData();
			_santaInv.gcBtn();
			_santaInv.gcWhitebase();
			if ( _santaInv != null ) {
				if (this.contains(_santaInv)) {
					removeChild(_santaInv);
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
		private function removeSanta():void {
			if ( santa != null ) {
				if (this.contains(santa)) {
					santa.removeSantaInvremoveSantaEvent();
					removeChild( santa );
					santa = null;
				}
			} // SSSS santa have automatic listener remover
		}
		private function removePickSanta():void {
			if ( meter != null ) {
				if (this.contains(meter)) {
					removeChild( meter );
					meter = null;	
				}
			}
			
			if ( pickMC != null ) {
				if (this.contains(pickMC)) {
					removeChild( pickMC );
					pickMC = null;
				}
			}
		}
		
	//end Engine
	}
}