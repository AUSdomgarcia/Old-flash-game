package Interactive 
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import GameEvents.GameEvent;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class Inventory extends Sprite
	{
		private var bg:SantaBag;
		private var whiteBase:WhiteBaseMc;
		private var lock:LockMc;
		public var arrLen:Array = [];
		public var refHolder:Array = new Array( { state: 0, name: 0 } );
		public var refArr:Array = [];
		public var refAvailable:Array = []
		
		public function Inventory() {
			init();
		}
		private function init():void {
			bg = new SantaBag();
		}
		public function set invAvailable( arr:Array ):void {
			refAvailable = new Array();
			refAvailable = arr;
			setGUI();
		}
		
		public function set invData( arr:Array ):void {
			refArr = arr;
			trace(refArr.length);
		}
		
		private function setGUI():void {
			
			for (var i:int = 0; i < 5; i++) 
			{
				whiteBase = new WhiteBaseMc();
				arrLen[ i ] = whiteBase;
				arrLen[ i ].gotoAndStop( Number( refAvailable[i].state)  );
				
				arrLen[ i ].x = 15 + ( i * ( whiteBase.width + 10 ));
				arrLen[ i ].y = 20;
				
				//arrLen[ i ].addEventListener(MouseEvent.CLICK, onInvSelect);
				bg.addChild( arrLen[ i ] );
			}
			trace("inv", refAvailable.length );
			addItem();
		}
		
		private function onInvSelect(e:MouseEvent):void 
		{
			TweenLite.to(this, .5, { x:640, y:50 } );
			this.parent.dispatchEvent( new GameEvent(GameEvent.ON_INV_SELECT));
		}
		private function addItem():void {
			addChild( bg );
		}
	}

}