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
		private var _ctr:Number = 0;
		private var houseMc:HouseMc;
		public var houseIndex:Number = 0;
		public var heldDreamListArr:Array = [];
		
		public var isComplete:Boolean = false;
		
		//ItemComponent
		public var dreamListHolderpArr:Array = [];
		public var dreamListComponent:DreamListComponent;
		private var timerA:Timer = new Timer(1000);
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
		
		public function pushItem( str:String ):void {
			heldDreamListArr.push( str );
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
				addChild( houseMc );
			}
		}
		public function removeSelf():void {
			gCDreamList();	
			if ( houseMc != null ) {
				if (this.contains(houseMc)) {
					removeChild( houseMc );
					houseMc = null;
				}
			}
			if ( chimney != null ) {
				if ( this.contains(chimney)) {
					removeChild( chimney );
				}
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
				if (this.contains(completeText)) {
					removeChild( completeText );
				completeText = null;
				}
			}
		}
		//==================================================== [ FOR HOUSE LIGHT SEQUENCE ] ===========================================================================
		public function set initTimerAndSetDelayForLight( timerDelay:Number ):void {
			levelTimer = new Timer( timerDelay );
			levelTimer.addEventListener( TimerEvent.TIMER, lightAndChimneyTimer );
			levelTimer.start();
		}
		private function lightAndChimneyTimer(e:TimerEvent):void 
		{
			chimneyChecker();
			checkerLight();
		}
		public function set hasAlightSequence( bL:Boolean ):void {
			hasLSequence = bL;
		}
		public function setMaxNumLight( maxL:Number ):void {
			_maxRNumLight = maxL;
			_randRNumLight = Math.floor(Math.random() * maxL ) + 2;
		}
		private function checkerLight():void 
		{
			if ( hasLSequence ) {
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
		
		public function set hasAChimneySequence( bC:Boolean ):void {
			hasCSequence = bC;
		}
		public function startHouseLightTimer():void {
			levelTimer.start();
		}
		public function stopHouseLightTimer():void {
			if( hasLSequence || hasCSequence){
				levelTimer.stop();
			}
		}
		
		//==================================================== [ FOR HOUSE CHIMNEY SEQUENCE ] ===========================================================================
		public function setMaxNumChimney( maxC:Number ):void {
			_maxRNumChimney = maxC;
			_randRNumChimney = Math.floor(Math.random() * maxC ) + 2;
		}
		private function chimneyChecker():void 
		{
			if ( hasCSequence ) {
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
			
			//if ( hasCSequence ) {
			//	trace (this, "=============================================CHIMNEY STOP ");
			//	levelTimer.stop();
			//} else { trace(this, "no light to stop");  }
	//end
	}
}