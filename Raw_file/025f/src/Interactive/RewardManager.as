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
		private var _bonusStackPoints:Number = 0;
		
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
		public function checkCurrScoreState( points:Number, isAllComp:Boolean ):void {
			_bonusStackPoints = points;
			var obj:Object = new Object();
			
			trace( "POINT: ",currPoint, "CTR: ",_counter , "ITEM LEN", _lenHolder );
			if ( currPoint < _lenHolder && !isAllComp ) { // HAY I FIX MO TO DOMZ
				if ( _bonusStackPoints <= 0 ) {
				obj.isProceed = false;
				obj.points = currPoint;
				this.parent.dispatchEvent( new GameEvent(GameEvent.ON_CURRPOINT_UPDATE, obj)); // points pass to map manager and will use to view in window pop up
				trace(this, "GAME FINISH ALMOST 100% ");
				gcData();
				}
			} else if ( currPoint == _lenHolder  || currPoint == ctr ) {
				obj.points = currPoint;
				obj.isProceed = true;
				this.parent.dispatchEvent( new GameEvent(GameEvent.ON_CURRPOINT_UPDATE, obj)); // points pass to map manager and will use to view in window pop up
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