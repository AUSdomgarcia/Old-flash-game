package Interactive 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author dHOMZKIe
	 */
	public class PizzaCar extends Sprite
	{
		private var pizzaCar:PizzaCarMc;
		private var isCarMove:Boolean = false;
		private var count:Number = 0;
		
		public function PizzaCar() 
		{
			displayCar();
			addListener();
		}
		
		public function displayCar():void {
			pizzaCar = new PizzaCarMc();
			pizzaCar.gotoAndStop(1);
			isCarMove = true;
		}
		
		private function addListener():void {
			addEventListener(Event.ENTER_FRAME, loop );
		}
		
		private function loop( e:Event ):void {
			count++
			if ( count >= 10 && isCarMove ) {
				addChild( pizzaCar );
				if (isCarMove) {
					pizzaCar.x--;
				}
			}
		}
	//end
	}
}