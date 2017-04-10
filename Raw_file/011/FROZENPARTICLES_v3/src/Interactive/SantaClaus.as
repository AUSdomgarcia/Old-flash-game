package Interactive 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class SantaClaus extends Sprite 
	{
		private var santa:SantaMc;
		private var obj:Object = new Object();
		
		public function SantaClaus() 
		{
			obj.x = x;
			obj.y = y;
			init();
		}
		
		private function init():void {
			santa = new SantaMc();
				addChild(santa);
		}
		public function addSanta():void {
			santa.gotoAndStop(1);
		}
		
		public function santaIdle():void {
			santa.gotoAndStop(1);
		}
		public function santaWalk():void {
			//santa.x--;
			santa.gotoAndStop(3);
		}
		public function santaJump():void {
			santa.gotoAndStop(2);
		}
		public function removeSanta():void {
			if ( this.parent != null ) {
				removeChild(santa);
			}
		}
	}

}