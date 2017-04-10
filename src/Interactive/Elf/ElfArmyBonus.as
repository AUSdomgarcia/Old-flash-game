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
		private var _elfCtr:Number = 0;
		private var _isWalk:Boolean = false;
		private var _isJump:Boolean = false;
		private var _timerCtr:Number = 0;
		
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
			if ( elfAmry != null ) {
				if (this.contains(elfAmry)) {
				elfAmry.gotoAndStop(4);
				}
			}
		}
		public function elfIdle():void {
			if ( elfAmry != null ) {
				if (this.contains(elfAmry)) {
				elfAmry.gotoAndStop(3);
				timerDelay = 300;
				timerElf.addEventListener( TimerEvent.TIMER, onTimer );
				timerElf.start();
				_isWalk = true;
				}
			}
		}
		private function onTimer(e:TimerEvent):void
		{
			_timerCtr = e.target.currentCount;
			checkElfJump();
			checkElfWalk();
		}
		private function checkElfWalk():void {
			if(_isWalk){
				if ( _timerCtr >= 1 ) {
				onElfIdleDone();
				_isWalk = false;
				}
			}
		}
		private function checkElfJump():void {
			
			if (_isJump) {
				if ( _timerCtr >= 200 ) {
					if ( this.parent != null ) {
					this.parent.dispatchEvent( new GameEvent( GameEvent.ON_ELF_JUMP_DONE ));
					}
					timerElf.stop();
					timerElf.reset();
					timerElf.removeEventListener( TimerEvent.TIMER, onTimer );
					_isJump = false;
					}
			}
		}
		private function onElfIdleDone():void 
		{
			this.addEventListener(Event.ENTER_FRAME, onElfWalk);
		}
		private function onElfWalk(e:Event):void 
		{
			_elfCtr++;
			if ( elfAmry != null ) {
				if ( this.contains( elfAmry ) ) {				
					if ( _elfCtr >= 15 ) {
						
						elfWalk();
						elfAmry.x-= 3;
					}
					if( elfAmry.x <= -48 ) {
						this.removeEventListener(Event.ENTER_FRAME, onElfWalk );
						elfJump();
						_elfCtr = 0;
					}	
				}
			}
		}
		public function removeGUI():void {
			if ( elfAmry != null ) {
				if ( this.contains( elfAmry ) ) {
					removeChild( elfAmry );
					elfAmry = null;
				}
			}
		}
		public function elfWalk():void {
			if ( elfAmry != null ) {
				if (this.contains(elfAmry)) {
					elfAmry.gotoAndStop(2);
				}
			}
		}
		public function elfJump():void {
			if (this.contains(elfAmry)) {
			elfAmry.gotoAndStop(1);
			timerDelay = 300;
			timerElf.addEventListener( TimerEvent.TIMER, onTimer );
			timerElf.start();
			_isJump = true;
			}
		}
		//end
	}
}