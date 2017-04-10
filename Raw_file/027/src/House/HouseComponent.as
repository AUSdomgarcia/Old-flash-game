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
		private var maxRNum:Number = 0;
		private var randRNum:Number = 0;
		public var levelTimer:Timer;
		public var lightIsOn:Boolean = false;
		
		public function HouseComponent()
		{	
			houseMc = new HouseMc();
			addListener();
		}
		public function addListener():void {
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut );
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver );
		}
		public function removeListener():void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, onOut );
			this.removeEventListener(MouseEvent.MOUSE_OVER, onOver );
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
				dreamListComponent = new DreamListComponent( heldDreamListArr[i] );
				dreamListHolderpArr[i] = dreamListComponent;
				dreamListHolderpArr[i].x = ( 50 * i ) - 10;
				dreamListHolderpArr[i].setRandomMax(2);
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
		//==================================================== [ FOR HOUSE SEQUENCE ] ===========================================================================
		
		public function setMaxNum( max:Number ):void {
			maxRNum = max;
			randRNum = Math.floor(Math.random() * max ) + 5;
		}
		private function checker():void 
		{
			randRNum--;
			if ( randRNum <= 1 ) {
				if (!lightIsOn) {
					lightIsOn = true;
				} else {  
					lightIsOn = false;
				}
				switcher();
			}
		}
		public function switcher():void {
			if ( lightIsOn ) {
				removeHouseLight();
			} else {
				addHouseLight();
			}
			setMaxNum( maxRNum );
		}
		private function removeHouseLight():void 
		{
			houseMc.gotoAndStop(2);
		}
		
		private function addHouseLight():void
		{
			houseMc.gotoAndStop(1);
		}	
		public function set initTimerAndSetDelay( timerDelay:Number ):void {
			levelTimer = new Timer( timerDelay );
			levelTimer.addEventListener( TimerEvent.TIMER, inLevelTimer );
			levelTimer.start();
		}
		private function inLevelTimer(e:TimerEvent):void 
		{
			checker();
		}
		
	//end
	}
}