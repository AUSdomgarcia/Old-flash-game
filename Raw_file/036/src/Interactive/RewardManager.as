package Interactive 
{
	import flash.display.Sprite;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class RewardManager extends Sprite
	{
		public var invQtyToItemList:Number = 0; 
		public var currPoint:Number = 0;
		
		private var _invQty:Array = [];
		private var _geneRandItem:Array = [];
		private var _counter:Number = 0;
		private var _lenHolder:Number = 0;
		
		public function RewardManager() 
		{
			
		}
		public function setInvQtyAndGeneRandItem( invQty:Array, geneRandItem:Array ):void {
			_counter = 0;
			_lenHolder = 0;
			
			_invQty = invQty; _geneRandItem = geneRandItem;
			_lenHolder = geneRandItem.length;
			for (var i:int = 0; i < invQty.length; i++) 
			{
				for (var j:int = 0; j < geneRandItem.length; j++) 
				{
					if ( invQty[i] == geneRandItem[j]) {
						_counter++;
					}
				}
			}
			trace( this,"maxPlayerComb",_counter );
		}
		public function addPoints():void {
			currPoint++;
		}
		public function checkCurrScoreState():void {
			var obj:Object = new Object();
			
			trace( "POINT: ",currPoint, "CTR: ",_counter , "ITEM LEN", _lenHolder );
			if ( currPoint >= _counter && currPoint != _lenHolder ) {
				trace(this, "GAME FINISH ALMOST 100% ");
				gcData();
			} else if ( currPoint == _counter ) {
				
				obj.points = currPoint;
				this.parent.dispatchEvent( new GameEvent(GameEvent.ON_CURRPOINT_UPDATE, obj));
				trace(this, "GAME FINISH 100% ");
				gcData();
			} else { trace(this,"STILL ON GAME "); }
		}
		private function gcData():void {
			_geneRandItem = new Array();
			_invQty = new Array();
			currPoint = 0;
		}
	//end
	}
}