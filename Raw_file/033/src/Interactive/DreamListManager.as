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
		private var distribCtr:Number = 0;
		
		private var _dreamListArray:Array = [];
		private var _dreamList:DreamListComponent;
		public function DreamListManager() 
		{
		}
		public function setArrRef( arrHouse:Array, arrItem:Array ):void {
			gcData();
			houseRefArr = arrHouse;	
			randomItemArr = arrItem;
			
			trace(this, "ArrItem:", arrItem.length, "ArrHouse.Length", arrHouse.length);
			generateDreamComponent();
		}
		
		private function gcData():void 
		{
			_dreamListArray = new Array();
			houseRefArr = new Array();
			randomItemArr = new Array();
			distribCtr = 0;
			
		}
		
		private function generateDreamComponent():void
		{
			for (var i:int = randomItemArr.length; i > 0; i--) 
			{
				var rndNum:int = Math.random() * houseRefArr.length;
				if(houseRefArr[rndNum].heldDreamListArr.length != 3){
				houseRefArr[rndNum].pushItem(randomItemArr[randomItemArr.length - 1]);
				randomItemArr.pop();
				}
			}
			this.parent.dispatchEvent( new GameEvent( GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE ));
		}
		//end
	}
}