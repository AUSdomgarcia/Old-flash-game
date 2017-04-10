package House 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Interactive.DreamListComponent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class HouseComponent extends Sprite
	{
		private var houseMc:HouseMc;
		public var isChimneyOn:Boolean = false;
		public var isLightOn:Boolean = false;
		public var hasSanta:Boolean = false;
		public var houseIndex:Number = 0;
		public var heldDreamListArr:Array = [];
		public var isHouseArrHasValue:Boolean = false;
		
		//ItemComponent
		public var dreamListHolderpArr:Array = [];
		public var dreamListComponent:DreamListComponent;
		private var timerA:Timer = new Timer(1000);
		private var sptHolder:Sprite = new Sprite();
		public var chimney:MovieClip;
		
		public function HouseComponent( _isChimneyOn:Boolean, _isLightOn:Boolean ) 
		{
			houseMc = new HouseMc();
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
			for (var i:int = 0; i < heldDreamListArr.length; i++) 
			{
				dreamListComponent = new DreamListComponent( heldDreamListArr[i] );
				dreamListHolderpArr[i] = dreamListComponent;
				dreamListHolderpArr[i].x = ( 50 * i ) - 10;
				dreamListHolderpArr[i].setRandomMax(2);
				addChild( dreamListHolderpArr[i] );
			}
			timerA.addEventListener(TimerEvent.TIMER, onTimer);
			onTimerStart();
		}
		public function spliceIndex( str:String ):void {
			var ctr:Number = 0;
			for (var i:int = 0; i < dreamListHolderpArr.length; i++) 
			{
				if ( str == heldDreamListArr[i]) {
				trace(this, "splice str", heldDreamListArr[i] );
				heldDreamListArr.splice( i, 1);
				ctr++;
				}
			}
			if ( ctr >= 2) {
				trace("CRITICAL");
			} else { trace("NO CRITICAL"); }
			gCDreamList();
		}
		public function gCDreamList():void {
		timerA.removeEventListener(TimerEvent.TIMER, onTimer);
		for (var i:int = 0; i < dreamListHolderpArr.length; i++)
			{
				dreamListHolderpArr[i].removeDreamComp();
			}
			dreamListHolderpArr = new Array();
			onTimerStop();
			genCompToHouse();
		}
	//end
	}
}