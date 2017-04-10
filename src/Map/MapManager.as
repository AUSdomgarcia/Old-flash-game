package Map
{	
	import CharData.CharaterData;
	import com.greensock.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	import Interactive.DreamListManager;
	import Interactive.Elf.BonusElfManager;
	import Interactive.Elf.ElfArmyBonus;
	import Interactive.PopUpManager;
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
		// DreamList
		private var generatedRandomItemForHouse:Array = [];
		private var dreamListManager:DreamListManager;
		//PopUp manager
		private var popUpManager:PopUpManager; 
		private var ispopUpDisplay:Boolean = false;
	
		private var hasPoints:Boolean = false;
		private var randItemCopy:Array = [];
		
		private var scoreCtr:Number = 0;
		private var _stref:Stage;
		private var _elfArmy:ElfArmyBonus;
		private var _elfCtr:Number = 0;
		//santa default
		private var _isSantaOnField:Boolean = false;
		
		private var _elfQueArr:Array = [];
		
		private var _bonusManager:BonusElfManager;
		private var _refBonusPoints:Number = 0;
		private var isAllHouseComplete:Boolean = false;
		public function MapManager( stref:Stage ) //frameRate
		{
			_stref = stref;
		}	
		public function init():void
		{
			popUpManager = new PopUpManager();
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
			_elfQueArr = new Array();
			ispopUpDisplay = false;
			
			itemList.x = 10;
			itemList.y = 10;
			
			_bonusManager = new BonusElfManager();
			_bonusManager.setPointsBonus(_refBonusPoints);
		}
		public function setCharData( num:Number ):void {
				lvlNum = num;
				trace(this, "Set Level:", lvlNum);
		}
		// LLL - Listeners
		public function addGlobalListener():void {
			this.addEventListener(GameEvent.ON_INV_DONE, onTriggerDoneBtn);
			this.addEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.addEventListener(GameEvent.ON_INV_SELECT, onInviSelect);
			this.addEventListener(GameEvent.ON_INV_RESET, onInvReset);
			this.addEventListener(GameEvent.ON_SANTA_JUMP_DONE, startTimerAfterJump);
			this.addEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
			this.addEventListener(GameEvent.ON_POPUP_CLICK_DONE, onPopWindowClick );
			this.addEventListener(GameEvent.ON_CURRPOINT_UPDATE, onPopUPUpdate);
			this.addEventListener(GameEvent.ON_BONUS_CLICK, onBtnBonusClick );
			this.addEventListener(GameEvent.ON_ELF_JUMP_DONE, onElfJumpDone );
		}
		// ============================================================= [ SANTA ELF  ] ===========================================================================
		public function generateElf():void {
			if ( _isSantaOnField && lvlManager.houseArray[currHouseIndex].heldDreamListArr.length != 0 ) {
				_santaInv.removeInv();
				santa.santaCalling();
				_elfArmy = new ElfArmyBonus();
				if ( _elfArmy != null ) {
				_elfArmy.x = santa.x + 10;
				_elfArmy.y = santa.y + 8;
				}
				addChild( _elfArmy );
				_elfQueArr.push(_elfArmy);
				_elfArmy.elfIdle();
				removeEventToHouse();
				removeSantaPickListener();
				
				this.parent.dispatchEvent(new GameEvent(GameEvent.ON_UPDATE_STACK_POINTS));
			} else { 
				trace(" SABLAY KA OR WALANG SANTA ");
				this.parent.dispatchEvent(new GameEvent(GameEvent.ON_UPDATE_STACK_POINTS));
			}
			
			//rManager.checkCurrScoreState( _refBonusPoints ); >!<
		}
		private function onElfJumpDone(e:GameEvent):void 
		{
			if ( _elfQueArr.length != 0) {
					if ( this.contains( _elfQueArr[0] )) {
					removeChild( _elfQueArr[0] );
					_elfQueArr.shift();
				}
			}
			if (_elfQueArr.length == 0) {
				
				addSantaPickListener();
				addListenerToHouseLight();
				addEventTohouse();
				santa.x = -50;
				santa.santaIdle();
				addChild(santa);
				if ( lvlManager.houseArray[currHouseIndex].heldDreamListArr.length == 0 && santa.x != 0 ) {
					lvlManager.houseArray[currHouseIndex].houseComplete(); // DISPLAY COMPLETE MC
				} else {
					lvlManager.houseArray[currHouseIndex].onTimerStart(); 
				}
				allComplete();
				rManager.checkCurrScoreState( _refBonusPoints, isAllHouseComplete );
				
			}
			trace("ELF ARRAY:", _elfQueArr.length );
		}
		public function setCurrentBonus( num:Number ):void {
			_refBonusPoints = num;
			trace(this, "CURR BONUS HAVE", _refBonusPoints );
		}
		private function spliceArrByBonus():void {
			if ( lvlManager.houseArray[currHouseIndex].heldDreamListArr.length != 0 ) {
				lvlManager.houseArray[currHouseIndex].spliceIndex( 0 );
				rManager.addPoints();
			} else { trace( this, " SAYANG ANG POINTS "); }
		}
		private function onBtnBonusClick(e:GameEvent):void
		{
			generateElf();
			spliceArrByBonus();
		}
		private function onPopUPUpdate(e:GameEvent):void
		{ 	//SHOW POP UP HERE
			if ( e.params.isProceed ) {
				popUpManager.setText( 2011, e.params.points, true );
				popUpManager.viewWindow();
				this.parent.dispatchEvent( new GameEvent( GameEvent.ON_CHARDATALVL_UPDATE ));
				this.parent.dispatchEvent( new GameEvent( GameEvent.ON_ADD_STACK_POINTS ));
			} else {
				popUpManager.setText( 2011, e.params.points, false );
				popUpManager.viewWindow();
			}
			removeItemListener();
		}
		private function removeItemListener():void {
			ispopUpDisplay = true;
			removeEventToHouse();
			removeSantaPickListener();
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].removeListener();
				lvlManager.houseArray[i].onTimerStop();
			}
		}
		
		private function onPopWindowClick(e:GameEvent):void
		{
			setItemListSelection();
		}
		//=========================================================[ ITEM SELECTION ]=============================================================
		
		private function setValues():void {
			//Inventory
			_santaInv.invAvailableSlot = levelData.setLevelInvData(lvlNum);
			_santaInv.x = 10;
			_santaInv.y = _stref.stageHeight - _santaInv.height + 10;
			//ItemList
			itemList.setItemListRefArr = levelData.setLevel(lvlNum);
			//CharManager
			_charManager.setCharRefArr = levelData.setLevel(lvlNum);
			//lvlManager
			lvlManager.setLevel(lvlNum);
			//Map
			_map.x = -250;
			_map.y = 0;
			//PopUp manager
			popUpManager.x = 500;
			popUpManager.y = 30;
		}
		public function setItemListSelection():void {
			gcRemoveAll();
			init();
			addGlobalListener();
			setValues();
			addGUI();
		}
		private function addGUI():void
		{	
			addChild(_map);
			addChild(itemList);
			addChild( _santaInv );
			addChild(_charManager);
			
			addChild( dreamListManager );
			addChild( popUpManager );
			addChild( rManager );
			addChild(_bonusManager);
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
			_isSantaOnField = false;
			trace(this, santa , santa.x );
			if ( santa != null && santa.x != 0 ) {
				trace(this,"START AGAIN");
				_santaInv.removeInv();
				addListenerToDreamList();
				addListenerToHouseLight();
				santa.x = -50;
				santa.santaIdle();
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
			
			trace(this, " INVENTORY ", _santaInv.refArrForInvIcon );
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
			setBonusPointDisplay();
			
			if ( itemList != null ) {
				removeChild( itemList );
				removeChild( _santaInv );
				removeChild( _charManager );
			}
			TweenLite.to( _map, 2, { x:0, y:0 , onComplete: function():void { trace("able to click"); addEventTohouse(); } } );
			
		}
		private function setSantaMeter():void {
			meter = new SantaMeter();
			meter.x = _stref.x + 20;
			meter.y = ( _stref.stageHeight - meter.height ) - 10 ;
			addChild(meter);
		}
		private function setSantaPick():void {
			pickMC.x = _stref.stageWidth - pickMC.width;
			pickMC.y = 90;
			addChild(pickMC);
			addSantaPickListener();
		}
		private function setBonusPointDisplay():void {
			_bonusManager.x = ( _stref.stageWidth - _bonusManager.width ) - 78;
			_bonusManager.y = 160;
			_bonusManager.addGUI();
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
			trace( this, lvlManager.houseArray[currHouseIndex].heldDreamListArr, "currLen * * * ", lvlManager.houseArray[currHouseIndex].heldDreamListArr.length );
			trace(this,"@@@@@========================== isLightON:", lvlManager.houseArray[currHouseIndex].lightIsOn );
			trace(this,"@@@@@======================== isChimneyON:", lvlManager.houseArray[currHouseIndex].chimneyIsOn );
			
			addListenerToHouseLight();
			lvlManager.houseArray[currHouseIndex].stopHouseLightChimneyTimer();
			_bonusManager.addListener(); //><
			
			if (lvlManager.houseArray[currHouseIndex].heldDreamListArr.length == 0 && lvlManager.houseArray[currHouseIndex].isComplete != true ) {
				ctr = 0;
				santa.x = e.currentTarget.x + 90;
				santa.y = e.currentTarget.y + 19;
				addChild(santa);
				_isSantaOnField = true;
				santa.santaIdle();
				addEventTohouse();
				
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
				_isSantaOnField = true;
			}
		}
		
		private function addListenerToDreamList():void 
		{
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				lvlManager.houseArray[i].onTimerStart();
			}
		}
		private function addListenerToHouseLight():void {
			for (var i:int = 0; i < lvlManager.houseArray.length; i++) 
			{
				if( lvlManager.houseArray[i].hasLSequence || lvlManager.houseArray[i].hasCSequence){
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
			_isSantaOnField = false;
			santa.x = -50;
			santa.santaIdle();
			addChild(santa);
			
			addEventTohouse();
			addSantaPickListener();
			addListenerToHouseLight();
			_bonusManager.addListener();
			allComplete();
			rManager.checkCurrScoreState( _refBonusPoints, isAllHouseComplete );
			
			
			if( hasPoints ){
			meter.animationStop();
				hasPoints = false;
			}
			if ( lvlManager.houseArray[currHouseIndex].heldDreamListArr.length == 0 && santa.x != 0 ) {
				lvlManager.houseArray[currHouseIndex].houseComplete(); // DISPLAY COMPLETE MC 
			} else {
				trace(this, "ready to click");
				if ( !ispopUpDisplay ) {
					lvlManager.houseArray[currHouseIndex].onTimerStart(); //><
				}
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
				trace(this,"loop has stop! ");
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
			trace(this,"COMPARISON,   INV ITEM:", _santaInv.refArrForInvIcon ,"    RAND ITEM:", generatedRandomItemForHouse );
			
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
			_bonusManager.removeListener();
			removeSantaPickListener();
			if ( _santaInv.isOnGamePlay ) {
				trace("IC > need:", e.params.need, "lvl:", e.params.lvl, "label:", e.params.label );
				for (var i:int = 0; i < lvlManager.houseArray[currHouseIndex].heldDreamListArr.length; i++)
				{
					if ( e.params.need == lvlManager.houseArray[currHouseIndex].heldDreamListArr[i] && 
					lvlManager.houseArray[currHouseIndex].dreamListHolderpArr[i].isVisible != false &&
					!lvlManager.houseArray[currHouseIndex].lightIsOn && !lvlManager.houseArray[currHouseIndex].chimneyIsOn  ) {
						var strHolder:String;
						strHolder = lvlManager.houseArray[currHouseIndex].heldDreamListArr[i];
						lvlManager.houseArray[currHouseIndex].spliceIndex( i );
						onSantaEventWalk();
						hasPoints = true;
						meter.scoreUp();
						rManager.addPoints();
						trace(this, i, "===============================$$= SPLICE STR", strHolder);
						
					} else if ( lvlManager.houseArray[currHouseIndex].lightIsOn && !lvlManager.houseArray[currHouseIndex].chimneyIsOn ) {
						if ( i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
							trace(this, "H U L I  K A  S A N T A");
							popUpManager.updateCaught();
							onSantaEventWalk();
							lvlManager.houseArray[currHouseIndex].genCompToHouse();
						}
					} else if ( lvlManager.houseArray[currHouseIndex].chimneyIsOn && !lvlManager.houseArray[currHouseIndex].lightIsOn ) {
						if ( i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
						trace(this, "S U N O G  K A  S A N T A");
						popUpManager.updateBurn();
						lvlManager.houseArray[currHouseIndex].genCompToHouse();
						onSantaEventWalk();
						}
					} else {  
						if ( hasPoints == false && i == lvlManager.houseArray[currHouseIndex].heldDreamListArr.length - 1) {
							trace(this, "M I N U S  P O I N T S");
							lvlManager.houseArray[currHouseIndex].genCompToHouse();
							onSantaEventWalk();
						}
					}
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
				//>!<
				isAllHouseComplete = true;
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
			this.removeEventListener(GameEvent.ON_SANTA_JUMP_DONE, startTimerAfterJump);
			this.removeEventListener(GameEvent.ADD_DATA_TO_INV, onAddingDataToInv );
			this.removeEventListener(GameEvent.ON_INV_RESET, onInvReset);
			this.removeEventListener(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE, calllvlManagerHouse);
			this.removeEventListener(GameEvent.ON_POPUP_CLICK_DONE, onPopWindowClick );
			this.removeEventListener(GameEvent.ON_CURRPOINT_UPDATE, onPopUPUpdate);
			this.removeEventListener(GameEvent.ON_BONUS_CLICK, onBtnBonusClick );
			this.removeEventListener(GameEvent.ON_ELF_JUMP_DONE, onElfJumpDone );
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
			removeCharacter(); // CHARACTER
			removeInventory(); // INVENTORY
			removeitemList();// ITEM LIST
			removelvlManager(); // LVL MANAGER, HOUSE COMPONENT
			removeMap(); // MAP
			removePopUp(); // POPUP
			removeRmanager(); // RMANAGER
			removeBonusBtn(); // BONUS BTN
			removeElf(); // ELF CHAR
			removeAllElf();
		}
		
		private function removeAllElf():void 
		{
			if ( _elfQueArr.length != 0 ) {
				for (var i:int = 0; i < _elfQueArr.length; i++) 
				{
					if (this.contains(_elfQueArr[i])) {
						removeChild(_elfQueArr[i]);
						_elfQueArr.shift();
					}
					if ( i == _elfQueArr.length - 1) {
						_elfQueArr = new Array();
					}
				}
			} else { trace( this, "NO ELF YET"); }
		}
		private function removeBonusBtn():void 
		{
			if ( _bonusManager != null ) {
				if (this.contains( _bonusManager )) {
					_bonusManager.removeGUI();
					removeChild( _bonusManager );
					_bonusManager = null;
				}
			}
		}
		private function removeRmanager():void 
		{
			if ( rManager != null ) {
				if (this.contains( rManager ) ) {
					removeChild( rManager );
					rManager = null;
				}
			}
		}
		
		private function removePopUp():void
		{
			if ( popUpManager != null ) {
				if (this.contains( popUpManager ) ) {
					popUpManager.removePopUp();
					popUpManager = null;
				}
			}
		}
		private function removeitemList():void {
			if ( itemList != null ) {
				if (this.contains(itemList)) {
					itemList.clearAll();
					removeChild( itemList );
					itemList = null;
				}
			}
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
			
			if ( _charManager!= null ) {
				if ( this.contains(_charManager)) {
					_charManager.removeChar();
					removeChild(_charManager);
					_charManager = null;
				}
			}
		}
		private function removelvlManager():void {
			
			if ( lvlManager != null ) {
					if ( _map != null) {
					if ( _map.contains(lvlManager)) {
						lvlManager.removeHouse();
						removeEventToHouse();
						_map.removeChild(lvlManager);
						lvlManager = null;
					}
				}
			}
		}
		public function removeInventory():void {
			
			if ( _santaInv != null ) {
				if (this.contains(_santaInv)) {
					_santaInv.isOnGamePlay = false;
					_santaInv.resetInvData();
					_santaInv.gcBtn();
					_santaInv.gcWhitebase();
					removeChild(_santaInv);
					_santaInv = null;
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
		private function removeElf():void {
			if ( _elfArmy != null ) {
				if ( this.contains( _elfArmy )) {
					_elfArmy.removeGUI();
					removeChild(_elfArmy );
					_elfArmy = null;
				}
			}
		}
	//end Engine
	}
}