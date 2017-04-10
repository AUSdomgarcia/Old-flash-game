package Interactive.Elf
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
	public class ElfArmyBonus extends Sprite 
	{
		private var elfAmry:ElvesBonus;
		private var timerElf:Timer;
		private var timerDelay:Number = 0;
		
		public function ElfArmyBonus() 
		{
			init();
			initTimer();
		}
		private function initTimer():void 
		{
			timerElf = new Timer(timerDelay);
		}
		private function init():void {
			elfAmry = new ElvesBonus();
			addChild(elfAmry);
		}
		public function elfStop():void {
			elfAmry.gotoAndStop(4);
		}
		public function elfIdle():void {
			elfAmry.gotoAndStop(3);
			timerDelay = 300;
			timerElf.addEventListener( TimerEvent.TIMER, onTimer );
			timerElf.start();
		}
		private function onTimer(e:TimerEvent):void
		{
			trace( e.target.currentCount );
			if ( e.target.currentCount >= 1 ) {
			this.dispatchEvent( new GameEvent( GameEvent.ON_ELF_IDLE_DONE ));
			timerElf.stop();
			timerElf.reset();
			}
		}
			/*if ( e.target.currentCount > 2 ) {
				if( this.parent != null ){
				this.parent.dispatchEvent( new GameEvent( GameEvent.ON_ELF_JUMP_DONE ));
			}
				elfAmry.stop();
				elfAmry.reset();
			}*/		
		private function addListener():void
		{
			
		}
		public function removeListener():void {	
			
		}
		public function removeGUI():void {
			if ( elfAmry != null ) {
				if ( this.contains( elfAmry ) ) {
					removeListener();
					removeChild( elfAmry );
					elfAmry = null;
				}
			}
		}
		public function elfWalk():void {
			elfAmry.gotoAndStop(2);
		}
		public function elfJump():void {
			elfAmry.gotoAndStop(1);
		}
		public function checkInv():void {	}
	}

}