package Interactive 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class SantaClaus extends Sprite 
	{
		private var santa:SantaMc;
		private var obj:Object = new Object();
		private var timerForjump:Timer;
		
		public function SantaClaus() 
		{
			obj.x = x;
			obj.y = y;
			init();
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeItem);
		}
		
		private function removeItem(e:Event):void 
		{
			this.removeEventListener(TimerEvent.TIMER, onTimer );
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeItem);
		}
		
		private function init():void {
			santa = new SantaMc();
			timerForjump = new Timer(800);
			addChild(santa);
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			trace("timerJump:",e.target.currentCount );
			if ( e.target.currentCount > 1 ) {
				this.parent.dispatchEvent( new GameEvent(GameEvent.TIMER_CALL_TO_ACTIVATE));
				timerForjump.stop();
			}
		}
		public function addSanta():void {
			santa.gotoAndStop(1);
		}
		
		public function santaIdle():void {
			santa.gotoAndStop(1);
		}
		public function santaWalk():void {
			santa.gotoAndStop(3);
		}
		public function santaJump():void {
			santa.gotoAndStop(2);
			timerForjump.addEventListener( TimerEvent.TIMER, onTimer );
			timerForjump.start();
		}
		public function removeSanta():void {
			if ( this.parent != null ) {
				removeChild(santa);
			}
		}
	}

}