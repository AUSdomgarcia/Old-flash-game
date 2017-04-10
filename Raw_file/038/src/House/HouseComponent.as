package House 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import Interactive.DreamListComponent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class HouseComponent extends Sprite
	{
		private var houseMc:HouseMc;
		public var houseIndex:Number = 0;
		public var heldDreamListArr:Array = [];
		
		public var isComplete:Boolean = false;
		
		//ItemComponent
		public var dreamListHolderpArr:Array = [];
		public var dreamListComponent:DreamListComponent;
		private var timerA:Timer = new Timer(1000);
		private var sptHolder:Sprite = new Sprite();
		public var chimney:MovieClip;
		
		private var completeText:TextComplete;
		// House Sequence
		private var _maxRNumLight:Number = 0;
		private var _randRNumLight:Number = 0;
		
		private var _maxRNumChimney:Number = 0;
		private var _randRNumChimney:Number = 0;
		
		public var levelTimer:Timer;
		public var lightIsOn:Boolean = false;
		public var chimneyIsOn:Boolean = false;
		
		public var hasLSequence:Boolean = false;
		public var hasCSequence:Boolean = false;
		
		public function HouseComponent()
		{	
			chimney = new MovieClip();
			houseMc = new HouseMc();
			chimney = houseMc.chimney;
			addListener();
		}
		public function addListener():void {
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut );
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver );
		}
		public function removeListener():void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOut );
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOver );
			levelTimer.removeEventListener( TimerEvent.TIMER, lightAndChimneyTimer );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			houseMc.filters = [];
		}
		
		private function onOver(e:MouseEvent):void 
		{
			var houseGlow:GlowFilter = new GlowFilter();
			houseGlow.color = 0x0080FF;
			houseMc.filters = [ houseGlow ];
		}
		
		//TIMER EVENT
		public function onTimerStart():void { timerA.start(); }
		public function onTimerStop():void { timerA.stop(); }
		
		private function onTimer(e:TimerEvent):void 
		{	
			for (var i:int = 0; i < dreamListHolderpArr.length; i++) {
				dreamListHolderpArr[i].update();
			}
		}
		public function addHouse():void {
			if ( houseMc != null ) {
				houseMc.addChild(sptHolder);
				addChild( houseMc );
			}
		}
		public function removeSelf():void {
			if ( houseMc.parent != null ) {
				gCDreamList();
				houseMc.removeChild(sptHolder);
				removeChild( houseMc );
				houseMc = null;
			}
		}
		
		// DREAMLIST COMPONENT MANAGER
		public function genCompToHouse():void {
			gCDreamList();
			for (var i:int = 0; i < heldDreamListArr.length; i++) 
			{
				dreamListComponent = new DreamListComponent( heldDreamListArr[i] , i );
				dreamListHolderpArr[i] = dreamListComponent;
				dreamListHolderpArr[i].x = ( 70 * i ) - 30;
				dreamListHolderpArr[i].y = -50;
				
				dreamListHolderpArr[i].setRandomMax(3);
				addChild( dreamListHolderpArr[i] );
			}
			timerA.addEventListener(TimerEvent.TIMER, onTimer);
			//onTimerStart();
		}
		public function spliceIndex( num:Number ):void {
			heldDreamListArr.splice( num, 1);
			gCDreamList();
			genCompToHouse();
		}
		
		public function gCDreamList():void {
		if ( dreamListHolderpArr.length != 0 ) {
			onTimerStop();
			timerA.removeEventListener(TimerEvent.TIMER, onTimer);
			for (var i:int = 0; i < dreamListHolderpArr.length; i++)
				{
					dreamListHolderpArr[i].removeDreamComp();
				}
			}
			dreamListHolderpArr = new Array();
		}
		
		public function resetDataHouse():void {
			heldDreamListArr = new Array();
		}
		
		public function houseComplete():void {
			hasCSequence = false;
			hasLSequence = false;
			isComplete = true;
			completeText = new TextComplete();
			addChild(completeText);
		}
		public function removeCompleteMC():void {
			isComplete = false;
			if ( completeText != null ) {
				removeChild( completeText );
				completeText = null;
			}
		}
		//==================================================== [ FOR HOUSE LIGHT SEQUENCE ] ===========================================================================
		
		public function setMaxNumLight( max:Number ):void {
			_maxRNumLight = max;
			_randRNumLight = Math.floor(Math.random() * max ) + 5;
		}
		private function checkerLight():void 
		{
			if( hasLSequence ){
				_randRNumLight--;
				if ( _randRNumLight <= 1 ) {
					if (!lightIsOn) {
						lightIsOn = true;
					} else {  
						lightIsOn = false;
					}
					switcherLight();
				}
			}
		}
		public function switcherLight():void {
		if ( lightIsOn ) {
				removeHouseLight();
			} else {
				addHouseLight();
			}
			setMaxNumLight( _maxRNumLight );
		}
		private function removeHouseLight():void 
		{
			houseMc.gotoAndStop(2);
		}
		
		private function addHouseLight():void
		{
			houseMc.gotoAndStop(1);
		}	
		public function set hasAChimneySequence( b:Boolean ):void {
			hasCSequence = b;
		}
		public function set hasAlightSequence( b:Boolean ):void {
			hasLSequence = b;
		}
		public function set initTimerAndSetDelayForLight( timerDelay:Number ):void {
			//hasCSequence = true;
			//hasLSequence = true;
			levelTimer = new Timer( timerDelay );
			levelTimer.addEventListener( TimerEvent.TIMER, lightAndChimneyTimer );
			levelTimer.start();
		}
		public function startHouseLightTimer():void {
			levelTimer.start();
		}
		public function stopHouseLightTimer():void {
			if( hasLSequence ){
			levelTimer.stop();
			} else { trace(this, "no light to stop");  }
			
			if( hasCSequence ){
			levelTimer.stop();
			} else { trace(this, "no light to stop");  }
		}
		private function lightAndChimneyTimer(e:TimerEvent):void 
		{
			chimneyChecker();
			checkerLight();
		}
		
		//==================================================== [ FOR HOUSE CHIMNEY SEQUENCE ] ===========================================================================
		public function setMaxNumChimney( max:Number ):void {
			_maxRNumChimney = max;
			_randRNumChimney = Math.floor(Math.random() * max ) + 5;
		}
		private function chimneyChecker():void 
		{
			if( hasCSequence ){
			_randRNumChimney--;
				if ( _randRNumChimney <= 1 ) {
					if (!chimneyIsOn) {
						chimneyIsOn = true;
					} else {  
						chimneyIsOn = false;
					}
					switcherChimney();
				}
			}
		}
		public function switcherChimney():void {
		if ( chimneyIsOn ) {
				removeHouseChimney();
			} else {
				addHouseChimney();
			}
			setMaxNumChimney( _maxRNumChimney );
		}
		private function removeHouseChimney():void 
		{
			chimney.gotoAndStop(2);
		}
		private function addHouseChimney():void
		{
			chimney.gotoAndStop(1);
		}
	//end
	}
}