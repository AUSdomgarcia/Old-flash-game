package Interactive 
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class DreamListManager extends Sprite
	{
		//External sorted
		public var houseRefArr:Array = [];
		public var randomItemArr:Array = [];
		
		private var _dreamListArray:Array = [];
		private var randomNum:Number = 0;
		private var dreamLTimer:Timer;
		public var timerDelay:Number = 800;
		
		private var _dreamList:DreamListComponent;
		public var arrDreamList:Array = [];
		
		private var _randNum:Number = 0;
			
		public function DreamListManager() 
		{
			dreamLTimer = new Timer( timerDelay );
			dreamLTimer.addEventListener( TimerEvent.TIMER, starDistribution );
		}
		
		private function starDistribution(e:TimerEvent):void 
		{
			
		}
		
		public function resetTime():void {
			dreamLTimer.reset();
		}
		public function stopTimer():void {
			dreamLTimer.stop();
		}
		
		public function startTime():void {
			dreamLTimer.start();
		}
		
		public function setArrRef( arrHouse:Array, arrItem:Array ):void {
			_dreamListArray = new Array();
			houseRefArr = arrHouse;			
			randomItemArr = arrItem;
			
			trace(this, "ArrItem:", arrItem.length, "ArrHouse.Length", arrHouse.length);
			generateDreamComponent();
		}
		
		private function generateDreamComponent():void
		{
			for (var l:int = 0; l < randomItemArr.length; l++) 
			{
				setToHouseArr( randomItemArr[l] );
			}
			this.parent.dispatchEvent( new GameEvent(GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE ));
		}
		
		
		private function setToHouseArr( str:String ):void 
		{
			var num:Number = Math.floor(Math.random() * houseRefArr.length);
			if ( houseRefArr[0].heldDreamListArr.length != 3) {
				houseRefArr[0].heldDreamListArr.push( str );
			} else { 
				for (var i:int = 0; i < houseRefArr.length; i++) 
				{
					if (houseRefArr[i].heldDreamListArr.length != 3) {
						houseRefArr[i].heldDreamListArr.push( str );
					}
				}			        
			} 
		}
		//end
	}
}