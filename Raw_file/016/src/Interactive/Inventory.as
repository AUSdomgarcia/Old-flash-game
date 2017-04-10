package Interactive 
{
	import flash.display.Sprite;
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
		
		public function Inventory() 
		
		{
			init();
		}
		private function init():void {
			bg = new SantaBag();
			setGUI();
			addItem();
		}
		private function setGUI():void {
			
			for (var i:int = 0; i < 5; i++) 
			{
				whiteBase = new WhiteBaseMc();
				arrLen[ i ] = whiteBase;
				arrLen[ i ].x = 15 + ( i * ( whiteBase.width + 10 ));
				arrLen[ i ].y = 20;
				bg.addChild( arrLen[ i ] );
			}
		}
		private function addItem():void {
			addChild( bg );
		}
	}

}