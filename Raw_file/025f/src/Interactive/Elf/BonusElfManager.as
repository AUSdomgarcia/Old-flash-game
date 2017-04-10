package Interactive.Elf 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class BonusElfManager extends Sprite
	{
		private var bonusBtn:BonusBtn;
		public var hasBonusPoints:Boolean = false;
		public var currPoints:Number = 0;
		public var currPointStack:Number = 0;
		
		public function BonusElfManager() 
		{
			init();
		}
		public function addBonusPoints():void {
			currPointStack++;
			if ( currPointStack <= 0 ) {
				hasBonusPoints = true;
			}
		}
		public function checkCurrBonusPoints():void {
			
		}
		public function addListener():void 
		{
			trace("BONUS", currPointStack );
			if ( currPointStack > 0) {
				bonusBtn.addEventListener(MouseEvent.CLICK, onBonusClick);
				bonusBtn.addEventListener(MouseEvent.ROLL_OVER, onBonusOver);
				bonusBtn.addEventListener(MouseEvent.ROLL_OUT, onBonusOut);
			} else { trace ("not allowed to use bonus");  }
		}
		
		public function removeListener():void 
		{
			bonusBtn.removeEventListener(MouseEvent.CLICK, onBonusClick);
			bonusBtn.removeEventListener(MouseEvent.ROLL_OVER, onBonusOver);
			bonusBtn.removeEventListener(MouseEvent.ROLL_OUT, onBonusOut);
		}
		
		private function onBonusOut(e:MouseEvent):void 
		{
			bonusBtn.gotoAndStop(1);
		}
		
		private function onBonusOver(e:MouseEvent):void 
		{
			bonusBtn.gotoAndStop(2);
		}
		
		private function onBonusClick(e:MouseEvent):void 
		{
			minusBonusPoint();
		}
		public function minusBonusPoint():void { 
			if ( currPointStack > 0) {
				currPointStack--;
				setPointsBonus(currPointStack);
				this.parent.dispatchEvent( new GameEvent( GameEvent.ON_BONUS_CLICK )); // dispatch event
			} else { trace(" NOT ENOUGH STACK "); }
			if ( currPointStack == 0 ) {
				removeListener();
			}
		}
		
		private function init():void 
		{
			bonusBtn = new BonusBtn();
		}
		public function addGUI():void 
		{
			addChild( bonusBtn );
		}
		public function setPointsBonus( num:Number ):void {
			bonusBtn.pointsTxt.text = "" + num;
			currPointStack = num;
		}
		public function removeGUI():void {
			if ( bonusBtn != null ) {
				removeListener();
				if ( this.contains( bonusBtn )) {
					removeChild( bonusBtn);
					bonusBtn = null;
				}
			}
		}
	//end
	}
}