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
		
		private var _isOnElse:Boolean = false;
		
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
			
			// IT STILL HAS A BUG AND REALLY HARD TO FIX
			for (var i:int = randomItemArr.length; i > 0; i--) 
			{
				var rndNum:int = Math.random() * houseRefArr.length;
				if (houseRefArr[rndNum].heldDreamListArr.length != 3) {
					houseRefArr[rndNum].pushItem(randomItemArr[randomItemArr.length - 1]);
					randomItemArr.pop();
					trace("NORMAL PUSH TO HOUSE:[", rndNum ,"] currIndex", i ," value:", randomItemArr[randomItemArr.length - 1]);
				//* * * [ trace for other ] * * * trace(houseRefArr[0].heldDreamListArr.length,houseRefArr[1].heldDreamListArr.length,houseRefArr[2].heldDreamListArr.length,houseRefArr[3].heldDreamListArr.length, "(",randomItemArr.length,")");
				} else {
					trace("NOT ABLE PUSH TO HOUSE:[", rndNum ,"] currIndex", i ," value:",randomItemArr[randomItemArr.length - 1] );
					_isOnElse = true;
					if ( _isOnElse ) 
					{	
					for (var j:int = 0; j < houseRefArr.length; j++) 
						{
							if ( houseRefArr[j].heldDreamListArr.length != 3 )
							{	
								houseRefArr[j].pushItem(randomItemArr[randomItemArr.length - 1]);
								randomItemArr.pop();
								trace("NOT FULL: >> ", j, "ELSE WILL PUSH TO [", j , "] currIndex", i );
							//* * * [ trace for other ] * * * trace(houseRefArr[0].heldDreamListArr.length,houseRefArr[1].heldDreamListArr.length,houseRefArr[2].heldDreamListArr.length,houseRefArr[3].heldDreamListArr.length, "(",randomItemArr.length,")");
								break;
							}
						}
					_isOnElse = false;
					}
				}
			}
			
			this.parent.dispatchEvent( new GameEvent( GameEvent.ON_LVLMANAGER_HOUSE_ACTIVATE ));
		}
		//end
	}
}