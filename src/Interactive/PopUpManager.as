package Interactive 
{
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class PopUpManager extends Sprite
	{
		private var popWin:PopUpWindow;
		private var _caughtValue:Number = 0;
		private var _burntValue:Number = 0;
		
		public function PopUpManager() 
		{
			initWindow();
		}
		
		private function addListener():void 
		{
			popWin.donePopUp.addEventListener(MouseEvent.CLICK, onPopDone );
			popWin.donePopUp.addEventListener(MouseEvent.ROLL_OVER, onOver );
			popWin.donePopUp.addEventListener(MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onOut(e:MouseEvent):void 
		{
			popWin.donePopUp.gotoAndStop(1);
		}
		
		private function onOver(e:MouseEvent):void 
		{
			popWin.donePopUp.gotoAndStop(2);
		}
		private function removeListener():void {
			popWin.donePopUp.removeEventListener(MouseEvent.CLICK, onPopDone );
			popWin.donePopUp.removeEventListener(MouseEvent.ROLL_OVER, onOver );
			popWin.donePopUp.removeEventListener(MouseEvent.ROLL_OUT, onOut );
		}
		
		private function onPopDone(e:MouseEvent):void 
		{
			cleartext();
			removePopUp();
			this.parent.dispatchEvent( new GameEvent(GameEvent.ON_POPUP_CLICK_DONE) );
		}
		public function removePopUp():void {
			if (popWin != null ) {
				if ( this.contains( popWin ) ) {
					removeListener();
					removeChild( popWin );
					popWin = null;
				}
			}
		}
		
		private function initWindow():void 
		{
			popWin = new PopUpWindow();
		}
		public function cleartext():void {
			popWin.year.text =  new String();
			popWin.caught.text = new String();
			popWin.burnt.text = new String();
			popWin.totalscore.text = new String();
			
			_caughtValue = 0;
			_burntValue = 0;
		}
		public function updateBurn():void {
			_burntValue++;
		}
		public function updateCaught():void {
			_caughtValue++;
		}
		public function setText( yr:Number, /*burnt:Number, caught:Number ,*/ score:Number , notEGift:Boolean ):void {
			if ( !notEGift ) {
				popWin.enoughGiftTxt.visible = true;
				popWin.PAGiftTxt.visible = true;
				popWin.extraPointsTxt.visible = false;
			} else {
				popWin.enoughGiftTxt.visible = false;
				popWin.PAGiftTxt.visible = false;
				popWin.extraPointsTxt.visible = true;
			}
			popWin.year.text =  "" + yr;
			popWin.caught.text = "" + _caughtValue;
			popWin.burnt.text = "" + _burntValue;
			popWin.totalscore.text = "" + score;
		}
		public function viewWindow():void {
			trace(this,"POP WINDOW");
			addChild( popWin );
			TweenLite.to( this , 3, { x:90, y:30, ease:Elastic.easeOut , onComplete: function():void { trace("able to click done btn"); addListener(); } } );
		}
		//end
	}
}